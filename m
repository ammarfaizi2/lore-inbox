Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTJNMZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJNMZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:25:38 -0400
Received: from holomorphy.com ([66.224.33.161]:44682 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262349AbTJNMZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:25:27 -0400
Date: Tue, 14 Oct 2003 05:28:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031014122835.GP16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014045614.22ea9c4b.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> So I tried mem=16m on my laptop (stinkpad T21).

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> Thanks for doing this.  We should try to not suck in this situation.

William Lee Irwin III <wli@holomorphy.com> wrote:
>> (a) The profile buffer requires about a 5MB bootmem allocation;
>> 	this near halves MemTotal when used. I refrained from using it,
>> 	as otherwise it's a test of mem=8m instead of mem=16m.

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> OK, so don't boot with `profile=N', yes?

That's pretty much my take on it, though it did rob me of profiles.
The next time I sleep I'll probably let it boot and bring it up with
mem=24m or something where I expect additional mem= to balance profile=


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (b) bootmem allocations aren't adding up; after kernel text, data,
>> 	and tracing __alloc_bootmem_core(), there is still about 0.5MB
>> 	still missing from MemTotal. I still haven't found where it's
>> 	gone. mem_map's bootmem allocation also didn't show up in the
>> 	logs, but it should only be 160KB for 16MB of RAM, not 512KB.
>> 	Matt Mackall spotted this, too.

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> Perhaps drop a printk(size) and a dump_stack() into the bootmem allocator,
> then postprocess the dmesg output after it's booted?

That's actually exactly how I traced it. Possibly the log buffer
dropped messages or some such nonsense. It's single-threaded in early
boot so it's all mindless drivel anyway.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (c) mem= no longer bounds the highest physical address, but rather
>> 	the sum of memory in e820 entries post-sanitization. This
>> 	means a ZONE_NORMAL with about 384KB showed up, with duly
>> 	perverse heuristic consequences for page_alloc.c

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> I don't understand this.  You mean almost all memory was in ZONE_DMA?
> "mem=" does not accurately emulate having that much memory.  So a 512M box
> booted with "mem=256M" has a different amount of memory from a 256M box
> booted with no "mem=" option.  It would be nice to fix that, but I've never
> looked into it.

Linux version 2.6.0-test6-wli-6 (wli@megeira) (gcc version 3.3 (Debian)) #1 Wed Oct 8 14:45:07 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009f800 (usable)
 user: 000000000009f800 - 00000000000a0000 (reserved)
 user: 00000000000e0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000001060800 (usable)
16MB LOWMEM available.
On node 0 totalpages: 4192
  DMA zone: 4096 pages, LIFO batch:16
  Normal zone: 96 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: root=/dev/hda2 mem=16m console=ttyS0,115200n8 init=/bin/sh

limit_regions() cuts e820 RAM regions short when the total size of
all the regions is seen to exceed the limit passed as an argument.
limit_regions() is how mem=${N}m does its dirty work.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (d) The system thrashed heavily on boot, allowing the largest mm
>> 	to acquire an RSS no larger than about 100KB. This needed
>> 	turning /proc/sys/vm/min_free_kb down to 128 to make the
>> 	system behave closer to normally. Matt Mackall spotted this.

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> hrm.  min_free_kbytes is normally 1024.  I'm surprised that the additional
> 900k made so much difference.  We must be on the hairy edge.
> It looks like we need to precalculate/scale min_free_kbytes, yes?

Well, ->pages_low and ->pages_high are twice it and thrice it
respectively, so we have a significant fraction of RAM involved in
the heuristics when the smoke clears. Now, exactly how these end up
influencing decisions I don't have decent enough logs for (the io for
logging got hard to keep up with in the presence of paging io). I can
probably arrange remote logging later on.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> (e) About 4.8MB are consumed by slab allocations at runtime.
>> 	The top 10 slab abusers are:
>> inode_cache               840K           840K     100.00%   
>> dentry_cache              746K           753K      99.07%   
>> ext3_inode_cache          591K           592K      99.84%   
>> size-4096                 504K           504K     100.00%   
>> size-512                  203K           204K      99.75%   
>> size-2048                 182K           204K      89.22%   
>> pgd                       188K           188K     100.00%   
>> task_struct               100K           108K      92.86%   
>> vm_area_struct             93K           101K      92.28%   
>> blkdev_requests           101K           101K     100.00%   
>> The inode_cache culprit is the obvious butt of many complaints:
>> # find /sys | wc -l
>> 2656
>> ... which accounts for 100% of the 840KB. TANSTAAFL. OTOH, maybe we
>> need to learn to do better than pinning dentries and inodes in-core...

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> I guess not mounting /sys doesn't help here.  It would be nice.  Maybe with
> a CONFIG_I_WILL_NEVER_MOUNT_SYSFS we could avoid all those allocations.

I have a vague notion the treatment hugh gave tmpfs earlier in 2.6
would be useful for sysfs, though I've at least heard the observation
that quite a bit can be reconstructed from kobjects on the fly.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> Load control, anyone?

On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> Roger Luethi is working on it; I need to pay some attention to his patch. 
> I expect we'll have something for post-2.6.0.

The name changes, but the presence of a helper is the same. I've felt
spurred to take it on myself, but am discouraged by other tasks and
all that. Well, that, and I should probably let someone else do
something (dammit, hugh, if you didn't have good ideas all the time I
wouldn't be compelled to make sure I have the stuff at my disposal).
I'll flag Roger down and see if I can say anything helpful about the
patch and so on if I don't get pegged to badly by interrupts this week.


-- wli
