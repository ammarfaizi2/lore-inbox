Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSEQSqp>; Fri, 17 May 2002 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSEQSqo>; Fri, 17 May 2002 14:46:44 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:19888 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S316649AbSEQSqn>;
	Fri, 17 May 2002 14:46:43 -0400
Message-ID: <3CE55009.9050505@colorfullife.com>
Date: Fri, 17 May 2002 20:46:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en, de
MIME-Version: 1.0
To: "'Roger Luethi'" <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
        Shing Chuang <ShingChuang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> All the three conditions caused the TXON bit of CR1 went off. the
>> driver must wait  a little while until the bit go off, reset the pointer of
>> [...]
>> do {} while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));
> 
> The driver "waits a little" in the interrupt handler? How long can that
> take, worst case? I don't know of many places where the kernel stops to
> wait for an external device to change some value.
> 

It's not that uncommon: Most network drivers busy-wait after stopping 
the tx process during netif_close().

But I would add a maximum timeout and a printk - just to avoid 
unexplainable system hangs. One example would be natsemi_stop_rxtx() in 
drivers/net/natsemi.c.
IIRC all register reads from the addresses that belong to a pulled out 
PCMCIA card return 0xFFFFFFFF ;-)

Shing, I don't like the empty body of the while loop. It's not a bug, 
but doesn't that generate a large load on the pci bus?

I've always added an udelay(1), i.e. wait one microsecond, into such loops.

--
	Manfred

