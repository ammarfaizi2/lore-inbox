Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280500AbRJaUtk>; Wed, 31 Oct 2001 15:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280499AbRJaUtb>; Wed, 31 Oct 2001 15:49:31 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:36881 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S280500AbRJaUtS>; Wed, 31 Oct 2001 15:49:18 -0500
Message-Id: <200110312049.f9VKnqY24522@aslan.scsiguy.com>
To: JP Navarro <navarro@mcs.anl.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: Raid/Adaptec/SCSI errors, obvious explanation isn't 
In-Reply-To: Your message of "Wed, 31 Oct 2001 14:02:48 CST."
             <3BE058E8.F9DC0FC1@mcs.anl.gov> 
Date: Wed, 31 Oct 2001 13:49:52 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We can consistently generate 1-2 of the following errors per hour:
>
>Oct 31 10:08:30 ccfs2 kernel: SCSI disk error : host 2 channel 0 id 9 lun 0
>return code = 800
>Oct 31 10:08:30 ccfs2 kernel: Current sd08:51: sense key Hardware Error
>Oct 31 10:08:30 ccfs2 kernel: Additional sense indicates Internal target failu
>re
>Oct 31 10:08:30 ccfs2 kernel:  I/O error: dev 08:51, sector 35371392

...
>Previous postings have suggested hardware (disk) failures or a bug in the RAID
><-> Adaptec driver interaction.  We think disk failures are unlikely since
>they are happening on multiple disks and only after a software upgrade.
>
>We once tested 15K drives on these EXP15 JBODs and encountered SCSI disks/driv
>er errors, so we've suspected some type of JBOD problem under high load.
>
>Anyhow, does anyone have a clue as to what might be causing these errors, what
>tests we could conduct to shed light on the problem, or additional information
>we could provide that would be useful.

Its hard for me to believe that the aic7xxx driver could "make up" sense
information returned from a drive that actually parsed correctly into a
valid set of error codes.  What I can believe is that after one error
occurs, this error shows up in commands that completed normally.  The
Linux SCSI mid-layer assumes that if the first byte of the sense buffer
is non-zero, it has been filled in regardless of the SCSI status byte
that is returned by the driver.  Up until the 6.2.0 aic7xxx driver, the
sense buffer's first byte was not zeroed out prior to executing a new
command.  This could result in false positives in certain situations.
If you ask me, the DRIVER_SENSE flag should only be set by the low level
driver in the case of auto-sense, or by the mid-layer when manual sense
recovery is successful (this latter case is somewhat questionable since
a driver that can do autosense but failed may have cleared the real sense
info already).  Poking around in a potentially unused buffer and guesing
that its contents imply one thing or the other is bad design.

Anyway, the hardware error is in part real.  If you modify the code that
prints out the error information to include the ASC and ASCQ code, the
drive vendor may be able to tell you exactly what is going wrong with your
drive.  If you upgrade to a later version of the aic7xxx driver (6.2.4 is
the lastest), the number of errors you encounter may decrease due to the
bug I listed above.

--
Justin
