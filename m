Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbUKOUDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUKOUDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKOUCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:02:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29928 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261678AbUKOT4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:56:19 -0500
Date: Mon, 15 Nov 2004 13:55:52 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: dev@sw.ru, wli@holomorphy.com, steiner@sgi.com, sandeen@sgi.com
Subject: 21 million inodes is causing severe pauses.
Message-ID: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The subject line is a little deceiving.  That number comes from using
XFS on a 2.4 kernel.  With a 2.6 kernel, we see problems similar to the
ones we are experiencing on 2.4, only less severe.

Digging into this some more, we determined the problem is the large number
of inodes and dentry items held.  For a machine with 32GB of memory and
8 cpus doing build type activity, we have found it stabilizes at between
2 and 8 million entries.

One significant problem we are running into is autofs trying to umount the
file systems.  This results in the umount grabbing the BKL and inode_lock,
holding it while it scans through the inode_list and others looking for
inodes used by this super block and attempting to free them.

We patched a SLES9 kernel with the patch found in the -mm tree which
attempts to address this problem by linking inodes off the sb structure.
This does make the umount somewhat quicker, but on a busy nfs mounted
filesystem, the BKL and inode_lock do still get in the way causing
frequent system pauses on the order of seconds.  This is on a SLES9
kernel which we just put into a test production environment last Thursday.
By 8:00 AM Friday, the system was unusable.

Additionally, we experience NULL pointer dereferences during
remove_inode_buffers.  I have not looked for additional patches in the
-mm tree to address that problem.

While discussing this in the hallway, we have come up with a few possible
alternatives.

1) Have the dentry and inode sizes limited on a per sb basis
   with a mount option as an override for the default setting.

2) Have the vfs limit dentry and inode cache sizes based on
   slab usage (ie, nfs, ext2, and xfs slab sizes are limited independently
   of each other.

3) Have the vfs limit it based on total inode_list entries.

We are not sure which if any is the right direction to go at this time.
We are only hoping to start a discussion.  Any guidance would be
appreciated.

Thank you,
Robin Holt

PS:  The patch referred to above is:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109474397830096&w=2
