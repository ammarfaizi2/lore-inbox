Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946040AbWGONpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946040AbWGONpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 09:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946042AbWGONpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 09:45:39 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:23246 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1946040AbWGONpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 09:45:39 -0400
Message-ID: <44B8F0C8.70103@s5r6.in-berlin.de>
Date: Sat, 15 Jul 2006 15:42:32 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ralph Campbell <ralphc@pathscale.com>, David Miller <davem@davemloft.net>,
       muli@il.ibm.com, rdreier@cisco.com, openib-general@openib.org
Subject: Re: [openib-general] Suggestions for how to remove bus_to_virt()
References: <20060712.174013.95062313.davem@davemloft.net>	 <20060713054658.GC5096@rhun.ibm.com>	 <1152916027.4572.391.camel@brick.pathscale.com>	 <20060714.153503.123972494.davem@davemloft.net> <1152920719.4572.398.camel@brick.pathscale.com>
In-Reply-To: <1152920719.4572.398.camel@brick.pathscale.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph Campbell wrote:
> On Fri, 2006-07-14 at 15:35 -0700, David Miller wrote:
...
>> The dma_mapping_ops idea will never get accepted by folks like Linus,
>> for reasons I've outlined in previous emails in this thread.  So, it's
>> best to look elsewhere for solutions to your problem, such as the
>> ideas used by the USB and IEE1394 device layers.
> 
> The USB code won't work in my case because the USB system is
> the one doing the memory allocation and IOMMU setup so it
> can remember the kernel virtual address or physical pages used
> to create the mapping.

Side note: The same is true with the DMA stuff in the ieee1394
subsystem. And the SCSI subsystem doesn't allocate (all) buffers but
leaves DMA mapping and unmapping to the low-level drivers --- i.e. Ralph
can't rip bus_to_virt replacements from there either, because:

> In my case, the infiniband (SRP) code is doing the mapping and
> only passing the dma_addr_t to the device driver at which point
> I have no way to convert it back to a kernel virtual address.
> I need to either change the IB device API to include mapping functions
> or intercept the dma_* functions so I can save the inputs.

On the other hand, ieee1394/dma is the rather obvious example of a
generic layer which keeps book of virtual address and bus address of
mapped memory regions, for above or below layers to use as they need.

Ralph, do you think you can arrange your required API change as a pure
_extension_ of the IB API? I.e. add fields to data structs or add fields
to callback templates or add calls into the SRP layer... (I haven't
bothered to look at the API yet.)
-- 
Stefan Richter
-=====-=-==- -=== -====
http://arcgraph.de/sr/
