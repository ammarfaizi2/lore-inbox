Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKFVNi>; Mon, 6 Nov 2000 16:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKFVN2>; Mon, 6 Nov 2000 16:13:28 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:32519 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129061AbQKFVNV>;
	Mon, 6 Nov 2000 16:13:21 -0500
Date: Mon, 6 Nov 2000 22:12:54 +0100
From: Martin Mares <mj@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>, Dan Hollis <goemon@anime.net>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Message-ID: <20001106221254.A1196@albireo.ucw.cz>
In-Reply-To: <3A06A053.56F09ACB@mandrakesoft.com> <E13sphu-0006O4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13sphu-0006O4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 06, 2000 at 05:05:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

> If the sound card is only used some of the time or setup and then used
> for TV its nice to get the 60K + 128K DMA buffer back when you dont need it
> especially on a low end box

So why don't we allocate / free the DMA buffer on device open / close instead
of module insert / remove?  If the reason lies in problems with allocation
of large chunks of contiguous memory, we're going to have exactly the same
problems when autoloading the module.

I think that automatic loading / unloading of modules has been a terrible hack
since its first days (although back in these times a useful one) and that the
era of its usefulness is over. There are zillions of problems with this
mechanism, the most important ones being:

   o  It would have to preserve _complete_ device state over module reload.
      For the sound card mixer settings discussed it's close to trivial, but
      for example consider a tape drive and the problem of preserving tape
      position after reload (probably including device reset causing tape rewind).
      And what about textures loaded to memory of a 3D video card?

   o  For many drivers, the "device currently open" concept makes no sense.
      Consider a mouse driver whose only activity is to feed mouse events
      to an event device. The mouse driver can be unloaded in any time (either
      manually or perhaps automatically after the mouse gets unplugged), hence
      it should have a use count == zero, but even if it seems to be unused,
      it must not be unloaded just because of some timeout since the mouse
      will cease to work.

   o  It interferes with hotplug in nasty ways. Let's have a USB host controller
      driver with currently no devices on its bus. It's also an example of a zero
      use count driver, but it also must not be unloaded as it's needed for
      recognizing newly plugged in devices.

I don't argue whether we need or need not some kind of persistent storage for
the modules (it might be a good idea when it comes to hotplug, but it should
be probably taken care of by the userspace hotplug helpers), but I think that
it has no chance to solve the problems with automatic unloading.

We could of course attempt to circumvent the problems listed above by adding
some hints to module state which will say whether it's possible to auto-unload
the module or not even if it has zero use count, but it means another thing
to handle in all the drivers (well, at least another thing to think of whether
it's needed or not for each driver) and I think that the total effect of
the autounloading mechanism (a minimum amount of memory saved) in no way
outweighs the cost of implementing it right.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"A mathematician is a machine for converting coffee into theorems."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
