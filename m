Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSFIQ6K>; Sun, 9 Jun 2002 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSFIQ6J>; Sun, 9 Jun 2002 12:58:09 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:23047 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313492AbSFIQ6J>; Sun, 9 Jun 2002 12:58:09 -0400
Date: Sun, 9 Jun 2002 17:58:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020609175804.B8761@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest kbuild version in 2.5.21, we are unable to build the
following files:

linux/drivers/block/smart1,2.h
linux/drivers/scsi/53c7,8xx.c
linux/drivers/scsi/53c7,8xx.h
linux/drivers/scsi/53c7,8xx.scr
linux/arch/arm/mm/proc-arm6,7.S
linux/arch/arm/mm/proc-arm2,3.S

This is because we end up passing gcc the following argument:

	-Wp,-MD,.proc-arm6,7.o.d

which gets passed to cpp0 as:

	-MD .proc-arm6 7.o.d
	              ^ space, not comma

and therefore cpp0 sees "-MD", ".proc-arm6" and "7.o.d" as separate
arguments.

There seems to be two solutions:

1. renaming all the above files to contain '_' instead of ','.
2. see if kbuild can use the DEPENDENCIES_OUTPUT environment variable

Kai pointed out that we've already got one exception in kbuild to fixup
the filename for KBUILD_BASENAME (, -> _ and that's not a weird smilie!)
so (1) is probably going to be better, and we can get rid of the special
"comma" handling.

Either way, I plan to rename the two ARM files.  That leaves the 53c7,8xx
driver and that block header file.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

