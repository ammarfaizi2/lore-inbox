Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278597AbRKHVm7>; Thu, 8 Nov 2001 16:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRKHVmu>; Thu, 8 Nov 2001 16:42:50 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:52728 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S278591AbRKHVmi>; Thu, 8 Nov 2001 16:42:38 -0500
Message-ID: <9678C2B4D848D41187450090276D1FAE1008ECFE@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'JP Navarro'" <navarro@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Raid/Adaptec/SCSI errors, obvious explanation isn't
Date: Thu, 8 Nov 2001 13:44:16 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JP,

Sense Key = 04  (Hardware Error)
ASC = 0x44      0x44,00 = Internal target failure
ASCQ = 0x00
See SCSI-3 spec, Table 66 for descriptions.  This text is also what the
error message returns.  

The problem should be reported to the disk manufacturer.  They will want to
see a SCSI trace of the problem, the model, firmware level, and mode page
configuration of the disk.  There are some conditions on the disk itself
that are dependent on timing & configuration, so your software change could
have exposed a disk problem that was previously latent.  Some errors can be
resolved with disk firmware upgrades or mode page changes, this may be one
of those.

BTW, I always turn off SMART & WCE in the mode pages for maximum disk
reliability.

Andy

-----Original Message-----
From: JP Navarro [mailto:navarro@mcs.anl.gov]
Sent: Wednesday, November 07, 2001 11:44 AM
To: Justin T. Gibbs
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid/Adaptec/SCSI errors, obvious explanation isn't


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
problem: two processes doing I/O to separate raid/ext3 volumes stop in "D"
and
"S" states. The D state process is doing a simple copy from local ext2 to
local
raid/ext3, the S state process is doing an rsync of a remote machine. The D
process can't be killed, but when the S process is killed the D process
continues. These process are otherwise unrelated (they aren't even doing I/O
to
the same file-system).

Thanks,

JP

"Justin T. Gibbs" wrote:
> 
> >We can consistently generate 1-2 of the following errors per hour:
> >
> >Oct 31 10:08:30 ccfs2 kernel: SCSI disk error : host 2 channel 0 id 9 lun
0
> >return code = 800
> >Oct 31 10:08:30 ccfs2 kernel: Current sd08:51: sense key Hardware Error
> >Oct 31 10:08:30 ccfs2 kernel: Additional sense indicates Internal target
failu
> >re
> >Oct 31 10:08:30 ccfs2 kernel:  I/O error: dev 08:51, sector 35371392
> 
> ...
> >Previous postings have suggested hardware (disk) failures or a bug in the
RAID
> ><-> Adaptec driver interaction.  We think disk failures are unlikely
since
> >they are happening on multiple disks and only after a software upgrade.
> >
> >We once tested 15K drives on these EXP15 JBODs and encountered SCSI
disks/driv
> >er errors, so we've suspected some type of JBOD problem under high load.
> >
> >Anyhow, does anyone have a clue as to what might be causing these errors,
what
> >tests we could conduct to shed light on the problem, or additional
information
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
