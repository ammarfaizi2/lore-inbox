Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264560AbSIWF0B>; Mon, 23 Sep 2002 01:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264592AbSIWF0B>; Mon, 23 Sep 2002 01:26:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:48121 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264560AbSIWF0A>;
	Mon, 23 Sep 2002 01:26:00 -0400
Message-ID: <3D8EA718.2FC057E5@digeo.com>
Date: Sun, 22 Sep 2002 22:31:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm1 dbench 512 might sleep backtrace emitted
References: <20020923045914.GI25605@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 05:31:04.0986 (UTC) FILETIME=[69508FA0:01C262C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Trace; c01175f7 <__might_sleep+27/2b>
> Trace; c0139764 <__alloc_pages+24/24c>
> Trace; f8e74698 <END_OF_CODE+38ac8334/????>
> Trace; c011300d <pte_alloc_one+41/118>
> Trace; c012b89d <pte_alloc_map+4d/214>
> Trace; c012da28 <vmtruncate+138/164>
> Trace; c0133f68 <move_one_page+e8/328>
> Trace; c0134091 <move_one_page+211/328>
> Trace; c01341d9 <move_page_tables+31/7c>
> Trace; c0134870 <do_mremap+64c/7cc>
> Trace; c0134a40 <sys_mremap+50/73>
> Trace; c010746f <syscall_call+7/b>

Well I can't immediately see any held locks on that path, can
you?  Odd.

Might be best to put a breakpoint on the printk in __might_sleep(),
get some more info if it bites again.

If there _are_ no locks held in that chain then there is
something wrong with in_atomic().  So check the current
task state with `task25' and `thread25' from my .gdbinit.


set editing on
set radix 0x0a

define rmt
set remotebaud 115200
target remote /dev/ttyS0
end

define comm25
p ((struct thread_info *)((int)$esp & ~0x1fff))->task->comm
end

define task25
p ((struct thread_info *)((int)$esp & ~0x1fff))->task
end

define thread25
p ((struct thread_info *)((int)$esp & ~0x1fff))
end

define reboot
	maintenance packet r
end


define page_states
printf "Dirty: %dK\n", (page_states[0].nr_dirty + page_states[1].nr_dirty + page_states[2].nr_dirty + page_states[3].nr_dirty) * 4
printf "Writeback: %dK\n", (page_states[0].nr_writeback + page_states[1].nr_writeback + page_states[2].nr_writeback + page_states[3].nr_writeback) * 4
printf "Pagecache: %dK\n", (page_states[0].nr_pagecache + page_states[1].nr_pagecache + page_states[2].nr_pagecache + page_states[3].nr_pagecache) * 4
printf "Page Table Pages: %d\n", (page_states[0].nr_page_table_pages + page_states[1].nr_page_table_pages + page_states[2].nr_page_table_pages + page_states[3].nr_page_table_pages) * 4
printf "nr_reverse_maps: %d\n", page_states[0].nr_reverse_maps + page_states[1].nr_reverse_maps + page_states[2].nr_reverse_maps + page_states[3].nr_reverse_maps
end


define offsetof
	set $off = &(((struct $arg0 *)0)->$arg1)
	printf "%d 0x%x\n", $off, $off
end

# list_entry list type member
define list_entry
	set $off = (int)&(((struct $arg1 *)0)->$arg2)
	set $addr = (int)$arg0
	set $res = $addr - $off
	printf "0x%x\n", $res
end
