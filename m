Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268348AbTCFU7w>; Thu, 6 Mar 2003 15:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268353AbTCFU7w>; Thu, 6 Mar 2003 15:59:52 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:1729 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S268348AbTCFU7s>;
	Thu, 6 Mar 2003 15:59:48 -0500
Date: Thu, 6 Mar 2003 15:10:13 -0600 (CST)
From: Robin Holt <holt@sgi.com>
X-X-Sender: holt@mandrake.americas.sgi.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Make ipconfig.c work as a loadable module.
Message-ID: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch at the end of this email makes ipconfig.c work as a loadable 
module under the 2.5.  The diff was taken against the bitkeeper tree 
changeset 1.1075.

Currently ipconfig.o must get statically linked into the kernel.  I have a 
proprietary driver which the supplier will not provide a GPL version or 
info.  In order to mount root over NFS, I need to get the vendors driver 
loaded via a ramdisk.

A couple more items get moved from ipconfig.h to nfs_fs.h.


Thanks,
Robin Holt


-------------------------  Patch  ---------------------------------------

===== fs/Kconfig 1.18 vs edited =====
--- 1.18/fs/Kconfig	Sun Feb  9 19:29:49 2003
+++ edited/fs/Kconfig	Wed Mar  5 11:07:56 2003
@@ -1270,7 +1270,7 @@
 
 config ROOT_NFS
 	bool "Root file system on NFS"
-	depends on NFS_FS=y && IP_PNP
+	depends on NFS_FS=y && IP_PNP!=n
 	help
 	  If you want your Linux box to mount its whole root file system (the
 	  one containing the directory /) from some other computer over the
===== fs/nfs/nfsroot.c 1.11 vs edited =====
--- 1.11/fs/nfs/nfsroot.c	Thu Nov  7 11:29:59 2002
+++ edited/fs/nfs/nfsroot.c	Wed Mar  5 11:07:56 2003
@@ -69,6 +69,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -106,6 +107,15 @@
 static struct nfs_mount_data nfs_data __initdata = { 0, };/* NFS mount info */
 static int nfs_port __initdata = 0;		/* Port to connect to for NFS */
 static int mount_port __initdata = 0;		/* Mount daemon port number */
+
+
+u32 root_server_addr __initdata = INADDR_NONE;	/* Address of NFS server */
+u8 root_server_path[NFS_ROOT_PATH_LEN] __initdata = { 0, };	/* Path to mount as root */
+
+#ifdef CONFIG_IP_PNP_MODULE
+EXPORT_SYMBOL(root_server_addr);
+EXPORT_SYMBOL(root_server_path);
+#endif
 
 
 /***************************************************************************
===== include/linux/nfs_fs.h 1.43 vs edited =====
--- 1.43/include/linux/nfs_fs.h	Sat Dec 21 00:29:02 2002
+++ edited/include/linux/nfs_fs.h	Wed Mar  5 11:07:56 2003
@@ -417,7 +417,12 @@
 
 /* NFS root */
 
+#ifdef CONFIG_ROOT_NFS
+#define NFS_ROOT_PATH_LEN     256
+extern u8 root_server_path[NFS_ROOT_PATH_LEN];        /* Path to mount as root */
+
 extern void * nfs_root_data(void);
