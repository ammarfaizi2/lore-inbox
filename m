Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSCOBC4>; Thu, 14 Mar 2002 20:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311887AbSCOBCr>; Thu, 14 Mar 2002 20:02:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49933 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311885AbSCOBCc>;
	Thu, 14 Mar 2002 20:02:32 -0500
Message-ID: <3C914816.1010707@mandrakesoft.com>
Date: Thu, 14 Mar 2002 20:02:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [patch] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <20020310.180456.91344522.davem@redhat.com> <20020310212210.A27870@redhat.com> <20020310.183033.67792009.davem@redhat.com> <20020312004036.A3441@redhat.com> <3C90733B.4020205@mandrakesoft.com> <20020314153711.D9194@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>>3) Seeing "volatile" in your code.  Cruft?  volatile's meaning change in 
>>recent gcc versions implies to me that your code may need some addition 
>>rmb/wmb calls perhaps, which are getting hidden via the driver's 
>>dependency on a compiler-version-specific implementation of "volatile."
>>
>
>Paranoia during writing.  I'll reaudit.  That said, volatile behaviour 
>is not compiler version specific.
>
gcc 3.1 volatile behavior changes, so, yes, it is...

>>4) Do you really mean to allocate memory for "REAL_RX_BUF_SIZE + 16"? 
>> Why not plain old REAL_RX_BUF_SIZE?
>>
>
>The +16 is for alignment (just like the comment says).  The hardware 
>requires that rx buffers be 64 bit aligned.
>
Cool... just checking.  Both RX_BUF_SIZE and REAL_RX_BUF_SIZE are defined as
    foo + magic_number

so I wasn't sure if the alignment space was -already- accounted for, in 
the definition of RX_BUF_SIZE, thus making the addition op next to 
allocations of REAL_RX_BUF_SIZE superfluous.  But, I stand corrected, 
thanks.

>5) Random question, do you call netif_carrier_{on,off,ok} for link 
>> status manipulation?  (if not, you should...)
>
>
>Ah, api updates.  Added to the todo.
>
More than just api updates... You have a bunch of hack-y logic for when 
the link goes down and up, messing around with netif_stop_queue and 
netif_wake_queue.  That stuff will be simplified or simply go away.  The 
basic idea is, if netif_carrier_ok(dev) is not true, then the net stack 
will not be sending you any packets.  So those extra 
netif_{stop,wake}_queue calls are superflouous.

We're also about to start sending link up/down messages async-ly via 
netlink, so that's even more added value as well.

>>6) skb_mangle_for_davem is pretty gross...  curious: what sort of NIC 
>>alignment restrictions are there on rx and tx buffers (not descriptors)? 
>> None? 32-bit?  Ignore CPU alignment for a moment here...
>>
>
>tx descriptors have no alignment restriction, rx descriptors must be 
>64 bit aligned.  Someone chose not to include the transistors for a 
>barrel shifter in the rx engine.
>

Sigh :)

>>7) What are the criteria for netif_wake_queue?  If you are waking when 
>>the TX is still "mostly full" you probably generate excessive wakeups...
>>
>
>Hrm?  Currently it will do a wakeup when at least one packet (8 sg 
>descriptors) can be sent.  Given that the tx done code is only called 
>when a tx desc (every 1/4 or so of the tx queue) or txidle interrupt 
>occurs, it shouldn't be that often.
>

Cool.  As FYI (_not_ advice on your driver), here's the logic I was 
referring to:

    dev->hard_start_xmit()
        if (free slots < MAX_SKB_FRAGS)
            BUG()
        queue packet
        if (free slots < MAX_SKB_FRAGS)
            netif_stop_queue(dev)

    foo_interrupt()
        if (some tx interrupt)
            complete as many TX's as possible
            if (netif_queue_stopped && (free slots > (TX_RING_SIZE / 4)))
                netif_wake_queue(dev)

But as long as your TX interrupts are well mitigated (and it sounds like 
they are), you can get by with your current scheme just fine.

    Jeff




