Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTFLRPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTFLRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:15:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264917AbTFLRPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:15:33 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Andy Pfiffer <andyp@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030611172958.5e4d3500.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055438856.1202.6.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 10:27:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 17:29, Andrew Morton wrote:
> Andy Pfiffer <andyp@osdl.org> wrote:
> >
> > So now the important question: is it wrong to not sync_blockdev() until
> > the count drops to 0?
> 
> Should be OK.  The close will not sync anything if someone else has the
> blockdev open (ie: there's a filesystem mounted there).
> 
> But sync() should certainly write everything out, and lilo does perform a
> sync.
> 
> I'd be interested in seeing the contents of /proc/meminfo immediately after
> the lilo run, see if there's any dirty memory left around.

How I measured:

	# cat measure
	#!/bin/sh
	sync
	cat /proc/meminfo
	/sbin/lilo
	cat /proc/meminfo

	# ./measure | dd bs=1024k > out

2.5.68 pure:

Before:				After:
MemTotal:       514304 kB	MemTotal:       514304 kB
MemFree:        388720 kB	MemFree:        385648 kB
Buffers:         10056 kB	Buffers:         12092 kB
Cached:          54000 kB	Cached:          54956 kB
SwapCached:          0 kB	SwapCached:          0 kB
Active:          62928 kB	Active:          63240 kB
Inactive:        34416 kB	Inactive:        37120 kB
HighTotal:           0 kB	HighTotal:           0 kB
HighFree:            0 kB	HighFree:            0 kB
LowTotal:       514304 kB	LowTotal:       514304 kB
LowFree:        388720 kB	LowFree:        385648 kB
SwapTotal:      787144 kB	SwapTotal:      787144 kB
SwapFree:       787144 kB	SwapFree:       787144 kB
Dirty:               0 kB	Dirty:               8 kB <---
Writeback:           0 kB	Writeback:           0 kB
Mapped:          45484 kB	Mapped:          45488 kB
Slab:            11880 kB	Slab:            12100 kB
Committed_AS:   146184 kB	Committed_AS:   146184 kB
PageTables:        656 kB	PageTables:        656 kB
VmallocTotal:   516040 kB	VmallocTotal:   516040 kB
VmallocUsed:     42608 kB	VmallocUsed:     42608 kB
VmallocChunk:   473432 kB	VmallocChunk:   473432 kB

2.5.68+kludge:

Before:				After:
MemTotal:       514304 kB	MemTotal:       514304 kB
MemFree:        390416 kB	MemFree:        387216 kB
Buffers:          9844 kB	Buffers:         11892 kB
Cached:          52920 kB	Cached:          53864 kB
SwapCached:          0 kB	SwapCached:          0 kB
Active:          62136 kB	Active:          62452 kB
Inactive:        33908 kB	Inactive:        36600 kB
HighTotal:           0 kB	HighTotal:           0 kB
HighFree:            0 kB	HighFree:            0 kB
LowTotal:       514304 kB	LowTotal:       514304 kB
LowFree:        390416 kB	LowFree:        387216 kB
SwapTotal:      787144 kB	SwapTotal:      787144 kB
SwapFree:       787144 kB	SwapFree:       787144 kB
Dirty:               0 kB	Dirty:               4 kB <---
Writeback:           0 kB	Writeback:           0 kB
Mapped:          45448 kB	Mapped:          45452 kB
Slab:            11564 kB	Slab:            11756 kB
Committed_AS:   146192 kB	Committed_AS:   146132 kB
PageTables:        656 kB	PageTables:        656 kB
VmallocTotal:   516040 kB	VmallocTotal:   516040 kB
VmallocUsed:     42608 kB	VmallocUsed:     42608 kB
VmallocChunk:   473432 kB	VmallocChunk:   473432 kB




