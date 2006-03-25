Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWCYTrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWCYTrl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCYTrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:47:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34320 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751120AbWCYTrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:47:40 -0500
Date: Sat, 25 Mar 2006 20:47:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] make UNIX a bool
Message-ID: <20060325194739.GS4053@stusta.de>
References: <20060225160150.GX3674@stusta.de> <20060225224631.GA4085@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225224631.GA4085@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 11:46:31PM +0100, Olaf Hering wrote:
>  On Sat, Feb 25, Adrian Bunk wrote:
> 
> > CONFIG_UNIX=m doesn't make much sense.
> 
> There is likely more code to support a modular unix.ko, this has to go
> as well.

Sounds resonable, updated patch below.

cu
Adrian


<--  snip  -->


CONFIG_UNIX=m doesn't make that much sense and requires us to export 
things we don't want to export to modules.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/file_table.c            |    1 -
 include/net/af_unix.h      |    2 --
 net/unix/Kconfig           |    2 +-
 net/unix/af_unix.c         |   18 ------------------
 net/unix/sysctl_net_unix.c |    9 +--------
 5 files changed, 2 insertions(+), 30 deletions(-)

--- linux-2.6.16-mm1-full/net/unix/Kconfig.old	2006-03-25 20:10:47.000000000 +0100
+++ linux-2.6.16-mm1-full/net/unix/Kconfig	2006-03-25 20:10:54.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 config UNIX
-	tristate "Unix domain sockets"
+	bool "Unix domain sockets"
 	---help---
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and
--- linux-2.6.16-mm1-full/include/net/af_unix.h.old	2006-03-25 20:13:33.000000000 +0100
+++ linux-2.6.16-mm1-full/include/net/af_unix.h	2006-03-25 20:13:40.000000000 +0100
@@ -85,10 +85,8 @@
 #ifdef CONFIG_SYSCTL
 extern int sysctl_unix_max_dgram_qlen;
 extern void unix_sysctl_register(void);
-extern void unix_sysctl_unregister(void);
 #else
 static inline void unix_sysctl_register(void) {}
-static inline void unix_sysctl_unregister(void) {}
 #endif
 #endif
 #endif
--- linux-2.6.16-mm1-full/net/unix/af_unix.c.old	2006-03-25 20:11:07.000000000 +0100
+++ linux-2.6.16-mm1-full/net/unix/af_unix.c	2006-03-25 20:14:05.000000000 +0100
@@ -475,7 +475,6 @@
 
 static const struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
-	.owner =	THIS_MODULE,
 	.release =	unix_release,
 	.bind =		unix_bind,
 	.connect =	unix_stream_connect,
@@ -496,7 +495,6 @@
 
 static const struct proto_ops unix_dgram_ops = {
 	.family =	PF_UNIX,
-	.owner =	THIS_MODULE,
 	.release =	unix_release,
 	.bind =		unix_bind,
 	.connect =	unix_dgram_connect,
@@ -517,7 +515,6 @@
 
 static const struct proto_ops unix_seqpacket_ops = {
 	.family =	PF_UNIX,
-	.owner =	THIS_MODULE,
 	.release =	unix_release,
 	.bind =		unix_bind,
 	.connect =	unix_stream_connect,
@@ -538,7 +535,6 @@
 
 static struct proto unix_proto = {
 	.name	  = "UNIX",
-	.owner	  = THIS_MODULE,
 	.obj_size = sizeof(struct unix_sock),
 };
 
@@ -2012,7 +2008,6 @@
 }
 
 static struct file_operations unix_seq_fops = {
-	.owner		= THIS_MODULE,
 	.open		= unix_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -2024,7 +2019,6 @@
 static struct net_proto_family unix_family_ops = {
 	.family = PF_UNIX,
 	.create = unix_create,
-	.owner	= THIS_MODULE,
 };
 
 static int __init af_unix_init(void)
@@ -2053,16 +2047,4 @@
 	return rc;
 }
 
-static void __exit af_unix_exit(void)
-{
-	sock_unregister(PF_UNIX);
-	unix_sysctl_unregister();
-	proc_net_remove("unix");
-	proto_unregister(&unix_proto);
-}
-
 module_init(af_unix_init);
-module_exit(af_unix_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NETPROTO(PF_UNIX);
--- linux-2.6.16-mm1-full/net/unix/sysctl_net_unix.c.old	2006-03-25 20:14:10.000000000 +0100
+++ linux-2.6.16-mm1-full/net/unix/sysctl_net_unix.c	2006-03-25 20:15:21.000000000 +0100
@@ -46,15 +46,8 @@
 	{ .ctl_name = 0 }
 };
 
-static struct ctl_table_header * unix_sysctl_header;
-
 void unix_sysctl_register(void)
 {
-	unix_sysctl_header = register_sysctl_table(unix_root_table, 0);
-}
-
-void unix_sysctl_unregister(void)
-{
-	unregister_sysctl_table(unix_sysctl_header);
+	register_sysctl_table(unix_root_table, 0);
 }
 
--- linux-2.6.16-mm1-full/fs/file_table.c.old	2006-03-25 20:39:30.000000000 +0100
+++ linux-2.6.16-mm1-full/fs/file_table.c	2006-03-25 20:39:44.000000000 +0100
@@ -62,7 +62,6 @@
 {
 	return files_stat.max_files;
 }
-EXPORT_SYMBOL_GPL(get_max_files);
 
 /*
  * Handle nr_files sysctl

