Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTJNLxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTJNLxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:53:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:8660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262406AbTJNLxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:53:02 -0400
Date: Tue, 14 Oct 2003 04:56:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031014045614.22ea9c4b.akpm@osdl.org>
In-Reply-To: <20031014105514.GH765@holomorphy.com>
References: <20031014105514.GH765@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> So I tried mem=16m on my laptop (stinkpad T21).

Thanks for doing this.  We should try to not suck in this situation.

> (a) The profile buffer requires about a 5MB bootmem allocation;
> 	this near halves MemTotal when used. I refrained from using it,
> 	as otherwise it's a test of mem=8m instead of mem=16m.

OK, so don't boot with `profile=N', yes?

> (b) bootmem allocations aren't adding up; after kernel text, data,
> 	and tracing __alloc_bootmem_core(), there is still about 0.5MB
> 	still missing from MemTotal. I still haven't found where it's
> 	gone. mem_map's bootmem allocation also didn't show up in the
> 	logs, but it should only be 160KB for 16MB of RAM, not 512KB.
> 	Matt Mackall spotted this, too.

Perhaps drop a printk(size) and a dump_stack() into the bootmem allocator,
then postprocess the dmesg output after it's booted?

> (c) mem= no longer bounds the highest physical address, but rather
> 	the sum of memory in e820 entries post-sanitization. This
> 	means a ZONE_NORMAL with about 384KB showed up, with duly
> 	perverse heuristic consequences for page_alloc.c

I don't understand this.  You mean almost all memory was in ZONE_DMA?

"mem=" does not accurately emulate having that much memory.  So a 512M box
booted with "mem=256M" has a different amount of memory from a 256M box
booted with no "mem=" option.  It would be nice to fix that, but I've never
looked into it.

> (d) The system thrashed heavily on boot, allowing the largest mm
> 	to acquire an RSS no larger than about 100KB. This needed
> 	turning /proc/sys/vm/min_free_kb down to 128 to make the
> 	system behave closer to normally. Matt Mackall spotted this.

hrm.  min_free_kbytes is normally 1024.  I'm surprised that the additional
900k made so much difference.  We must be on the hairy edge.

It looks like we need to precalculate/scale min_free_kbytes, yes?

> (e) About 4.8MB are consumed by slab allocations at runtime.
> 	The top 10 slab abusers are:
> 
> inode_cache               840K           840K     100.00%   
> dentry_cache              746K           753K      99.07%   
> ext3_inode_cache          591K           592K      99.84%   
> size-4096                 504K           504K     100.00%   
> size-512                  203K           204K      99.75%   
> size-2048                 182K           204K      89.22%   
> pgd                       188K           188K     100.00%   
> task_struct               100K           108K      92.86%   
> vm_area_struct             93K           101K      92.28%   
> blkdev_requests           101K           101K     100.00%   
> 
> The inode_cache culprit is the obvious butt of many complaints:
> # find /sys | wc -l
> 2656
> 
> ... which accounts for 100% of the 840KB. TANSTAAFL. OTOH, maybe we
> need to learn to do better than pinning dentries and inodes in-core...

I guess not mounting /sys doesn't help here.  It would be nice.  Maybe with
a CONFIG_I_WILL_NEVER_MOUNT_SYSFS we could avoid all those allocations.

> Load control, anyone?

Roger Luethi is working on it; I need to pay some attention to his patch. 
I expect we'll have something for post-2.6.0.


