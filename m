Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbTD2TKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTD2TKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:10:31 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:43841 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261544AbTD2TKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:10:30 -0400
Date: Tue, 29 Apr 2003 15:21:21 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Swap Compression
To: linux-kernel@vger.kernel.org
Message-id: <200304291521210840.0462CAF4@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
 <200304262224040410.031419FD@smtp.comcast.net>
 <20030427090418.GB6961@wohnheim.fh-wedel.de>
 <200304271324370750.01655617@smtp.comcast.net>
 <20030427175147.GA5174@wohnheim.fh-wedel.de>
 <200304271431250990.01A281C7@smtp.comcast.net>
 <3EAE8899.2010208@techsource.com>
 <200304291521120230.0462A551@smtp.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why keep a fixed page size?  A 4k page can be represented by an
N bit offset in the swap partition (32 for 4 gig or less) and a 13 bit
length description.  Let's not go with the overhead of 13 bit; 16 bit
lengths.  Something divisible by two.  Sure, we gain what
4 + 2 == 6 bytes per page, but we compress out more than that in
most cases (in theory).

and as for RAM, I really prefer the user to control swap-on-ram, and
to have it implimented as such.  4 meg'ers might try SoR but it may
hurt.  The kernel should default to using the RAM swap as its primary
swap partition though.  Why make extra overhead chopping up and
reassembling pages?  We did that with compression.

--Bluefox Icy
(Well that's my opinion)

*********** REPLY SEPARATOR  ***********

On 4/29/2003 at 10:13 AM Timothy Miller wrote:

>Here's a way to keep the two-level swap complexity down, perhaps.
>
>The VM is aware of two kinds of memory space and therefore two kinds of 
>swap.  The first kind of memory is "normal" memory that is used by 
>applications.  When the VM has to swap that, it compresses to RAM.  The 
>second kind of memory is "compressed" memory.  When the VM has to swap 
>that, it swaps it to disk.
>

Swap-on-RAM with compression enabled.

>All swapping operations are done in page units.  Compressed pages will 
>use arbitrary amounts of memory, so when compressed pages are swapped, 
>the boundaries between one compressed page and another are not 
>considered.  Compressed pages will be broken up.  But that's okay, 
>because if there is a page fault in the compressed memory, the VM just 
>swaps in from disk.  Perhaps some intelligent memory management could be 
>employed which reorganizes compressed RAM so that a recently used 
>compressed page does not share a physical page with a compressed page 
>that has not been touched in a while.
>

Ouch.  That introduces extra managment between the compressed RAM
and the swapping procedure.  On the plus, it would save us the hassle
of fragmented swap but heck, idle-time and on-urgent page defragmentation
should take care of that (do I need to explain these concepts?).

>There has been talk of a "simpler" system which compresses to swap 
>without the intermediate level.  The thing is, that intermediate level 
>always exists to some extent.  And trying to manage compressed pages on 
>disk like that can get quite complex.  If we were to compress to a whole 
>number of sectors, just so we could keep things separate, then we would 
>limit the benefit from compressing.  The two level system could be 
>employed to compress to swap simply by keeping the compressed memory 
>fixed and very small.



