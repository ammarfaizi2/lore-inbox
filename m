Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbUA2GCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUA2GCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:02:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:9950 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266083AbUA2GCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:02:03 -0500
Date: Wed, 28 Jan 2004 22:02:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Schwebel <robert@schwebel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DHCP root-path in 2.6
Message-Id: <20040128220230.641501ab.akpm@osdl.org>
In-Reply-To: <20040128122803.GP23652@pengutronix.de>
References: <20040128122803.GP23652@pengutronix.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel <robert@schwebel.de> wrote:
>
> Hi, 
> 
> the 2.6 behaviour of the root-path option seems to have changed: in 2.4
> it was possible to do this in the DHCP configuration:
> 
> 	option root-path "192.168.1.1:/path/to/root";
> 
> to specify an NFS server other than the TFTP boot server where the
> kernel comes from; in 2.6 the code in ipconfig.c which parses this
> option for the IP address has been removed. 
> 
> Was this done on purpuse or by accident? What's the "correct" way to
> specify the address? 

Actually it seems that this functionality was added to 2.4 after 2.5 was
forked off and never got forward ported.  I don't know if this was
deliberate or just an oversight.

The original patch seems to apply to 2.5 OK.  You get to test it ;)



# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2002/04/01 18:50:30-03:00 martin@meltin.net 
#   [PATCH] Patch to pull NFS server address off root_server_path
#   
#   Hi Marcelo,
#   
#   I've submitted the following patch to Trond Myklebust, who seems to
#   think it is OK.  Dave Jones has also included it in his 2.5 kernel
#   series...
#   
#   The following patch pulls an NFS server IP address off
#   root_server_path (handed out via the DHCP root-path option), if it is
#   present.  For example, you can do this sort of thing in dhcpd.conf:
#   
#     root-path = 192.168.1.33:/tftpboot/yip.zImage
#   
#   This lets you mount your root filesystem off a different machine than
#   you booted from, without needing to use kernel command-line
#   parameters.
#   
#   The patch appears to be backwards compatible.
#   
#   RFC2132 says this about the root-path option:
#   
#      This option specifies the path-name that contains the client's root
#      disk.  The path is formatted as a character string consisting of
#      characters from the NVT ASCII character set.
#   
#   This is sufficiently vague to allow the path-name to include an
#   IP-address.  Also, I found some documentation for FreeBSD saying it
#   does this too, so it must be right, because those FreeBSD guys are
#   really smart...  :-)
#   
#   The only downside of the patch is that the summary that ipconfig
#   prints can be a little odd when the kernel command line overrides
#   whatever ipconfig gets from (say) DHCP.  The address from the kernel
#   command line seems to get stripped off early, so ipconfig reports it,
#   but it doesn't report the kernel command line NFS path, since that's
#   handled a bit later...  This small cosmetic problem looks difficult to
#   "fix" without rewriting quite a bit of stuff...
#   
#   peace & happiness,
#   martin
# 
# net/ipv4/ipconfig.c
#   2002/03/12 11:42:15-03:00 martin@meltin.net +39 -0
#   Patch to pull NFS server address off root_server_path
# 
# include/linux/nfs_fs.h
#   2002/03/12 11:25:14-03:00 martin@meltin.net +3 -0
#   Patch to pull NFS server address off root_server_path
# 
# fs/nfs/nfsroot.c
#   2002/03/12 11:25:14-03:00 martin@meltin.net +1 -32
#   Patch to pull NFS server address off root_server_path
# 
diff -Nru a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
--- a/fs/nfs/nfsroot.c	Wed Jan 28 22:00:06 2004
+++ b/fs/nfs/nfsroot.c	Wed Jan 28 22:00:06 2004
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
 
diff -Nru a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
--- a/include/linux/nfs_fs.h	Wed Jan 28 22:00:06 2004
+++ b/include/linux/nfs_fs.h	Wed Jan 28 22:00:06 2004
@@ -276,6 +276,9 @@
 extern int  nfs_mount(struct sockaddr_in *, char *, struct nfs_fh *);
 extern int  nfs3_mount(struct sockaddr_in *, char *, struct nfs_fh *);
 
+/* linux/net/ipv4/ipconfig.c: trims ip addr off front of name, too. */
+extern u32 root_nfs_parse_addr(char *name); /*__init*/
+
 /*
  * inline functions
  */
diff -Nru a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
--- a/net/ipv4/ipconfig.c	Wed Jan 28 22:00:06 2004
+++ b/net/ipv4/ipconfig.c	Wed Jan 28 22:00:06 2004
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

