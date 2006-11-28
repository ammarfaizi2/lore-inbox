Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756992AbWK1NEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992AbWK1NEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbWK1NEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:04:33 -0500
Received: from spirit.analogic.com ([204.178.40.4]:59402 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1756992AbWK1NEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:04:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 28 Nov 2006 13:04:24.0785 (UTC) FILETIME=[BA70C410:01C712ED]
Content-class: urn:content-classes:message
Subject: Re: Reserving a fixed physical address page of RAM.
Date: Tue, 28 Nov 2006 08:04:24 -0500
Message-ID: <Pine.LNX.4.61.0611280750250.7035@chaos.analogic.com>
In-Reply-To: <456BAEB0.5030800@vertical.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
thread-index: AccS7bp4G4cOC7F6T9a98AlMRhLiPQ==
References: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no> <456B8517.7040502@shaw.ca> <456BAEB0.5030800@vertical.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jon Ringle" <jringle@vertical.com>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Nov 2006, Jon Ringle wrote:

> Robert Hancock wrote:
>> Jon Ringle wrote:
>>> Hi,
>>>
>>> I need to reserve a page of memory at a specific area of RAM that will
>>> be used as a "shared memory" with another processor over PCI. How can I
>>> ensure that the this area of RAM gets reseved so that the Linux's memory
>>> management (kmalloc() and friends) don't use it?
>>>
>>> Some things that I've considered are iotable_init() and ioremap().
>>> However, I've seen these used for memory mapped IO devices which are
>>> outside of the RAM memory. Can I use them for reseving RAM too?
>>>
>>> I appreciate any advice in this regard.
>>
>> Sounds to me like dma_alloc_coherent is what you want..
>>
> It looks promising, however, I need to reserve a physical address area
> that is well known (so that the code running on the other processor
> knows where in PCI memory to write to). It appears that
> dma_alloc_coherent returns the address that it allocated. Instead I need
> something where I can tell it what physical address and range I want to use.
>
> Jon

First, "PCI memory" is some memory inside a board that is addressed through the 
PCI bus. This address is allocated upon machine start and is available though 
the PCI interface (check any of the PCI card drivers). If you want to access 
this memory, you need to follow the same procedures that other boards use.

However, perhaps you don't mean "PCI memory". Perhaps you mean real memory
in the address-space, and you need to reserve it and give its physical address 
to something inside a PCI-bus card, perhaps for DMA. In that case, you can 
either memory-map some physical memory (get_dma_pages()) or you can tell the 
kernel you have less memory than you really have, and use the memory the kernel 
doesn't know about for your own private purposes. To access this private memory 
you use ioremap() and friends. This can be memory-mapped to user-space as well 
so you can perform DMA directly to user-space buffers. You can find the highest 
address that the kernel uses by reading kernel variable num_physpages. This 
tells the number of pages the kernel uses. The kernel does write to the next one 
so you need to start using pages that are two higher than num_physpages.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
