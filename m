Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272043AbTHHWRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272012AbTHHWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:16:04 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:47108 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272130AbTHHWPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:15:04 -0400
Date: Sat, 9 Aug 2003 00:11:39 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 4/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (svc)
Message-ID: <20030809001139.E2699@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com> <20030809000633.B2699@electric-eye.fr.zoreil.com> <20030809000841.C2699@electric-eye.fr.zoreil.com> <20030809001013.D2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809001013.D2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:10:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file support for /proc/net/atm/svc:

Same comments as pvc. Just s/p/s/


 net/atm/proc.c |   81 ++++++++++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 37 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-svc-conversion net/atm/proc.c
--- linux-2.6.0-test2-bk8/net/atm/proc.c~atm-proc-seq-svc-conversion	Fri Aug  8 20:29:28 2003
+++ linux-2.6.0-test2-bk8-fr/net/atm/proc.c	Fri Aug  8 20:29:28 2003
@@ -323,29 +323,26 @@ static void vc_info(struct atm_vcc *vcc,
 	    atomic_read(&vcc->sk->sk_rmem_alloc), vcc->sk->sk_rcvbuf);
 }
 
-
-static void svc_info(struct atm_vcc *vcc,char *buf)
+static void svc_info(struct seq_file *seq, struct atm_vcc *vcc)
 {
-	char *here;
-	int i;
-
 	if (!vcc->dev)
-		sprintf(buf,sizeof(void *) == 4 ? "N/A@%p%10s" : "N/A@%p%2s",
-		    vcc,"");
-	else sprintf(buf,"%3d %3d %5d         ",vcc->dev->number,vcc->vpi,
-		    vcc->vci);
-	here = strchr(buf,0);
-	here += sprintf(here,"%-10s ",vcc_state(vcc));
-	here += sprintf(here,"%s%s",vcc->remote.sas_addr.pub,
+		seq_printf(seq, sizeof(void *) == 4 ?
+			   "N/A@%p%10s" : "N/A@%p%2s", vcc, "");
+	else
+		seq_printf(seq, "%3d %3d %5d         ",
+			   vcc->dev->number, vcc->vpi, vcc->vci);
+	seq_printf(seq, "%-10s ", vcc_state(vcc));
+	seq_printf(seq, "%s%s", vcc->remote.sas_addr.pub,
 	    *vcc->remote.sas_addr.pub && *vcc->remote.sas_addr.prv ? "+" : "");
-	if (*vcc->remote.sas_addr.prv)
+	if (*vcc->remote.sas_addr.prv) {
+		int i;
+
 		for (i = 0; i < ATM_ESA_LEN; i++)
-			here += sprintf(here,"%02x",
-			    vcc->remote.sas_addr.prv[i]);
-	strcat(here,"\n");
+			seq_printf(seq, "%02x", vcc->remote.sas_addr.prv[i]);
+	}
+	seq_putc(seq, '\n');
 }
 
-
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 
 static char*
@@ -522,31 +519,41 @@ static int atm_vc_info(loff_t pos,char *
 	return 0;
 }
 
-
-static int atm_svc_info(loff_t pos,char *buf)
+static int atm_svc_seq_show(struct seq_file *seq, void *v)
 {
-	struct hlist_node *node;
-	struct sock *s;
-	struct atm_vcc *vcc;
-	int left;
+	static char atm_svc_banner[] = 
+		"Itf VPI VCI           State      Remote\n";
 
-	if (!pos)
-		return sprintf(buf,"Itf VPI VCI           State      Remote\n");
-	left = pos-1;
-	read_lock(&vcc_sklist_lock);
-	sk_for_each(s, node, &vcc_sklist) {
-		vcc = atm_sk(s);
-		if (vcc->sk->sk_family == PF_ATMSVC && !left--) {
-			svc_info(vcc,buf);
-			read_unlock(&vcc_sklist_lock);
-			return strlen(buf);
-		}
-	}
-	read_unlock(&vcc_sklist_lock);
+	if (v == (void *)1)
+		seq_puts(seq, atm_svc_banner);
+	else {
+		struct atm_vc_state *state = seq->private;
+		struct atm_vcc *vcc = atm_sk(state->sk);
 
+		svc_info(seq, vcc);
+	}
 	return 0;
 }
 
+static struct seq_operations atm_svc_seq_ops = {
+	.start	= atm_vc_common_seq_start,
+	.next	= atm_vc_common_seq_next,
+	.stop	= atm_vc_common_seq_stop,
+	.show	= atm_svc_seq_show,
+};
+
+static int atm_svc_seq_open(struct inode *inode, struct file *file)
+{
+	return atm_vc_common_seq_open(inode, file, PF_ATMSVC, &atm_svc_seq_ops);
+}
+
+static struct file_operations atm_seq_svc_fops = {
+	.open		= atm_svc_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= atm_vc_common_seq_release,
+};
+
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 static int atm_arp_info(loff_t pos,char *buf)
 {
@@ -792,7 +799,7 @@ int __init atm_proc_init(void)
 		return -ENOMEM;
 	CREATE_SEQ_ENTRY(devices);
 	CREATE_SEQ_ENTRY(pvc);
-	CREATE_ENTRY(svc);
+	CREATE_SEQ_ENTRY(svc);
 	CREATE_ENTRY(vc);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 	CREATE_ENTRY(arp);

_
