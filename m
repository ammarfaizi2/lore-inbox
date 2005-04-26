Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVDZDxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVDZDxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVDZDxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:53:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:18630 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261303AbVDZDw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:52:58 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       alexn@dsv.su.se, Greg KH <greg@kroah.com>, gud@eth.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>,
       cramerj@intel.com, Linux-USB <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425221326.GC15366@redhat.com>
References: <1114458325.983.17.camel@localhost.localdomain>
	 <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
	 <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:52:16 +1000
Message-Id: <1114487537.7182.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > I have vague memories of this being discussed at some length last year. 
>  > Nothing comprehensive came of it, except that perhaps the kdump code should
>  > spin with irqs off for a couple of seconds so the DMA and IRQs stop.
>  > 
>  > (Ongoing DMA is not a problem actually, because the kdump kernel won't be
>  > using that memory anyway)
> 
> Actually, some cpufreq drivers *should* do their speed transitions with
> all PCI mastering disabled. The lack of any infrastructure to quiesce drivers
> and prevent new DMA transactions from occuring whilst the transition occurs
> means that currently.. we don't.  So +1 for any driver model work that
> may lead to something we can use here.

True, I have the same problem on pmac with some machines that use PMU
based speed switch. On those, the CPU is hard rebooted, so we need to
flush all caches which can't always be done in a completely "safe" way
with pending DMAs...

> This is the main reason the longhaul cpufreq driver is currently busted.
> That it ever worked at all is a miracle.

Well, In my case, I disp-flush so much more than is normally necessary
that I end up with something that seem stable, but I agree it's dodgy.

The PMSG_FREEZE semantics that we defined for suspend-to-disk however is
just what we need here. It basically tells driver to stop any DMA
activity and freeze processing. It should be used for kexec too.

The problem is, as far as I understand what David told me a while ago,
some USB chips simply _cannot_ disable DMA without actually suspending
the bus, which itself is a complex process that takes some time and can
involve all sort of problems with devices / drivers that don't deal with
suspended busses properly. I suspect other kind of chips may be
similarily busted by design.





