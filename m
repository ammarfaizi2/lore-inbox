Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTDTV7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDTV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:59:43 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:63410 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263722AbTDTV7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:59:42 -0400
Date: Sun, 20 Apr 2003 18:06:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200304201811_MC3-1-3537-1648@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Looks like the fix for the "ran out of interrupt sources" panic
has a problem.  It will eventually assign a device the same IRQ
number as the first system vector, i.e. the local APIC timer.
I think this will fix it:


--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@ -1117,7 +1117,7 @
 	if (current_vector == SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
+	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset = (offset + 1) & 7;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}


 I found this while trying to forward-port my .66 patch to make
the redirect table look like this:


 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    E7     <== timer at level E
 01 001 01  0    0    0   0   0    1    1    30     <== start at 30, not 31
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    38
 04 001 01  0    0    0   0   0    1    1    40
 05 001 01  0    0    0   0   0    1    1    48
 06 001 01  0    0    0   0   0    1    1    50
 07 001 01  0    0    0   0   0    1    1    58
 08 001 01  0    0    0   0   0    1    1    60
 09 001 01  0    0    0   0   0    1    1    68
 0a 001 01  0    0    0   0   0    1    1    70
 0b 001 01  0    0    0   0   0    1    1    78
 0c 001 01  0    0    0   0   0    1    1    88     <== only one device at 8
 0d 001 01  0    0    0   0   0    1    1    90
 0e 001 01  0    0    0   0   0    1    1    98
 0f 000 00  1    0    0   0   0    0    0    00
 10 001 01  1    1    0   1   0    1    1    A0
 11 001 01  1    1    0   1   0    1    1    A8
 12 001 01  1    1    0   1   0    1    1    B0
 13 001 01  1    1    0   1   0    1    1    B8
 14 001 01  0    0    0   0   0    1    1    C0
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00



------
 Chuck
