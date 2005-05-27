Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVE0BjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVE0BjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVE0BhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:37:12 -0400
Received: from eth2613.sa.adsl.internode.on.net ([150.101.239.52]:30671 "EHLO
	eth2613.sa.adsl.internode.on.net") by vger.kernel.org with ESMTP
	id S261435AbVE0BeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:34:15 -0400
Date: Fri, 27 May 2005 10:59:09 +0930
From: jpearson <jpearson@oasissystems.com.au>
To: linux-kernel@vger.kernel.org
Cc: Olivier Guerrier <olivier.lkml@guerrier.com>
Subject: Re: Fake ext3 corruption on raid5 in 2.6 .9 smp
Message-ID: <20050527012909.GA32085@oasissystems.com.au>
Reply-To: huiac@internode.on.net
References: <42959820.7090309@guerrier.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42959820.7090309@guerrier.com>
User-Agent: Mutt/1.5.9i
X-Spam-Score: -105.8
X-Spam-Report: Spam detection software, running on the system "foghorn2.internal",
	has examined this email to determine if it is likely to be spam.
	The original message has been attached to this so you can view it
	(if it isn't spam) or label similar future email.
	The presence of these headers does not, by itself, indicate that this
	is spam; they are provided for your information.
	The actual score awarded to this email appears in the 'X-Spam-Score'
	header; if the score is high enough that this is likely to be spam,
	then the subject line will have been modified or the message rejected,
	depending on how highly it scored.
	A summary of the scores awarded by individual tests appears below.
	If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, I saw this exact same error (EXT3-fs error (device
	dm-x): ext3_readdir: bad entry in directory #nnnnnnn: rec_len % 4 != 0
	- offset=0, inode=xxxxxxxx, rec_len=... from time to time in my non-SMP
	RAID system with 512Mb RAM, with ext3 on LVM on top of RAID5. [...] 
	Content analysis details:   (-105.8 points, 4.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw this exact same error (EXT3-fs error (device dm-x): ext3_readdir:
bad entry in directory #nnnnnnn: rec_len % 4 != 0 - offset=0, inode=xxxxxxxx,
rec_len=...

from time to time in my non-SMP RAID system with 512Mb RAM, with ext3 on LVM on top of RAID5.

Never caused actual corruption - run FSCK, no errors, remount rw
successfully until next time; error rarely in the same place, but always
in a directory and rec_len % 4 != 0.  Looks like an 'in-kernel' thing,
because (e.g.) running find on the volume after remounting rw produced
no issues, so presumably the on-disk directory wasn't *really* the
issue.

Filesystems between about 8 and 50 Gb, and not what I'd characterise as a
heavy load.

This was with about 2.6.4 - 2.6.7.  I'm running 2.6.11 now and haven't
seen it in some time; so it was either fixed by 2.6.11, or mounting ro
by default has just reduced my exposure.


John Pearson.


On Thu, May 26, 2005 at 11:34:24AM +0200, Olivier Guerrier wrote
> Hello,
> 
> I've encoutered the following strangeness with a newly installed box.
> This box was not previously running Linux, but has been carefully tested
> with memtest86, cpuburn, and some smalls scripts of mine. So hardware
> failure may be excluded at first.
> 
> The box is an asus a7m266D with dual athlon-MP (true MP), 2Go RAM, and
> the raid 5 set is build on 4 maxtor 160Go connected to 2 additionals
> sil0680 ata133 IDE controllers.
> 
> I use dm aes encryption over sotfware raid5, and under heavy load,
> I get theses error messages, and the partition is remounted ro:
> 
> 8<--
> EXT3-fs error (device dm-6): ext3_readdir: bad entry in directory
> #20515395: rec_len % 4 != 0 - offset=0, inode=1605429031, rec_len=14026,
> name_len=177
> Aborting journal on device dm-6.
> ext3_abort called.
> EXT3-fs error (device dm-6): ext3_journal_start_sb: Detected aborted journal
> Remounting filesystem read-only
> EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
> (repeated 3 times)
> EXT3-fs error (device dm-6) in ext3_ordered_writepage: IO failure
> EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
> (repeated 53 times)
> __journal_remove_journal_head: freeing b_committed_data (repeated 5 times)
> -->8
> 
> It is easily reproducible.
> 
> fsck show no error, no hardware related message found in dmesg, the raid
> set is not marked as bad, no reconstruction needed. I just remount the
> partition rw, and now try to keep the box out of pressure.
> 
> Googling around I found theses threads, but it does not contain a
> conclusion:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107913912311421&w=2
> and
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=+295657
> 
> The kernel is patched with grsec, I have disabled it all but same
> behaviour occur, maybe a vanilla will change something, but previous
> links show same error on non-grsec kernel.
> 
> attached is my .config and boot-time dmesg.
> 
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: config.txt
> Url: http://lists.us.dell.com/pipermail/linux-kernel-daily-digest/attachments/20050526/15e8620a/config.txt
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: dmesg_boot.txt
> Url: http://lists.us.dell.com/pipermail/linux-kernel-daily-digest/attachments/20050526/15e8620a/dmesg_boot.txt
> 
> ------------------------------

-- 
Voice: +61 8 8202 9040
Email: jpearson@oasissystems.com.au

Oasis Systems Pty Ltd
288 Glen Osmond Road
Fullarton, South Australia 5063

Ph: + 61 8 82029000
Fax: +61 8 82029001

CAUTION: This email and any attachments may contain information that is
confidential and subject to copyright. If you are not the
intended recipient, you must not read, use, disseminate, distribute or
copy this email or any attachments. If you have received this
email in error, please notify the sender immediately by reply email and
erase this email and any attachments.

DISCLAIMER: OASIS Systems uses virus-scanning technology but accepts
no responsibility for loss or damage arising from the use of the
information transmitted by this email including damage from virus.

