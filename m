Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270295AbUJUGLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270295AbUJUGLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUJUGLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:11:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:47272 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270327AbUJUGIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:08:25 -0400
Subject: Interrupts & total mess
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098338878.3941.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 16:07:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok so my simple project of adding NO_IRQ definitions all over the place
is turning into a nightmare for various reasons (the probe_irq_* stuff
beeing one of them, as it currently prevents using -1, so I'm leaning
toward defining NO_IRQ as beeing INT_MIN, nothing against that ?)

However, while trying to do that in a simple way, that is with a
 #ifndef NO_IRQ
 #define NO_IRQ		(INT_MIN)
 #endif

Somewhere in some generic piece of include after we has some asm/* stuff
included to let the arch a chance to override it, I figured that, first,
there are a number of places where "irq" is defined as beeing unsigned
long... So neither INT_MIN nor -1 are appropriate. Then I noticed while
looking for the right files to add this stuff that we have, at least:

include/linux/interrupts.h
include/linux/irq.h
include/linux/hardirq.h
include/asm-*/irq.h
include/asm-*/hw_irq.h
include/asm-*/hardirq.h

Which is seriously starting to make no sense, especially when you don't
really know who is including who, with also the strange rule of never
including linux/irq.h directly from a driver since the arch may not use
the definitions in there, etc... it's a complete can of worms...

So basically, linux/irq.h should be asm-generic/irq.h right ?

Then, all of the CONFIG_HARDIRQS_GENERIC stuff in linux/interrupts.h
should be moved there as well, since that's pretty much what the things
in linux/irq.h already define.

So our path should be:

toplevel include
	linux/interrupts.h (or rename it to linux/irq.h)
	  asm/irq.h (the arch implementation)
	    [asm-generic/irq.h] (optionally using the common defs)

but I'm not sure what to do with the various hardirq.h & hw_irq.h
thingies, at least one of the 2 arch ones should die.

I'm ready to start the (painful) work of cleaning that up, though
that will probably end up in a giga-patch touching hundreds of files
(just to change a #include directive most of the time) though I won't
fix all archs, I prefer not mucking aroudn with things I don't
understand.

But I'm not sure what we want to do here, so let's discuss it a bit.

Ben.

