Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSG2PTQ>; Mon, 29 Jul 2002 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSG2PTQ>; Mon, 29 Jul 2002 11:19:16 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:1518 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S313416AbSG2PTP>; Mon, 29 Jul 2002 11:19:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Axel Siebenwirth <axel@hh59.org>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.29: Oops at boot after mount of root fs (JFS)
Date: Mon, 29 Jul 2002 10:22:14 -0500
X-Mailer: KMail [version 1.4]
References: <20020729151621.GB661@prester.freenet.de>
In-Reply-To: <20020729151621.GB661@prester.freenet.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207291022.15086.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 10:16, Axel Siebenwirth wrote:
> Hi,
>
> I get an oops during boot of 2.5.29. Since I have problems with JFS I
> guessed it might be related to JFS. It happens right after rw mount
> of my jfs root filesystem. At another attempt to boot not the rm
> process oops but mount itself oopsed.

JFS had two incorrect calls to d_delete in jfs_rmdir and jfs_unlink.  They
were needed in the 2.2 kernel, and somehow they didn't do any apparent
harm until now.

Here is that patch I sent to Linus:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.511   -> 1.512  
#	      fs/jfs/namei.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/29	shaggy@kleikamp.austin.ibm.com	1.512
# Remove d_delete call from jfs_rmdir and jfs_unlink
# 
# jfs_rmdir and jfs_unlink have always called d_delete, but it hasn't
# caused a problem until 2.5.28.  The call is an artifact of the 2.2
# kernel, which had gone unnoticed in 2.4 and 2.5.
# --------------------------------------------
#
diff -Nru a/fs/jfs/namei.c b/fs/jfs/namei.c
--- a/fs/jfs/namei.c	Mon Jul 29 09:18:53 2002
+++ b/fs/jfs/namei.c	Mon Jul 29 09:18:53 2002
@@ -399,8 +399,6 @@
 
 	IWRITE_UNLOCK(dip);
 
-	d_delete(dentry);
-
       out2:
 	free_UCSname(&dname);
 
@@ -542,8 +540,6 @@
 	}
 
 	IWRITE_UNLOCK(dip);
-
-	d_delete(dentry);
 
       out1:
 	free_UCSname(&dname);

