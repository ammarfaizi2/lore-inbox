Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVJZR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVJZR23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVJZR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:28:29 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:38924 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964841AbVJZR22 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:28:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <435FB708.3040506@anagramm.de>
References: <435FB708.3040506@anagramm.de>
X-OriginalArrivalTime: 26 Oct 2005 17:28:27.0018 (UTC) FILETIME=[ACBD2EA0:01C5DA52]
Content-class: urn:content-classes:message
Subject: Re: Is this Oops due to messed up memory? - And how to protect fs during driver development?
Date: Wed, 26 Oct 2005 13:28:27 -0400
Message-ID: <Pine.LNX.4.61.0510261306220.5943@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is this Oops due to messed up memory? - And how to protect fs during driver development?
Thread-Index: AcXaUqzG8GnGYrOlTHepn2zm6F2h6g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Oct 2005, Clemens Koller wrote:

> Hi There!
>
> During my DMA driver development on an embedded MPC8540 (e500) PPC processor, which
> is work in progress and definitely dangerous and unstable, I received the oops as shown
> below... not really during a dma transfer but later during recompilation of my driver.
> I guess, that I corrupted my memory very bad (misprogrammed DMA).
> The kernel is still a 2.6.13-rc7
>
> How can I avoid to crash my filesystem during driver development as much as possible?
> Well, I do backups, but is there something like a temporary "remount it physically
> readonly for the next 10 secons" thingy?
>
> Thanks,
>
> Clemens
>
[SNIPPED crash]

DMA can write ANYWHERE! It doesn't know anything about CPU page
protection, etc. It doesn't use the CPU! So, if you trash some
buffer that eventually gets written to your file-system, you can
trash the file-system and destroy all the work you ever did
on the system.

There are several solutions:

(1) Do initial testing on a "throw-away" system that only
has some tools and the kernel installed (like a fresh
copy of your favorite distribution) -- nothing else.
Use the network to copy over your completed work. Do
NOT mount your remote system via NFS.

(2) Boot on a throw-away partition then mount your work
partition for design/development. Unmount that partition
before you insert or try to test your module.

(3) Don't ever write DMA code.


> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
> -


You need to remember that simple "off-by-one" errors that are hard to
find in user-mode code, will still be hard to find in kernel code
-- and harder when you have to install everything from scratch each
time you try to insert your module!

Simple question? With the old PC/AT DMA controller, do you
program it for a byte-count or a word-count? Is the count
exactly the required transfer count or is it different?

Trick questions, but they MUST be answered before you try
to run any code using the device(s).

There are similar off-by-zillions problems with many bus-mastering
DMA controllers. Some can't take a count of 0 because the count
is decremented AFTER each transfer!!! That could trash 32-bits
worth of address-space! So, if you have scatter-lists that are
dynamically built, you need to check out the corner cases long
before you throw the code off-the-cliff and hope it will fly!

What I do with DMA code, and I'm supposed to be experienced, is
I `ftp` it to a "target" that I can trash. Even code that has
been tested and "known to work" gets tested on a trash target.

They are cheap. Don't test new drivers on your development
machine. If you do, sooner or later you WILL destroy at least
a day's work, maybe more.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
