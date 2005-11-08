Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVKHWrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVKHWrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVKHWrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:47:02 -0500
Received: from web32406.mail.mud.yahoo.com ([68.142.207.199]:42159 "HELO
	web32406.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030266AbVKHWrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:47:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BccD3522YZTCTMYQfbg1X4y9YE+QFcHMJt+iz82lLhytsoo21202pofjLIRhy455nwlxVJsjIVv49Kkg3c7SLFEtcWu8+mWOXIKek8VXoshUm9BcrO5S5seY1rr4mXRSde95F68TtyKru7JXvVRRf1DmM4+7Awbe+0hJMvv6k5k=  ;
Message-ID: <20051108224700.68513.qmail@web32406.mail.mud.yahoo.com>
Date: Tue, 8 Nov 2005 14:47:00 -0800 (PST)
From: Anil kumar <anils_r@yahoo.com>
Subject: Re: bus_to_virt equivalent
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20051108013722.GK23749@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Thanks for the reply.
I can store the returned dma_addr from
pci_map_sg/single or pci_map_page in a driver
structure.

struct page *page =
virt_to_page(Cmnd->request_buffer);
                unsigned long offset = ((unsigned
long)Cmnd->request_buffer &
                                        ~PAGE_MASK);
                dma_addr_t busaddr =
pci_map_page(hostdata->pci_dev,
                                                 
page, offset,
                                                 
Cmnd->request_bufflen,
                                                 
scsi_to_pci_dma_dir(Cmnd->sc_data_direction));

But how do I convert this returned "busaddr" into a
virtual addr?

regards,
Anil

--- Matthew Wilcox <matthew@wil.cx> wrote:

> On Mon, Nov 07, 2005 at 03:52:47PM -0800, Anil kumar
> wrote:
> > Hi,
> > 
> > I am trying to port bus_to_virt and virt_to_bus to
> the
> > DMA-mapping scheme.
> > I found a way to move virt_to_bus() as follows:
> > page = virt_to_page(cmd->request_buffer);
> > offset = (unsigned long)address & ~PAGE_MASK;
> > dma_addr_t addr = pci_map_page(dev, page, offset,
> > size,direction);
> > 
> > But now I want to get virtual address for
> dma_addr_t.
> 
> Did you *read* DMA-mapping.txt?
> 
>   Drivers converted fully to this interface should
> not use virt_to_bus
>   any longer, nor should they use bus_to_virt. Some
> drivers have to
>   be changed a little bit, because
>   *there is no longer an equivalent to bus_to_virt
> in the dynamic
>   DMA mapping scheme*
>   - you have to always store the DMA addresses
> returned by the
>   pci_alloc_consistent, pci_pool_alloc, and
> pci_map_single calls
>   (pci_map_sg stores them in the scatterlist itself
> if the platform
>   supports dynamic DMA mapping in hardware) in your
> driver structures
>   and/or in the card registers.
> 
> The reason for this is that there may be many
> physical addresses which
> correspond to the same bus address.  For example
> (this is on an HP rx8620)
> the bus address c001b000 maps to 00000f000001b000
> for device 00:03.0,
> 00000f010001b000 for device 40:03.0,
> 00000f020001b000 for device 80:03.0
> and 00000f030001b000 for device c0:03.0.
> 
> Now, maybe we should add a function:
> 
> unsigned long device_bus_addr_to_phys(struct device
> *dev, dma_addr_t handle);
> 
> but we don't have one yet.  So you have to follow
> the rules above.
> 



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
