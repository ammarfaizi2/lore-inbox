Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTDJV6T (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTDJV6T (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:58:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50894 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264188AbTDJV6R (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:58:17 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 00:09:51 +0200 (MEST)
Message-Id: <UTC200304102209.h3AM9pf11795.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       pbadari@us.ibm.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I noticed that I have been unsubscribed for a day or so,
so may not have seen earlier mail.]

	From: Badari Pulavarty <pbadari@us.ibm.com>

	--- linux-2.5.67/drivers/scsi/sd.c	Wed Apr  9 13:12:38 2003
	+++ linux-2.5.67.new/drivers/scsi/sd.c	Thu Apr 10 13:23:49 2003
	@@ -56,7 +56,9 @@
	  * Remaining dev_t-handling stuff
	  */
	 #define SD_MAJORS	16
	-#define SD_DISKS	(SD_MAJORS << 4)
	+#define SD_DISKS	((SD_MAJORS - 1) << 4)
	+#define LAST_MAJOR_DISKS	(1 << (KDEV_MINOR_BITS - 4))
	+#define TOTAL_SD_DISKS	(SD_DISKS + LAST_MAJOR_DISKS)
	 
	-static unsigned long sd_index_bits[SD_DISKS / BITS_PER_LONG];
	+static unsigned long sd_index_bits[TOTAL_SD_DISKS / BITS_PER_LONG];

I try to make sure there are no assumptions about the
size or structure of device numbers anywhere outside kdev_t.h.
In particular I object to the use of KDEV_MINOR_BITS.

Apart from this formal point, there is also the practical point:
suppose 64 = 32+32 is used, so that KDEV_MINOR_BITS equals 32.
Then LAST_MAJOR_DISKS is 2^28 and sd_index_bits[] would be 32 MB array.
Unreasonable.

The conclusion is that the easy way out is to define MAX_NR_DISKS.
A different way out, especially when we use 32+32, is to kill this
sd_index_bits[] array, and give each disk a new number: replace
	index = find_first_zero_bit(sd_index_bits, SD_DISKS);
by
	index = next_index++;

Andries
