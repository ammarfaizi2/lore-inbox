Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWEUInw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWEUInw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWEUInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:43:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:20998 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751511AbWEUInu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:43:50 -0400
Date: Sun, 21 May 2006 10:40:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel
Message-ID: <20060521084055.GA14593@w.ods.org>
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org> <446FAEE3.6060003@cmu.edu> <20060521054826.GA14334@w.ods.org> <44701017.8000803@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44701017.8000803@cmu.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 03:00:39AM -0400, George Nychis wrote:
> Thanks for all the help Willy,
> 
> Nothing from the grep:
> [root@emu-5 net]# grep 8390.o /lib/modules/2.4.32/modules.dep
> [root@emu-5 net]#
> 
> Exact list:
> enable_irq
> eth_type_trans
> __kfree_skb
> alloc_skb
> ether_setup
> crc32_le
> kmalloc
> cpu_raise_softirq
> alloc_netdev
> __out_of_line_bug
> disable_irq_nosync
> netif_rx
> skb_over_panic
> bitreverse
> jiffies
> softnet_data
> prink
^^^^^^^

You copied the list by hand, didn't you ?
Are you sure there were not revision after the symbol names,
such as "printk_R1b7d4074" ?


> __const_udelay
> 
> Grepping 2 or 3:
> [root@emu-5 net]# grep enable_irq /proc/ksyms
> c010a5e0 enable_irq_R__ver_enable_irq
> c0343610 matroxfb_enable_irq_R__ver_matroxfb_enable_irq
> [root@emu-5 net]# grep printk /proc/ksyms
> c011aee0 printk_R__ver_printk
> [root@emu-5 net]# grep kmalloc /proc/ksyms
> c0132c60 kmalloc_R__ver_kmalloc
> c03c07e0 sock_kmalloc_R__ver_sock_kmalloc
                        ^^^^^^^^^^^^^^^^^^^

There should be and 'R' followed by 8 hex digits here. I remember I
already came across this once, but unfortunately I don't remember how
nor how I fixed it.

When I build from your .config, I have "printk_R1b7d4074" for example.
It is defined in include/linux/modules/printk.ver which is dynamically
generated during make dep :

#define __ver_printk	1b7d4074
#define printk	_set_ver(printk)
#define __ver_acquire_console_sem	f174ed48
#define acquire_console_sem	_set_ver(acquire_console_sem)
#define __ver_console_print	b714a981
#define console_print	_set_ver(console_print)
#define __ver_console_unblank	b857dfed
#define console_unblank	_set_ver(console_unblank)
#define __ver_register_console	80c5241f
#define register_console	_set_ver(register_console)
#define __ver_unregister_console	d83dc0dd
#define unregister_console	_set_ver(unregister_console)

So I suspect that this file was not included at all during build. Stupid
question : are you really sure that the bzImage you boot from has been
rebuilt and that you're not running an old one ? Have you performed a
"make distclean" before you have built the kernel for the first time
(save your .config before doing this).

Hmmm while I'm thinking about it, please also ensure that you have
'genksyms' somewhere in your path.

> binutils version: 2.15.92.0.2 20040927
> gcc: 3.4.2 20041017

Should be OK.

> My .config can be found here:
> http://www.andrew.cmu.edu/user/gnychis/.config
> 
> And I will try taking out CONFIG_MODVERSIONS support and let you know
> how it goes!

I'm sure it will work.

> By the way, i'm not keen on inserting 8390.o into the kernel, it was
> simply the first thing i saw in my /lib/modules/2.4.32 directory, my
> goal is to get any module at all to insert, because it seems none will
> insert.

I understand, what I meant is that 8390 relies on crc32.o which might
or might not be included in the kernel. I wanted to identify the
possibility that some modules might have been missing.

> Thanks again!
> George

Regards,
Willy

