Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVECWRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVECWRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVECWRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:17:41 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:27320 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261853AbVECWR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:17:27 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Davy Durham <pubaddr2@davyandbeth.com>
Date: Wed, 4 May 2005 08:17:20 +1000
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
Message-ID: <20050503221720.GD26031@cse.unsw.EDU.AU>
References: <4270FA5B.5060609@davyandbeth.com> <427770C9.1050808@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427770C9.1050808@davyandbeth.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davy

On Tue, 03 May 2005, Davy Durham wrote:

> I was thinking about delving into this problem a bit.   I don't have any 
> unpartitioned free space on my physical drive.  I was going to ask if 
> it's possible to create a virtual device in RAM or in a file that I 
> could then create an ext3 file system on for testing.. I'm at least 
> trying to recreate the situation of the negative diskspace usage.. then 
> maybe try to debug ext3 a bit.  At first I thought "oh RAMFS!", then "no 
> wait, I couldn't create an EXT3 file system that way".. I need a 
> non-physical (block? or character?) device.
> 
Make sure your kernel has ramdisk support, then

dd if=/dev/zero of=/dev/ram bs=1024k count=512
sbin/mkfs -t ext3 -b 1024 /dev/ram 524288
mount -t ext3 /dev/ram <where ever you want to mount the fs> 


Note*   you will need to be root
Note**  the block size of the fs has to be equal to the bs of the ram disk
Note*** if you get permissions denied when writing to /dev/ram try /dev/ramX (X=[0-9])
 
> Thanks,
>  Davy
> 
> 
> 
> Davy Durham wrote:
> 
> >Greetings,
> >  I'm having an issues with ext3.  For about 3 months the /home 
> >partition has had low-to-medium use/activity.. adding files, nightly 
> >log rotations, some mysql dbs coming and going at a slow pace..  Well, 
> >yesterday after I had migrated everything off of it (no files in /home 
> >anymore) the df output looked like this:
> >
> ># uptime
> >10:35:54 up 96 days, 14:22,  1 user,  load average: 0.00, 0.00, 0.00
> ># df -h
> >Filesystem            Size  Used Avail Use% Mounted on
> >/dev/ide/host0/bus0/target0/lun0/part1
> >                     2.0G  483M  1.4G  26% /
> >/dev/ide/host0/bus0/target0/lun0/part6
> >                      33G  -64Z   31G 101% /home
> >
> >I did notice that if I created a file (cat /dev/zero >/home/foo) of 
> >significant size that I could make it look normal again.. So I figure 
> >it's an underflow in some count.
> >
> >Crazy huh?  Well, I unmounted /home and did an fsck -f  on the 
> >partition and remounted it.  Then everything looked okay.
> >
> >---
> >
> >Well today on a different server (that I have not cleaned off yet) 
> >that has been up and running for 6 months is saying the same thing:
> >
> ># uptime
> >10:39:16 up 181 days,  2:42,  2 users,  load average: 0.00, 0.00, 0.00
> ># df -h
> >Filesystem            Size  Used Avail Use% Mounted on
> >/dev/ide/host0/bus0/target0/lun0/part1
> >                     2.0G  483M  1.4G  26% /
> >/dev/ide/host0/bus0/target0/lun0/part6
> >                      33G  -64Z   31G 101% /home
> >
> >Now, this server is still in production.  I could bring it down for a 
> >brief time to fsck or reboot it, but I'd be afraid to.  du -h /home 
> >shows that really only 268M is used.
> >
> >If I create a large file (176M) in /home it then don't underflow on 
> >the df, but is still incorrect.
> >
> >
> >Is this a known issue with ext3? Or ext2?  Anything I should or should 
> >not do about it?
> >
> >Thanks,
> >Davy
> >
> >
> >
> >
> >
> >BTW- df -k looks like
> ># df -k
> >Filesystem           1K-blocks      Used Available Use% Mounted on
> >/dev/ide/host0/bus0/target0/lun0/part1
> >                      2054064    493660   1454380  26% /
> >/dev/ide/host0/bus0/target0/lun0/part6
> >                     33690964 -73786976294838186940  31971456 101% /home
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe 
> >linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
