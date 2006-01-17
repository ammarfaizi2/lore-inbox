Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWAQUOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWAQUOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAQUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:14:04 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:12168 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S964812AbWAQUN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:13:57 -0500
Date: Tue, 17 Jan 2006 21:13:49 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <20060117193913.GD3714@kvack.org>
Message-ID: <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Benjamin LaHaise wrote:

> On Tue, Jan 17, 2006 at 01:35:46PM -0600, Cynbe ru Taren wrote:
> > In principle, RAID5 should allow construction of a
> > disk-based store which is considerably MORE reliable
> > than any individual drive.
> > 
> > In my experience, at least, using Linux RAID5 results
> > in a disk storage system which is considerably LESS
> > reliable than the underlying drives.
> 
> That is a function of how RAID5 works.  A properly configured RAID5 array 
> will have a spare disk to take over in case one of the members fails, as 
> otherwise you run a serious risk of not being able to recover any data.
> 
> > What happens repeatedly, at least in my experience over
> > a variety of boxes running a variety of 2.4 and 2.6
> > Linux kernel releases, is that any transient I/O problem
> > results in a critical mass of RAID5 drives being marked
> > 'failed', at which point there is no longer any supported
> > way of retrieving the data on the RAID5 device, even
> > though the underlying drives are all fine, and the underlying
> > data on those drives almost certainly intact.
> 
> Underlying disks should not be experiencing transient failures.  Are you 
> sure the problem isn't with the disk controller you're building your array 
> on top of?  At the very least any bug report requires that information to 
> be able to provide even a basic analysis of what is going wrong.

Well, I had a similar experience lately with the Adaptec AAC-2410SA RAID 
5 array. Due to the CPU overheating the whole box was suddenly shot down 
by the CPU damage protection mechanism. While there is no battery backup 
on this particular RAID controller, the sudden poweroff caused some very 
localized inconsistency of one disk in the RAID. The configuration was 
1x160 GB and 3x120GB, with the 160 GB being split into 120 GB part within 
the RAID 5 and a 40 GB part as a separate volume. The inconsistency 
happend in the 40 GB part of the 160 GB HDD (as reported by the Adaptec 
BIOS media check). In particular the problem was in the /dev/sda2 (with 
/dev/sda being the 40 GB Volume, /dev/sda1 being an NTFS Windows system, 
and /dev/sda2 being ext3 Linux system).

Now, what is interesting, is that Linux completely refused any possible 
access to every byte within /dev/sda, not even dd(1) reading from any 
position within /dev/sda, not even "fdisk /dev/sda", nothing. Everything 
ended up with lots of following messages:

        sd 0:0:0:0: SCSI error: return code = 0x8000002
        sda: Current: sense key: Hardware Error
            Additional sense: Internal target failure
        Info fld=0x0
        end_request: I/O error, dev sda, sector <some sector number>

I've consulted this with Mark Salyzyn, because I thought it was a problem 
of the AACRAID driver. But I was told, that there is nothing that AACRAID 
can possibly do about it, and that it is a problem of the upper Linux 
layers (block device layer?) that are strictly fault intollerant, and 
thouth the problem was just an inconsistency of one particular localized 
region inside /dev/sda2, Linux was COMPLETELY UNABLE (!!!!!) to read a 
single byte from the ENTIRE VOLUME (/dev/sda)!

And now for the best part: From Windows, I was able to access the ENTIRE 
VOLUME without the slightest problem. Not only did Windows boot entirely 
from the /dev/sda1, but using Total Commander's ext3 plugin I was also 
able to access the ENTIRE /dev/sda2 and at least extract the most 
important data and configurations, before I did the complete low-level 
formatting of the drive, which fixed the inconsistency problem.

I call this "AN IRONY" to be forced to use Windows to extract information 
from Linux partition, wouldn't you? ;)

(Besides, even GRUB (using BIOS) accessed the /dev/sda without 
complications - as it was the bootable volume. Only Linux failed here a 
100%. :()

Martin
