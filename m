Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280872AbRKGQxf>; Wed, 7 Nov 2001 11:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280871AbRKGQxY>; Wed, 7 Nov 2001 11:53:24 -0500
Received: from cliff.mcs.anl.gov ([140.221.9.17]:7552 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S280862AbRKGQxN>;
	Wed, 7 Nov 2001 11:53:13 -0500
Message-ID: <3BE964DE.D3628925@mcs.anl.gov>
Date: Wed, 07 Nov 2001 10:44:14 -0600
From: JP Navarro <navarro@mcs.anl.gov>
Organization: Argonne National Laboratory
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Raid/Adaptec/SCSI errors, obvious explanation isn't
In-Reply-To: <200110312049.f9VKnqY24522@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin,

We upgraded to 2.4.13-ac8 with aic7xxx 6.2.4. We also modified the kernel to
print the ASC and ASCQ codes. We've now seen the error only once:

SCSI disk error : host 2 channel 0 id 8 lun 0 return code = 8000002
Current sd08:51: sense key Hardware Error
Additional sense indicates Internal target failure
ASC=44 ASCQ= 0
 I/O error: dev 08:51, sector 65536016
   
How can we find out what ASC=44 means?
Is this a retriable failure and is it recovering?
Would this error cause corruption? (we haven't seen any)

On a sideline:

Repeated attempts to produce the error have failed due to some other kernel
problem: two processes doing I/O to separate raid/ext3 volumes stop in "D" and
"S" states. The D state process is doing a simple copy from local ext2 to local
raid/ext3, the S state process is doing an rsync of a remote machine. The D
process can't be killed, but when the S process is killed the D process
continues. These process are otherwise unrelated (they aren't even doing I/O to
the same file-system).

Thanks,

JP

"Justin T. Gibbs" wrote:
> 
> >We can consistently generate 1-2 of the following errors per hour:
> >
> >Oct 31 10:08:30 ccfs2 kernel: SCSI disk error : host 2 channel 0 id 9 lun 0
> >return code = 800
> >Oct 31 10:08:30 ccfs2 kernel: Current sd08:51: sense key Hardware Error
> >Oct 31 10:08:30 ccfs2 kernel: Additional sense indicates Internal target failu
> >re
> >Oct 31 10:08:30 ccfs2 kernel:  I/O error: dev 08:51, sector 35371392
> 
> ...
> >Previous postings have suggested hardware (disk) failures or a bug in the RAID
> ><-> Adaptec driver interaction.  We think disk failures are unlikely since
> >they are happening on multiple disks and only after a software upgrade.
> >
> >We once tested 15K drives on these EXP15 JBODs and encountered SCSI disks/driv
> >er errors, so we've suspected some type of JBOD problem under high load.
> >
> >Anyhow, does anyone have a clue as to what might be causing these errors, what
> >tests we could conduct to shed light on the problem, or additional information
> >we could provide that would be useful.
> 
> Its hard for me to believe that the aic7xxx driver could "make up" sense
> information returned from a drive that actually parsed correctly into a
> valid set of error codes.  What I can believe is that after one error
> occurs, this error shows up in commands that completed normally.  The
> Linux SCSI mid-layer assumes that if the first byte of the sense buffer
> is non-zero, it has been filled in regardless of the SCSI status byte
> that is returned by the driver.  Up until the 6.2.0 aic7xxx driver, the
> sense buffer's first byte was not zeroed out prior to executing a new
> command.  This could result in false positives in certain situations.
> If you ask me, the DRIVER_SENSE flag should only be set by the low level
> driver in the case of auto-sense, or by the mid-layer when manual sense
> recovery is successful (this latter case is somewhat questionable since
> a driver that can do autosense but failed may have cleared the real sense
> info already).  Poking around in a potentially unused buffer and guesing
> that its contents imply one thing or the other is bad design.
> 
> Anyway, the hardware error is in part real.  If you modify the code that
> prints out the error information to include the ASC and ASCQ code, the
> drive vendor may be able to tell you exactly what is going wrong with your
> drive.  If you upgrade to a later version of the aic7xxx driver (6.2.4 is
> the lastest), the number of errors you encounter may decrease due to the
> bug I listed above.
> 
> --
> Justin