+#endif
 
 #define nfs_wait_event(clnt, wq, condition)				\
 ({									\
===== include/net/ipconfig.h 1.2 vs edited =====
--- 1.2/include/net/ipconfig.h	Tue Feb  5 01:40:15 2002
+++ edited/include/net/ipconfig.h	Wed Mar  5 11:07:56 2003
@@ -21,7 +21,6 @@
 extern u32 ic_servaddr;		/* Boot server IP address */
 
 extern u32 root_server_addr;	/* Address of NFS server */
-extern u8 root_server_path[];	/* Path to mount as root */
 
 
 
===== net/ipv4/Kconfig 1.4 vs edited =====
--- 1.4/net/ipv4/Kconfig	Wed Nov 13 06:52:02 2002
+++ edited/net/ipv4/Kconfig	Wed Mar  5 11:07:56 2003
@@ -133,8 +133,8 @@
 	  you may want to say Y here to speed up the routing process.
 
 config IP_PNP
-	bool "IP: kernel level autoconfiguration"
-	depends on INET
+	tristate "IP: kernel level autoconfiguration"
+	depends on INET!=n
 	help
 	  This enables automatic configuration of IP addresses of devices and
 	  of the routing table during kernel boot, based on either information
@@ -146,7 +146,7 @@
 
 config IP_PNP_DHCP
 	bool "IP: DHCP support"
-	depends on IP_PNP
+	depends on IP_PNP!=n
 	---help---
 	  If you want your Linux box to mount its whole root file system (the
 	  one containing the directory /) from some other computer over the
@@ -163,7 +163,7 @@
 
 config IP_PNP_BOOTP
 	bool "IP: BOOTP support"
-	depends on IP_PNP
+	depends on IP_PNP!=n
 	---help---
 	  If you want your Linux box to mount its whole root file system (the
 	  one containing the directory /) from some other computer over the
@@ -178,7 +178,7 @@
 
 config IP_PNP_RARP
 	bool "IP: RARP support"
-	depends on IP_PNP
+	depends on IP_PNP!=n
 	help
 	  If you want your Linux box to mount its whole root file system (the
 	  one containing the directory /) from some other computer over the
===== net/ipv4/ipconfig.c 1.22 vs edited =====
--- 1.22/net/ipv4/ipconfig.c	Tue Feb 18 12:38:27 2003
+++ edited/net/ipv4/ipconfig.c	Wed Mar  5 11:07:56 2003
@@ -32,6 +32,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -52,6 +53,7 @@
 #include <linux/proc_fs.h>
 #include <linux/major.h>
 #include <linux/root_dev.h>
+#include <linux/nfs_fs.h>
 #include <net/arp.h>
 #include <net/ip.h>
 #include <net/ipconfig.h>
@@ -131,9 +133,6 @@
 
 u32 ic_servaddr __initdata = INADDR_NONE;	/* Boot server IP address */
 
-u32 root_server_addr __initdata = INADDR_NONE;	/* Address of NFS server */
-u8 root_server_path[256] __initdata = { 0, };	/* Path to mount as root */
-
 /* Persistent data: */
 
 int ic_proto_used;			/* Protocol used, if any */
@@ -1136,6 +1135,7 @@
 	unsigned long jiff;
 
 #ifdef CONFIG_PROC_FS
+	/* >>> Need to remove this on unload!!! */
 	proc_net_create("pnp", 0, pnp_get_info);
 #endif /* CONFIG_PROC_FS */
 
@@ -1263,8 +1263,6 @@
 	return 0;
 }
 
-module_init(ip_auto_config);
-
 
 /*
  *  Decode any IP configuration options in the "ip=" or "nfsaddrs=" kernel
@@ -1386,6 +1384,29 @@
 	return 1;
 }
 
+
+#ifdef CONFIG_IP_PNP_MODULE
+char *ip = NULL;
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Martin Mares");
+MODULE_DESCRIPTION("IP Autoconfig module: \n" \
+	"Uses BOOTP/DHCP/RARP to determine IP configuration before the root\n"
+       " filesystem is mounted.  See nfsroot.txt in the kernel source.");
+MODULE_PARM(ip, "s");
+MODULE_PARM_DESC(ip, "[[<client-ip>]:[<server-ip>]:[<gw-ip>]:[<netmask>]:[<hostname>]:[<device>]:]<autoconf>");
+
+
+int __init init_module(void)
+{
+	if (ip != NULL) {
+		ip_auto_config_setup(ip);
+	}
+
+	return ip_auto_config();
+}
+#else
+module_init(ip_auto_config);
+
 static int __init nfsaddrs_config_setup(char *addrs)
 {
 	return ip_auto_config_setup(addrs);
@@ -1393,3 +1414,4 @@
 
 __setup("ip=", ip_auto_config_setup);
 __setup("nfsaddrs=", nfsaddrs_config_setup);
+#endif

