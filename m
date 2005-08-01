Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVHACWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVHACWD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 22:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVHACWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 22:22:03 -0400
Received: from fmr20.intel.com ([134.134.136.19]:43480 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262008AbVHACWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 22:22:01 -0400
Subject: Re: revert yenta free_irq on suspend
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com, torvalds@osdl.org,
       pavel@ucw.cz, hugh@veritas.com, linux@dominikbrodowski.net,
       daniel.ritz@gmx.ch, len.brown@intel.com
In-Reply-To: <20050731190645.748f57e9.akpm@osdl.org>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	 <1122861542.2953.8.camel@linux-hp.sh.intel.com>
	 <20050731190645.748f57e9.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 10:22:23 +0800
Message-Id: <1122862943.3235.7.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 19:06 -0700, Andrew Morton wrote:
> Shaohua Li <shaohua.li@intel.com> wrote:
> >
> > Hi,
> > > In general, I think that calling free_irq is the right behavior.
> > > Although irqs changing after suspend is rare, there are also some
> > > more serious issues.  This has been discussed in the past, and a
> > > summary is as follows:
> >
> > irqs actually isn't changed after suspend currently, it's a considering
> > for future usage like hotplug.
> > Calling free_irq actually isn't a complete ACPI issue, but ACPI requires
> > it to solve nasty 'sleep in atomic' warning.
> 
> Is that the only problem?  If so, then surely we can make free_irq() run
> happily with interrupts disabled: unlink the IRQ handler synchronously,
> defer the /proc teardown or something like that.
The problem is we are going to use ACPI interpreter with interrupt
disabled. The interpreter itself might use kmalloc, semaphore, iomap,
msleep and etc, depends on BIOS. Fixing interpreter is hard. Originally
we think to introduce a new system state for suspend/resume to avoid
warning, but later we found drivers calling pci_disable_irq/free_irq is
better and safer not just for the issue at hand. We might reconsider
previous option (a new system state) if free_irq is rejected.

Thanks,
Shaohua

