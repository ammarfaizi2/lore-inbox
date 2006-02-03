Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWBCTJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWBCTJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWBCTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:09:44 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:12943 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1422690AbWBCTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:09:43 -0500
Date: Fri, 3 Feb 2006 20:09:15 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Bill Davidsen <davidsen@tmr.com>,
       Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: RAID5 unusably unstable through 2.6.14
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9959@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0602031937300.24081@kepler.fjfi.cvut.cz>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9959@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Salyzyn, Mark wrote:

> Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> >       sd 0:0:0:0: SCSI error: return code = 0x8000002
> >       sda: Current: sense key: Hardware Error
> >           Additional sense: Internal target failure
> >       Info fld=0x0
> >       end_request: I/O error, dev sda, sector <some sector number>
> 
> You reported that the Adaptec management software did not indicate the
> array was offline in the Adapter, thus these reports come when there is
> a unrecoverable (non-redundant) bad block being read from the physical
> media.

Well, it is strange indeed.

> The alternate to this is that such a condition or similar had
> existed in the past, and the media bad block was remapped then marked as
> inconsistent (as noted, until a write makes it consistent).
>
> However, such conditions do not make the array inaccessible from dd as
> you indicate (unless block 0 is the inconsistent block?);

No that wasn't the case. The BIOS Media Verification procedure found the 
inconsistency at the position of about 83% of the first 160 GB disk. That 
is 1.6 GB per 1%, which means that was at about 132.8-th GB from the 
beginning of the disk, substracting the leading 120 GB for the other array 
places it at about 12.8-th GB of the 40 GB array in question (/dev/sda).

> thus the array
> must have been offline.

If it was, then the driver didn't know about it, or at least didn't report 
it. On the other hand, if the offline state were to be caused by the 
controller itself, then there would be absolutely no explanation for 
Windows both comletely booting from /dev/sda1 and then normally accessing 
both /dev/sda1 (C:) and /dev/sda2 (through Total Commander's ext2 plugin). 
If controller was to put the device offline, then even the wondows driver 
would be unable to access it, I guess, wouldn't it?

And I did even things like:

1) First trying to boot Linux. Grub loaded the system image, which resides 
on /dev/sda2 (!!) using BIOS (!!). Then kernel booted, but when it was to 
mount the root partition which is /dev/sda2, the messages appeared and 
nothing happened.

2) Then I booted Knoppix from CD. Tried accessing /dev/sda, which 
again resulted in the same behaviour as in the step 1) (the messages 
mentioned on top of this mail). However mounting and R/W to the /dev/sdb 
(RAID 5) works fine, though I cannot say whether it was degraded or not. 
Kernel didn't indicate any such thing and neither did Adaptec BIOS. 
(Actually untill I did the BIOS' Media Verification, which was much later, 
even the Adaptec BIOS was thinking that BOTH (!!!) arrays are in OK and 
non-degraded state.)

3) So I tried booting Windows from /dev/sda1. Complete success. Both 
reading and writing to C: (/dev/sda1) were working and no strange 
behaviour of any king was observed. Even the Adaptec management cools 
didn't complain about anything anywhere.

4) Using the Total Commander's ext2 plugin I tried to access the Linux 
partition /dev/sdb2, in a hope to at least save some important data and 
configuration files, if Linux wasn't able to access them. Again complete 
success. Not only was I able to read everything, I was also able to write.

5) Being stimulated by the success of Windows, I tried to boot the Linux 
again, but again no success, behaviour completely the same as in step 1).

6) So I tried the Adaptec BIOS again. This time at first the array status 
showed the RAID 5 in OK non-degraded state, and the Volume in OK state. So 
I figured I may try the Media Verification option of the first HDD. And 
that failed at 83%. The failure of this test resulted in the BIOS marking 
the entire HDD as faulty and removing it from both arrays. Which have only 
first at this point (!!) put the RAID 5 array into the degraded mode and 
the Volume array was empty without any disk in it. Of course at this point 
I had no other choice than to low-level format it, reinsert it into both 
arrays, resync the RAID 5 array, and completely reinstall both systems on 
the Volume arrays. Ever since then it works, OK.

> Too bad we can not reproduce this, the
> management applications must have indicated the array was offline (two
> drive + failure).

Maybe you could, if you try the procedure that I've described in the 
previos mails and are lucky. That may be worth trying, if you have any 
such system for experiments.

Martin
