Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSEXSuC>; Fri, 24 May 2002 14:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSEXSuB>; Fri, 24 May 2002 14:50:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314413AbSEXSuB>; Fri, 24 May 2002 14:50:01 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
Date: Fri, 24 May 2002 18:49:29 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <acm1vp$2ak$1@penguin.transmeta.com>
In-Reply-To: <20020523171326.GA11562@kroah.com> <3CED6E0B.8020501@pacbell.net>
X-Trace: palladium.transmeta.com 1022266200 12746 127.0.0.1 (24 May 2002 18:50:00 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 May 2002 18:50:00 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3CED6E0B.8020501@pacbell.net>,
David Brownell  <david-b@pacbell.net> wrote:
>
>Is there a clean way to detect the "card ejected before anything calls 
>pci_dev->remove()" case?  I don't really like the idea of wrapping code
>around every PCI register access to detect such cases.

You don't have much choice with CardBus, I'm afraid.

Even if the user were to do the rmmod "before" yanking out the card,
assuming that the rmmod took a bit of time and started the "remove()"
call at the same time the card was actually removed, you'll end up in
the same situation.

It's just a fact of life with any hot-plug thing that can be removed
without software first freeing it.

On most (practically all?) machines, a device that no longer exists will
return a nice floating 0xff for device reads, so it's usually reasonably
simple to detect (0xff is often not a legal status register value for
most devices for example). 

Also, it's generally a good idea to "just say no" to endless loops in
drivers. Hardware bugs _do_ happen, and it's a lot more pleasant to have
the driver do a

	printk("Device does not respond\n");

than for the kernel to hang.

		Linus
