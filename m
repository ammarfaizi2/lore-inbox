Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbTGIAXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbTGIAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:23:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6405 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267991AbTGIAVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:21:38 -0400
Date: Wed, 9 Jul 2003 02:26:19 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 2/8] 2.5.74 - seq_file conversion of /proc/net/atm (vc helpers)
Message-ID: <20030709022619.D11897@electric-eye.fr.zoreil.com>
References: <20030709021152.B11897@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030709021152.B11897@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Wed, Jul 09, 2003 at 02:11:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helpers for seq_file conversion of proc/atm/{pvc/svc/vc}:
- struct atm_vc_state keeps
  1) the struct sock from which the current struct atm_vcc is deduced
  2) the family to which must belong the vcc (PF_ATM{SVC/PVC/any})
  3) the availability of clip module
- atm_vc_common_seq_{start/stop} are responsible for vcc_sklist locking
- atm_vc_common_seq_{open/release} take care of get/put for the clip module.


 net/atm/proc.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+)

diff -puN net/atm/proc.c~atm-proc-seq-vc-utils net/atm/proc.c
--- linux-2.5.74-1.1360.1.1-to-1.1384/net/atm/proc.c~atm-proc-seq-vc-utils	Wed Jul  9 01:42:55 2003
+++ linux-2.5.74-1.1360.1.1-to-1.1384-fr/net/atm/proc.c	Wed Jul  9 01:42:55 2003
@@ -161,6 +161,109 @@ static void atmarp_info(struct net_devic
 
 #endif
 
+struct atm_vc_state {
+	struct sock *sk;
+	int family;
+	int clip_info;
+};
+
+static inline int compare_family(struct sock *sk, int family)
+{
+	struct atm_vcc *vcc = atm_sk(sk);
+
+	return !family || (vcc->sk->sk_family == family);
+}
+
+/*
+ * Don't know what happens if l < 1
+ */
+static int __atm_vc_common_walk(struct sock **sock, int family, loff_t l)
+{
+	struct sock *sk = *sock;
+
+	if (sk == (void *)1) {
+		sk = hlist_empty(&vcc_sklist) ? NULL : __sk_head(&vcc_sklist);
+		l--;
+	} 
+	for (; sk; sk = sk_next(sk)) {
+		l -= compare_family(sk, family);
+		if (l < 0)
+			goto out;
+	}
+	sk = (void *)1;
+out:
+	*sock = sk;
+	return (l < 0);
+}
+
+static void *atm_vc_common_walk(struct atm_vc_state *state, loff_t l)
+{
+	return __atm_vc_common_walk(&state->sk, state->family, l) ?
+	       state : NULL;
+}
+
+static int atm_vc_common_seq_open(struct inode *inode, struct file *file,
+	int family, struct seq_operations *ops)
+{
+	struct atm_vc_state *state;
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		goto out;
+
+	rc = seq_open(file, ops);
+	if (rc)
+		goto out_kfree;
+
+	state->family = family;
+	state->clip_info = try_atm_clip_ops();
+
+	seq = file->private_data;
+	seq->private = state;
+out:
+	return rc;
+out_kfree:
+	kfree(state);
+	goto out;
+}
+
+static int atm_vc_common_seq_release(struct inode *inode, struct file *file)
+{
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	struct seq_file *seq = file->private_data;
+	struct atm_vc_state *state = seq->private;
+
+	if (state->clip_info)
+		module_put(atm_clip_ops->owner);
+#endif
+	return seq_release_private(inode, file);
+}
+
+static void *atm_vc_common_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct atm_vc_state *state = seq->private;
+	loff_t left = *pos;
+
+	read_lock(&vcc_sklist_lock);
+	state->sk = (void *)1;
+	return left ? atm_vc_common_walk(state, left) : (void *)1;
+}
+
+static void atm_vc_common_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&vcc_sklist_lock);
+}
+
+static void *atm_vc_common_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct atm_vc_state *state = seq->private;
+
+	v = atm_vc_common_walk(state, 1);
+	*pos += !!PTR_ERR(v);
+	return v;
+}
 
 static void pvc_info(struct atm_vcc *vcc, char *buf, int clip_info)
 {

_
