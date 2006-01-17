Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWAQTSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWAQTSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWAQTSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:18:16 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:21769 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751203AbWAQTSQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:18:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43CD3CE4.3090300@comcast.net>
X-OriginalArrivalTime: 17 Jan 2006 19:18:14.0134 (UTC) FILETIME=[C3409160:01C61B9A]
Content-class: urn:content-classes:message
Subject: Re: Huge pages and small pages. . .
Date: Tue, 17 Jan 2006 14:18:13 -0500
Message-ID: <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Huge pages and small pages. . .
Thread-Index: AcYbmsNHmPSAZ6HmQmCdTfAq0M5stg==
References: <43CD3CE4.3090300@comcast.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "John Richard Moser" <nigelenki@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jan 2006, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Is there anything in the kernel that shifts the physical pages for 1024
> physically allocated and contiguous virtual pages together physically
> and remaps them as one huge page?  This would probably work well for the

A page is something that is defined by the CPU. Perhaps you mean
"order"? When acquiring pages for DMA, they need to be contiguous if
you are going to access more than one page at a time. Therefore, one
can attempt to get two or more pages, i.e., the order or pages.

Since the CPU uses virtual memory always, there is no advantage to
having contiguous pages. You just map anything that's free into
what looks like contiguous memory and away you go.

> low end of the heap, until someone figures out a way to tell the system
> to free intermittent pages in a big mapping (if the heap has an
> allocation up high, it can have huge, unused areas that are allocated).

The actual allocation only occurs when an access happens. You can
allocate all the virtual memory in the machine and never use any
of it. When you allocate memory, the kernel just marks a promised
page 'not present'. When you attempt to access it, a page-fault
occurs and the kernel tries to find a free page to map into your
address space.

> It may possibly work for disk cache as well, albeit I can't say for
> sure if it's common to have a 4 meg contiguous section of program data
> loaded.
>

But it __is__ contiguous as far as the program is concerned.
The only time you need physically contiguous pages is when a
DMA operation occurs that crosses page boundaries. Otherwise,
it's a waste of time and CPU resources trying to make
something contiguous. Also, modern DMA engines use scatter-
lists so one can DMA to pages scattered all over the address-
space in one operation. In this case, you just build a list of
pages. You don't care where they physically reside, although you
do need to tell the DMA engine their correct locations.

Now there are some M$Garbage "high-memory" so-called enhancements
that, using page-registers, "map" more that 4 GB of memory into
the 4 GB address space. This is like the garbage that M$ created
to use "high memory" for DOS. Use of this kind of hardware-hack
is not relevant to the discussion about virtual memory.

> Shifting odd huge allocations around would be neat to, re:
>
> {2m}[4M  ]{2m}  ->  [4M  ][4M  ]
>
> - --
> All content of all messages exchanged herein are left in the
> Public Domain, unless otherwise explicitly stated.
>
>    Creative brains are a valuable, limited resource. They shouldn't be
>    wasted on re-inventing the wheel when there are so many fascinating
>    new problems waiting out there.
>                                                 -- Eric Steven Raymond
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
> iD8DBQFDzTzjhDd4aOud5P8RAud1AJ9MVy90XzvJWmgHmlBUdHcpsYNtWACfVxY6
> f/jYDM1XiM8/09TfrzEDI3w=
> =CsLK
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
