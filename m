Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVE0GTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVE0GTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVE0GTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:19:03 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:55446 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261881AbVE0GSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:18:50 -0400
Message-ID: <000701c5628b$583f8060$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: 387 emulator hack - mutant AAD trick - any objections?
Date: Fri, 27 May 2005 03:11:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will there be any objections to using a quasi-documented mutation of the
x86's AAD instruction in the 387 emulator? Every CPU around has to do this
mutation correctly or a LOT of existing code will break...

The performance of storing to user space of BCD numbers in the 387 emulator
code could be improved significantly by using the mutant AAD instruction
trick (i.e. alter its implicit base from 10 to 16).  See reg_ld_str.c, in
function FPU_store_bcd()

As it stands now, the BCD digits are being decoded one at a time in a 10
iteration divide by 10 loop that makes two calls to an extended precision
division routine.

This loop could be morphed into a 5 iteration divide by 100 loop.

The remainder of a divide by 100 would be processed thus (pseudo asm code):

AL = remainder
AH = 0
AAM    /* this creates BCD nibbles in low 4 of AH and AL */
AAD (mutated with 16 as base rather than 10)

Now AL contains two packed BCD digits.   Here's a worked out example of the
transformation of data starting with an initial remainder of 35 (decimal) in
AX

1) Start with AX = 0x0023
2) Execute AAM instruction
3) Now AX = 0x0203 (unpacked BCD)
4) Execute base 16 AAD instruction
5) Now AX = 0x0023 (packed BCD)

AAM and AAD aren't cheap instructions, but compared to the cost of 2X trips
through the extended precision divide routine, they are quite a bargain.


