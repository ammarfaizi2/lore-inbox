Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267722AbUHEPBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267722AbUHEPBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHEPBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:01:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17037 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267722AbUHEPAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:00:50 -0400
Date: Thu, 5 Aug 2004 17:00:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805150032.GF12483@suse.de>
References: <200408051348.i75DmlGD004576@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051348.i75DmlGD004576@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Joerg Schilling wrote:
> >From: Jens Axboe <axboe@suse.de>
> 
> 
> >> In 1998, I did send a patch against the sg.c driver that introduced
> >> everything that is needed for Generic SCSI transport. I am still
> >> waiting for even the needed features to appear........
> 
> >If you have issues with SG_IO, please feel free to address them. If they
> >are valid, I'd love to help you get it fixed.
> 
> 
> Here is the current list of problems with CD/DVD writing on Linux:
> 
> -	Linux sometimes bastardizes the SCSI commands sent to ATAPI drives.
> 
> 	Some people report that they cannot blank their CD-RW media for
> 	this reason. See:
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=186099
> 
> 	Similar things happen when trying to read defective "CD-DA" media
> 	created by the "Music Mafia". If you use a Plextor drive, everything
> 	works fine. If you use a Pioneer drive, the SCSI command "READ FULL TOC"
> 	aborts with "illegal field in CDB", rebooting the same PC to
> 	SCO UnixWare makes the problem go away.
> 
> 	This problem has not yet been reported because I got the impression 
> 	that nobody on LKML is interested in fixing CD/DVD writing related 
> 	bugs. 
> 
> 	Time to fix: unknown - may be more than 2 weeks.

That's very interesting, I've noted at least a few of these myself
(where seemingly the same commands gets different results). Currently I
have no lead on this.

> -	ide-scsi does not use DMA if the "DMA size" is not a multiple of 512.
> 	This bug has been reported many times! Last time was when you introduced
> 	the unneeded SCSI transport via /dev/hd*. This interface initially
> 	did have the same bug - it has been fixed. The same bug in ide-scsi
> 	has not been fixed although I send several related mails :-(

SG_IO for atapi was born working that way. This should have been fixed
in 2.4, agree, in 2.6 it's not so urgent (since /dev/hd* /dev/sr* works
direct and does dma to anything, it'll bounce to kernel buffers if it
has to).

> -	Parallel (50 bin) SCSI (unknown HBA) on Linux-2.6 does not work if
> 	DMA size is not a multiple of 4. The data transferred from the SCSI
> 	device is OK for the first part that is a multiple of 4.
> 	The remainder of bytes arrive as binary zeroes.
> 
> 	This is a new bug (I received the related information this week).

Might be a hardware issue.

> -	ioctl(f, SCSI_IOCTL_GET_IDLUN, &sg_id)) and ioctl(f, SCSI_IOCTL_GET_BUS_NUMBER, &Bus)
> 	do not return instance numbers if applied to a fd from /dev/hd*
> 
> 	This bug has been reported 2 years ago.
> 
> 	Time to fix: 10 minutes

It has been argued several times that we will not doctor bus/id/lun on
atapi devices, because it does not make sense. So I'm regarding this as
invalid.

> -	DMA residual count is not returned (reported in 1998).
> 	This is extremely important - it prevents me from unsing Linux as a
> 	development platform.
> 
> 	Time to fix: about one month to rework the whole SCSI driver stack.

That's bogus, the SCSI stack (as well as the block layer) is very well
capable of reporting residual counts, and if the hardware can do it (we
can't get it from some ide hardware :/), we will report residuals.

So if it doesn't work it's a bug, but not a design bug.

> -	Only the first 14 bytes of SCSI Sense data is returned (reported
>	in 1998) This is extremely important - it prevents me from unsing
>	Linux as a development platform.	
> 
> 	Time to fix: about one month to rework the whole SCSI driver
> 	stack.  With good luck, this may be done on 2 days.

2.6 uses 96 byte sense buffers inside the command and copies back as
much as specified in the sense buffer, I fear you have to qualify this
bug some more (for SCSI). ide-cd uses 18 bytes.

> -	Unclear documentation whether DID_TIME_OUT should apply to a selection
> 	time out, a SCSI command timeout or both.
> 
> 	Time to fix: one day
> 
> -	It seems that the only way to find out whether a SCSI command did time 
> 	out is to meter the time it takes and guess for any unclear return
> 	codes that coincidence with a command time >= the set up timeout to
> 	assume a SCSI command timeout.
> 
> 	Time to fix: one day

Maybe James can clarify these?

> -	Many unclear problem reports lead me to the assumption that Linux-2.6
> 	does not set up the SCSI command timeout properly. See previous point!

Issued through SG_IO, or how? Again, more details are required.

> -	Linux Kernel include files (starting with Linux-2.5) are buggy and 
> 	prevent compilation. Many files may be affected but let me name
> 	the most important files for me:
> 
> 	-	/usr/src/linux/include/scsi/scsi.h depends on a nonexistant
> 		type "u8". The correct way to fix this would be to replace
> 		any "u8" by "uint8_t". A quick and dirty fix is to call:
> 
> 			"change u8 __u8 /usr/src/linux/include/scsi/scsi.h"
> 
> 		ftp://ftp.berlios.de/pub/change/
> 
> 	-	/usr/src/linux/include/scsi/sg.h includes "extra text" "__user"
> 		in some structure definitions. This may be fixed by adding
> 		#include <linux/compiler.h> somewhere at the beginning of
> 		/usr/src/linux/include/scsi/sg.h
> 
> 	This bug has been reported several times (starting with Linux-2.5).
> 
> 	Time to fix: 5 minutes.

This has also been discussed before, you should not include the kernel
headers. Yes I know you don't agree, but that's how it is for now.

> There may be other problems that I do not remember now. If I would get
> the impression that LKML is interested in fixing CD/DVD writing
> related bugs, I would report more.....

If they are kernel bugs, of course we want to know! The above is a
pretty damn good start, I just wish you would include more info (or test
cases...) as they are a bit ambigious in several places. I understand if
you just wanted to list some of them down and that is fine. Perhaps I
can get you to elaborate on the ones where I added followup questions?

> From the current number of problem reports, it looks like Linux-2.6 is
> not yet ready for general use as too many problems only appear on
> Linux-2.6. I currently give peeople the advise to either go back to
> Linux-2.4 or to check Solaris (see
> http://wwws.sun.com/software/solaris/solaris-express/get.html).

If they wish to sell their soul...

2.6 is newer, so it's not unnatural if it has a few more bugs right now.
Especially since some of this infrastructure is new in 2.6. But
generally I think it works well, 2.6.8 will work a lot better as it
fixed several bugs in this area (though none of those you outline
above).

> As my previous experiences with discussions on LKML have not been very
> fruitful, I would propose to suspend the current discussion to a time
> after at least some bugs from the list above have been fixed.

Well I'm not going to point fingers.

-- 
Jens Axboe

