Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTBPAKV>; Sat, 15 Feb 2003 19:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTBPAKV>; Sat, 15 Feb 2003 19:10:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265477AbTBPAKU>; Sat, 15 Feb 2003 19:10:20 -0500
Date: Sat, 15 Feb 2003 16:16:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roger Luethi <rl@hellgate.ch>
cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
In-Reply-To: <20030215225204.GA6887@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0302151611310.23496-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Feb 2003, Roger Luethi wrote:
> 
> Thanks for raising that issue. It is my understanding that PIO ops are
> synchronous (on IA-32). If that is correct, problems should only occur if
> the driver is built with MMIO support, no?

No, even PIO ops are asynchronous. They are _more_ synchronous than the
MMIO ones (I think the CPU waits until they hit the bus, and most bridges
just pass them through), but the CPU does not wait for them to hit the
device.

So in practice, this _tends_ to mean that a PIO write will usually hit the 
device within a microsecond or less of being issued by the CPU, and you 
don't need a IO read to force it out. But considering the wide variety of 
PCI bridges out there I bet there are some that will post even PIO writes 
and might hold on to them for some time, especially if other activity like 
DMA keeps the bus busy.

In other words: I suspect the code will work. But it's probably _safer_ to 
do the normal "read to synchronize" unless there are major performance 
issues (which is clearly not the case in this particular instance, but 
might be somewhere else).

		Linus

