Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWGHR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWGHR7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWGHR7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:59:39 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:50912 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964928AbWGHR7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:59:38 -0400
Date: Sat, 08 Jul 2006 11:59:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC 0/8] Optional ZONE_DMA
In-reply-to: <fa.3mXwB3pXW7L2KpeFW2PO8SBLhJA@ifi.uio.no>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-id: <44AFF286.6020601@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.3mXwB3pXW7L2KpeFW2PO8SBLhJA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Optional ZONE_DMA
> 
> ZONE_DMA is usually used for ISA DMA devices. Typically modern hardware
> does not have any of these anymore. We frequently do not need
> the zone anymore.
> 
> This patch allows to make the configuration of the kernel for
> ZONE_DMA dependend on the user choosing to support ISA DMA.
> If ISA DMA is not supported then i386 systems f.e. can be
> configured using a single ZONE_NORMAL. The overhead of maintaining
> multiple zones and balancing page use between the different
> zone is then gone. My i386 system now runs with a single zone.
> 
> On x86_64 systems also usually we do not need ZONE_DMA since there
> are barely any ISA DMA devices around (or are you still using a floppy?).
> So for most cases the zone can be dropped. Also if the x86_64 systems
> has less than 4G RAM or DMA controllers that actually can do 64 bit
> then we also do not need ZONE_DMA32. My x86_64 system has 1G of
> memory therefore I can run with a single zone.

Keep in mind that:

-LPC devices like the floppy controller, maybe enhanced parallel, etc. 
may have 24-bit DMA restrictions even if there is no physical ISA bus.

-Even in totally ISA and LPC-free systems, some PCI devices (like those 
that were a quick hack of an ISA device onto PCI) still have 24-bit 
address restrictions. There are other devices that have sub-32-bit DMA 
capabilities, like Broadcom wireless chips that only address 31 bits 
(although I think they are fixing this in the driver). Without the DMA 
zone there is no way to ensure that these requests can be satisfied.

So I don't think it is safe to make this conditional on ISA or even the 
ISA DMA API. Only if all devices on the system have addressing 
capability of a full 32 bits (or at least of all installed RAM) can this 
zone be removed.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

