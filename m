Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130422AbRCGHGz>; Wed, 7 Mar 2001 02:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbRCGHGp>; Wed, 7 Mar 2001 02:06:45 -0500
Received: from colorfullife.com ([216.156.138.34]:14859 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130422AbRCGHG1>;
	Wed, 7 Mar 2001 02:06:27 -0500
Message-ID: <3AA5DDCC.7F9CBA91@colorfullife.com>
Date: Wed, 07 Mar 2001 08:05:48 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Peter Zaitcev <zaitcev@redhat.com>, "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
In-Reply-To: <20010306004454.A12846@devserv.devel.redhat.com> <023301c0a693$087591e0$6800000a@brownell.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
> There are two problems I see.
> 
> (1) CONFIG_SLAB_DEBUG breaks the documented
> requirement that the slab cache return adequately aligned
> data ...

adequately aligned for the _cpu_, not for some controllers. It's neither
documented that HW_CACHEALIGN aligns to 16 byte boundaries nor that
kmalloc uses HW_CACHEALIGN.

> which the appended patch should probably handle
> nicely (something like it sure did :-) and with less danger
> than the large patch you posted.
>
> (2) The USB host controller drivers all need something
> like a pci_consistent slab cache, which doesn't currently
> exist.  I have something like that in the works, and David
> Miller noted one driver that I may steal from.
>

> - Dave
> 
> --- slab.c-orig Tue Mar  6 15:01:26 2001
> +++ slab.c Tue Mar  6 15:05:58 2001
> @@ -676,12 +676,10 @@
>   }
> 
>  #if DEBUG
> + /* redzoning would break cache alignment requirements */
> + if (flags & SLAB_HWCACHE_ALIGN)
> +  flags &= ~SLAB_RED_ZONE;

The problem is that you've just disabled red zoning for kmalloc. And
kmalloc is the only case where redzoning is important: If a caller uses
kmem_cache_alloc() for a structure then he won't write beyond the end of
the structure.

I think everyone agrees that (2) correct fix.
I see 2 temporary workarounds: either your patch or

+ #ifdef CONFIG_SLAB_DEBUG
+ #error
+ #endif

in uhci.c.

--
	Manfred
