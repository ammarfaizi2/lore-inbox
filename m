Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTKCUG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTKCUG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:06:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:39327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263062AbTKCUGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:06:24 -0500
Date: Mon, 3 Nov 2003 12:06:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniele Venzano <webvenza@libero.it>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add PM support to sis900 network driver
Message-Id: <20031103120647.549f0c81.akpm@osdl.org>
In-Reply-To: <20031103181721.GC852@picchio.gall.it>
References: <20031102182852.GC18017@picchio.gall.it>
	<20031102111254.481bcbfd.akpm@osdl.org>
	<20031103181721.GC852@picchio.gall.it>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano <webvenza@libero.it> wrote:
>
> On Sun, Nov 02, 2003 at 11:12:54AM -0800, Andrew Morton wrote:
> > pci_set_power_state() can sleep, so we shouldn't be calling it
> > under spin_lock_irqsave().  Is it necessary to hold the lock
> > here?
> 
> New patch with locking completely removed, since in a similar
> function none was used.

OK.  I think.  Net driver suspend handlers in general seem a bit racy wrt
interrupt activity as well as SMP.  Maybe I'm missing something.

> I think also the 8139too driver has the same locking problem in
> rtl8139_suspend, do you want a patch ?

Wouldn't hurt, thanks.  It's one way to wake Jeff up ;)

8139too just does netif_device_detach(), whereas your sis900 patch does
netif_stop_queue() and then netif_device_detach().

I don't know which is right, really.  8139too will end up with a
non-stopped queue if __LINK_STATE_PRESENT is clear.  The sis900 approach is
certainly safe enough, but it'd be nice to know what netif_device_detach()
is trying to do there.
