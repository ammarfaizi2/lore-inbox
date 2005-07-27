Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVG0NCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVG0NCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVG0NCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:02:04 -0400
Received: from smtp8.clb.oleane.net ([213.56.31.28]:14225 "EHLO
	smtp8.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262236AbVG0NBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:01:53 -0400
Date: Wed, 27 Jul 2005 15:01:15 +0200
From: Christophe Lucas <clucas@rotomalug.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@lists.osdl.org, domen@coderock.org, wharms@bfs.de
Message-ID: <20050727130115.GE5089@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux / 2.6.13-rc3-kj (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Mail-From: clucas@rotomalug.org
Subject: [PATCH][RFC] procfs_failure && possible uses
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built mer oct 29 11:46:13 CET 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

description:
audit return code of create_proc_* function is a entry in janitors
TODO list. Audit this return and printk() when it fails, spams log of
system without compiled proc support. So this patch can correct it.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>


 arch/arm/kernel/apm.c   |    7 ++++---
 arch/arm/kernel/ecard.c |   12 ++++++++++--
 include/linux/proc_fs.h |    5 +++++
 3 files changed, 19 insertions(+), 5 deletions(-)

Index: linux-2.6.13-rc3-mm2/include/linux/proc_fs.h
===================================================================
--- linux-2.6.13-rc3-mm2.orig/include/linux/proc_fs.h
+++ linux-2.6.13-rc3-mm2/include/linux/proc_fs.h
@@ -83,6 +83,9 @@ struct vmcore {
 
 #ifdef CONFIG_PROC_FS
 
+#define procfs_failure(fmt,arg...) \
+	printk(KERN_WARNING fmt,##arg)
+
 extern struct proc_dir_entry proc_root;
 extern struct proc_dir_entry *proc_root_fs;
 extern struct proc_dir_entry *proc_net;
@@ -198,6 +201,8 @@ static inline void proc_net_remove(const
 
 #else
 
+#define procfs_failure(fmt,arg...) do { } while(0)
+
 #define proc_root_driver NULL
 #define proc_net NULL
 #define proc_bus NULL
Index: linux-2.6.13-rc3-mm2/arch/arm/kernel/ecard.c
===================================================================
--- linux-2.6.13-rc3-mm2.orig/arch/arm/kernel/ecard.c
+++ linux-2.6.13-rc3-mm2/arch/arm/kernel/ecard.c
@@ -776,9 +776,17 @@ static struct proc_dir_entry *proc_bus_e
 
 static void ecard_proc_init(void)
 {
+	struct proc_dir_entry *proc_entry;
+
 	proc_bus_ecard_dir = proc_mkdir("ecard", proc_bus);
-	create_proc_info_entry("devices", 0, proc_bus_ecard_dir,
-		get_ecard_dev_info);
+	if (!proc_bus_ecard_dir)
+		procfs_failure("ecard: Unable to create proc dir entry.\n");
+	else {
+		proc_entry = create_proc_info_entry("devices", 0, 
+				proc_bus_ecard_dir, get_ecard_dev_info);
+		if (!proc_entry)
+			procfs_failure("ecard: Unable to create proc entry.\n");
+	}
 }
 
 #define ec_set_resource(ec,nr,st,sz)				\
Index: linux-2.6.13-rc3-mm2/arch/arm/kernel/apm.c
===================================================================
--- linux-2.6.13-rc3-mm2.orig/arch/arm/kernel/apm.c
+++ linux-2.6.13-rc3-mm2/arch/arm/kernel/apm.c
@@ -515,6 +515,7 @@ static int kapmd(void *arg)
 static int __init apm_init(void)
 {
 	int ret;
+	struct proc_dir_entry *proc_entry;
 
 	if (apm_disabled) {
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
@@ -534,9 +535,9 @@ static int __init apm_init(void)
 		return ret;
 	}
 
-#ifdef CONFIG_PROC_FS
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
-#endif
+	proc_entry = create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	if (!proc_entry)
+		procfs_failure("apm: Unable to create apm proc entry.\n");
 
 	ret = misc_register(&apm_device);
 	if (ret != 0) {
