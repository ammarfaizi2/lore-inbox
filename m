Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSHPJTM>; Fri, 16 Aug 2002 05:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSHPJTM>; Fri, 16 Aug 2002 05:19:12 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:65285 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318258AbSHPJTL>;
	Fri, 16 Aug 2002 05:19:11 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Fri, 16 Aug 2002 11:21:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.31 boot failure on pdc20267
CC: martin@dalecki.de, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2298DFF575E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 02 at 22:13, Mikael Pettersson wrote:
> Petr Vandrovec writes:
>  > On 15 Aug 02 at 17:15, Mikael Pettersson wrote:
>  > > Booting 2.5.31 (non-bk) on hde5, a UDMA(66) Quantum Fireball
>  > > on a PDC20267 add-on card, resulted in a complete hang as init
>  > > came to its "mount -n -o remount,rw /" point. No visible messages
>  > > or anything in the log.
>  > 
>  > Known bug. Apply IDE113 (Aug 06, 11:02 CEST, from Martin), or just open 
>  > drivers/ide/pcidma.c in your favorite text editor, look for (first) 
>  > #ifdef CONFIG_BLK_DEV_TRM290, and replace whole ifdef block with 
>  > '*--table |= cpu_to_le32(0x80000000);'
> 
> Tested. First time 2.5.31 + the patch booted it seemed to work, but hung
> later on while compiling a 2.4.19 kernel. No messages of any kind. The
> hang _seemed_ to coincide with the console screen blanker kicking in.
> Second boot went ok and I made sure the screen blanker wouldn't kick
> in while doing the compile, and it didn't hang.
> 
> This box is the only one so far I've seen this problem on, my other
> Intel chipset boxes actually seem to work fairly well with 2.5.31.

Yes. If you'll look at d1510r0c.pdf from ATA guys, you'll find that
between 0b and 0c revisions definition of EOT bit (highest bit of
length) was removed. It is very unfortunate because of now host
adapters cannot prefetch across segment boundaries, because of host
adapter does not know when transfer will terminate (unless host monitors
all accesses to the disk and maintains its own set of IDE registers 
(including HOB, so using > 256sectors transfers with such host adapters
which do not implement HOB is impossible)). It is also very dangerous 
because of for reads when drive generates more data than expected, with 
EOT flag transfer was terminated with error, but without EOT host will 
just fetch random entries after last valid, and will (silently) corrupt 
random memory. 

And Promise implements old, safe&prefetchable, interface, while Intel
just fetches more and more PRD entries as long as drive has/wants more 
data.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
