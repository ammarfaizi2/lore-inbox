Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUBNDby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 22:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUBNDby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 22:31:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:10395 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262745AbUBNDbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 22:31:50 -0500
Subject: Race in PCI probing vs. IRQs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076729411.7305.223.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 14:30:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An old problem, though I suppose the actual race window is very
small:

The PCI code, when probing for a device will write the the BARs to
get the size, then restore the BAR to their original state. It does
that with interrupts enabled on all CPUs of course.

That mean that for a short window of time, we have the device no longer
accessible on the PCI bus.

However, that device may be a system device of some kind which may be
involved in the interrupt processing.

An example is PowerMacs. Their main interrupt controller is on the
MacIO PCI ASIC. We "probe" it using the OF device-tree, and IRQs are
initialized before PCI. We have a couple of other system devices like
the Power Manager unit which we communicate to via interfaces in
this ASIC, and those are setup & initialized before PCI is probed.

That means that we have potential driver activity and interrupts
going on during the PCI probe. So there is a window where the MacIO
ASIC may be temporarily inaccessible on the PCI bus during boot,
and thus the PIC and some other device, while we can actually take
an interrupt and try to tap them.... bad...

I don't think the "other" CPUs during boot are much active during 
the PCI probe, but they might well take interrupts too...

What would be a good fix for that ? I'd hate to have to use an IPI
to gather all CPUs into some wait loop with IRQs off and do all of
the PCI probe with IRQs off, but that may be the best solution if we
want to be completely safe...

Ben.

