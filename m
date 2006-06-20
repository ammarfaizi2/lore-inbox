Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWFTW2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWFTW2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWFTW2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:28:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49636 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751321AbWFTW2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/25] Decouple IRQ issues (MSI, i386, x86_64, ia64) 
Date: Tue, 20 Jun 2006 16:24:35 -0600
Message-ID: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patchset is against 2.6.17-rc6-mm2.
It was the only easy place I could get everyones work who has been
touching relevant code.

The primary aim of this patch is to remove maintenances problems caused
by the irq infrastructure.  The two big issues I address are an
artificially small cap on the number of irqs, and that MSI assumes
vector == irq.  My primary focus is on x86_64 but I have touched
other architectures where necessary to keep them from breaking.

- To increase the number of irqs I modify the code to look at
  the (cpu, vector) pair instead of just  looking at the vector.

  With a large number of irqs available systems with a large irq
  count no longer need to compress their irq numbers to fit.
  Removing a lot of brittle special cases.

  For acpi guys the result is that irq == gsi.

- Addressing the fact that MSI assumes irq == vector takes a few more
  patches.  But suffice it to say when I am done none of the generic
  irq code even knows what a vector is.

In quick testing on a large Unisys x86_64 machine we stumbled over at
least one driver that assumed that NR_IRQS could always fit into an 8
bit number.  This driver is clearly buggy today.  But this has become
a class of bugs that it is now much easier to hit. 

I've done my best but if this patchset wasn't perfect it won't
surprise me.  But I'm pretty certain I have succeeded in decoupling
any fixes should be small and well contained.

Eric
