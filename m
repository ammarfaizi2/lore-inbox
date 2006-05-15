Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWEOT3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWEOT3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWEOT3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:29:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:56737 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751481AbWEOT3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:29:36 -0400
Date: Mon, 15 May 2006 14:29:32 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       phillip@hellewell.homeip.net, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.17-rc4-mm1
Message-ID: <20060515192931.GA3388@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515164938.GB10143@mipter.zuzino.mipt.ru> <20060515100144.0aff41b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515100144.0aff41b1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 10:01:44AM -0700, Andrew Morton wrote:
> I don't immediately see how to fix this one, actually:
> 
> static inline int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
> {
> 	return vfs_statfs(ecryptfs_superblock_to_lower(sb), buf);
> }
> 
> Once we've run ecryptfs_superblock_to_lower() to get the "lower
> superblock", we need to turn that back into a vfsmount for
> vfs_statfs()..

Assuming we have all our other ducks in a row, this should work. I
still need to finish the build and run my tests to say for certain,
but here is a tentative fix.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

Index: linux-2.6.17-rc4-mm1-ecryptfs/fs/ecryptfs/super.c
===================================================================
--- linux-2.6.17-rc4-mm1-ecryptfs.orig/fs/ecryptfs/super.c      2006-05-15 14:16:15.000000000 -0500
+++ linux-2.6.17-rc4-mm1-ecryptfs/fs/ecryptfs/super.c   2006-05-15 14:27:45.000000000 -0500
@@ -124,9 +124,12 @@
  * Get the filesystem statistics. Currently, we let this pass right through
  * to the lower filesystem and take no action ourselves.
  */
-static inline int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int ecryptfs_statfs(struct vfsmount *vfs_mnt, struct kstatfs *buf)
 {
-       return vfs_statfs(ecryptfs_superblock_to_lower(sb), buf);
+       struct vfsmount *lower_mnt;
+
+       lower_mnt = ecryptfs_superblock_to_private(vfs_mnt->mnt_sb)->lower_mnt;
+       return vfs_statfs(lower_mnt, buf);
 }
 
 /**
