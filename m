Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUH1BhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUH1BhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUH1BhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:37:09 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:58755
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266127AbUH1Bgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:36:52 -0400
Date: Fri, 27 Aug 2004 18:36:46 -0700
From: "David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.de
Subject: ALSA update broke Sparc
Message-Id: <20040827183646.1da2befc.davem@davemloft.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Each platform uses a different number of arguments for
io_remap_page_range(), so you can't just blindly call it
from generic code.

However, sound/core/pcm_native.c is doing exactly that.

The reason each platform takes a different number of
args is that the "unsigned long" base address argument
is only 32-bits on 32-bit platforms yet on some of
such platforms I/O and physical memory addresses
are larger than 32-bits.

Sparc and Sparc64 use a "space" argument to provide this
upper 32-bits of information.

Also, what this PCM mmap'ing code is trying to do
is take I/O addresses and remap them into the process
address space.  pci_resource_start() values are not necessarily
suitable for passing around as physical addresses.  These
things are well defined when used with ioremap() but
that is it.  I don't know if we've defined it such that
passing these into io_remap_page_range() can be expected
to work.

In fact, because of the sparc 32-bit issue, I know it won't
work.  You'll need to have the full resource structure
available, as that's where we hide the upper 32-bits of
the physical address on sparc32.

This is really non-portable, what the PCM code is doing.
I would suggest, for the time being, to pass resources
around and then have an arch-defined macro which takes
the resource pointer and makes the appropriate io_remap_page_range()
call.

Can I make a small formal request of the ALSA folks?  Can you
at least setup a cross-compiler to make sure your ALSA merges
don't explode on sparc64?  As it stands, 1 out of every 2 ALSA
merges breaks the build on that platform.
