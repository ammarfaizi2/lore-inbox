Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTJFUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTJFUqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:46:18 -0400
Received: from mcomail03.maxtor.com ([134.6.76.14]:7440 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S261664AbTJFUqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:46:04 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB20E@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Daniel B.'" <dsb@smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: IDE DMA errors, massive disk corruption:  Why?  Fixed Yet?  W
	hy not   re-do failed op?
Date: Mon, 6 Oct 2003 14:46:03 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel B. [mailto:dsb@smart.net]
> Sent: Monday, October 06, 2003 2:21 PM
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet?
> Why not re-do failed op?
> 
> Are you sure?  If you issue a write to block 1 and then issue another
> write to block 1, it would have to guarantee the relative 
> order of those 
> writes (or equivalent optimization in the write cache), wouldn't it?

Relative order of two writes to the same LBA is guaranteed, however the bus
order of two distinct writes is not required to be the same as the disk-work
order of those same two writes.

Picture the states as:
X (initial)
A (write 1 to LBA n)
B (write 2 to LBA n)

There are two posibilities that are both "legal":

1. drive maintains separate buffer space for both writes, and does them in
order

2. drive shares buffer space for both writes, and the 2nd write "corrupts"
the first one. There are three different things that can occur in this
situation of simultaneous disk and cable IO:

2a) Drive completes first write before 2nd bus transfer occurs, this results
in two distinct correct states on the media

	X -> A -> B

2b) Drive is in the middle of the first write when 2nd bus transfer occurs,
this results in a write splice which the drive must detect and then rewrite
the data in the buffer which is "correct":

	X -> A'B' -> B

2c) Drive hasn't started the write when the 2nd bus transfer occurs, so only
a single physical write actually needs to occur.  The drive actually
transfers from 

	X -> B

In all 3 cases, you should end up in state B.  (All this is in the absense
of reads, FYI).  Case 2 is *much* faster for local-area IO... Case 1
guarantees at least 1 rev of rotational latency per operation on
overlapped/repetitive writes in the steady-state, whereas Case 2 requires
more internal brains but can accept writes at bus speed regardless of
overlaps.  Case 1 is also less efficient for cache space, since you could
concievably use the entire 8MB drive cache to hold 16K copies of the same
LBA.

In either case, an error of *any* kind on a write means that the entire
region you were writing should be considered invalid, and you should
re-write the entire transfer.

> But we're not talking about errors IN the disk drive after 
> the communi-
> cation between the kernel and drive is already done.  We're talking
> about errors in the communication BETWEEN the kernel and the 
> drive (lost
> DMA interrupts), aren't we?
> 
> If the kernel issues a write command to the drive, and never gets a 
> response (DMA-complete interrupt?) from the drive that it has 
> accepted 
> the command, why can't the kernel repeat the write command?

In that case (which I guess is the whole issue) the kernel should repeat the
write command.  If the DMA never completes for some reason, the entire DMA
transfer should be considered invalid and re-done.  Reading a drive after a
partial data transfer has unspecified results. (Though a lot of OEMs test
for this sort of thing to figure out how each vendor's implementation
varies)

--eric
