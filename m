Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTATSZG>; Mon, 20 Jan 2003 13:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbTATSZG>; Mon, 20 Jan 2003 13:25:06 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:60315 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S266473AbTATSZE>; Mon, 20 Jan 2003 13:25:04 -0500
Date: Mon, 20 Jan 2003 10:41:35 -0800
From: David Brownell <david-b@pacbell.net>
Subject: pci_set_mwi() ... why isn't it used more?
To: linux-kernel@vger.kernel.org
Message-id: <3E2C42DF.1010006@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at some new hardware and noticed that it's
got explicit support for the PCI Memory Write and Invalidate
command ... enabled (in part) under Linux by pci_set_mwi().

However, very few Linux drivers use that routine.  Given
that it can lead to improved performance, and that devices
don't have to implement that enable bit, I'm curious what
the story is...

  - Just laziness or lack-of-education on the part of
    driver writers?

  - Iffy upport in motherboard chipsets or CPUs?  If so,
    which ones?

  - Flakey support in PCI devices, so that enabling it
    leads to trouble?

  - Something else?

  - Combination of all the above?

Briefly, MWI can avoid some cache flushes, thereby reducing
memory bus contention.  It can also enable longer PCI bursts
(since the dma master won't stop writing mid-cacheline).

And calling pci_set_mwi() makes sure that the device knows
the correct cache line size, which can make Memory Read
Multiple (and Memory Read Line) commands work better (also
with longer PCI bursts) by hinting to bridges when prefetch
would be a Fine Thing ... likewise reducing memory bus
contention.  Those benefits can happen even if the hardware
doesn't support MWI; on my systems I noticed that the
cacheline size is always set too small by default, which
seems like a PCI initialization bug.

So what's the story ... is there some reason Linux isn't
trying to enable such PCI features more often?  And why
it doesn't set the cacheline size correctly by default?

- Dave

