Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVAFWu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVAFWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVAFWt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:49:26 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:58791 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S263054AbVAFWrr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:47:47 -0500
X-Ironport-AV: i="3.88,108,1102312800"; 
   d="scan'208"; a="177369250:sNHT23576276"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Thu, 6 Jan 2005 16:47:46 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D32@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcTAIAVAVRscS9MSR36xZTS1/gcpSAADEUdwDPQ/CKAAEI5dwA==
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2005 22:47:46.0806 (UTC) FILETIME=[BDD41160:01C4F441]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> anything i can do to avoid dropping characters without using 
> low_latency, which still hangs SMP kernels?

this patch fixes the problem for me, but its probably an awful hack -- a
brief interrupt storm occurs until tty processes its buffer, but IMHO
that's better than dropping characters.

is there a better alternative?
thanks,
tim

--- 8250-orig.c	2005-01-06 16:25:24.000000000 -0600
+++ 8250.c	2005-01-06 16:27:21.000000000 -0600
@@ -989,8 +989,10 @@
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
 			if(tty->low_latency)
 				tty_flip_buffer_push(tty);
-			/* If this failed then we will throw away the
-			   bytes but must do so to clear interrupts */
+			else
+				break;
+			/* If this failed then we will just leave now 
+			   rather than dropping bytes (interrupts not
cleared) */
 		}
 		ch = serial_inp(up, UART_RX);
 		flag = TTY_NORMAL;
