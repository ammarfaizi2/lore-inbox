Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262860AbSJGENd>; Mon, 7 Oct 2002 00:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262861AbSJGENd>; Mon, 7 Oct 2002 00:13:33 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:56071 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262860AbSJGENb>; Mon, 7 Oct 2002 00:13:31 -0400
Date: Mon, 7 Oct 2002 01:19:07 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH] X25: fix permission bogosity in create_proc_entry usage
Message-ID: <20021007041907.GF1201@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please consider pulling from:

master.kernel.org:/home/acme/BK/x25-2.5

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.624, 2002-10-07 01:15:18-03:00, acme@conectiva.com.br
  o X25: fix permission bogosity in create_proc_entry usage
  
  Thanks to Al Viro for reviewing this, this also fixes the
  example that made me do this copy'n'paste brain fart.


 wanrouter/wanproc.c |   26 +++-----------------------
 x25/x25_proc.c      |   15 ++-------------
 2 files changed, 5 insertions(+), 36 deletions(-)


diff -Nru a/net/wanrouter/wanproc.c b/net/wanrouter/wanproc.c
--- a/net/wanrouter/wanproc.c	Mon Oct  7 01:17:09 2002
+++ b/net/wanrouter/wanproc.c	Mon Oct  7 01:17:09 2002
@@ -61,9 +61,6 @@
 
 #ifdef CONFIG_PROC_FS
 
-/* Proc filesystem interface */
-static int router_proc_perms(struct inode *, int);
-
 /* Miscellaneous */
 
 /*
@@ -79,11 +76,6 @@
  *	Generic /proc/net/router/<file> file and inode operations 
  */
 
-static struct inode_operations router_inode =
-{
-	.permission =	router_proc_perms,
-};
-
 /*
  *	/proc/net/router 
  */
@@ -99,15 +91,6 @@
 /****** Proc filesystem entry points ****************************************/
 
 /*
- *	Verify access rights.
- */
-
-static int router_proc_perms (struct inode* inode, int op)
-{
-	return 0;
-}
-
-/*
  *	Iterator
  */
 static void *r_start(struct seq_file *m, loff_t *pos)
@@ -320,16 +303,14 @@
 	if (!proc_router)
 		goto fail;
 
-	p = create_proc_entry("config",0,proc_router);
+	p = create_proc_entry("config", S_IRUGO, proc_router);
 	if (!p)
 		goto fail_config;
 	p->proc_fops = &config_fops;
-	p->proc_iops = &router_inode;
-	p = create_proc_entry("status",0,proc_router);
+	p = create_proc_entry("status", S_IRUGO, proc_router);
 	if (!p)
 		goto fail_stat;
 	p->proc_fops = &status_fops;
-	p->proc_iops = &router_inode;
 	return 0;
 fail_stat:
 	remove_proc_entry("config", proc_router);
@@ -359,11 +340,10 @@
 	if (wandev->magic != ROUTER_MAGIC)
 		return -EINVAL;
 		
-	wandev->dent = create_proc_entry(wandev->name, 0, proc_router);
+	wandev->dent = create_proc_entry(wandev->name, S_IRUGO, proc_router);
 	if (!wandev->dent)
 		return -ENOMEM;
 	wandev->dent->proc_fops	= &wandev_fops;
-	wandev->dent->proc_iops	= &router_inode;
 	wandev->dent->data	= wandev;
 	return 0;
 }
diff -Nru a/net/x25/x25_proc.c b/net/x25/x25_proc.c
--- a/net/x25/x25_proc.c	Mon Oct  7 01:17:09 2002
+++ b/net/x25/x25_proc.c	Mon Oct  7 01:17:09 2002
@@ -202,15 +202,6 @@
 	.release	= seq_release,
 };
 
-static int x25_proc_perms(struct inode* inode, int op)
-{
-	return 0;
-}
-
-static struct inode_operations x25_seq_inode = {
-	.permission	= x25_proc_perms,
-};
-
 static struct proc_dir_entry *x25_proc_dir;
 
 int __init x25_proc_init(void)
@@ -222,17 +213,15 @@
 	if (!x25_proc_dir)
 		goto out;
 
-	p = create_proc_entry("route", 0, x25_proc_dir);
+	p = create_proc_entry("route", S_IRUGO, x25_proc_dir);
 	if (!p)
 		goto out_route;
 	p->proc_fops = &x25_seq_route_fops;
-	p->proc_iops = &x25_seq_inode;
 
-	p = create_proc_entry("socket", 0, x25_proc_dir);
+	p = create_proc_entry("socket", S_IRUGO, x25_proc_dir);
 	if (!p)
 		goto out_socket;
 	p->proc_fops = &x25_seq_socket_fops;
-	p->proc_iops = &x25_seq_inode;
 	rc = 0;
 out:
 	return rc;

===================================================================


This BitKeeper patch contains the following changesets:
1.624
## Wrapped with gzip_uu ##


begin 664 bkpatch11053
M'XL(`,8*H3T``^U676_3,!1]KG_%%7L`Q-KZ(W:2HD[[0H!`VC08XFUR';>-
MUL25[7:KE!^/G=(QL:Z(L4>2-#>)KX^/?<]IL@>73MM!1ZI*HSWX8)P?=)2I
MM?+E4O:4J7HC&QHNC`D-_:FI=#_F]H\_]6\I[](>1Z'Y7'HUA:6V;M`A/7;W
MQ*_F>M"Y>/?^\O/1!4+#(9Q,93W17[2'X1!Y8Y=R5KA#Z:<S4_>\E;6KM&\'
M;NY2&XHQ#3LG*<-<-$3@)&T4*0B1"=$%IDDF$A1Y'?[._3<4@G&*&<D(;K"@
M@J%3(#U!$\"T3W`?IX#)@/`!R;J8#3"&K:#PAD(7HV-XW@F<(`4&OE,^@'%Y
M"W-MJ]*YTM0P,A/C2K^"L@9EM?3Z:FZ-NM*UMRM8.#G1H6\XOH8AKUW@!4<S
M^%9:`V-CP>IEJ6_*>@)^6KK]]@QRYDP<1X?T:>RN;V4UG^EP)SU4LM!0:2C,
M.EN9^>IE_7(NG=<PLC(0&4OK>^@3",(Q.O]56=3]RPTA+#$ZV+[63:U]E%K\
MM9/NJ?N5%(0T5`A&&U9@D:@TH:-,%QD9/P$N(9SPAF<YY8'.[N)&G!M96[/P
MVL:K>V`_2YWSO!&,9UF3XQ%)"R(2S49XG.@=W![#O$\P21+1NNGA9**MGG<=
MGPA'&T*2%+<&HP_LQ?]H+\+^^VOMK[4>SZ!K;]HC&.9\2^6?8+O3L&20AT`Y
M$/1Q'3IS&#Y<A%<O6E6^V(<O5Q\O+M^?[<-FZ*NBM*_?1I0\=#^EC+1@;7@,
MS!EUK?U.-!;);$2^Q15_?H'\DT6173B_.HQG9>R\E:9<[,9,28X%$12'VSQ+
M6^T3_K?B9]"E_\6_$7_[7[=%_%N*\!0'B`3"1T!&@:-3@FET`Z,L"G@='A-P
M*-NXG-P7<-NZIA3URV@*-*)DNVS@I5^X72B,1D\Q05M*;>B$"1=ZV3TH`LI6
DW$U"+2N]`UN(Z+#-MYJ::G7M%M40<ZG&.1^A']+\^D<="@``
`
end
