Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRJCRaW>; Wed, 3 Oct 2001 13:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276595AbRJCRaM>; Wed, 3 Oct 2001 13:30:12 -0400
Received: from chiara.elte.hu ([157.181.150.200]:63240 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276591AbRJCRaE>;
	Wed, 3 Oct 2001 13:30:04 -0400
Date: Wed, 3 Oct 2001 19:28:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031109430.4833-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110031749030.8633-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> use the netif_rx() return code and hardware flowcontrol to fix it.

i'm using hardware flowcontrol in the patch, but at a different, higher
level. This part of the do_IRQ() code disables the offending IRQ source:

	[...]
        desc->status |= IRQ_MITIGATED|IRQ_PENDING;
        __disable_irq(desc, irq);

which in turn stops that device as well sooner or later. Optionally, in
the future, this can be made more finegrained for chipsets that support
device-independent IRQ mitigation features, like the USB 2.0 EHCI feature
mentioned by David Brownell.

i'd prefer it if all subsystems and drivers in the kernel behaved properly
and limited their IRQ load - but this does not always happen and users are
hit by irq overload situations.

Your NAPI patch, or any driver/subsystem that does flowcontrol accurately
should never be affected by it in any way. No overhead, no performance
hit.

	Ingo

