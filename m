Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275852AbRJYRMO>; Thu, 25 Oct 2001 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJYRME>; Thu, 25 Oct 2001 13:12:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23306 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275778AbRJYRLy>; Thu, 25 Oct 2001 13:11:54 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Kernel PCMCIA
Date: 25 Oct 2001 10:12:06 -0700
Organization: Transmeta Corporation
Message-ID: <9r9h56$2ai$1@cesium.transmeta.com>
In-Reply-To: <3BD843DE.6FD5AF2D@nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BD843DE.6FD5AF2D@nyc.rr.com>,
John Weber  <weber@nyc.rr.com> wrote:
>
>Why are hotplug and cardmgr needed?  As I understand it, cardbus uses
>hotplug for config/init, and other pcmcia cards use cardmgr for init and
>/etc/pcmcia/* for config.  This seems like a big, smelly mess.

I'd personally love to get rid of cardmgr, and in fact you do not need
it with true 32-bit cards and proper PCI drivers, because the drivers
have sane plug/unplug semantics.

In fact, with CardBus cards, you don't strictly need /sbin/hotplug
either: /sbin/hotplug is nothing but a _notification_ thing, and as such
you can easily for example just compile the proper PCI driver into the
kernel, and the driver will automatically find and configure the card,
and if you don't insert/remove it at run-time you can consider the
CardBus slot just another PCI slot. 

So the "/sbin/hotplug" is really not a cardbus thing at all: it's just
the kernels way of telling user space that "hey, you might want to load
a driver" (if the kernel didn't find one pre-loaded) or "hey, I just got
a new network card, maybe you should set up routing etc?"

In fact /sbin/hotplug works well for non-CardBus events too, like USB.

  Now comes the ugly part.

When I wrote the new CardBus code I didn't want to know about how 16-bit
PCMCIA works (I still mostly don't, but the pain of having to have
cardmgr might some day push me over the edge), so 16-bit PCMCIA cards
are handled with all the old legacy stuff, and they don't understand
about /sbin/hotplug and friends. 

If somebody who knows 16-bit PCMCIA wants to change the "hey, I need a
driver" code to use /sbin/hotplug and not need cardmgr, I'd be thrilled.

>I don't use modules, so I don't use cardmgr for anything except to tell
>the kernel that there is a card in the socket.

You shouldn't even need that, if the 16-bit PCMCIA drivers weren't too
damn helpless..

		Linus


