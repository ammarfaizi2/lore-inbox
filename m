Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263142AbUKTSmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUKTSmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbUKTSmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:42:19 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:56303
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S263142AbUKTSmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:42:15 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: ide-cd problem
Date: Sat, 20 Nov 2004 18:42:14 +0000
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411201842.15091.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to track down why all attempts to burn a cd on my ide cdrw 
fails (see bug #3741 on bugzilla ), with a subprocess of cdrecord ending up 
hanging in uninterruptable sleep state.

I think I understand what is happening, I just don't know what to do about it.

Inside drivers/ide/ide-cd.c

the ide_do_rw_cdrom routine has been called via a request with the request 
flags having the REQ_BLOCK_PC flag set.  The request->data_len of this 
request is set to 0.

This request is sent to the device and it generates interrupts to eventually 
land it up inside the routine cdrom_newpc_intr.

At this point the status register on the hardware is set to 0x58 - implying, I 
think that the DRQ_STAT bit is set and that something should be sent to the 
device.

Normally, because the requested data_len is not zero, the data is sent.  In 
this case however, because the original request had nothing to send, the 
while/if clauses to initiate a new transfer are skipped and the routine ends 
up setting a new interrupt handler address and returning to await an 
interrupt that will never come.

Question: should something validate that the request length is not zero 
earlier, or should there be a check in ide-cd.c, or is it my hardware (its a 
generic cd read/rewriter which announces itself as 'CW078D CD-R/RW')
-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
