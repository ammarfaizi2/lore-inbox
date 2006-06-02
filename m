Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWFBK5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFBK5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFBK5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:57:04 -0400
Received: from mga07.intel.com ([143.182.124.22]:35720 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751387AbWFBK5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:57:01 -0400
X-IronPort-AV: i="4.05,203,1146466800"; 
   d="scan'208"; a="45008256:sNHT1338842428"
Subject: Re: pci_walk_bus race condition
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060601222402.f2d427b4.akpm@osdl.org>
References: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
	 <20060526135039.GA13280@kroah.com>
	 <1148863271.4377.521.camel@ymzhang-perf.sh.intel.com>
	 <1148889932.4377.537.camel@ymzhang-perf.sh.intel.com>
	 <1149222942.8436.189.camel@ymzhang-perf.sh.intel.com>
	 <20060601221141.d84bcf97.akpm@osdl.org>
	 <20060601222402.f2d427b4.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1149245505.8436.222.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 02 Jun 2006 18:51:45 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 13:24, Andrew Morton wrote:
> On Thu, 1 Jun 2006 22:11:41 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Fri, 02 Jun 2006 12:35:43 +0800
> > "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> > 
> > > pci_walk_bus has a race with pci_destroy_dev. When cb is called
> > > in pci_walk_bus, pci_destroy_dev might unlink the dev pointed by next.
> > > Later on in the next loop, pointer next becomes NULL and cause
> > > kernel panic.
> > > 
> > > Below patch against 2.6.17-rc4 fixes it by changing pci_bus_lock (spin_lock)
> > > to pci_bus_sem (rw_semaphore).
> > 
> > How does s/spinlock/rwsem/ fix a race??
> 
> oic.  "and hold the lock across the callback".
Sorry for missing the statement.

> 
> Is the ranking of pci_bus_sem and dev->dev.sem correct+consistent?  It
> looks OK.
Yes, I think so. The write lock of pci_bus_sem and dev->dev.sem are used in
different steps. Here we use read lock of pci_bus_sem + dev->dev.sem.

> 
> It might be worth making a not that the callback function cannot call any
> PCI layer function which takes pci_bus_sem - that'll casue a recursive
> down_read(), which is a nasty source of rare deadlocks.
Currently, only pci error recovery codes call it while cb are the error
callback functions in the driver. They shouldn't try to apply for write lock of
pci_walk_sem. Perhaps we could add more comments in function pci_walk_bus.
