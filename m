Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272053AbTHHWRt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTHHWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:16:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48388 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272131AbTHHWPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:15:05 -0400
Date: Sat, 9 Aug 2003 00:10:13 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 3/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (pvc)
Message-ID: <20030809001013.D2699@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com> <20030809000633.B2699@electric-eye.fr.zoreil.com> <20030809000841.C2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809000841.C2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:08:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file support for /proc/net/atm/pvc:
- pvc_info(): seq_printf/seq_putc replaces sprintf;
- atm_pvc_info() removal;
- the vc helpers (atm_vc_common_seq_xxx) do the remaining work.


 net/atm/proc.c |   81 +++++++++++++++++++++++----------------------------------
 1 files changed, 34 insertions(+), 47 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-pvc-conversion net/atm/proc.c
--- linux-2.6.0-test2-bk8/net/atm/proc.c~atm-proc-seq-pvc-conversion	Fri Aug  8 20:29:25 2003
+++ linux-2.6.0-test2-bk8-fr/net/atm/proc.c	Fri Aug  8 20:29:25 2003
@@ -262,7 +262,7 @@ static void *atm_vc_common_seq_next(stru
 	return v;
 }
 
-static void pvc_info(struct atm_vcc *vcc, char *buf, int clip_info)
+static void pvc_info(struct seq_file *seq, struct atm_vcc *vcc, int clip_info)
 {
 	static const char *class_name[] = { "off","UBR","CBR","VBR","ABR" };
 	static const char *aal_name[] = {
@@ -270,9 +270,8 @@ static void pvc_info(struct atm_vcc *vcc
 		"???",	"5",	"???",	"???",	/*  4- 7 */
 		"???",	"???",	"???",	"???",	/*  8-11 */
 		"???",	"0",	"???",	"???"};	/* 12-15 */
-	int off;
 
-	off = sprintf(buf,"%3d %3d %5d %-3s %7d %-5s %7d %-6s",
+	seq_printf(seq, "%3d %3d %5d %-3s %7d %-5s %7d %-6s",
 	    vcc->dev->number,vcc->vpi,vcc->vci,
 	    vcc->qos.aal >= sizeof(aal_name)/sizeof(aal_name[0]) ? "err" :
 	    aal_name[vcc->qos.aal],vcc->qos.rxtp.min_pcr,
@@ -284,18 +283,14 @@ static void pvc_info(struct atm_vcc *vcc
 		struct net_device *dev;
 
 		dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
-		off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
+		seq_printf(seq, "CLIP, Itf:%s, Encap:",
 		    dev ? dev->name : "none?");
-		if (clip_vcc->encap)
-			off += sprintf(buf+off,"LLC/SNAP");
-		else
-			off += sprintf(buf+off,"None");
+		seq_printf(seq, "%s", clip_vcc->encap ? "LLC/SNAP" : "None");
 	}
 #endif
-	strcpy(buf+off,"\n");
+	seq_putc(seq, '\n');
 }
 
-
 static const char *vcc_state(struct atm_vcc *vcc)
 {
 	static const char *map[] = { ATM_VS2TXT_MAP };
@@ -466,48 +461,40 @@ static struct file_operations atm_seq_de
 	.release	= seq_release,
 };
 
-/*
- * FIXME: it isn't safe to walk the VCC list without turning off interrupts.
- * What is really needed is some lock on the devices. Ditto for ATMARP.
- */
-
-static int atm_pvc_info(loff_t pos,char *buf)
+static int atm_pvc_seq_show(struct seq_file *seq, void *v)
 {
-	struct hlist_node *node;
-	struct sock *s;
-	struct atm_vcc *vcc;
-	int left, clip_info = 0;
+	static char atm_pvc_banner[] = 
+		"Itf VPI VCI   AAL RX(PCR,Class) TX(PCR,Class)\n";
 
-	if (!pos) {
-		return sprintf(buf,"Itf VPI VCI   AAL RX(PCR,Class) "
-		    "TX(PCR,Class)\n");
-	}
-	left = pos-1;
-#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	if (try_atm_clip_ops())
-		clip_info = 1;
-#endif
-	read_lock(&vcc_sklist_lock);
-	sk_for_each(s, node, &vcc_sklist) {
-		vcc = atm_sk(s);
-		if (vcc->sk->sk_family == PF_ATMPVC && vcc->dev && !left--) {
-			pvc_info(vcc,buf,clip_info);
-			read_unlock(&vcc_sklist_lock);
-#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-			if (clip_info)
-				module_put(atm_clip_ops->owner);
-#endif
-			return strlen(buf);
-		}
+	if (v == (void *)1)
+		seq_puts(seq, atm_pvc_banner);
+	else {
+		struct atm_vc_state *state = seq->private;
+		struct atm_vcc *vcc = atm_sk(state->sk);
+
+		pvc_info(seq, vcc, state->clip_info);
 	}
-	read_unlock(&vcc_sklist_lock);
-#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	if (clip_info)
-		module_put(atm_clip_ops->owner);
-#endif
 	return 0;
 }
 
+static struct seq_operations atm_pvc_seq_ops = {
+	.start	= atm_vc_common_seq_start,
+	.next	= atm_vc_common_seq_next,
+	.stop	= atm_vc_common_seq_stop,
+	.show	= atm_pvc_seq_show,
+};
+
+static int atm_pvc_seq_open(struct inode *inode, struct file *file)
+{
+	return atm_vc_common_seq_open(inode, file, PF_ATMPVC, &atm_pvc_seq_ops);
+}
+
+static struct file_operations atm_seq_pvc_fops = {
+	.open		= atm_pvc_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= atm_vc_common_seq_release,
+};
 
 static int atm_vc_info(loff_t pos,char *buf)
 {
@@ -804,7 +791,7 @@ int __init atm_proc_init(void)
 	if (!atm_proc_root)
 		return -ENOMEM;
 	CREATE_SEQ_ENTRY(devices);
-	CREATE_ENTRY(pvc);
+	CREATE_SEQ_ENTRY(pvc);
 	CREATE_ENTRY(svc);
 	CREATE_ENTRY(vc);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)

_
