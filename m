Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWBBUc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWBBUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWBBUc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:32:57 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:3888 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932218AbWBBUcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:32:55 -0500
Message-ID: <43E26CB6.7030808@tmr.com>
Date: Thu, 02 Feb 2006 15:33:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org> <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab wrote:

> Well, I had a similar experience lately with the Adaptec AAC-2410SA RAID 
> 5 array. Due to the CPU overheating the whole box was suddenly shot down 
> by the CPU damage protection mechanism. While there is no battery backup 
> on this particular RAID controller, the sudden poweroff caused some very 
> localized inconsistency of one disk in the RAID. The configuration was 
> 1x160 GB and 3x120GB, with the 160 GB being split into 120 GB part within 
> the RAID 5 and a 40 GB part as a separate volume. The inconsistency 
> happend in the 40 GB part of the 160 GB HDD (as reported by the Adaptec 
> BIOS media check). In particular the problem was in the /dev/sda2 (with 
> /dev/sda being the 40 GB Volume, /dev/sda1 being an NTFS Windows system, 
> and /dev/sda2 being ext3 Linux system).
> 
> Now, what is interesting, is that Linux completely refused any possible 
> access to every byte within /dev/sda, not even dd(1) reading from any 
> position within /dev/sda, not even "fdisk /dev/sda", nothing. Everything 
> ended up with lots of following messages:
> 
>         sd 0:0:0:0: SCSI error: return code = 0x8000002
>         sda: Current: sense key: Hardware Error
>             Additional sense: Internal target failure
>         Info fld=0x0
>         end_request: I/O error, dev sda, sector <some sector number>

But /dev/sda is not a Linux filesystem, running fsck on it makes no 
sense. You wanted to run on /dev/sda2.
> 
> I've consulted this with Mark Salyzyn, because I thought it was a problem 
> of the AACRAID driver. But I was told, that there is nothing that AACRAID 
> can possibly do about it, and that it is a problem of the upper Linux 
> layers (block device layer?) that are strictly fault intollerant, and 
> thouth the problem was just an inconsistency of one particular localized 
> region inside /dev/sda2, Linux was COMPLETELY UNABLE (!!!!!) to read a 
> single byte from the ENTIRE VOLUME (/dev/sda)!

The obvious test of this "it's not us" statement is to connect that one 
drive to another type controller and see if the upper level code 
recovers. I'm assuming that "sda" is a real drive and not some 
pseudo-drive which exists only in the firmware of the RAID controller. 
That message is curious, did you cat /proc/scsi/scsi to see what the 
system thought was there? Use the infamous "cdrecord -scanbus" command?

> 
> And now for the best part: From Windows, I was able to access the ENTIRE 
> VOLUME without the slightest problem. Not only did Windows boot entirely 
> from the /dev/sda1, but using Total Commander's ext3 plugin I was also 
> able to access the ENTIRE /dev/sda2 and at least extract the most 
> important data and configurations, before I did the complete low-level 
> formatting of the drive, which fixed the inconsistency problem.
> 
> I call this "AN IRONY" to be forced to use Windows to extract information 
> from Linux partition, wouldn't you? ;)
> 
> (Besides, even GRUB (using BIOS) accessed the /dev/sda without 
> complications - as it was the bootable volume. Only Linux failed here a 
> 100%. :()

 From the way you say sda when you presumably mean sda1 or sda2 it's not 
clear if you don't understand the difference between drive and partition 
access or are just so pissed off you are not taking the time to state 
the distinction clearly.

There was a problem with recovery from errors in RAID-5 which is 
addressed by recent changes to fail a sector, try rewriting it, etc. I 
would have to read linux-raid archives to explain it, so I'll stop with 
the overview. I don't think that's the issue here, you're using a RAID 
controller rather than the software RAID, so it should not apply.

I assume that the problem is gone, so we can't do any more analysis 
after the fact.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
