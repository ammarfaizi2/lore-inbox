Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUGaRzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUGaRzY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbUGaRzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:55:24 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:22657 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S267976AbUGaRzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:55:16 -0400
From: David Brownell <david-b@pacbell.net>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: Solving suspend-level confusion
Date: Sat, 31 Jul 2004 10:51:58 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200407310723.12137.david-b@pacbell.net> <200407311901.17390.oliver@neukum.org>
In-Reply-To: <200407311901.17390.oliver@neukum.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407311051.58207.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 10:01, Oliver Neukum wrote:
> 
> > So suspend-to-RAM more or less matches PCI D3hot, and
> > suspend-to-DISK matches PCI D3cold.  If those power states
> > were passed to the device suspend(), the disk driver could act
> > appropriately.  In my observation, D3cold was never passed
> > down, it was always D3hot.
> 
> Maybe a better approach would be to describe the required features to
> the drivers rather than encoding them in a single integer. Rather
> like passing a request that states "lowest power level with device state
> retained, must not do DMA, enable remote wake up"

For PCI devices this is mostly defined by the parameter that says
what PCI power state to enter.  Even still-common "legacy" PCI
devices can basically fit into those definitions (though they may
not handle "low power" states other than "off").

Enabling remote wakeup is somewhat orthogonal.  Network
drivers have separate Wake-On-LAN calls, but that stuff should
arguably be part of the driver model PM framework.  Much of
the Linux PM work seems to be limited to "suspend when laptop
lid shuts, resume when it opens" ... which is a necessary start (one
that doesn't work universally yet either!) but not sufficient.


> [..]
> > Though the PM core doesn't cooperate at all there.  Neither the
> > suspend nor the resume codepaths cope well with disconnect
> > (and hence device removal), the PM core self-deadlocks since
> > suspend/resume outcalls are done while holding the semaphore
> > that device_pm_remove() needs, ugh.
> 
> Shouldn't we deal with this like a failed resume?

That was the first place I kept running into the deadlocks,
and I had to rewrite chunks of the OHCI driver to avoid
them.  The problem is that PM core uses a semaphore to
protect list membership, rather than a spinlock, and
that the semaphore is also trying to protect against more
than one thing at a a time.

- Dave

