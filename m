Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267693AbUHENyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267693AbUHENyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267698AbUHENwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:52:39 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:58553 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267693AbUHENtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:49:23 -0400
Date: Thu, 5 Aug 2004 15:48:47 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051348.i75DmlGD004576@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jens Axboe <axboe@suse.de>


>> In 1998, I did send a patch against the sg.c driver that introduced
>> everything that is needed for Generic SCSI transport. I am still
>> waiting for even the needed features to appear........

>If you have issues with SG_IO, please feel free to address them. If they
>are valid, I'd love to help you get it fixed.


Here is the current list of problems with CD/DVD writing on Linux:

-	Linux sometimes bastardizes the SCSI commands sent to ATAPI drives.

	Some people report that they cannot blank their CD-RW media for
	this reason. See:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=186099

	Similar things happen when trying to read defective "CD-DA" media
	created by the "Music Mafia". If you use a Plextor drive, everything
	works fine. If you use a Pioneer drive, the SCSI command "READ FULL TOC"
	aborts with "illegal field in CDB", rebooting the same PC to
	SCO UnixWare makes the problem go away.

	This problem has not yet been reported because I got the impression 
	that nobody on LKML is interested in fixing CD/DVD writing related 
	bugs. 

	Time to fix: unknown - may be more than 2 weeks.

-	ide-scsi does not use DMA if the "DMA size" is not a multiple of 512.
	This bug has been reported many times! Last time was when you introduced
	the unneeded SCSI transport via /dev/hd*. This interface initially
	did have the same bug - it has been fixed. The same bug in ide-scsi
	has not been fixed although I send several related mails :-(

	Time to fix: less than a day (for Jens)

-	Parallel (50 bin) SCSI (unknown HBA) on Linux-2.6 does not work if
	DMA size is not a multiple of 4. The data transferred from the SCSI
	device is OK for the first part that is a multiple of 4.
	The remainder of bytes arrive as binary zeroes.

	This is a new bug (I received the related information this week).

	Time to fix: approx. one day

-	ioctl(f, SCSI_IOCTL_GET_IDLUN, &sg_id)) and ioctl(f, SCSI_IOCTL_GET_BUS_NUMBER, &Bus)
	do not return instance numbers if applied to a fd from /dev/hd*

	This bug has been reported 2 years ago.

	Time to fix: 10 minutes

-	DMA residual count is not returned (reported in 1998).
	This is extremely important - it prevents me from unsing Linux as a
	development platform.

	Time to fix: about one month to rework the whole SCSI driver stack.

-	Only the first 14 bytes of SCSI Sense data is returned (reported in 1998)
	This is extremely important - it prevents me from unsing Linux as a
	development platform.	

	Time to fix: about one month to rework the whole SCSI driver stack.
	With good luck, this may be done on 2 days.

-	Unclear documentation whether DID_TIME_OUT should apply to a selection
	time out, a SCSI command timeout or both.

	Time to fix: one day

-	It seems that the only way to find out whether a SCSI command did time 
	out is to meter the time it takes and guess for any unclear return
	codes that coincidence with a command time >= the set up timeout to
	assume a SCSI command timeout.

	Time to fix: one day

-	Many unclear problem reports lead me to the assumption that Linux-2.6
	does not set up the SCSI command timeout properly. See previous point!

	Time to fix: 

-	Linux Kernel include files (starting with Linux-2.5) are buggy and 
	prevent compilation. Many files may be affected but let me name
	the most important files for me:

	-	/usr/src/linux/include/scsi/scsi.h depends on a nonexistant
		type "u8". The correct way to fix this would be to replace
		any "u8" by "uint8_t". A quick and dirty fix is to call:

			"change u8 __u8 /usr/src/linux/include/scsi/scsi.h"

		ftp://ftp.berlios.de/pub/change/

	-	/usr/src/linux/include/scsi/sg.h includes "extra text" "__user"
		in some structure definitions. This may be fixed by adding
		#include <linux/compiler.h> somewhere at the beginning of
		/usr/src/linux/include/scsi/sg.h

	This bug has been reported several times (starting with Linux-2.5).

	Time to fix: 5 minutes.
	
There may be other problems that I do not remember now. If I would get the 
impression that LKML is interested in fixing CD/DVD writing related bugs, I 
would report more.....

>From the current number of problem reports, it looks like Linux-2.6 is not yet 
ready for general use as too many problems only appear on Linux-2.6. I 
currently give peeople the advise to either go back to Linux-2.4 or to check
Solaris (see http://wwws.sun.com/software/solaris/solaris-express/get.html).

As my previous experiences with discussions on LKML have not been very 
fruitful, I would propose to suspend the current discussion to a time after
at least some bugs from the list above have been fixed.




Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
