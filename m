Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311761AbSCNUiF>; Thu, 14 Mar 2002 15:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311764AbSCNUhz>; Thu, 14 Mar 2002 15:37:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37667 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S311761AbSCNUhq>; Thu, 14 Mar 2002 15:37:46 -0500
Date: Thu, 14 Mar 2002 15:37:11 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [patch] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
Message-ID: <20020314153711.D9194@redhat.com>
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <20020310.180456.91344522.davem@redhat.com> <20020310212210.A27870@redhat.com> <20020310.183033.67792009.davem@redhat.com> <20020312004036.A3441@redhat.com> <3C90733B.4020205@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C90733B.4020205@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Mar 14, 2002 at 04:54:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 04:54:03AM -0500, Jeff Garzik wrote:
> Comments:
> 
> 1) What were the test conditions leading to your decision to decrease 
> the RX/TX ring count?  I'm not questioning the decision, but looking to 
> be better informed...  other gigabit drivers normally have larger rings. 
>  I also wonder if the slowdown you see could be related to a small-sized 
> FIFO on the natsemi chips, that would probably not be present on other 
> gigabit chips.

Smaller rings lead to better thruput, especially on the slower cpus.  Not 
that in part the slowness was caused by having slab debugging enabled.  
Turning slab debugging off brought the p3s up to ~500mbit and the athlons 
over 900.

> 2) PCI latency timer is set with pci_set_master(), as in:  if it's not 
> correctly set, fix it up.  If it's correctly set, leave it alone and let 
> the user tune in BIOS Setup.

Ah.  That part is something I was thinking of deleting, and now will do.

> 3) Seeing "volatile" in your code.  Cruft?  volatile's meaning change in 
> recent gcc versions implies to me that your code may need some addition 
> rmb/wmb calls perhaps, which are getting hidden via the driver's 
> dependency on a compiler-version-specific implementation of "volatile."

Paranoia during writing.  I'll reaudit.  That said, volatile behaviour 
is not compiler version specific.

> 4) Do you really mean to allocate memory for "REAL_RX_BUF_SIZE + 16"? 
>  Why not plain old REAL_RX_BUF_SIZE?

The +16 is for alignment (just like the comment says).  The hardware 
requires that rx buffers be 64 bit aligned.

> 5) Random question, do you call netif_carrier_{on,off,ok} for link 
> status manipulation?  (if not, you should...)

Ah, api updates.  Added to the todo.

> 6) skb_mangle_for_davem is pretty gross...  curious: what sort of NIC 
> alignment restrictions are there on rx and tx buffers (not descriptors)? 
>  None? 32-bit?  Ignore CPU alignment for a moment here...

tx descriptors have no alignment restriction, rx descriptors must be 
64 bit aligned.  Someone chose not to include the transistors for a 
barrel shifter in the rx engine.

> 7) What are the criteria for netif_wake_queue?  If you are waking when 
> the TX is still "mostly full" you probably generate excessive wakeups...

Hrm?  Currently it will do a wakeup when at least one packet (8 sg 
descriptors) can be sent.  Given that the tx done code is only called 
when a tx desc (every 1/4 or so of the tx queue) or txidle interrupt 
occurs, it shouldn't be that often.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
