Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRI3M6K>; Sun, 30 Sep 2001 08:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273442AbRI3M6A>; Sun, 30 Sep 2001 08:58:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:8164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S272636AbRI3M5s>;
	Sun, 30 Sep 2001 08:57:48 -0400
Message-ID: <3BB71715.A57FA7D4@gmx.de>
Date: Sun, 30 Sep 2001 14:59:01 +0200
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: BHA Industries
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <Pine.LNX.4.33.0109300914490.1665-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> This is a property of Linux's buddy allocator. If you allocate a 9th order
> 'big page', that does not mean you can free the pages one by one.

I used  free_pages((ULONG)card_ptr->dma_blk0[n], max_order); before Roman 
changed it. And still do for minor 26 now...

> while unconventional, doing this is safe. There is nothing in the page
> structure that says that the page was allocated as a higher order page.

> But the above is an 'internal' property of
> the Linux page allocator, so it's not guaranteed to stay so forever.

Thats why I don't like it so much. But it seems I must do it for some strange
reason:

On minor 26 I do it the old way, on minor 27 I use Romans fix. What shall I say:
Reading and writing to the buffer allocated with Roman's fix so far never
crashed the system. But doing it the normal way (minor 26) how I also learned it
from A. Rubini's book, 
does harm to the system.

After usage of the normally allocated buffer the strangest thing occur:
- Issing w caused a dump on the console once.
- Halt doesn't really halt the system completely
- Reboot caused everything to hang, partitions still dirty...


> (the Linux kernel does not do the above for understandable reasons: it
> takes a loop of 512 iterations to fix up the page counts in the above way,
> which is noticeable runtime overhead.)

Oh yes, indeed! But:

Is there a guarantee that the n - 1 pages above the 1st one are not donated to
other programs while my driver uses them?


> is it a fundamental property of the hardware that it needs a continuous
> physical memory buffer?

Yes. The FW on the card demands it.

> Being able to allocate a 2 MB page is only guaranteed during bootup. There
> is just no mechanizm in Linux that guarantees it for you to be able to
> allocate a 2 MB page (let alone two adjacent 2 MB pages), in even a
> moderately utilized system. Scatter-gather avoids all these problems.

I'll move the code to init_module later once it is stable.

Ciao,
-- 
Bernd Harries

bha@gmx.de           http://www.freeyellow.com/members/bharries
bha@nikocity.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org      8.48'21" E  52.48'52" N  | Medusa T40
           <>_<>      _______                _____
       .---|'"`|---. |  |_|  |_|_|_|_|_|_|_ (_____)  .-----.
______`o"O-OO-OO-O"o'`-o---o-'`-oo-----oo-'`-o---o-'`-o---o-'___
