Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754661AbWKHUd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbWKHUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbWKHUdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:33:55 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:41664 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1754662AbWKHUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:33:54 -0500
Date: Wed, 8 Nov 2006 15:33:23 -0500
To: Suzuki <suzuki@linux.vnet.ibm.com>
Cc: reiserfs-list@namesys.com, lkml <linux-kernel@vger.kernel.org>,
       Jan Kara <jack@suse.cz>
Subject: Re: Problem with multiple mounts
Message-ID: <20061108203323.GA8238@csclub.uwaterloo.ca>
References: <45522E67.7050907@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45522E67.7050907@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 11:22:15AM -0800, Suzuki wrote:
> "I exported a disk partition using nbd protocol. On the nbd client, I 
> make reiserfs and run fsstress test case on this partition. At the same 
> time, I mount this partition on the nbd server. Then Oops appears as 
> following:"
> 
> ReiserFS: sda10: found reiserfs format "3.6" with standard journal
> ReiserFS: sda10: using ordered data mode
> ReiserFS: sda10: journal params: device sda10, size 8192, journal first 
> block 18, max trans len 1024, max batch 900, max commit age 30, max 
> trans age 30
> ReiserFS: sda10: checking transaction log (sda10)
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
> 
> Call Trace:
> [C000000011333090] [C0000000001EDB70] .journal_read+0x165c/0x1b6c 
> (unreliable)
> [C000000011333410] [C0000000001EF280] .journal_init+0xdc0/0xee8
> [C000000011333530] [C0000000001CDBD8] .reiserfs_fill_super+0xa90/0x1e40
> [C000000011333790] [C00000000011E988] .get_sb_bdev+0x208/0x31c
> [C000000011333870] [C0000000001CA00C] .get_super_block+0x38/0x60
> [C000000011333900] [C00000000011E260] .vfs_kern_mount+0xec/0x198
> [C0000000113339B0] [C00000000011E3E0] .do_kern_mount+0x88/0xdc
> [C000000011333A50] [C0000000001532CC] .do_mount+0xd50/0xe08
> [C000000011333D60] [C000000000175090] .compat_sys_mount+0x368/0x448
> [C000000011333E30] [C00000000000861C] syscall_exit+0x0/0x40
> 
> But, if we try the steps in the reverse order,
> 
> "mount the partition on nbd server first and then try fsstress tests on 
> the client side. This is just to ensure that the server is not seeing an 
> incomplete journal created by the client side runs."
> 
> Things work fine !
> 
> I doubt if this is due to the mount finding an incomplete journal 
> created by the client side fsstress runs in the first scenario.
> 
> My question is : Is this supported ? Mounting a filesystem which is 
> already mounted and replaying the ( - a may be incomplete- ) journal.

Absolutely not supported.  Unless you have a filesystem that is
specifically designed for simultanious read-write mount from multiple
places, then you can't.  For performance reasons most systems cache
writes and updates in many cases, so the data read by one system may be
out of date because another system has an update waiting to go to disk.
You need a filesystem that has the ability for multiple systems to talk
to each other about updates and locking and such things.  Look for a
cluster supporting filesystem or whatever is used to refer to a
filesystem that supports multiple hosts having it mounted to provide
redundant access.  No normal filesystem can do it unless everyone has it
mounted read only.  If you want to share it, use NFS.  That's what it's
for.

--
Len Sorensen
