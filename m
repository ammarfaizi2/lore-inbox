Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130370AbQKDDN3>; Fri, 3 Nov 2000 22:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbQKDDNT>; Fri, 3 Nov 2000 22:13:19 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5129 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S130370AbQKDDNF>;
	Fri, 3 Nov 2000 22:13:05 -0500
Message-ID: <3A037E9F.55B16633@mandrakesoft.com>
Date: Fri, 03 Nov 2000 22:12:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9
In-Reply-To: <Pine.LNX.3.95.1001103213717.2705A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> On Fri, 3 Nov 2000, Jeff Garzik wrote:
> > "Richard B. Johnson" wrote:
> > > (3)      With the new kernel, I can't access screen memory anymore. When
> > > testing software drivers for hardware that I don't have, I usually use
> > > the screen-regen buffer to emulate the shared memory window.
> > >
> > > Here is a snippet of code:
> > >
> > > //    info->mem = 0xb8000     what they actually are
> > > //    info->mem_len = 0x4000
> > >
> > >     if((info->vxi_iomem = ioremap(info->mem, info->mem_len)) == NULL)
> > >     {
> > >         printk(KERN_ALERT "%s: Can't allocate shared memory\n", devname);
> > >         (void)unregister_chrdev(info->major, info->dev);
> > >         kfree(info->tmp_buf);
> > >         kfree(info);
> > >         return -ENOMEM;
> > >     }
> > >     info->vxi_base   = (UNIV *) bus_to_virt(UL info->vxi_iomem);
> > >     ||||||||||||||
> > >     This pointer should point to the beginning of the screen buffer.
> > >     It always has before.
> > >
> > > When accessing this from a module, I get;
> > > Unable to handle kernel paging requist at virtual address 800b8304.
> >
> > bug 1) ioremap returns a cookie, not a bus address.  therefore, calling
> > ioremap output to bus_to_virt is incorrect.
> >
> 
> So explain??  What do you mean a cookie?

ioremap returns a value that ideally should only be passed on to other
MMIO functions:  iounmap, readb, readw, readl, writeb, writew, writel,
memcpy_toio, memcpy_fromio, etc.

Think of ioremap as returning a token which can be passed back into the
above list of functions.  You should never dereference ioremap'd memory
directly...


> > bug 2) what are you doing with vxi_base?  I don't have the rest of your
> > code here, but I'm willing to bet that you are directly de-referencing
> > memory, instead of using {read,write}[bwl] / memcpy_{to,from}io.  Read
> > linux/Documentation/IO-mapping.txt for more info.
> >
> 
> Nope. It's copied, using memcpy_to/from_io, into a kmalloc()ed buffer.

As long as you are passing ioremap'd address to memcpy_to/from_io,
that's ok.


> However, there is a section, of 0x800 dwords that are accessed as
> registers (directly).
> 
> This will be a real bitch, if necessary, with the real device because
> I have to reference 0x800 dwords as device registers.

> And if I can't do that, I am totally screwed, and will have to stay
> with a version that allows it. I can just imagine code that references
> these registers using an obscure macro. It just won't be maintainable
> and I don't intend to live with the code for the product lifetime.

Well, ioremap returns a virtual address, which is directly accessible to
the local CPU.  Maybe (as a hack) you can completely ignore what I said
above, and directly de-reference the ioremap'd memory.  ie. eliminate
info->vxi_base altogether.

But if you are going to eliminate info->vxi_base, it seems like that
would flush out all direct de-refs, whether they are buried in an
obscure macro or not.  And if you find all that crap, you might as well
use readb/writel at that point...

	info->registers[0x7FF] = newvalue;
		becomes
	writel(newvalue, &info->registers[0x7FF]);
and
	regval = info->registers[0x7FF];
		becomes
	regval = readl(&info->registers[0x7FF]);

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
