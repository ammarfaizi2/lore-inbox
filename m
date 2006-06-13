Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWFMQfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWFMQfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWFMQfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:35:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56518 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932181AbWFMQfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:35:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: The i386 and x86_64 genirq patches are wrong!
Date: Tue, 13 Jun 2006 10:34:31 -0600
Message-ID: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A little while ago I worked up some patches to that made
x86 vectors per cpu.  Allowing x86 to handle more than
256 irqs, which significantly cleaned up the code.

The big stumbling block there was msi and it's totally
backwards way of allocating interrupts.  Getting msi
to work with irqs and not vectors is a lot of work,
and very hard to make a clean patchset out of.

Since there has been a lot of irq work, I decided to rebase
my changes on the -mm tree so that I could catch all of
the relevant patches and be in a better shape for merging
when I am done.

The work on msi in the -mm tree while still woefully
short of making it a general piece of code seemed
to be in the right direction.

When I got to io_apic.c I screamed, things had gotten worse.

I currently have a pending bug fix that puts move_irq in
the correct place for edge and level triggered interrupts.

For edge triggered interrupts you must move the irq before
you acknowledge the interrupt, or else it can reoccur.  

For level triggered interrupts you must acknowledge the irq
before you move it, or else the acknowledgement will never
find it's way back to the irq source.

I can no longer implement that bug fix in io_apic.c because
the two interrupt handling paths have been smushed together.

Previously in io_apic.c the hacks that the msi code imposed on
it were clear, and many of them were enclosed in #ifdef CONFIG_PCI_MSI.
Now that ifdefs are gone, and the logic in io_apic.h that
selected between the versions of the irq handlers to use (vector or irq)
has not been updated.

I don't know if the latter is actually a bug.  But it definitely makes
it harder to remove the msi hacks, and io_apic.h should definitely
have been updated.

The fact that you I now can't put move_irq where it needs to be is definitely
a bug.

So could we please get a version the genirq patches that don't simultaneously
convert the x86 code to the new infrastructure and try and clean it up
simultaneously.

Eric
