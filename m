Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293208AbSCFEg3>; Tue, 5 Mar 2002 23:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293216AbSCFEgU>; Tue, 5 Mar 2002 23:36:20 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:37641 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293208AbSCFEgF>; Tue, 5 Mar 2002 23:36:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Patch to pull NFS server address off root_server_path
Date: Wed, 06 Mar 2002 15:04:31 +1100
Message-Id: <E16iSfH-0007W9-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was submitted to the trivial patch daemon.  Looks OK to me,
Trond?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

------- Forwarded Message

Date: Wed, 6 Mar 2002 14:06:46 +1100
To: trivial@rustcorp.com.au
Subject: Patch to pull NFS server address off root_server_path
X-Mailer: VM 7.03 under Emacs 21.1.90.1
From: "Martin Schwenke" <martin@meltin.net>

The following patch pulls an NFS server IP address off
root_server_path (handed out via the DHCP root-path option), if it is
present.  For example, you can do this sort of thing in dhcpd.conf:

  root-path = 192.168.1.33:/tftpboot/yip.zImage

The patch appears to be backwards compatible.

RFC2132 says this about the root-path option:

   This option specifies the path-name that contains the client's root
   disk.  The path is formatted as a character string consisting of
   characters from the NVT ASCII character set.

This is sufficiently vague to allow the path-name to include an
IP-address.  Also, I found some documentation for FreeBSD saying it
does this too, so it must be right, because those FreeBSD guys are
really smart...  :-)

peace & happiness,
martin

diff -r -u linux.orig/fs/nfs/nfsroot.c linux/fs/nfs/nfsroot.c
--- linux.orig/fs/nfs/nfsroot.c	Thu Oct 25 11:29:22 2001
+++ linux/fs/nfs/nfsroot.c	Wed Mar  6 14:01:10 2002
@@ -167,7 +167,7 @@
  *  need to have root_server_addr set _before_ IPConfig gets called as it
  *  can override it.
  */
-static void __init root_nfs_parse_addr(char *name)
+void __init root_nfs_parse_addr(char *name, u32 *addr)
 {
 	int octets = 0;
 	char *cp, *cq;
@@ -187,7 +187,7 @@
 	if (octets == 4 && (*cp == ':' || *cp == '\0')) {
 		if (*cp == ':')
 			*cp++ = '\0';
-		root_server_addr = in_aton(name);
+		*addr = in_aton(name);
 		strcpy(name, cp);
 	}
 }
@@ -344,7 +344,7 @@
 			line[sizeof(nfs_root_name) - strlen(NFS_ROOT) - 1] = '\0';
 		sprintf(nfs_root_name, NFS_ROOT, line);
 	}
-	root_nfs_parse_addr(nfs_root_name);
+	root_nfs_parse_addr(nfs_root_name, &root_server_addr);
 	return 1;
 }
 
diff -r -u linux.orig/net/ipv4/ipconfig.c linux/net/ipv4/ipconfig.c
--- linux.orig/net/ipv4/ipconfig.c	Tue Feb 26 07:14:51 2002
+++ linux/net/ipv4/ipconfig.c	Wed Mar  6 14:01:10 2002
@@ -1197,6 +1197,16 @@
 		ic_dev = ic_first_dev->dev;
 	}
 
+#ifdef CONFIG_ROOT_NFS
+	{
+		extern void __init root_nfs_parse_addr(char *name, u32 *addr);
+		u32 addr = INADDR_NONE;
+		root_nfs_parse_addr(root_server_path, &addr);
+		if (root_server_addr == INADDR_NONE)
+			root_server_addr = addr;
+	}
+#endif
+
 	/*
 	 * Use defaults whereever applicable.
 	 */
