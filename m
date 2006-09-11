Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWIKVyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWIKVyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWIKVyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:54:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63425 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964974AbWIKVyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:54:31 -0400
Message-ID: <4505DB10.7080807@pobox.com>
Date: Mon, 11 Sep 2006 17:54:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
References: <1157947414.31071.386.camel@localhost.localdomain>	 <200609111139.35344.jbarnes@virtuousgeek.org> <1158011129.3879.69.camel@localhost.localdomain>
In-Reply-To: <1158011129.3879.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Ah ? What about the comment in e1000 saying that it needs a wmb()
> between descriptor updates in memory and the mmio to kick them ? That
> would typically be a memory_to_io_wb(). Or are your MMIOs ordered cs.
> your cacheable stores ?

That's likely just following existing practice found in many network 
drivers.  The following two design patterns have been copied across a 
great many network drivers:

1) When in a loop, reading through a DMA ring, put an "rmb()" at the top 
of the loop, to ensure that the compiler does not optimize out all 
memory loads after the first.

2) Use "wmb()" to ensure that just-written-to memory is visible to a PCI 
device that will be reading said memory region via DMA.

I don't claim that either of these is correct, just that's existing 
practice, perhaps in some case perpetuated by my own arch ignorance.

So, in a perfect world where I was designing my own API, I would create 
two new API functions:

prepare_to_read_dma_memory()
	and
make_memory_writes_visible_to_dmaing_devices()

and leave the existing APIs untouched.  Those are the two fundamental 
operations that are needed.

	Jeff


