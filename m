Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266290AbSKGC0n>; Wed, 6 Nov 2002 21:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266291AbSKGC0n>; Wed, 6 Nov 2002 21:26:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:53497 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id <S266290AbSKGC0k>;
	Wed, 6 Nov 2002 21:26:40 -0500
Date: Wed, 6 Nov 2002 18:33:17 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: jsun@mvista.com
Subject: PageLRU BUG() when preemption is turned on (2.4 kernel)
Message-ID: <20021106183317.E15363@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am chasing a nasty bug that shows up in 2.4 kernel when preemption
is turned on.  I would appreciate any help.  Please cc your reply
to me email account.

I caught the BUG() live with kgdb (on a MIPS board).  See the backtrace
attached at the end.

In a nutshell, access_process_vm() calls put_page(), which
calls __free_pages(), where it finds page->count is 0 but does not
like the fact that page->flags still has LRU bit set.

What is LRU bit?  And why it cannot be set when the page->count
goes down to 0 in __free_pages_ok()?

I inserted some testing code in access_process_vm() function
and confirmed that page->count does get changed in the middle of
the function when preemptible kernel is enabled.

My best guess at this moment is:

. access_process_vm() starts and gets preempted in the middle
. other process(es) decrement the page->count to 1, somehow.  However
  LRU bit remains set as it was (is this possible?)
. access_process_vm() resumes and calls put_page(), and then hits
  the BUG.

I am doing an experiement now which disables preemption inside the loop
of access_process_vm().  If my guess is right, it should kill this
symptom.  (I may need to wait for more than 10 hours for the results)

But the bug is in someplace else.  Basically, how can the preempting
process decrement the page->count but still leave LRU bit set? 

Any pointers on how I could debug further?  Thanks in advance.

Jun

----------------------
(gdb) bt
#0  panic (fmt=0x80164ad0 "kernel BUG at %s:%d!\n") at panic.c:52
#1  0x80060e04 in __free_pages_ok (page=0x57, order=2148945076)
    at page_alloc.c:87
#2  0x80061adc in __free_pages (page=0x57, order=2148945076)
    at page_alloc.c:449
#3  0x80048c68 in access_process_vm (tsk=0x80164ad0, addr=2147449516, 
    buf=0x8079f000, len=12, write=0) at ptrace.c:188
#4  0x800903f0 in proc_pid_cmdline (task=0x80a3c000, buffer=0x8079f000 "sh")
    at base.c:157
#5  0x80090780 in proc_info_read (file=0x80164ad0, 
    buf=0x7fff7370 "/proc/14565/cmdline", count=2047, ppos=0x82722740)
    at base.c:265
#6  0x8006a4c4 in sys_read (fd=2148944592, 
    buf=0x7fff7370 "/proc/14565/cmdline", count=2047) at read_write.c:177

(at frame #1, #2: 'page' value is garbage because the register is garbled)

(gdb) l
access_process_vm()
82                      BUG();
83              if (PageLocked(page))
84                      BUG();
85              if (PageLRU(page)) {
86                      printk("page = 0x%p\n", page);
87                      BUG();
88              }
89              if (PageActive(page))
90                      BUG();
91

(gdb) p current->preempt_count
$10 = 0

