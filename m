Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263720AbTCUSWF>; Fri, 21 Mar 2003 13:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263716AbTCUSVB>; Fri, 21 Mar 2003 13:21:01 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:2434 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S263714AbTCUSUO>;
	Fri, 21 Mar 2003 13:20:14 -0500
Date: Fri, 21 Mar 2003 19:31:12 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ncpfs and rpcgss order in fs/Kconfig
Message-ID: <20030321183111.GA9243@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RPCSEC_GSS options are related to (only) nfs/nfsd, so it is
more logical to ask RPCSEC_GSS questions immediately after 
nfs/nfsd, not after half of screen more questions.

NCPFS related options should appear immediately below
ncpfs question, not after Coda and RPCSEC...

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz



--- vger/fs/Kconfig	2003-03-21 19:06:44.000000000 +0100
+++ linux/fs/Kconfig	2003-03-21 19:23:06.000000000 +0100
@@ -1357,6 +1357,35 @@
 	tristate
 	default NFSD
 
+config SUNRPC
+	tristate
+	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
+	default y if NFS_FS=y || NFSD=y
+
+config SUNRPC_GSS
+	tristate "Provide RPCSEC_GSS authentication (EXPERIMENTAL)"
+	depends on SUNRPC && EXPERIMENTAL
+	default SUNRPC if NFS_V4=y
+	help
+	  Provides cryptographic authentication for NFS rpc requests.  To
+	  make this useful, you must also select at least one rpcsec_gss
+	  mechanism.
+	  Note: You should always select this option if you wish to use
+	  NFSv4.
+
+config RPCSEC_GSS_KRB5
+	tristate "Kerberos V mechanism for RPCSEC_GSS (EXPERIMENTAL)"
+	depends on SUNRPC_GSS && CRYPTO_DES && CRYPTO_MD5
+	default SUNRPC_GSS if NFS_V4=y
+	help
+	  Provides a gss-api mechanism based on Kerberos V5 (this is
+	  mandatory for RFC3010-compliant NFSv4 implementations).
+	  Requires a userspace daemon;
+		see http://www.citi.umich.edu/projects/nfsv4/.
+
+	  Note: If you select this option, please ensure that you also
+	  enable the MD5 and DES crypto ciphers.
+
 config SMB_FS
 	tristate "SMB file system support (to mount Windows shares etc.)"
 	depends on INET
@@ -1460,6 +1489,8 @@
 	  will be called ncpfs.  Say N unless you are connected to a Novell
 	  network.
 
+source "fs/ncpfs/Kconfig"
+
 config CODA_FS
 	tristate "Coda file system support (advanced network fs)"
 	depends on INET
@@ -1497,37 +1528,6 @@
 	  support.  You will also need a file server daemon, which you can get
 	  from <http://www.inter-mezzo.org/>.
 
-config SUNRPC
-	tristate
-	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
-	default y if NFS_FS=y || NFSD=y
-
-config SUNRPC_GSS
-	tristate "Provide RPCSEC_GSS authentication (EXPERIMENTAL)"
-	depends on SUNRPC && EXPERIMENTAL
-	default SUNRPC if NFS_V4=y
-	help
-	  Provides cryptographic authentication for NFS rpc requests.  To
-	  make this useful, you must also select at least one rpcsec_gss
-	  mechanism.
-	  Note: You should always select this option if you wish to use
-	  NFSv4.
-
-config RPCSEC_GSS_KRB5
-	tristate "Kerberos V mechanism for RPCSEC_GSS (EXPERIMENTAL)"
-	depends on SUNRPC_GSS && CRYPTO_DES && CRYPTO_MD5
-	default SUNRPC_GSS if NFS_V4=y
-	help
-	  Provides a gss-api mechanism based on Kerberos V5 (this is
-	  mandatory for RFC3010-compliant NFSv4 implementations).
-	  Requires a userspace daemon;
-		see http://www.citi.umich.edu/projects/nfsv4/.
-
-	  Note: If you select this option, please ensure that you also
-	  enable the MD5 and DES crypto ciphers.
-
-source "fs/ncpfs/Kconfig"
-
 config AFS_FS
 # for fs/nls/Config.in
 	tristate "Andrew File System support (AFS) (Experimental)"
