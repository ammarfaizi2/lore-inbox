Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTBLLIi>; Wed, 12 Feb 2003 06:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTBLKzl>; Wed, 12 Feb 2003 05:55:41 -0500
Received: from ns.suse.de ([213.95.15.193]:3333 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267038AbTBLKyK>;
	Wed, 12 Feb 2003 05:54:10 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Date: Wed, 12 Feb 2003 12:03:58 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
References: <200302112018.58862.agruen@suse.de> <20030211123223.1d95ad72.akpm@digeo.com>
In-Reply-To: <20030211123223.1d95ad72.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_M207LNY2W3W7QXT4NMVM"
Message-Id: <200302121203.58216.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_M207LNY2W3W7QXT4NMVM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 11 February 2003 21:32, Andrew Morton wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > Hi Andrew,
> >
> > here are five patches against 2.5.60. Each file contains a brief
> > description of what it does.
>
> Minor point:
> ext3_journal_stop() can return an error code - most notable -EIO if
> it was a synchronous transaction, or the filesystem has detected
> corruption.

Thanks, I have overlooked this third bug. An incremental patch on top of=20
my previous kernel_lock_bug.diff is attached. (I have also uploaded the=20
patches to <http://acl.bestbits.at/pre/v2.5/> in the meantime).

> > The third to fifth are all steps towards trusted extended
> > attributes, which are useful for privileged processes (mostly
> > daemons). One use for this is Hierarchical Storage Management, in
> > which a user space daemon stores online/offline information for
> > files in trusted EA's, and the kernel communicates requests to
> > bring files online to that daemon. This class of EA's will also
> > find its way into XFS and ReiserFS, and expectedly also into JFS in
> > this form. (Trusted EAs are included in the 2.4.19/2.4.20 patches
> > as well.)
>
> So is this new code actually functional yet?  As in: something
> in-kernel using it?
>
> If not, what is involved in completing the kernel side of trusted
> EA's?

The important point for me now is to get the iops xattr-flags and=20
xattr-flags-policy patches into 2.5 so that the API won't change during=20
2.6. The xattr-trusted patch only affects file systems locally, so it's=20
far less critical.

The kernel side of trusted EAs is completely implemented with the=20
patches I sent. In the future there will very likely be modules=20
actually making use of the XATTR_KERNEL_CONTEXT flag, but Trusted EAs=20
are quite useful from user space alone.

Cheers,
Andreas.


--------------Boundary-00=_M207LNY2W3W7QXT4NMVM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="kernel_lock_bug2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kernel_lock_bug2.diff"

diff -u linux-2.5.60/fs/ext3/xattr.c linux-2.5.60/fs/ext3/xattr.c
--- linux-2.5.60/fs/ext3/xattr.c	2003-02-11 12:33:45.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.c	2003-02-12 11:18:18.000000000 +0100
@@ -848,7 +848,7 @@
 	       const void *value, size_t value_len, int flags)
 {
 	handle_t *handle;
-	int error;
+	int error, error2;
 
 	lock_kernel();
 	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
@@ -857,10 +857,10 @@
 	else
 		error = ext3_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
-	ext3_journal_stop(handle, inode);
+	error2 = ext3_journal_stop(handle, inode);
 	unlock_kernel();
 
-	return error;
+	return error ? error : error2;
 }
 
 /*

--------------Boundary-00=_M207LNY2W3W7QXT4NMVM--

