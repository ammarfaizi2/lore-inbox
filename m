Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSFEMRF>; Wed, 5 Jun 2002 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSFEMRF>; Wed, 5 Jun 2002 08:17:05 -0400
Received: from mons.uio.no ([129.240.130.14]:61165 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S311885AbSFEMRE>;
	Wed, 5 Jun 2002 08:17:04 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Matthias Welk <welk@fokus.gmd.de>
Subject: Re: nfs slowdown since 2.5.4
Date: Wed, 5 Jun 2002 14:16:56 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206041253.44446.welk@fokus.gmd.de> <200206041928.54392.trond.myklebust@fys.uio.no> <3CFDFAF6.8090801@fokus.fhg.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8GF833WG5IQCPQQAZPU2"
Message-Id: <200206051416.56927.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_8GF833WG5IQCPQQAZPU2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Wednesday 05 June 2002 13:50, Matthias Welk wrote:

> Yes, the lookup rate increased 1/3 compared to the unpatched version.
> I have attached updated results of the build process, because there was a
> mistake for the 2.4.18 version.

I'm still confused about this... It suggests a sign error in a comparison 
somewhere, but I cannot for the life of me see where...

However I do see some cases where we should update timestamps on dentries, but 
are cleearly forgetting to do so. If this patch too leads to increased lookup 
rates...

Cheers,
  Trond

--------------Boundary-00=_8GF833WG5IQCPQQAZPU2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="gnarf.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="gnarf.dif"

--- fs/nfs/dir.c.orig	Tue Mar 12 16:35:02 2002
+++ fs/nfs/dir.c	Wed Jun  5 14:09:32 2002
@@ -554,6 +554,8 @@
 	}
 	if (is_bad_inode(inode))
 		force_delete(inode);
+	/* When creating a negative dentry, we want to renew d_time */
+	nfs_renew_times(dentry);
 	iput(inode);
 }
 
@@ -1064,6 +1066,7 @@
 		d_rehash(rehash);
 	if (!error && !S_ISDIR(old_inode->i_mode))
 		d_move(old_dentry, new_dentry);
+	nfs_renew_times(new_dentry);
 
 	/* new dentry created? */
 	if (dentry)

--------------Boundary-00=_8GF833WG5IQCPQQAZPU2--
