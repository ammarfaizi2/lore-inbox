Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265451AbTLHQWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265456AbTLHQWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:22:30 -0500
Received: from holomorphy.com ([199.26.172.102]:50907 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265451AbTLHQWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:22:20 -0500
Date: Mon, 8 Dec 2003 08:22:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Per Buer <perbu@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
Message-ID: <20031208162214.GW19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Per Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org
References: <1070897058.25490.56.camel@netstat.linpro.no> <20031208153641.GJ8039@holomorphy.com> <1070898870.25490.76.camel@netstat.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070898870.25490.76.camel@netstat.linpro.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 16:36, William Lee Irwin III wrote:
>> Could you send out a dmesg and a config file?

On Mon, Dec 08, 2003 at 04:54:31PM +0100, Per Buer wrote:
> Sure.
> We have tried two kernels on this server. A plain 2.4.18 (no patches)
> and 2.4.22 with the RMAP VM (we thought this might be related to the VM)
> and the brk()-fixes. No such luck. :(

The most common issue of this kind is where the device has addressibility
constraints that are automatically satisfied due to limited memory, but
once that's exceeded, the kernel resorts to overly-strict allocation
constraints because it has no other way of representing the constraint.

Specifically, the areas to which allocations may be constrained are:

ZONE_HIGHMEM:	no constraint
ZONE_NORMAL:	<= 896MB
ZONE_DMA:	<= 16MB

If your memory ended at 2GB and the driver had 31-bit DMA, it may have
decided to use unconstrained allocations. Then, when you added more RAM,
it was forced to ask for <= 896MB, which made it copy to buffers that are
actually below 896MB most of the time.

However, what I can see in the driver is very inconsistent with this
theory: it rather suggests it has 32-bit PCI and is otherwise not
constrainted.

So it's more likely that you have an unfriendly dma mask inherited from
upper levels (e.g. default bounce_pfn values in scsi template bits) or
bus' constraints (pci_set_dma_mask() etc. bits) than anything per-driver.


-- wli
