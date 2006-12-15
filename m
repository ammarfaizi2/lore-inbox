Return-Path: <linux-kernel-owner+w=401wt.eu-S1753405AbWLOUZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbWLOUZg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbWLOUZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:25:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:39508 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbWLOUZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:25:35 -0500
Subject: Re: [PATCH] Fix sparsemem on Cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       apw@shadowen.org, mkravetz@us.ibm.com, hch@infradead.org, jk@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org,
       gone@us.ibm.com
In-Reply-To: <20061215165335.61D9F775@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 07:21:53 +1100
Message-Id: <1166214113.31351.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The only other assumption is that all memory-hotplug-time pages 
> given to memmap_init_zone() are valid and able to be onlined into
> any any zone after the system is running.  The "valid" part is
> really just a question of whether or not a 'struct page' is there
> for the pfn, and *not* whether there is actual memory.  Since
> all sparsemem sections have contiguous mem_map[]s within them,
> and we only memory hotplug entire sparsemem sections, we can
> be confident that this assumption will hold.
> 
> As for the memory being in the right node, we'll assume tha
> memory hotplug is putting things in the right node.

BTW, just that people know, what we are adding isn't even memory :-) We
are calling __add_pages() to create struct page for the SPE local stores
and register space as we use them later from a nopage() handler (and no,
we can't use no_pfn just yet for various reasons, notably we need to
handle races with unmap_mapping_ranges() and thus have the truncate
logic in).

Those pages, thus, must never be onlined. Ever. It might make sense to
create a way to inform memory hotplug of that fact, but on the other
hand, I wouldn't bother as I have a plan to get rid of those
__add_pages() completely and work without struct page, maybe in a 2.6.21
timeframe.

Ben.


