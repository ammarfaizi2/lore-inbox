Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274908AbRJALdl>; Mon, 1 Oct 2001 07:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274896AbRJALdY>; Mon, 1 Oct 2001 07:33:24 -0400
Received: from mx0.gmx.de ([213.165.64.100]:40013 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S274890AbRJALdB>;
	Mon, 1 Oct 2001 07:33:01 -0400
Date: Mon, 1 Oct 2001 13:33:24 +0200 (MEST)
From: Bernd Harries <mlbha@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
MIME-Version: 1.0
Subject: Re: __get_free_pages(): is the MEM really mine?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000450161@gmx.net
X-Authenticated-IP: [141.200.125.99]
Message-ID: <26148.1001936004@www42.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> > Is there a guarantee that the n - 1 pages above the 1st one are not
> > donated to other programs while my driver uses them?
> 
> yes. The 2MB block of 512 x 4k pages (we should perhaps call it a 'order 9
> page') is yours.

I think I have to demonstrate to you how my driver behaves in reality.

Too bad the driver would in the moment not allow any open() without at least
a PLX RDK Lite evaluation board... It would be possible to modify it to
allow opens even there is no card. Or to malloc a 4 MB buffer also for the minor
31 device, which is my dummy test minor that needs no HW.

Of course you couldn't use the PLX DMA engine then. But you could still mmap
the RAM to user space.

An alternative to sending you a driver (which could make your box instable
temporaryly) is to let you use my Linux box at home. Damn, why didn't I let
you log in from Oldenburg... I forgot about that possibility. I took a PLX eval
board home with me already friday, because here I have the real RSC cards
already.

What do you think?


> > I'll move the code to init_module later once it is stable.
> 
> even init_module() can be executed much later: eg. kmod removes the module
> because it's unused, and it's reinserted later. So generally it's really
> unrobust to expect a 9th order allocation to succeed at module_init()
> time.

For our application (dedicated System) I could guarantee even that.

> the fundamental issue is not the lazyness of Linux VM developers. 99.9% of
> all allocations are order 0. 99.9% of the remaining allocations are order
> 1 or 2.

I wonder why only I see problems so far. Maybe it's because I also mmap()
that RAM to user space?



> (later on we could even add support to grow and shrink the size of the
> physical memory pool (within certain boundaries), so it could be sized
> boot-time.)
> 
> would anything like this be useful? Since it's a completely separate pool
> (in fact it wont even show up in the normal memory statistics), it does
> not disturb the existing VM in any way.

It would'nt even be needed in the moment. The 9-order get_free_pages() does
not explicitly fail. Not even during later open()s. If it would I would
simply add more RAM. (well, let the company pay it) 256 MB are in and that is
enough so far.

Later I will load the module explicitly right after boot and then it's
almost sure I will get the RAM.

Well, as I said, get_free_pages doesn't even fail! It just seems to allow
others to use the RAM before I free it again... Or it corrupts some kernel
structs during munmap(), which certainly decrements the usage counter of the
upper pages to 0 again.

For now I'll try to reproduce instability without using a DMA Hardware.

Thanks,

-- 
Bernd Harries

bha@gmx.de            http://bharries.freeyellow.com
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40

GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

