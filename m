Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTAFXnb>; Mon, 6 Jan 2003 18:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbTAFXnb>; Mon, 6 Jan 2003 18:43:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53256 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267224AbTAFXna>; Mon, 6 Jan 2003 18:43:30 -0500
Date: Mon, 6 Jan 2003 15:19:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Grant Grundler <grundler@cup.hp.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <davidm@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
In-Reply-To: <20030106215210.GE26790@cup.hp.com>
Message-ID: <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Grant Grundler wrote:
> 
> I agree - it looks better. But I fail to see how it fixes the problem
> of knowing when we can or cannot disable a device in order to size
> the BAR.

With a two-phase discovery, and a separate FIXUP_EARLY in the first phase,
we can now make fixups for devices behind bridges.

In particular, we can make the first phase disable DMA on the devices we 
find, which means that we know they won't be generating PCI traffic during 
the second phase - so now the second phase (which does the BAR sizing) can 
do sizing and be safe in the knowledge that there should be no random PCI 
activity ongoing at the same time.

That should fix at least the USB DMA problem.

> I'm under the impression some i386 specific code needs to be added
> to identify/fixup the broken configurations (memory disabled when
> a PCI Bridge is disabled).

It's fine to temporarily disable memory on the northbridge, as long as
nothign else tries to _access_ that memory at the same time. The tho-phase 
discovery with the first phase doing the disables should make sure of 
that.

		Linus

