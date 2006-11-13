Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753931AbWKMFUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbWKMFUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWKMFUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:20:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:31885 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1753931AbWKMFUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:20:37 -0500
Subject: [RFC] make sys_pciconfig_iobase lethal to calling processes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 16:20:28 +1100
Message-Id: <1163395228.4982.281.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm fixing various bugs (oops... some are even my faul) in powerpc's
implementation of mmap of PCI resources via /proc and /sys. While there,
I noticed that we have some nasty issues with the sys_pciconfig_iobase
syscall.

We introduced that syscall in a distant past to let apps like X retreive
the physical address at which they could find PCI IOs when
using /dev/mem to access PCI cards.

There are several problems with it however, though the main one is that
it returns that base address as the syscall result, which means it's
limited to 32 bits for 32 bits processes, while on pSeries machines,
among others, PCI sits way above that.

So basically, it really only works for PowerMacs.

The other nasty problem is that the only user I know of (and -please-
let me know asap if you know of anything else using it), X.org, will not
only not test for errors from that syscall (and happily try to mmap -1 +
BAR value via /dev/mem and whack that), but also, 32 bits X on 64 bits
machine will truncate the top 32 bits of PCI addresses and then try to
access them via /dev/mem...

So basically, this syscall being called by a 32 bits process, means
that:

 - if the PCI host bridge has the IO and MMIO below 32 bits, there is a
chance that things will work, so proceed as before (+/- a bug where we
might not get the right bus but I'm trying to fix that).

 - if the PCI host bridge has IO or MMIO above 32 bits, then there is no
way the calling process will work since we'll return a truncated value.
In fact, we know that (at least I think) the only caller is X and it
will do very bad things to /dev/mem and ignore errors. So the sanest
things we can do in this case is to kill the calling process with
force_sig (what about SIGSEGV for that ?). If we don't do that, we'll
end up with random levels of memory corruption due to X whacking things
in /dev/mem at completely wrong addresses.

If the caller is a 64 bits process, things can work so we don't do
anything special. The syscall is deprecated anyway, so once X gets fixed
to properly use /sysfs or /proc, it won't use it anymore and thus won't
trigger that killswitch.

Any objection ? Does anybody knows of another legitimate user of that
syscall that might deserve to survive calling it in 32 bits mode on a 64
bits machine with PCI IO or MMIO above 32 bits ?

Cheers,
Ben.


