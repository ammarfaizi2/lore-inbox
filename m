Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTARQtG>; Sat, 18 Jan 2003 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTARQtC>; Sat, 18 Jan 2003 11:49:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18692 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264938AbTARQsE>; Sat, 18 Jan 2003 11:48:04 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: SCSI/Block boot problems
Message-Id: <E18ZwHG-0007l0-00@flint.arm.linux.org.uk>
Date: Sat, 18 Jan 2003 16:57:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing the theme of testing 2.5.59, there appears to be some fairly
bad error handling somewhere in this area at the moment.  So far, my
debugging shows the following:

1. A permanent error with a _1_ SCSI target on a SCSI bus causes the
   SCSI error handling to go completely gaga and eventually ends up
   oopsing the kernel.  Full kernel messages with SCSI debugging enabled
   have been forwarded to James Bottomley.

2. SCSI appears to attempt to spin up a non-present disk in removable
   SCSI drive _3_ times during boot.  This is new behaviour for 2.5,
   which 2.4, 2.2 nor 2.0 used to show.

   Since each spinup takes around 2 minutes to timeout and the drive
   obvious isn't going to spin up without media present, it produces
   some very long test cycles, and is a source of continual annoyance.

3. SCSI goes completely gaga after a SCSI disk IO error.  I haven't
   got much to say about this other than to supply the kernel messages
   (with some extra ones added to try to track down the problem.)

   At this point, we are trying to read the partition table on the
   aforementioned empty SCSI removable drive:

	 sda:submitting buffer 0 of 1 (cc3fa580) page c026e3c0
	submission done
	prep_rq_fn: device sda ret = 1

   scsi_prep_fn() returns BLKPREP_KILL, and we end the request:

	__end_that_request_first: req c0427dc0 uptodate 0 nrbytes 4096
	end_request: I/O error, dev sda, sector 0
	end_buffer_async_read: bh cc3fa580 page c026e3c0 uptodate 0
	Buffer I/O error on device sd(8,0), logical block 0
	unlocking page: all buffers unlocked
	unlocking page c026e3c0 waitqueue c0003228: flags 00001006
	all done

   The partition code attempts to read another page:

	submitting buffer 0 of 1 (cc3fa580) page c026e3c0
	submission done
	wait_on_page_bit: task c0441040 page c026e3c0 bit 0 waitqueue c0003228
	prep_rq_fn: device sda ret = 2
	sleeping on page c026e3c0: flags 00021007
	prep_rq_fn: device sda ret = 2
	prep_rq_fn: device sda ret = 2
	prep_rq_fn: device sda ret = 2
	prep_rq_fn: device sda ret = 2
	prep_rq_fn: device sda ret = 2

   This time, scsi_prep_fn() continually returns BLKPREP_DEFER and we
   don't make any further progress.  (I assume 20 minutes of waiting is
   probably long enough! 8))

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

