Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311929AbSCOEiH>; Thu, 14 Mar 2002 23:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311930AbSCOEh6>; Thu, 14 Mar 2002 23:37:58 -0500
Received: from test.inspired.net.au ([216.122.33.55]:4298 "EHLO
	test.inspired.net.au") by vger.kernel.org with ESMTP
	id <S311929AbSCOEhw>; Thu, 14 Mar 2002 23:37:52 -0500
Message-Id: <200203150437.PAA30106@thucydides.inspired.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Mar 2002 15:37:17 +1100
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Patch to pull NFS server address off root_server_path
X-Mailer: VM 7.03 under Emacs 21.1.90.1
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version of a patch that I originally submitted to Rusty
Russell as trivial patch dude...

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

The only downside of the patch is that the summary that ipconfig
prints can be a little odd when the kernel command line overrides
whatever ipconfig gets from (say) DHCP.  The address from the kernel
command line seems to get stripped off early, so ipconfig reports it,
but it doesn't report the kernel command line NFS path, since that's
handled a bit later...

peace & happiness,
martin

diff -r -u linux-2.4.19-pre2/fs/nfs/nfsroot.c linux-2.4.19-pre2-working/fs/nfs/nfsroot.c
--- linux-2.4.19-pre2/fs/nfs/nfsroot.c	Thu Oct 25 11:29:22 2001
+++ linux-2.4.19-pre2-working/fs/nfs/nfsroot.c	Tue Mar 12 14:25:14 2002
@@ -163,37 +163,6 @@
 
 
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
@@ -344,7 +313,7 @@
 			line[sizeof(nfs_root_name) - strlen(NFS_ROOT) - 1] = '\0';
 		sprintf(nfs_root_name, NFS_ROOT, line);
 	}
-	root_nfs_parse_addr(nfs_root_name);
+	root_server_addr = root_nfs_parse_addr(nfs_root_name);
 	return 1;
 }
 
diff -r -u linux-2.4.19-pre2/include/linux/nfs_fs.h linux-2.4.19-pre2-working/include/linux/nfs_fs.h
--- linux-2.4.19-pre2/include/linux/nfs_fs.h	Tue Feb 26 11:39:37 2002
+++ linux-2.4.19-pre2-working/include/linux/nfs_fs.h	Tue Mar 12 14:25:14 2002
@@ -273,6 +273,9 @@
 extern int  nfs_mount(struct sockaddr_in *, char *, struct nfs_fh *);
 extern int  nfs3_mount(struct sockaddr_in *, char *, struct nfs_fh *);
 
+/* linux/net/ipv4/ipconfig.c: trims ip addr off front of name, too. */
+extern u32 root_nfs_parse_addr(char *name); /*__init*/
+
 /*
  * inline functions
  */
Only in linux-2.4.19-pre2-working/include/linux: nfs_fs.h.orig
diff -r -u linux-2.4.19-pre2/net/ipv4/ipconfig.c linux-2.4.19-pre2-working/net/ipv4/ipconfig.c
--- linux-2.4.19-pre2/net/ipv4/ipconfig.c	Tue Feb 26 07:14:51 2002
+++ linux-2.4.19-pre2-working/net/ipv4/ipconfig.c	Tue Mar 12 14:42:15 2002
@@ -1105,6 +1105,40 @@
 #endif /* CONFIG_PROC_FS */
 
 /*
+ *  Extract IP address from the parameter string if needed. Note that we
+ *  need to have root_server_addr set _before_ IPConfig gets called as it
+ *  can override it.
+ */
+u32 __init root_nfs_parse_addr(char *name)
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
 
@@ -1112,6 +1146,7 @@
 {
 	int retries = CONF_OPEN_RETRIES;
 	unsigned long jiff;
+	u32 addr;
 
 #ifdef CONFIG_PROC_FS
 	proc_net_create("pnp", 0, pnp_get_info);
@@ -1196,6 +1231,10 @@
 		/* Device selected manually or only one device -> use it */
 		ic_dev = ic_first_dev->dev;
 	}
+
+	addr = root_nfs_parse_addr(root_server_path);
+	if (root_server_addr == INADDR_NONE)
+		root_server_addr = addr;
 
 	/*
 	 * Use defaults whereever applicable.
