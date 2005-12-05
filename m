Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVLEOSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVLEOSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVLEOSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:18:54 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:57605 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751358AbVLEOSx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:18:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <e1e1d5f40512022134y73318ed4p54064a07905cef3c@mail.gmail.com>
X-OriginalArrivalTime: 05 Dec 2005 14:18:51.0967 (UTC) FILETIME=[D13424F0:01C5F9A6]
Content-class: urn:content-classes:message
Subject: Re: kernel loading question
Date: Mon, 5 Dec 2005 09:18:51 -0500
Message-ID: <Pine.LNX.4.61.0512050900340.27266@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel loading question
Thread-Index: AcX5ptFCkluUG5E4R+OVI+dAucOprw==
References: <e1e1d5f40512022134y73318ed4p54064a07905cef3c@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Dec 2005, Daniel Bonekeeper wrote:

> Well, this probably should not be posted here, but who knows ? =)
>
> Well, on arch/i386/boot/compressed/head.S line 65 we call
> decompress_kernel that decompresses the kernel starting at $0x100000.
> If we were loaded high, we first move the code back to $0x1000 before
> ljmp'ing it.
>
> My question is: why, when loaded high, we care to disable interrupts
> (cli  # make sure we don't get interrupted) while otherwise, we don't
> do that ? in both cases, aren't we supposed to disable cli (as they
> can happen in both situations) ?
>
> Since currently, the kernel boots fine for everybody in the world, I
> know that this is not a bug... but why don't disable interruptions on
> both cases ?
>
> Thanks !

The first thing to do when looking at assembly language files
is to find what symbols are global (.globl or .global). Unlike
'C' the stuff doesn't default to being visible from other
files. Given that, you will see that code executes from
startup_32, the only way "in" since it's the only global
symbol. The second instruction is 'cli', which will disable
interrupts on the current processor.

Now, later on in the code is the sequence:
 		pushl	$0
 		popfl

... which will further clear any flags so the interrupt-enable
flag is truly disabled there, also. Later on, there are redundant
'cld' instructions as well as an additional 'cli' instruction.

These probably occurred because the code was assembled from
various pieces and nobody bothered to review it for such
redundancy.

Getting rid of the extra instructions will save 3 or 4 bytes
of code. Since this code executes only once, it's certainly
not in the "fast-path" so nobody has bothered to clean it.
If you would like to clean up the code and submit a patch
it probably would be accepted.

I will test any patch you may want to produce.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
