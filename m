Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSENF5w>; Tue, 14 May 2002 01:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSENF5v>; Tue, 14 May 2002 01:57:51 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:30894 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315218AbSENF5u>; Tue, 14 May 2002 01:57:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
Date: Mon, 13 May 2002 17:51:22 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch>
MIME-Version: 1.0
Message-Id: <02051317475500.00917@cobra.linux>
Content-Transfer-Encoding: 7BIT
Cc: LKML <linux-kernel@vger.kernel.org>, Urban Widmark <urban@teststation.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 May 2002 09:53 pm, you wrote:
> I don't know how many time-out problems exist in via-rhine.c, but the patch
> below fixes at least one of them. It works for my VT6102 based card. I hope
> some of you can confirm the fix (or let me know what other chips I broke).

My card behaves as unpredictably as always.
Sometimes it works fine for relatively long periods of time (2mins+ :) )
and sometimes it stalls dead on the first 100K.

So....
I've learned not to trust that card regarding anything..
Let's look at the code instead.

> - Recover gracefully from TxAbort (the actual fix)

Some time ago, I asked Becker about this same piece of code in the Linuxfet 
driver pertaining to IntrTxUnderrun. They recover in such a way for both 
Underrun and Abort. And here's what he said:


<QUOTE>
> if (txstatus & 0x0800) {
>              /* uderrun happen */
>               np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
>               writel(virt_to_bus(&np->tx_ring[entry]), ioaddr + TxRingPtr);


This is backing up the Tx pointer to retransmit the failed packet.
My original driver did not do this -- I believe that it's semantically
wrong.

I write my drivers to always fail the current transmit attempt on Tx
Abort.  Ethernet uses dropped packets on severe overload (16 collision
abort) to provide flow control to the protocol layers.  If you back up
and attempt to retransmit the same packet you defeat this element of the
protocol.  It's an atypical case, but Ethernet works where Aloha fails
because it gets the rare cases right.
</QUOTE>

I don't know if he's right or wrong. 
I have tried the code. I got different results with different combinations of 
recovery from Underrun and Abort. I think I was able to get some improvement 
on the stall issue with one of them, but then speed went down, as you 
acknowledge. A friend also verified that some time ago:

<QUOTE>
with patch:
transmit and receive speeds are slow but steady, no stalling

without patch:
transmit speeds are fast but have occasional stalls... overall, its probably 
the same speed as with the patch
</QUOTE>

So, given what Becker said and the completely random behavior of my card,
I decided to stay away from the abort handling. You can figure out if it's 
the proper thing to do.


Speaking of VIA Rhine Cards....

THIS:
      if (chip_id == VT86C100A) {
                /* More recent docs say that this bit is reserved ... */
                n = inb(ioaddr + ConfigA) | 0x20;
                outb(n, ioaddr + ConfigA);

is not right, as the comment also explains...
So what should be done here instead??

Ivan G, tested with a Rhine-I card (VT86C100A)




