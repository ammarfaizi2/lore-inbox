Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132213AbQKDBGJ>; Fri, 3 Nov 2000 20:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbQKDBF7>; Fri, 3 Nov 2000 20:05:59 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39687 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132213AbQKDBFw>;
	Fri, 3 Nov 2000 20:05:52 -0500
Message-ID: <3A0360CB.F534D043@mandrakesoft.com>
Date: Fri, 03 Nov 2000 20:05:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9
In-Reply-To: <Pine.LNX.3.95.1001103175055.612A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> I have, again, tried to use a new kernel. It is linux-2.4.0-test9
> Apparently a newer version was just put up while downloading this
> one. This is possible because it took a day to download it );

If you could download patch-2.4.0-test10, and try out test10-final, that
would be awesome...


> (3)      With the new kernel, I can't access screen memory anymore. When
> testing software drivers for hardware that I don't have, I usually use
> the screen-regen buffer to emulate the shared memory window.
> 
> Here is a snippet of code:
> 
> //    info->mem = 0xb8000     what they actually are
> //    info->mem_len = 0x4000
> 
>     if((info->vxi_iomem = ioremap(info->mem, info->mem_len)) == NULL)
>     {
>         printk(KERN_ALERT "%s: Can't allocate shared memory\n", devname);
>         (void)unregister_chrdev(info->major, info->dev);
>         kfree(info->tmp_buf);
>         kfree(info);
>         return -ENOMEM;
>     }
>     info->vxi_base   = (UNIV *) bus_to_virt(UL info->vxi_iomem);
>     ||||||||||||||
>     This pointer should point to the beginning of the screen buffer.
>     It always has before.
> 
> When accessing this from a module, I get;
> Unable to handle kernel paging requist at virtual address 800b8304.

bug 1) ioremap returns a cookie, not a bus address.  therefore, calling
ioremap output to bus_to_virt is incorrect.

bug 2) what are you doing with vxi_base?  I don't have the rest of your
code here, but I'm willing to bet that you are directly de-referencing
memory, instead of using {read,write}[bwl] / memcpy_{to,from}io.  Read
linux/Documentation/IO-mapping.txt for more info.


> (4)     More name-space polution. Somebody added another macro called
>         get_page(). When, if ever, will we start using the good-old
>         convention of defining macros in upper-case?
> 
>         The name-space polution has really gotten out-of-hand. You
>         can't write code using ordinary symbol names anymore. You
>         need to make variables have names like:
> 
>         int LoopCounterForOutSideLoop;
>         char *UserInputAndOutputBufferForWednesday;
> 
>         This is NotGood(tm)

I guess it should probably have been named "page_get"?  I looked through
'nm vmlinux' output at the public symbols, and there are definitely a
ton of them.

Though it is definitely C convention that macros are in all uppercase
(gcc is good about this), the kernel has never really been good about
that...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
