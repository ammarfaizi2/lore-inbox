Return-Path: <linux-kernel-owner+w=401wt.eu-S1750773AbXACNZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXACNZj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXACNZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:25:39 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:55197 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbXACNZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:25:38 -0500
X-Originating-Ip: 74.109.98.100
Date: Wed, 3 Jan 2007 08:20:09 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: Folkert van Heusden <folkert@vanheusden.com>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <1167586995.20929.829.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0701030818330.31668@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> 
 <200612302149.35752.vda.linux@googlemail.com> 
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain> 
 <1167518748.20929.578.camel@laptopd505.fenrus.org>  <20061231133902.GA13521@vanheusden.com>
  <1167572735.20929.750.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0612311118490.13153@localhost.localdomain>
 <1167586995.20929.829.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006, Arjan van de Ven wrote:

> So... yes I fully agree with you that it's worth looking at the
> memset( , PAGE_SIZE) users. If they are page aligned, yes absolutely
> make it a clear_page(), I think that's a very good idea. However
> also please check if they've been very recently allocated in that
> code, and if maybe the zeroing allocators are better suited there..
> (or maybe there's even double zeroing going on.. that's be a nice
> gain)

  there's certainly some cleanup/speedup that could be done regarding
these numerous "memset(...,0,PAGE_SIZE) calls.

  first, there the obvious 1:1 replacement with a call to
"clear_page()" ***if that's appropriate***.

  second, there's some possible simplification, given snippets like
this one from arch/sparc/mm/sun4c.c

	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
        if (pte)
                memset(pte, 0, PAGE_SIZE);

which seems to be an obvious candidate for replacement with:

	pte = get_zeroed_page(GFP_KERNEL|__GFP_REPEAT)

no?

  finally, there is certainly some "double zeroing" going on, as with
this snippet from drivers/atm/eni.c:

	...
	eni_dev->rx_map = (struct atm_vcc **) get_zeroed_page(GFP_KERNEL);
                                              ^^^^^^^^^^^^^^^
        if (!eni_dev->rx_map) {
                printk(KERN_ERR DEV_LABEL "(itf %d): couldn't get free page\n",
                    dev->number);
                free_page((unsigned long) eni_dev->free_list);
                return -ENOMEM;
        }
        memset(eni_dev->rx_map,0,PAGE_SIZE);	// redundant, no?
	...

  so, yes, there does appear to be room for cleanup/speedup.

rday


