Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbTGIA1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbTGIAZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:25:17 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9477 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267996AbTGIAV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:21:58 -0400
Date: Wed, 9 Jul 2003 02:29:46 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 5/8] 2.5.74 - seq_file conversion of /proc/net/atm (vc)
Message-ID: <20030709022946.G11897@electric-eye.fr.zoreil.com>
References: <20030709021152.B11897@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030709021152.B11897@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Wed, Jul 09, 2003 at 02:11:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file support for /proc/net/atm/vc:

Same comments as for pvc and svc.


 net/atm/proc.c |   80 ++++++++++++++++++++++++++++++---------------------------
 1 files changed, 43 insertions(+), 37 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-vc-conversion net/atm/proc.c
--- linux-2.5.74-1.1360.1.1-to-1.1384/net/atm/proc.c~atm-proc-seq-vc-conversion	Wed Jul  9 01:43:00 2003
+++ linux-2.5.74-1.1360.1.1-to-1.1384-fr/net/atm/proc.c	Wed Jul  9 01:43:00 2003
@@ -301,29 +301,27 @@ static const char *vcc_state(struct atm_
 	return map[ATM_VF2VS(vcc->flags)];
 }
 
-
-static void vc_info(struct atm_vcc *vcc,char *buf)
+static void vc_info(struct seq_file *seq, struct atm_vcc *vcc)
 {
-	char *here;
-
-	here = buf+sprintf(buf,"%p ",vcc);
-	if (!vcc->dev) here += sprintf(here,"Unassigned    ");
-	else here += sprintf(here,"%3d %3d %5d ",vcc->dev->number,vcc->vpi,
-		    vcc->vci);
+	seq_printf(seq, "%p ", vcc);
+	if (!vcc->dev)
+		seq_printf(seq, "Unassigned    ");
+	else 
+		seq_printf(seq, "%3d %3d %5d ", vcc->dev->number, vcc->vpi,
+			vcc->vci);
 	switch (vcc->sk->sk_family) {
 		case AF_ATMPVC:
-			here += sprintf(here,"PVC");
+			seq_printf(seq, "PVC");
 			break;
 		case AF_ATMSVC:
-			here += sprintf(here,"SVC");
+			seq_printf(seq, "SVC");
 			break;
 		default:
-			here += sprintf(here, "%3d", vcc->sk->sk_family);
+			seq_printf(seq, "%3d", vcc->sk->sk_family);
 	}
-	here += sprintf(here," %04lx  %5d %7d/%7d %7d/%7d\n",vcc->flags,
-	    vcc->reply,
-	    atomic_read(&vcc->sk->sk_wmem_alloc), vcc->sk->sk_sndbuf,
-	    atomic_read(&vcc->sk->sk_rmem_alloc), vcc->sk->sk_rcvbuf);
+	seq_printf(seq, " %04lx  %5d %7d/%7d %7d/%7d\n", vcc->flags, vcc->reply,
+		atomic_read(&vcc->sk->sk_wmem_alloc),vcc->sk->sk_sndbuf,
+		atomic_read(&vcc->sk->sk_rmem_alloc),vcc->sk->sk_rcvbuf);
 }
 
 static void svc_info(struct seq_file *seq, struct atm_vcc *vcc)
@@ -496,32 +494,33 @@ static struct file_operations atm_seq_pv
 	.release	= atm_vc_common_seq_release,
 };
 
-static int atm_vc_info(loff_t pos,char *buf)
+static int atm_vc_seq_show(struct seq_file *seq, void *v)
 {
-	struct atm_vcc *vcc;
-	struct hlist_node *node;
-	struct sock *s;
-	int left;
-
-	if (!pos)
-		return sprintf(buf,sizeof(void *) == 4 ? "%-8s%s" : "%-16s%s",
-		    "Address"," Itf VPI VCI   Fam Flags Reply Send buffer"
-		    "     Recv buffer\n");
-	left = pos-1;
-	read_lock(&vcc_sklist_lock);
-	sk_for_each(s, node, &vcc_sklist) {
-		vcc = atm_sk(s);
-		if (!left--) {
-			vc_info(vcc,buf);
-			read_unlock(&vcc_sklist_lock);
-			return strlen(buf);
-		}
-	}
-	read_unlock(&vcc_sklist_lock);
+	if (v == (void *)1) {
+		seq_printf(seq, sizeof(void *) == 4 ? "%-8s%s" : "%-16s%s",
+			"Address ", "Itf VPI VCI   Fam Flags Reply "
+			"Send buffer     Recv buffer\n");
+	} else {
+		struct atm_vc_state *state = seq->private;
+		struct atm_vcc *vcc = atm_sk(state->sk);
 
+		vc_info(seq, vcc);
+	}
 	return 0;
 }
 
+static struct seq_operations atm_vc_seq_ops = {
+	.start	= atm_vc_common_seq_start,
+	.next	= atm_vc_common_seq_next,
+	.stop	= atm_vc_common_seq_stop,
+	.show	= atm_vc_seq_show,
+};
+
+static int atm_vc_seq_open(struct inode *inode, struct file *file)
+{
+	return atm_vc_common_seq_open(inode, file, 0, &atm_vc_seq_ops);
+}
+
 static int atm_svc_seq_show(struct seq_file *seq, void *v)
 {
 	static char atm_svc_banner[] = 
@@ -538,6 +537,13 @@ static int atm_svc_seq_show(struct seq_f
 	return 0;
 }
 
+static struct file_operations atm_seq_vc_fops = {
+	.open		= atm_vc_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= atm_vc_common_seq_release,
+};
+
 static struct seq_operations atm_svc_seq_ops = {
 	.start	= atm_vc_common_seq_start,
 	.next	= atm_vc_common_seq_next,
@@ -803,7 +809,7 @@ int __init atm_proc_init(void)
 	CREATE_SEQ_ENTRY(devices);
 	CREATE_SEQ_ENTRY(pvc);
 	CREATE_SEQ_ENTRY(svc);
-	CREATE_ENTRY(vc);
+	CREATE_SEQ_ENTRY(vc);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 	CREATE_ENTRY(arp);
 #endif

_
