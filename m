Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316534AbSEPAuN>; Wed, 15 May 2002 20:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSEPAuM>; Wed, 15 May 2002 20:50:12 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:49640 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316534AbSEPAuL>;
	Wed, 15 May 2002 20:50:11 -0400
Date: Thu, 16 May 2002 02:49:27 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Urban Widmark <urban@teststation.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
Message-ID: <20020516004927.GA13388@k3.hellgate.ch>
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch> <02051317475500.00917@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002 17:51:22 -0600, Ivan G. wrote:
> My card behaves as unpredictably as always.

I'll take that down as "The patch didn't break anything" <g>. Thanks.

> Sometimes it works fine for relatively long periods of time (2mins+ :) )
> and sometimes it stalls dead on the first 100K.

You have a different chip. I don't have a VT86C100A to play with. Too bad.

> > - Recover gracefully from TxAbort (the actual fix)
> 
> Some time ago, I asked Becker about this same piece of code in the Linuxfet 
> driver pertaining to IntrTxUnderrun. They recover in such a way for both 
> Underrun and Abort. And here's what he said:

Yeah, I noticed VIA does that for underrun, too. I have never seen one,
though. So for everything I know the driver might work for underruns as it
is. Note that for TxAbort, the LK driver already tries to restart Tx,
whereas for TxUnderrun, it just increases the threshold. What I am trying
to improve is that the restart after TxAbort works.

> <QUOTE>
> This is backing up the Tx pointer to retransmit the failed packet.
> My original driver did not do this -- I believe that it's semantically
> wrong.
> </QUOTE>

I tend to agree with Donald Becker here. I am working on an updated patch
which drops the aborted frame.

> recovery from Underrun and Abort. I think I was able to get some improvement 
> on the stall issue with one of them, but then speed went down, as you 
> acknowledge.

What I have seen: switching from eeprom default (AMD/MBA backoff on my
card) to something else (as VIA does) slows things down, but the TxAborts
are gone. Did you try different backoff algorithms?

Also, you may want to try if the backoff bit in TxConfig makes a difference
for you (may be different with your chip, after all). It's not a one-liner
like ConfigD, though, since TxConfig gets overwritten in several places.
On a side note, I'm not particularly happy about the way we stomp all over
TxConfig when we set the threshold. IMO we should leave the lower 5 bits
alone.

> A friend also verified that some time ago:
>
> <QUOTE>
> with patch:
> transmit and receive speeds are slow but steady, no stalling
> 
> without patch:
> transmit speeds are fast but have occasional stalls... overall, its probably 
> the same speed as with the patch
> </QUOTE>

That quote would be immensely more helpful if we knew what patch exactly
he's talking about <g>.

> Speaking of VIA Rhine Cards....
> 
> THIS:
>       if (chip_id == VT86C100A) {
>                 /* More recent docs say that this bit is reserved ... */
>                 n = inb(ioaddr + ConfigA) | 0x20;
>                 outb(n, ioaddr + ConfigA);
> 
> is not right, as the comment also explains...
> So what should be done here instead??

The only data sheet I've seen for the VT86C100A agrees with the code, not
the comment, so apparantly I don't have access to those more recent docs.
This code is only used if you enable MMIO, though, which may not be a good
idea if you already have problems with the driver.

> One other thing I forgot to mention....
> interrupts logged by your patch:
> 0008 (abort) (LOTS)
> 0009 (abort, rxdone)
> 001a (underrun, abort, txdone)

That's all perfectly normal. Except for the underrun, that I have never
seen myself.

If your chip behaves anything like mine, you are _supposed_ to see lots of
aborts with BackAMD selected. I intentionally picked the backoff algorithm
which produces TxAborts (it's the eeprom default anyway, though). If you
change BackAMD to say BackRandom and there are still as many aborts as
before, we have found another difference between our systems.

Roger
