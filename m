Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVAKBbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVAKBbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVAKBbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:31:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:14512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262684AbVAKBad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:30:33 -0500
Date: Mon, 10 Jan 2005 17:30:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
In-Reply-To: <41E31D95.50205@osdl.org>
Message-ID: <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org>
References: <8746466a050110153479954fd2@mail.gmail.com>
 <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org> <41E31D95.50205@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jan 2005, Randy.Dunlap wrote:
> 
> Speaking of fall-out, or more like trickle-down,
> I'm almost done with a patch to make PCMCIA resources use
> unsigned long instead of u_int or u_short for IO address:

Ahh, yes. That's required on pretty much all platforms except x86 and
x86-64.

Of course, since ARM and MIPS already do the "u_int" thing, and not a 
whole lot of other architectures do PCMCIA, I guess it doesn't matter 
_that_ much. Cardbus stuff should get it right regardless.

> typedef unsigned long	ioaddr_t;
> 
> and then include/pcmcia/cs.c needs some changes in use of
> ioaddr_t, along with drivers (printk formats).
> 
> Does that sound OK?
> I guess that it would become unsigned long long (or u64)
> with this proposal?

I don't think ioaddr_t needs to match resources. None of the IO accessor
functions take "u64"s anyway - and aren't likely to do so in the future
either - so "unsigned long" should be good enough.

Having u64 for resource handling is mainly an issue for RAM and
memory-mapped IO (right now the 32-bit limit means that we throw away
information about stuff above the 4GB mark from the e820 interfaces on
x86, for example - that _happens_ to work because we never see anything 
but RAM there anyway, but it means that /proc/iomem doesn't show all of 
the system RAM, and it does mean that our resource management doesn't 
actually handle 64-bit addresses correctly. 

See drivers/pci/probe.c for the result:

	"PCI: Unable to handle 64-bit address for device xxxx"

(and I do not actually think this has _ever_ happened in real life, which 
makes me suspect that Windows doesn't handle them either - but it 
inevitably will happen some day).

		Linus
