Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUHOAXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUHOAXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 20:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHOAXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 20:23:46 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:7069 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265521AbUHOAXn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 20:23:43 -0400
Date: Sat, 14 Aug 2004 18:23:40 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Otto Wyss <otto.wyss@orpatec.ch>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: New concept of ext3 disk checks
Message-ID: <20040815002340.GA19889@schnapps.adilger.int>
Mail-Followup-To: Otto Wyss <otto.wyss@orpatec.ch>,
	Theodore Ts'o <tytso@mit.edu>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <411BAFCA.92217D16@orpatec.ch> <20040812223907.GA7720@thunk.org> <20040813003403.GK18216@schnapps.adilger.int> <411DBC0C.7FE46F9C@orpatec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <411DBC0C.7FE46F9C@orpatec.ch>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 14, 2004  09:15 +0200, Otto Wyss wrote:
> Instead of a daily cron job I envision a solution where writes to the
> disk are checked for correctness within a short time lag after they have
> been done. Assume this time lag is set to a few minutes, on a high
> performance system not each write of a certain node gets checked while
> on a desktop system most probably each single write is. Choosing the
> right time lag gives a balance of discovering problems fast against
> additional disk access.
> 
> Okay, such tests could be done by a constantly running background task
> in user space. But since journalling just should guarantee that any disk
> access is done correct, even in case of problems, it should be
> considered if such test can be integrated there. This has the advantage
> that if journalling is able to guarantee correctness by other means
> these test aren't needed at all and may be completely remove.
> 
> What I want to achieve with this new concept is that the file system
> itself not only tries to prevent any data corruption but also tries to
> detect and report it if corruption still has happened anyway. 

The ext3 (and ext2) kernel code already does consistency checking of a
lot of data structures in the kernel, and if any errors are found the
superblock is marked with an "error" flag and the next time the system
is booted a full fsck is done.  The administrator has the option (via
the "errors=" mount option) to either panic the kernel, remount read-only,
or continue using the filesystem if an error is found.

The problem with re-reading blocks and checking for validity after a write
is that there is a good chance the block is still in cache (either kernel
buffer/page cache or disk cache) so this doesn't really add much robustness.
The other problem with this is that checking individual block validity
doesn't take the "big picture" into account since if we just wrote a block
to disk we assume that what we wrote is the correct thing so re-checking
this same data doesn't help much.

The periodic fsck of a filesystem snapshot, on the other hand, is as good 
as you can get for validity checking.  The only additional feature needed
is online repair, but that is a .00001% requirement vs. actually detecting
the error in the first place.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

