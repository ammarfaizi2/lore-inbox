Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUJFM7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUJFM7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUJFM7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:59:53 -0400
Received: from unthought.net ([212.97.129.88]:28330 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S269255AbUJFM7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:59:32 -0400
Date: Wed, 6 Oct 2004 14:59:31 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: NFS+SMP+XFS problems, Take II
Message-ID: <20041006125931.GU18307@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Dear all,

The dcache patch (originally from Neil Brown, adapted for 2.6.8.1 by me)
has been included in the current 2.6.9 RC. It *seemed* that this patch
solved the XFS+NFS+SMP problem completely, and that it would then be
possible to finally run an NFS server with XFS on an SMP machine.

Well, close, but not close enough.

Today, my "small" system (described in the earlier XFS problems thread -
this is a dual athlon MP serving a ~150G XFS file system via. NFS) hosed
itself.

It is running 2.6.8.1 with the dcache patch
(http://lkml.org/lkml/2004/9/17/92).

Today I got the error:
----------------------------
Oct  6 12:44:53 phoenix kernel: xfs_iget_core: ambiguous vns: vp/0xf5c73de0, invp/0xf5c6be00
Oct  6 12:44:53 phoenix kernel: ------------[ cut here ]------------
Oct  6 12:44:53 phoenix kernel: kernel BUG at fs/xfs/support/debug.c:106!
Oct  6 12:44:53 phoenix kernel: invalid operand: 0000 [#1]
Oct  6 12:44:53 phoenix kernel: SMP
Oct  6 12:44:53 phoenix kernel: CPU:    1
Oct  6 12:44:53 phoenix kernel: EIP:    0060:[dev_change_name+279/496] Not tainted
Oct  6 12:44:53 phoenix kernel: EFLAGS: 00010246   (2.6.8.1)
Oct  6 12:44:53 phoenix kernel: EIP is at cmn_err+0x97/0xb0
Oct  6 12:44:53 phoenix kernel: eax: 00000040   ebx: 00000293   ecx: c036fa24   edx: c036fa24
Oct  6 12:44:53 phoenix kernel: esi: c033c1a7   edi: c0437c1e   ebp: 00000000   esp: f6553a94
Oct  6 12:44:53 phoenix kernel: ds: 007b   es: 007b   ss: 0068
Oct  6 12:44:53 phoenix kernel: Process nfsd (pid: 303, threadinfo=f6552000 task=f709b790)
Oct  6 12:44:53 phoenix kernel: Stack: c04208e0 f60799d4 f6552000 f7348d28 f5c6be20 c01f7fb2 000000 00 c0337040
Oct  6 12:44:53 phoenix kernel:        f5c73de0 f5c6be00 f5c6be20 f5c6be00 f6552000 00000008 f60799 d8 f60818d0
Oct  6 12:44:53 phoenix kernel:        c01f83cc f5c6be00 f7348c00 00000000 1c15be1b 00000000 000000 08 f6553b44
Oct  6 12:44:53 phoenix kernel: Call Trace:
Oct  6 12:44:53 phoenix kernel:  [e100_clean_cbs+98/240] xfs_iget_core+0x182/0x510
...
----------------------------

There exists another small patch for XFS which was a work-around for
some of this - that patch has, as far as I know, never made it into a
kernel, and, again as far as I know, there are some good reasons for
this (known to the XFS people I guess).

That patch is attached to this mail (ireclaim.diff) - I tried patching
my dcache-patched 2.6.8.1 kernel, but the patch had no effect on this
problem.

The server would BUG again, after starting up the knfsd processes (it
seems that an NFS client on the network had a queued request which would
consistently trigger this bug whenever the server came back up).


The *only* way in which I got this server back up and running, was to
boot it with "noapic noacpi nosmp" - booting it in uniprocessor mode. It
is now running that way, with a plain 2.6.8.1 and the dcache patch (no
XFS patches).

So, it seems that there is still a problem left, even after the dcache
patch.

The "window of opportunity" for whatever bug this is, has shrunk
considerably after the dcache patch got applied - the server now ran for
several weeks before hosing itself.

In other words; it seems the dcache patch was a move in the right
direction, but it also seems that there's something left.

Ideas, anyone?

-- 

 / jakob


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ireclaim.diff"

--- 1.53/fs/xfs/xfs_vnodeops.c	Tue Mar  2 06:35:29 2004
+++ edited/fs/xfs/xfs_vnodeops.c	Thu Mar  4 14:03:06 2004
@@ -3974,21 +3974,9 @@
 	 * avoids flushing the inode to disk during the delete operation
 	 * itself.
 	 */
-	if (!ip->i_update_core && (ip->i_itemp == NULL)) {
-		xfs_ilock(ip, XFS_ILOCK_EXCL);
-		xfs_iflock(ip);
-		return xfs_finish_reclaim(ip, 1, XFS_IFLUSH_DELWRI_ELSE_SYNC);
-	} else {
-		xfs_mount_t	*mp = ip->i_mount;
-
-		/* Protect sync from us */
-		XFS_MOUNT_ILOCK(mp);
-		vn_bhv_remove(VN_BHV_HEAD(vp), XFS_ITOBHV(ip));
-		list_add_tail(&ip->i_reclaim, &mp->m_del_inodes);
-		ip->i_flags |= XFS_IRECLAIMABLE;
-		XFS_MOUNT_IUNLOCK(mp);
-	}
-	return 0;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_iflock(ip);
+	return xfs_finish_reclaim(ip, 1, XFS_IFLUSH_DELWRI_ELSE_SYNC);
 }
 
 int
--- 1.20/fs/xfs/xfs_iget.c	Fri Jan  9 07:20:13 2004
+++ edited/fs/xfs/xfs_iget.c	Thu Mar  4 15:54:35 2004
@@ -578,7 +548,7 @@
 
 	/* We shouldn't get here without this being true, but just in case */
 	if (inode->i_state & I_NEW) {
-		make_bad_inode(inode);
+		remove_inode_hash(inode);
 		unlock_new_inode(inode);
 	}
 	if (lock_flags)

--3MwIy2ne0vdjdPXF--
