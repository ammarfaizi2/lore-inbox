Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVLTOGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVLTOGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVLTOGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:06:53 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:18 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751040AbVLTOGx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:06:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7a37e95e0512192044s7cd8cce4y56ff9cfce06b44c3@mail.gmail.com>
X-OriginalArrivalTime: 20 Dec 2005 14:06:51.0373 (UTC) FILETIME=[9FE479D0:01C6056E]
Content-class: urn:content-classes:message
Subject: Re: scatter-gather list.
Date: Tue, 20 Dec 2005 09:06:49 -0500
Message-ID: <Pine.LNX.4.61.0512200849390.27253@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: scatter-gather list.
Thread-Index: AcYFbp/uMOtzaAXzSrOcgMl8xRbqig==
References: <7a37e95e0512192044s7cd8cce4y56ff9cfce06b44c3@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Deven Balani" <devenbalani@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2005, Deven Balani wrote:

> Hi All,
>
> I am trying to port a driver from x86 PCI based platform to ARM platform.
>
> The x86 driver has scatter-gather list as one of the DMA mechanism.
> Can I bypass this, As I believe sg list is for PCI buses and not for
> HSX buses.
>
> Can any one give me the _source_ where I can understand the necessity for
> a PCI bus to use sg list.
>
> Regards,
> deven
> -

The S/G list is used with the INTERFACE chip, i.e., whatever the
device is connected to. If you have a PCI/Bus and the device is
to do DMA across the PCI/Bus with a chip that requires a S/G list,
then you need the S/G list (which is trivial BTW). If your interface
device doesn't require a S/G list then you don't use one.

For instance, a common PCI/Bus interface chip is the PLX PCI 9656BA.
This has a S/G list. In principle, it's possible to bypass the S/G
list, but its downright dumb because you need to get all the information
necessary to build the S/G list anyway, to make one-buffer-at-a-time
DMA (which is what you get without the scatter-list). Typically
scatter lists consists of:

 	uint32_t	padr;	// Bus address to get/put data
 	uint32_t	ladr;	// Local address inside the device
 	uint32_t;	size;	// Transfer size in bytes
 	uint32_t;	dpr; 	// Next descriptor Bus address

That last bus address "dpr" has some low bits that tell the
controller if it is the last in a chain, etc. This stuff needs
to be in physical memory and its bus address is used.

If you don't use a S/G list, then you can't transfer more than
a page of virtual memory because the bus addresses may not
be contiguous. Typically, you build your S/G list using the
appropriate macros to extract the bus address from the virtual
address, so you need this information anyway.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
