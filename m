Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSGQNmD>; Wed, 17 Jul 2002 09:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSGQNmC>; Wed, 17 Jul 2002 09:42:02 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21936 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313628AbSGQNmB>;
	Wed, 17 Jul 2002 09:42:01 -0400
Date: Wed, 17 Jul 2002 15:44:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717154448.A19761@ucw.cz>
References: <20020716143415.GO7955@tahoe.alcove-fr> <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz> <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020717132459.GF14581@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Wed, Jul 17, 2002 at 03:24:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 03:24:59PM +0200, Stelian Pop wrote:
> On Wed, Jul 17, 2002 at 02:08:04PM +0200, Vojtech Pavlik wrote:
> 
> > > i8042.c: 60 -> i8042 (command) [65]
> > > i8042.c: 77 -> i8042 (parameter) [65]
> > > i8042.c: d4 -> i8042 (command) [65]
> > > i8042.c: f6 -> i8042 (parameter) [65]
> > 
> > This is the bug. :) It tries to talk to the mouse before enabling the
> > mouse interface. I wonder how it could work ... probably many chipsets
> > ignore the disable bit altogether.
> > 
> > Please try with the attached i8042.c.
> 
> I'm afraid it doesn't work either:
> ...

But it actually looks to do the correct thing this time :(
But for some reason your hardware doesn't like it.

> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
>  hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
> mice: PS/2 mouse device common for all mice
> i8042.c: fa <- i8042 (flush, kbd) [0]

Throw away stale data.

> i8042.c: 20 -> i8042 (command) [0]
> i8042.c: 47 <- i8042 (return) [0]

Remember the CTR.

> i8042.c: 60 -> i8042 (command) [0]
> i8042.c: 56 -> i8042 (parameter) [0]

Disable kbd and kbd interupt.

> i8042.c: d3 -> i8042 (command) [0]
> i8042.c: 5a -> i8042 (parameter) [0]
> i8042.c: a5 <- i8042 (return) [0]

Test mouse port loopback.

> i8042.c: a9 -> i8042 (command) [0]
> i8042.c: 00 <- i8042 (return) [0]

Test mouse port.

> i8042.c: a7 -> i8042 (command) [1]
> i8042.c: 20 -> i8042 (command) [1]
> i8042.c: 76 <- i8042 (return) [1]
> i8042.c: a9 -> i8042 (command) [1]
> i8042.c: 00 <- i8042 (return) [1]
> i8042.c: a8 -> i8042 (command) [1]
> i8042.c: 20 -> i8042 (command) [1]
> i8042.c: 56 <- i8042 (return) [1]

More aux port sanity tests, all ok.

> i8042.c: 60 -> i8042 (command) [2]
> i8042.c: 74 -> i8042 (parameter) [2]

Everything disabled.

> i8042.c: 60 -> i8042 (command) [2]
> i8042.c: 54 -> i8042 (parameter) [2]

Ints disabled, kbd disabled, aux enabled.

> i8042.c: 60 -> i8042 (command) [2]
> i8042.c: 56 -> i8042 (parameter) [2]

Aux interrupt enable.

> i8042.c: d4 -> i8042 (command) [2]
> i8042.c: f6 -> i8042 (parameter) [2]
> i8042.c: 60 -> i8042 (command) [3]
> i8042.c: 56 -> i8042 (parameter) [3]

Send reset to the mouse, wait ....

... but nothing comes in after almost a second. :(

> i8042.c: 60 -> i8042 (command) [92]
> i8042.c: 54 -> i8042 (parameter) [92]
> i8042.c: 60 -> i8042 (command) [93]
> i8042.c: 56 -> i8042 (parameter) [93]
> i8042.c: d4 -> i8042 (command) [93]
> i8042.c: f5 -> i8042 (parameter) [93]
> i8042.c: 60 -> i8042 (command) [93]
> i8042.c: 56 -> i8042 (parameter) [93]

Try again later, nothing ...

> i8042.c: 60 -> i8042 (command) [182]
> i8042.c: 54 -> i8042 (parameter) [182]
> serio: i8042 AUX port at 0x60,0x64 irq 12

Try this patch, if it doesn't work, we'll have to try more changes, like
trying to skip the AUX port detection that might confuse the chip ....

--- i8042.c.old	Wed Jul 17 15:36:01 2002
+++ i8042.c	Wed Jul 17 15:37:19 2002
@@ -270,6 +270,8 @@
 		return -1;
 	}
 
+	i8042_interrupt(0, NULL, NULL);
+
 	return 0;
 }
 

Btw, what's the exact chipset involved?

-- 
Vojtech Pavlik
SuSE Labs
