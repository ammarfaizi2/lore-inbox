Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbRABMZB>; Tue, 2 Jan 2001 07:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRABMYv>; Tue, 2 Jan 2001 07:24:51 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:39162 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S130643AbRABMYh>; Tue, 2 Jan 2001 07:24:37 -0500
Date: Tue, 2 Jan 2001 12:54:08 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.0-rerelease] driver/net/Makefile bug (pcmcia)
In-Reply-To: <20010102104957.A1949@dungeon.inka.de>
Message-ID: <Pine.LNX.4.10.10101021227350.1179-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Jan 2001, Andreas Jellinghaus wrote:

> modules for pcmcia network cards are not build by the kernel.

I just tried, and I don't see this problem. What's your .config?

> subdir-$(CONFIG_PCMCIA) += pcmcia
> 
> should be
> 
> ifeq ($(CONFIG_PCMCIA),y)
>   subdir-y += pcmcia
>   subdir-m += pcmcia
> endif
> 
> because CONFIG_PCMCIA=y but CONFIG_PCMCIA_SOMENETWORKDRIVER=m

No, pcmcia is in $(mod-subdirs), which leads to "make" entering
drivers/net/pcmcia when MAKING_MODULES, even if pcmcia is only in
$(subdir-y). 

BTW: CONFIG_PCMCIA is a tristate, so the above would break
CONFIG_PCMCIA=m.

> maybe even bett is useing CONFIG_NET_PCMCIA instead of CONFIG_PCMCIA.

Yes, that makes sense to me.
Proposed patch:

diff -ur linux-2.4.0-prerelease-diff/drivers/net/Makefile linux-2.4.0-prerelease-diff.work/drivers/net/Makefile
--- linux-2.4.0-prerelease-diff/drivers/net/Makefile	Tue Jan  2 12:26:45 2001
+++ linux-2.4.0-prerelease-diff.work/drivers/net/Makefile	Tue Jan  2 12:50:42 2001
@@ -26,7 +26,7 @@
   obj-$(CONFIG_ISDN) += slhc.o
 endif
 
-subdir-$(CONFIG_PCMCIA) += pcmcia
+subdir-$(CONFIG_NET_PCMCIA) += pcmcia
 subdir-$(CONFIG_TULIP) += tulip
 subdir-$(CONFIG_IRDA) += irda
 subdir-$(CONFIG_TR) += tokenring

[This doesn't fix any bugs, but it slightly optimizes the build process
because drivers/net/pcmcia will only be entered when PCMCIA net drivers
are selected]

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
