Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319338AbSIKVOP>; Wed, 11 Sep 2002 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319339AbSIKVOP>; Wed, 11 Sep 2002 17:14:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61193 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319338AbSIKVOO>; Wed, 11 Sep 2002 17:14:14 -0400
Date: Wed, 11 Sep 2002 22:19:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 SCSI core bug?
Message-ID: <20020911221859.A17951@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just been running some of my tests on 2.4.19 on ARM, and came
across the following bug, which seems to be somewhere in the bowls of
the SCSI layer.

I'm using drivers/acorn/scsi/powertec.c, which uses fas216.c as the
core chipset driver (I authored both of these files) which contains
some pretty rigorous sanity checking.

Basically, what seems to be happening is that scsi can go wrong after
a medium error, and repeatedly pass invalid requests back down to the
HBA.  My HBA driver dislikes invalid requests thusly:

scsi0.2: bad request buffer length 38400, should be 130048

38400 is SCpnt->request_bufflen.
130048 is the total number of bytes in the SG list.

Dumping out the offending command:
	Read (10) 00 00 00 46 00 00 00 fe 00

Ok, so we were asking for 0xfe 512-byte sectors, which is 130048.
So why did SCSI tell me that it wanted 38400 bytes in
SCpnt->request_bufflen?

My workaround for this is to forcefully set request_bufflen
correctly, which appears to work.  However, the SCSI subsystem
completely stops making progress at this point.  (It just
repeats the above command indefinitely.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

