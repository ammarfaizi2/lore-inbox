Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUGMWHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUGMWHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266911AbUGMWHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:07:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266907AbUGMWHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:07:42 -0400
Message-ID: <40F45D1C.8060005@pobox.com>
Date: Tue, 13 Jul 2004 18:07:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: Re: Trivial cleanups & 64-bit fixes for donauboe.c
References: <20040713212156.GA2971@elf.ucw.cz>
In-Reply-To: <20040713212156.GA2971@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> donauboe uses __u32; this is kernel code, you are allowed to use u32
> which is less ugly. ASSERT() is pretty ugly. I made it 64-bit clean,
> and if it is outside 32-bit range, it BUG()s. Not ideal, but better
> than not compiling.
[...]
> -#if (BITS_PER_LONG == 64)
> -#error broken on 64-bit:  casts pointer to 32-bit, and then back to pointer.
> -#endif
> -
> -  /*We need to align the taskfile on a taskfile size boundary */
> +  /* We need to align the taskfile on a taskfile size boundary */
>    {
>      unsigned long addr;
>  
> -    addr = (__u32) self->ringbuf;
> +    addr = (unsigned long) self->ringbuf;
>      addr &= ~(OBOE_RING_LEN - 1);
>      addr += OBOE_RING_LEN;
>      self->ring = (struct OboeRing *) addr;
>    }


This driver is awful:

1) it kmalloc's memory for DMA purposes
2) it uses virt_to_bus to map the rx/tx buffers
3) it uses 32-bit hardware field to store a pointer

If you want to clean all that up, and convert it to the PCI DMA API, 
that would be the proper fix for all this.

Making it compile, but leaving the bugs, is worse than the #error I 
added... it just hides the bugs again.  Your patch does not address the 
bugs at all.  (the cleanups are, of course, OK)

	Jeff


