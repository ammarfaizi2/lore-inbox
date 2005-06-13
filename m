Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVFMMLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVFMMLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFMMLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:11:09 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:50388 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261537AbVFMMJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:09:39 -0400
Message-ID: <002301c57018$266079b0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 09:02:20 -0400
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

A) dump_thread() and dump_task_regs() are in the middle of the file, but
will be infrequently used. With default 16 byte alignment, this may cause
bits of them to wind up polluting the L1 on anything with L1 lines > 16
bytes.  L2 lines could be similarly polluted too of course.

Moving these two routines to the bottom would probably be a better deal.

B) elf_core_copy_regs() macro (which resolves to ELF_CORE_COPY_REGS macro)
just copies largely similar (but not quite identical) structures with a bit
of difference in the middle for seg reg handling using a long sequence of "a
= b" type assignments.  It would seem this could be tweaked a bit with a
couple of REP MOV's on either side of the seg reg dissimilarity.  Fast crash
dump handling code isn't as desirable as compact crash dump handling code.

C) dump_task_regs() can be shortened up a tad by zeroing the high words of
the seg reg vars with a bit of inline that uses a word AND with imm8 zero.
Right now the compiler is generating 4 MOVZX's and 4 MOV's to clip off the
trash bits. Again, not being a high performance path, the better compactness
of (4) AND mem16,imm8 would be more desirable over the 8 MOVZX/MOV
instructions that get generated now.

