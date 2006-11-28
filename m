Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936058AbWK1Twp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936058AbWK1Twp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936075AbWK1Twp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:52:45 -0500
Received: from isaowa.keyvoice.com ([12.153.69.53]:38078 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S936058AbWK1Two convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:52:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reserving a fixed physical address page of RAM.
Date: Tue, 28 Nov 2006 14:52:42 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D0F89@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccS7bp4G4cOC7F6T9a98AlMRhLiPQANwVQA
From: "Jon Ringle" <JRingle@vertical.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 27 Nov 2006, Jon Ringle wrote:
> 
> > Robert Hancock wrote:
> >> Jon Ringle wrote:
> >>> Hi,
> >>>
> >>> I need to reserve a page of memory at a specific area of RAM that 
> >>> will be used as a "shared memory" with another processor 
> over PCI. 
> >>> How can I ensure that the this area of RAM gets reseved 
> so that the 
> >>> Linux's memory management (kmalloc() and friends) don't use it?
> >>>
> >>> Some things that I've considered are iotable_init() and ioremap().
> >>> However, I've seen these used for memory mapped IO 
> devices which are 
> >>> outside of the RAM memory. Can I use them for reseving RAM too?
> >>>
> >>> I appreciate any advice in this regard.
> >>
> >> Sounds to me like dma_alloc_coherent is what you want..
> >>
> > It looks promising, however, I need to reserve a physical 
> address area 
> > that is well known (so that the code running on the other processor 
> > knows where in PCI memory to write to). It appears that 
> > dma_alloc_coherent returns the address that it allocated. Instead I 
> > need something where I can tell it what physical address 
> and range I want to use.
> >
> > Jon
> 
> First, "PCI memory" is some memory inside a board that is 
> addressed through the PCI bus. This address is allocated upon 
> machine start and is available though the PCI interface 
> (check any of the PCI card drivers). If you want to access 
> this memory, you need to follow the same procedures that 
> other boards use.

In my hardware setup, Linux is running in PCI option mode on a IXP455
processor and it exposes a segment of the IXP455's memory so that it is
available on the PCI bus. The other processor (a pentium M running
Windows OS) sees this exposed IXP455 memory as PCI memory from it's
perspective.

> 
> However, perhaps you don't mean "PCI memory". Perhaps you 
> mean real memory in the address-space, and you need to 
> reserve it and give its physical address to something inside 
> a PCI-bus card, perhaps for DMA. In that case, you can either 
> memory-map some physical memory (get_dma_pages()) or you can 
> tell the kernel you have less memory than you really have, 
> and use the memory the kernel doesn't know about for your own 
> private purposes. To access this private memory you use 
> ioremap() and friends. This can be memory-mapped to 
> user-space as well so you can perform DMA directly to 
> user-space buffers. You can find the highest address that the 
> kernel uses by reading kernel variable num_physpages. This 
> tells the number of pages the kernel uses. The kernel does 
> write to the next one so you need to start using pages that 
> are two higher than num_physpages.

I'll take a look telling the kernel it has less memory that there
physically exists and use ioremap() to map it in.

Thanks,
Jon 
