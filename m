Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWEGAIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWEGAIO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWEGAIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 20:08:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46473
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751148AbWEGAIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 20:08:13 -0400
Date: Sat, 06 May 2006 17:08:10 -0700 (PDT)
Message-Id: <20060506.170810.74552888.davem@davemloft.net>
To: mpm@selenic.com
Cc: tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060506164808.GY15445@waste.org>
References: <20060505203436.GW15445@waste.org>
	<20060506115502.GB18880@thunk.org>
	<20060506164808.GY15445@waste.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Sat, 6 May 2006 11:48:08 -0500

> But network traffic should be _assumed_ to be observable to some
> degree.

But, and this is a huge but and the one that matters, nothing
between the network packet arriving and the interrupt being
delivered is observable outside of the machine.

The PHY of the network card has some tiny delays internal
to how it decodes the coding sequence on the wire and passes
it on to the MAC.

The MAC and the bus frontend have all sorts of timing and
delays wrt. making sure the necessary RX descriptor is fetched
and if a free packet buffer is available, DMA'ing the packet
into memory.

If the chip has hw interrupt mitigation enabled, these add other
delays and almost across the board these interrupt mitigation
timers are relatively imprecise.  If the first packet that starts
the time hits half-way between two clock ticks, the mitigation
fire will be a half clock off.

There are propagation delays for the interrupt to get to the cpu.
Every implementation is there, but the delays are there and highly
variable.  In many cases, it's the time to send a cacheline over
the main system bus to the target cpu (MSI, or sparc64 style PCI
controllers which turn traditional INTX signals into 64-byte
interrupt packets targeted at specific cpus).

Then there is the trap entry delay, and perhaps the cpu has interrupts
disabled while holding a spinlock or whatever.  Then there are all the
cache misses and instruction execution delays just to get into the
interrupt handler.

None of this is observable or predictable outside of the machine.
So the arguments about the SA_SAMPLE_RANDOM samples being risky in
the networking drivers is bogus.

Please put together a test case that proves that /dev/random can
be predicted just by being on the wire sniffing packets going into
the machine.  Then you will have my full support.

Everything shown so far is theoretical swiss cheese.
