Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTIPT4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbTIPTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:55:59 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:56292 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S262499AbTIPTzi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:55:38 -0400
Date: Tue, 16 Sep 2003 16:55:33 -0300
Message-Id: <HLBOOL$9F22A6BA6BDFE9CEF6137FE62345D3D3@terra.com.br>
Subject: =?iso-8859-1?Q?(Possible_Fix)_MS-PNR_SCSI_Card_/_NCR5380_SCSI_Driver?=
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "=?iso-8859-1?Q?Wagner_Volanin?=" <fadinha.mail@terra.com.br>
To: "=?iso-8859-1?Q?linux-kernel?=" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 3.2 R28 (B53 pl3)
X-type: 0
X-SenderIP: 200.165.18.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an old Genius Colorpage-SP2 SCSI scanner.
It is shipped with a MS-PNR 8bit ISA non-pnp proprietary SCSI
card from Microtek.

Although its chipset is a NCR53c400a, it wouldn't work with the
appropriate driver, always accusing timeout, whatever settings
I passed to it.

Today I messed a little with the NCR5380.c file in drivers/scsi
which is included by the g_NCR5380 driver and I couldn't understand
one thing:

Why the function NCR5380_poll_politely() returned the value 'r'
on success if this value should be '0' case everything went ok...

So I changed "return r;" to "return 0;" and after that my
scanner worked fine, and was easily detected by SANE, without
a single error message.  :)

I have not the time to delve into the problem further, but I
wanted to report this. I couldn't find any counter-effects caused
by changing these return values.

- Wagner Volanin.


GCC:            gcc 2.95 (Debian Stable)
Kernel:         2.6.0-test5 compiled for Pentium-MMX.
Computer:       Pentium MMX with PCCHIPS Motherboard.
Distribution:   Debian Unstable
Command issued:
 modprobe g_NCR5380 ncr_53c400a=1 ncr_addr=0x280 ncr_irq=255


The diff for the file follows below:
(Apply it inside drivers/scsi directory)


--- NCR5380.c.orig	2003-09-16 18:24:00.000000000 +0000
+++ NCR5380.c	2003-09-16 18:53:59.000000000 +0000
@@ -371,18 +371,18 @@
 	while( n-- > 0)
 	{
 		r = NCR5380_read(reg);
 		if((r & bit) == val)
-			return r;
+			return 0;
 		cpu_relax();
 	}
 	
 	/* t time yet ? */
 	while(time_before(jiffies, end))
 	{
 		r = NCR5380_read(reg);
 		if((r & bit) == val)
-			return r; 
+			return 0; 
 		if(!in_interrupt())
 			yield();
 		else
 			cpu_relax();




