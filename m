Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRI0JSG>; Thu, 27 Sep 2001 05:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272212AbRI0JRz>; Thu, 27 Sep 2001 05:17:55 -0400
Received: from chiara.elte.hu ([157.181.150.200]:19469 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S272197AbRI0JRu>;
	Thu, 27 Sep 2001 05:17:50 -0400
Date: Thu, 27 Sep 2001 11:15:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Bernd Harries <mlbha@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <356.1001580994@www46.gmx.net>
Message-ID: <Pine.LNX.4.33.0109271107360.3716-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Bernd Harries wrote:

> Is __get_free_pages() not enough to allocate memory in the kernel?
> Seems like something else is using the same memory. Do I have to lock
> the pages I allocated?

it's enough. The pages you allocate through the Linux page allocator are
private, no additional locking is necessery

> In a driver I'm writing, in the open() method, I use multiple
> __get_free_pages() to allocate a 4 MB kernel (image)buffer for DMA
> purposes. The buffer I get is contiguous (I try until it is) and is
> freed in close(). Order count is 9.

so you are using two __get_free_pages(order==9) calls to get two chunks of
2 MB physical areas, and you use them as a single 4 MB area? This is
perfectly legal - but there is no guarantee you will succeed getting two
nearby 2 MB pages. You will get it if your driver initializes during
bootup - but if it's loaded/unloaded via kmod while the system is up and
running and using its RAM, chances are very low that you'll get a single 2
MB page - let alone two that are adjacent.

> When I run the user appl. again after short time I mostly get the same
> chunk of physical memory (virt_to_bus is identical!)

have you perpahs freed that page? printk every occasion of
allocating/freeing a 2 MB buffer and i'm sure you'll see the problem.
(Perhaps it's the close() implicitly done by exit() that frees the
buffer?)

> If I repeat the user program within seconds, suddenly the 2nd 256 byte
> dump starts to change. Sometimes I see filenames of my harddisk within
> the hexdump, looking like some directory listing. (e.g.
> "/etc/ppp/options" ) Sometimes I see the contents of the printk buffer
> of the kernel, sometimes stuff I cannot identify.

it appears you freed the page. send the relevant parts of the driver code
for details.

	Ingo

