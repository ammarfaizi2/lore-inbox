Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130192AbRAKVCp>; Thu, 11 Jan 2001 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbRAKVCg>; Thu, 11 Jan 2001 16:02:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130192AbRAKVCX>; Thu, 11 Jan 2001 16:02:23 -0500
Date: Thu, 11 Jan 2001 16:01:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux driver:  __get_free_pages()
In-Reply-To: <20010111203933.17385.qmail@web119.yahoomail.com>
Message-ID: <Pine.LNX.3.95.1010111154554.379A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Paul Powell wrote:

> Our driver is trying to allocate a DMA buffer to flash
> an adapter's firmware.  This can require as much as
> 512K ( of contiguous DMA memory ). We are using the
> function __get_free_pages( GFP_KERNEL | GFP_DMA, order
> ) .  The call is failing if 'order' is greater than 6.
> The problem is seen on systems with system memory of
> only 64MB.  It works fine on systems with more memory.
>  Does it make sense that a system with 64MB would not
> have 512K ( contiguous ) available?  The most that can
> be allocated successfully on the 64MB system appears
> to be 256K.  (Nothing else is running that would eat
> up 64MB of memory).
> 
> Does this make sense and/or is there another way that
> the DMA memory could be allocated successfully?
> 

Are you sure it needs memory? Usually, you need address-space
to flash firmware. Also, in recent months, I've evaluated a
lot of NVRAM from flash to single-bit SEEPROM. I have never
seen anything that would `know` how to flash from DMA.

Typically, with NVRAM, you scribble some 0xaaa, 0x555, 0xetc, at some
specified offset, then you write a single byte/word/longword (depending
upon its addressing), at the location to program. Then you loop, waiting
for it to "take", then you do the next. All stuff you would never do with
DMA.

If all you need is a kernel buffer to store the stuff that will be
written to NVRAM, then just use kmalloc(). It is virtual and will
seem contiguous to your driver.

If you have to 'bus-master' data from your buffer to the NVRAM, you
just do it one page at a time, using the same page.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
