Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSLWAVO>; Sun, 22 Dec 2002 19:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSLWAVO>; Sun, 22 Dec 2002 19:21:14 -0500
Received: from dp.samba.org ([66.70.73.150]:28827 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261742AbSLWAVN>;
	Sun, 22 Dec 2002 19:21:13 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15878.22747.913279.67149@argo.ozlabs.ibm.com>
Date: Mon, 23 Dec 2002 11:29:15 +1100
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <20021222222106.B30070@localhost.park.msu.ru>
References: <m17ke3m3gl.fsf@frodo.biederman.org>
	<Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com>
	<15877.26255.524564.576439@argo.ozlabs.ibm.com>
	<1040569382.1966.11.camel@zion>
	<20021222222106.B30070@localhost.park.msu.ru>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky writes:

> Just out of curiosity, formerly you mentioned that said ASIC cannot
> be relocated in the PCI address space, why? Firmware issues or anything
> else?

It's mainly the fact that we have already ioremapped parts of the
address space of the ASIC.  For example we would have ioremapped the
interrupt controller's registers in init_IRQ(), which happens much
earlier than PCI probing.  If we are using a serial console via one of
the serial ports in the ASIC, we would have ioremapped the serial
ports by this time.  And so on.

We could relocate the ASIC if we could find the ioremaps and fix them
up, or if we could get to all the drivers and have them re-do their
ioremaps.  There is no way to do that at the moment, though.
Typically the ASIC will have a couple of IDE interfaces, audio,
serial, i2c, interrupt controller, wireless ethernet, timer, and PMU
(power management unit) interfaces in it, so there are several drivers
involved.

In fact we don't really need to probe the BARs of the ASIC at all,
because the device tree that we get from Open Firmware tells us the
size and location of the resources it is using (along with all the
other PCI devices in the system).  If we could have a
platform-specific hook so that we could provide an alternative method
for probing the BARs of certain PCI devices, that would let us avoid
the whole problem.

Paul.
