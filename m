Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTIDQl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTIDQl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:41:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:35228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265295AbTIDQly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:41:54 -0400
Date: Thu, 4 Sep 2003 09:41:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <Pine.GSO.4.21.0309041420460.8244-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Geert Uytterhoeven wrote:
> 
> `ioremap is meant for PCI memory space only'

No, I don't agree. The "iomem_resource" is there for all IO-mapped ranges, 
and it could easily be a mixture of PCI and other buses. In fact, it 
already is on bog-standard hardware: it contains the AGP windows etc.

Whatever is visible in the physical memory window (by _some_ definition of 
"physical memory window", and that definition clearly has to be the 
biggest possible as seen by software, so it's usually a CPU-centric view 
of "any bus that is outside the CPU") should be mappable into the 
_virtual_ memory window as seen by the CPU.

So clearly ioremap() has to work for other buses too.

I think that in the 2.7.x timeframe, the right thing to do is definitely:
 - move towards using "struct resource" and "ioremap_resource()"
 - make resource sizes potentially be larger (ie use "u64" instead of 
   "unsigned long")

This is actually a potential issue already, with 64-bit PCI on regular 
PC's. We don't handle it at all right now (the PCI probing will just not 
create the resources), and nobody has complained, but clearly the 
RightThing(tm) to do eventually is to make sure this all works cleanly.

I just don't think it's worth worrying about in 2.6.x right now, since it 
doesn't matter for anybody. 

		Linus

