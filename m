Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319408AbSILCEC>; Wed, 11 Sep 2002 22:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319409AbSILCEC>; Wed, 11 Sep 2002 22:04:02 -0400
Received: from inspired.net.au ([203.58.81.130]:32264 "EHLO inspired.net.au")
	by vger.kernel.org with ESMTP id <S319408AbSILCEA>;
	Wed, 11 Sep 2002 22:04:00 -0400
Message-Id: <200209120208.MAA00777@thucydides.inspired.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Sep 2002 12:08:17 +1000
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Pull NFS server address off root_server_path
X-Mailer: VM 7.07 under Emacs 21.2.90.3
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch pulls an NFS server IP address off
root_server_path, if it is present.  This is useful, for example, when
root_server_path is obtained via the DHCP root-path option.  You can
do this sort of thing in dhcpd.conf:

  root-path = 192.168.1.33:/tftpboot/yip.zImage

This lets you mount your root filesystem off a different machine than
you booted from, without needing to use kernel command-line
parameters.

The change is backwards compatible; if the IP address is not present
then the existing behaviour takes place.  It is very well tested and
has been accepted into 2.4 and 2.5-dj.  FreeBSD allows root-path to
include an IP address in the above format and the description of
root-path in RFC2132 (DHCP Options ...) is general enough to allow an
IP address to be present.

Regards,
Martin

diff -r -u linux-2.5.34/fs/nfs/nfsroot.c linux-2.5.34.work/fs/nfs/nfsroot.c
--- linux-2.5.34/fs/nfs/nfsroot.c	2002-06-17 13:28:46.000000000 +1000
+++ linux-2.5.34.work/fs/nfs/nfsroot.c	2002-09-12 11:34:08.000000000 +1000
@@ -164,37 +164,6 @@
 
 
 /*
- *  Extract IP address from the parameter string if needed. Note that we
- *  need to have root_server_addr set _before_ IPConfig gets called as it
- *  can override it.
- */
-static void __init root_nfs_parse_addr(char *name)
-{
-	int octets = 0;
-	char *cp, *cq;
-
-	cp = cq = name;
-	while (octets < 4) {
-		while (*cp >= '0' && *cp <= '9')
-			cp++;
-		if (cp == cq || cp - cq > 3)
-			break;
-		if (*cp == '.' || octets == 3)
-			octets++;
-		if (octets < 4)
-			cp++;
-		cq = cp;
-	}
-	if (octets == 4 && (*cp == ':' || *cp == '\0')) {
-		if (*cp == ':')
-			*cp++ = '\0';
-		root_server_addr = in_aton(name);
-		strcpy(name, cp);
-	}
-}
-
-
-/*
  *  Parse option string.
  */
 static void __init root_nfs_parse(char *name, char *buf)
@@ -346,7 +315,7 @@
 			line[sizeof(nfs_root_name) - strlen(NFS_ROOT) - 1] = '\0';
 		sprintf(nfs_root_name, NFS_ROOT, line);
 	}
-	root_nfs_parse_addr(nfs_root_name);
+	root_server_addr = ipconfig_parse_addr(nfs_root_name);
 	return 1;
 }
 
diff -r -u linux-2.5.34/include/net/ipconfig.h linux-2.5.34.work/include/net/ipconfig.h
--- linux-2.5.34/include/net/ipconfig.h	2001-05-02 13:59:24.000000000 +1000
+++ linux-2.5.34.work/include/net/ipconfig.h	2002-09-12 11:34:08.000000000 +1000
@@ -6,6 +6,9 @@
  *  Automatic IP Layer Configuration
  */
 
+#ifndef _NET_IPCONFIG_H
+#define _NET_IPCONFIG_H
+
 /* The following are initdata: */
 
 extern int ic_enable;		/* Enable or disable the whole shebang */
@@ -36,3 +39,10 @@
 #define IC_BOOTP	0x01	/*   BOOTP (or DHCP, see below) */
 #define IC_RARP		0x02	/*   RARP */
 #define IC_USE_DHCP    0x100	/* If on, use DHCP instead of BOOTP */
+
+#ifdef __KERNEL__
+/* linux/net/ipv4/ipconfig.c: trims ip addr off front of name, too. */
+extern u32 ipconfig_parse_addr(char *name); /*__init*/
+#endif /* __KERNEL */
+
+#endif
diff -r -u linux-2.5.34/net/ipv4/ipconfig.c linux-2.5.34.work/net/ipv4/ipconfig.c
--- linux-2.5.34/net/ipv4/ipconfig.c	2002-08-28 06:12:28.000000000 +1000
+++ linux-2.5.34.work/net/ipv4/ipconfig.c	2002-09-12 11:34:08.000000000 +1000
@@ -1128,12 +1128,47 @@
 #endif /* CONFIG_PROC_FS */
 
 /*
+ *  Extract IP address from the parameter string if needed. Note that we
+ *  need to have root_server_addr set _before_ IPConfig gets called as it
+ *  can override it.
+ */
+u32 __init ipconfig_parse_addr(char *name)
+{
+	u32 addr;
+	int octets = 0;
+	char *cp, *cq;
+
+	cp = cq = name;
+	while (octets < 4) {
+		while (*cp >= '0' && *cp <= '9')
+			cp++;
+		if (cp == cq || cp - cq > 3)
+			break;
+		if (*cp == '.' || octets == 3)
+			octets++;
+		if (octets < 4)
+			cp++;
+		cq = cp;
+	}
+	if (octets == 4 && (*cp == ':' || *cp == '\0')) {
+		if (*cp == ':')
+			*cp++ = '\0';
+		addr = in_aton(name);
+		strcpy(name, cp);
+	} else
+		addr = INADDR_NONE;
+
+	return addr;
+}
+
+/*
  *	IP Autoconfig dispatcher.
  */
 
 static int __init ip_auto_config(void)
 {
 	unsigned long jiff;
+	u32 addr;
 
 #ifdef CONFIG_PROC_FS
 	proc_net_create("pnp", 0, pnp_get_info);
@@ -1222,6 +1257,10 @@
 		ic_dev = ic_first_dev->dev;
 	}
 
+	addr = ipconfig_parse_addr(root_server_path);
+	if (root_server_addr == INADDR_NONE)
+		root_server_addr = addr;
+
 	/*
 	 * Use defaults whereever applicable.
 	 */
