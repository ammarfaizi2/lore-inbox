Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130101AbQKDCt5>; Fri, 3 Nov 2000 21:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbQKDCtr>; Fri, 3 Nov 2000 21:49:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7172 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130101AbQKDCtj>; Fri, 3 Nov 2000 21:49:39 -0500
Date: Fri, 3 Nov 2000 21:49:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9
In-Reply-To: <3A0360CB.F534D043@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1001103213717.2705A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Jeff Garzik wrote:

> "Richard B. Johnson" wrote:
> > I have, again, tried to use a new kernel. It is linux-2.4.0-test9
> > Apparently a newer version was just put up while downloading this
> > one. This is possible because it took a day to download it );
> 
> If you could download patch-2.4.0-test10, and try out test10-final, that
> would be awesome...
> 
I will do that Monday.

> 
> > (3)      With the new kernel, I can't access screen memory anymore. When
> > testing software drivers for hardware that I don't have, I usually use
> > the screen-regen buffer to emulate the shared memory window.
> > 
> > Here is a snippet of code:
> > 
> > //    info->mem = 0xb8000     what they actually are
> > //    info->mem_len = 0x4000
> > 
> >     if((info->vxi_iomem = ioremap(info->mem, info->mem_len)) == NULL)
> >     {
> >         printk(KERN_ALERT "%s: Can't allocate shared memory\n", devname);
> >         (void)unregister_chrdev(info->major, info->dev);
> >         kfree(info->tmp_buf);
> >         kfree(info);
> >         return -ENOMEM;
> >     }
> >     info->vxi_base   = (UNIV *) bus_to_virt(UL info->vxi_iomem);
> >     ||||||||||||||
> >     This pointer should point to the beginning of the screen buffer.
> >     It always has before.
> > 
> > When accessing this from a module, I get;
> > Unable to handle kernel paging requist at virtual address 800b8304.
> 
> bug 1) ioremap returns a cookie, not a bus address.  therefore, calling
> ioremap output to bus_to_virt is incorrect.
> 

So explain??  What do you mean a cookie?


> bug 2) what are you doing with vxi_base?  I don't have the rest of your
> code here, but I'm willing to bet that you are directly de-referencing
> memory, instead of using {read,write}[bwl] / memcpy_{to,from}io.  Read
> linux/Documentation/IO-mapping.txt for more info.
> 

Nope. It's copied, using memcpy_to/from_io, into a kmalloc()ed buffer.

However, there is a section, of 0x800 dwords that are accessed as
registers (directly).

This will be a real bitch, if necessary, with the real device because
I have to reference 0x800 dwords as device registers.

And if I can't do that, I am totally screwed, and will have to stay
with a version that allows it. I can just imagine code that references
these registers using an obscure macro. It just won't be maintainable
and I don't intend to live with the code for the product lifetime.

> 
> > (4)     More name-space polution. Somebody added another macro called
> >         get_page(). When, if ever, will we start using the good-old
> >         convention of defining macros in upper-case?
> > 
> >         The name-space polution has really gotten out-of-hand. You
> >         can't write code using ordinary symbol names anymore. You
> >         need to make variables have names like:
> > 
> >         int LoopCounterForOutSideLoop;
> >         char *UserInputAndOutputBufferForWednesday;
> > 
> >         This is NotGood(tm)
> 
> I guess it should probably have been named "page_get"?  I looked through
> 'nm vmlinux' output at the public symbols, and there are definitely a
> ton of them.
> 
> Though it is definitely C convention that macros are in all uppercase
> (gcc is good about this), the kernel has never really been good about
> that...
> 
> 	Jeff
 

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
