Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUKOUlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUKOUlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKOUjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:39:41 -0500
Received: from [81.23.229.73] ([81.23.229.73]:30595 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261688AbUKOUfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:35:39 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: Robin Holt <holt@sgi.com>
Subject: Re: 21 million inodes is causing severe pauses.
Date: Mon, 15 Nov 2004 21:35:35 +0100
User-Agent: KMail/1.6.2
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
In-Reply-To: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411152135.35121.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would help a lot if you provided logins to everybody on this list to this 
desktop system of you (-:

Anyway: There is temporary solution, which will help a little in this case: 
Increase the blocksize so that your total number of inodes decreases. Since 
XFS is your own filesystem, you could calculate the results of this pretty 
quick.

Using another filesystem could help too, but I don't have any comparison bases 
for this since the largest system we have here at this moment only has 1 TB 
of diskspace.
I will monitor this thread though, we are in tender for a somewhat larger 
project in which problems like this could become our problem too.

On Monday 15 November 2004 20:55, you wrote:
> The subject line is a little deceiving.  That number comes from using
> XFS on a 2.4 kernel.  With a 2.6 kernel, we see problems similar to the
> ones we are experiencing on 2.4, only less severe.
>
> Digging into this some more, we determined the problem is the large number
> of inodes and dentry items held.  For a machine with 32GB of memory and
> 8 cpus doing build type activity, we have found it stabilizes at between
> 2 and 8 million entries.
>
> One significant problem we are running into is autofs trying to umount the
> file systems.  This results in the umount grabbing the BKL and inode_lock,
> holding it while it scans through the inode_list and others looking for
> inodes used by this super block and attempting to free them.
>
> We patched a SLES9 kernel with the patch found in the -mm tree which
> attempts to address this problem by linking inodes off the sb structure.
> This does make the umount somewhat quicker, but on a busy nfs mounted
> filesystem, the BKL and inode_lock do still get in the way causing
> frequent system pauses on the order of seconds.  This is on a SLES9
> kernel which we just put into a test production environment last Thursday.
> By 8:00 AM Friday, the system was unusable.
>
> Additionally, we experience NULL pointer dereferences during
> remove_inode_buffers.  I have not looked for additional patches in the
> -mm tree to address that problem.
>
> While discussing this in the hallway, we have come up with a few possible
> alternatives.
>
> 1) Have the dentry and inode sizes limited on a per sb basis
>    with a mount option as an override for the default setting.
>
> 2) Have the vfs limit dentry and inode cache sizes based on
>    slab usage (ie, nfs, ext2, and xfs slab sizes are limited independently
>    of each other.
>
> 3) Have the vfs limit it based on total inode_list entries.
>
> We are not sure which if any is the right direction to go at this time.
> We are only hoping to start a discussion.  Any guidance would be
> appreciated.
>
> Thank you,
> Robin Holt
>
> PS:  The patch referred to above is:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109474397830096&w=2
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
