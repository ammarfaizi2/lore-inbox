Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSEQAS6>; Thu, 16 May 2002 20:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSEQAS6>; Thu, 16 May 2002 20:18:58 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:42947 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S315232AbSEQAS5>;
	Thu, 16 May 2002 20:18:57 -0400
Date: Fri, 17 May 2002 02:16:54 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Shing Chuang <ShingChuang@via.com.tw>,
        Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        AJ Jiang <AJJiang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020517001534.GA3632@k3.hellgate.ch>
In-Reply-To: <20020516203159.GA10868@k3.hellgate.ch> <Pine.LNX.3.95.1020516165412.1477A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think one has to <somehow> find that the chip has halted besides
> the current way (noticing that it can't transmit anymore). I don't

There seems to be a misunderstanding. We already get an interrupt and a
status to indicate what kind of problem occured. Thanks to Shing's recent
posting we even have confirmed information about what events stop the Tx
engine. _Plus_ there is a bit flag TXON in a chip status register which
indicates whether the Tx engine is active.

So what's left as a (potential) problem? -- The code snippet that Shing
shared with us suggests that there is potential for a race between the chip
and an ISR which is already scavenging Tx buffers: the chip has updated the
buffer descriptors and set the interrupt status to reflect the error, but
is not yet done halting the Tx engine (if it had only failed to update the
TXON status bit, there would be no special handling required, since we are
writing that bit anyway in a next step, so the issue has to be that the
chip is in a transitional state and restarting the Tx engine at this point
would be premature). Of course this description assumes that the VIA coders
made that particular recent change in their driver for a reason.

> In the chip-halted work-around that everybody seems to use now,
> reprogram it from scratch. The last program operation being to remove
> loop-back. I don't even know if this chip can be set to loop-back,
> though, so the whole idea may be moot.

It can be set to loopback, but I'm not keen on having my chip reprogrammed
by every traffic burst (excessive collisions -> abort). Is that really the
fashion of the year now?

Roger
