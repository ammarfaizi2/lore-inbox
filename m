Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264545AbRFYOLo>; Mon, 25 Jun 2001 10:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbRFYOLf>; Mon, 25 Jun 2001 10:11:35 -0400
Received: from [32.97.182.101] ([32.97.182.101]:994 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264545AbRFYOL2>;
	Mon, 25 Jun 2001 10:11:28 -0400
Importance: Normal
Subject: all processes waiting in TASK_UNINTERRUPTIBLE state
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>,
        <mingo@elte.hu>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF7B251945.42FE908D-ON85256A76.004C34E9@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Mon, 25 Jun 2001 10:10:38 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V508_06042001 |June 4, 2001) at
 06/25/2001 10:10:18 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


keywords:  tux, aic7xxx, 2.4.5-ac4, specweb99, __wait_on_page, __lock_page

Greetings,

I am running in to a problem, seemingly a deadlock situation, where almost
all the processes end up in the TASK_UNINTERRUPTIBLE state.   All the
process eventually stop responding, including login shell, no screen
updates, keyboard etc.  Can ping and sysrq key works.   I traced the tasks
through sysrq-t key.  The processors are in the idle state.  Tasks all seem
to get stuck in the __wait_on_page or __lock_page.  It appears from the
source that they are waiting for pages to be unlocked.   run_task_queue
(&tq_disk) should eventually cause pages to unlock but it doesn't happen.
Anybody familiar with this problem or have seen it before?  Thanks for any
comments.
Bulent

Here are the conditions:
Dual PIII, 1GHz, 1GB of memory,  aic7xxx scsi driver, acenic eth.
This occurs while TUX  (2.4.5-B6) webserver is being driven by SPECWeb99
benchmark at a rate of 800 c/s.  The system is very busy doing disk and
network I/O.  Problem occurs sometimes in an hour and sometimes 10-20 hours
in to the running.

Bulent


Process: 0, {             swapper}
EIP: 0010:[<c010524d>] CPU: 1 EFLAGS: 00000246
EAX: 00000000 EBX: c0105220 ECX: c2afe000 EDX: 00000025
ESI: c2afe000 EDI: c2afe000 EBP: c0105220 DS: 0018 ES: 0018
CR0: 8005003b CR2: 08049df0 CR3: 268e0000 CR4: 000006d0
Call Trace: [<c01052d2>] [<c0119186>] [<c01192fb>]
SysRq : Show Regs

Process: 0, {             swapper}
EIP: 0010:[<c010524d>] CPU: 0 EFLAGS: 00000246
EAX: 00000000 EBX: c0105220 ECX: c030a000 EDX: 00000000
ESI: c030a000 EDI: c030a000 EBP: c0105220 DS: 0018 ES: 0018
CR0: 8005003b CR2: 08049f7c CR3: 37a63000 CR4: 000006d0
Call Trace: [<c01052d2>] [<c0105000>] [<c01001cf>]
SysRq : Show Regs

EIP: 0010:[<c010524d>] CPU: 1 EFLAGS: 00000246
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000000 EBX: c0105220 ECX: c2afe000 EDX: 00000025
ESI: c2afe000 EDI: c2afe000 EBP: c0105220 DS: 0018 ES: 0018
CR0: 8005003b CR2: 08049df0 CR3: 268e0000 CR4: 000006d0
Call Trace: [<c01052d2>] [<c0119186>] [<c01192fb>]

EIP: 0010:[<c010524d>] CPU: 0 EFLAGS: 00000246
EAX: 00000000 EBX: c0105220 ECX: c030a000 EDX: 00000000
ESI: c030a000 EDI: c030a000 EBP: c0105220 DS: 0018 ES: 0018
CR0: 8005003b CR2: 08049f7c CR3: 37a63000 CR4: 000006d0
Call Trace: [<c01052d2>] [<c0105000>] [<c01001cf>]

>>EIP; c010524d <default_idle+2d/40>   <=====
Trace; c01052d2 <cpu_idle+52/70>
Trace; c0119186 <__call_console_drivers+46/60>
Trace; c01192fb <call_console_drivers+eb/100>

>>EIP; c010524d <default_idle+2d/40>   <=====
Trace; c01052d2 <cpu_idle+52/70>
Trace; c0105000 <prepare_namespace+0/10>
Trace; c01001cf <L6+0/2>

=================

SysRq : Show Memory
Mem-info:
Free pages:        4300kB (   792kB HighMem)
( Active: 200434, inactive_dirty: 26808, inactive_clean: 1472, free: 1075
(574 1148 1722) )
24*4kB 15*8kB 2*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 728kB)
493*4kB 3*8kB 1*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB
0*2048kB 0*4096kB = 2780kB)
0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB
0*4096kB = 792kB)
Swap cache: add 2711, delete 643, find 5301/6721
Free swap:       2087996kB
253932 pages of RAM
24556 pages of HIGHMEM
7212 reserved pages
221419 pages shared
2068 pages swap cached
0 pages in page table cache
Buffer memory:    12164kB
    CLEAN: 2322 buffers, 9276 kbyte, 3 used (last=2322), 2 locked, 0
protected, 0 dirty
   LOCKED: 405 buffers, 1608 kbyte, 39 used (last=404), 348 locked, 0
protected, 0 dirty
    DIRTY: 322 buffers, 1288 kbyte, 0 used (last=0), 322 locked, 0
protected, 322 dirty

=====================

async IO 0/2  D 00000013     0  1061   1059          1062       (NOTLB)
Call Trace: [<c012e121>] [<c012f059>] [<c02614d7>] [<c0258c44>]
[<c02588c0>]
   [<c025c65a>] [<c0256848>] [<c0258478>] [<c0105636>] [<c02582a0>]

Trace; c012e121 <___wait_on_page+91/c0>
Trace; c012f059 <do_generic_file_read+449/7d0>
Trace; c02614d7 <send_abuf+27/30>
Trace; c0258c44 <generic_send_file+84/100>
Trace; c02588c0 <sock_send_actor+0/1a0>
Trace; c025c65a <http_send_body+6a/100>
Trace; c0256848 <tux_schedule_atom+18/20>
Trace; c0258478 <cachemiss_thread+1d8/350>
Trace; c0105636 <kernel_thread+26/30>
Trace; c02582a0 <cachemiss_thread+0/350>


==================

bash          D C2AE541C     0   920    912                     (NOTLB)
Call Trace: [<c012e1e1>] [<c012e04d>] [<c016b880>] [<c012fdac>]
[<c012a76a>]
   [<c012a8cb>] [<c0110018>] [<c02709c7>] [<c0113ed0>] [<c0114106>]
[<c0195494>]
   [<c01417d2>] [<c011e25b>] [<c0113ed0>] [<c01075b8>

Trace; c012e1e1 <__lock_page+91/c0>
Trace; c012e04d <read_cluster_nonblocking+17d/1c0>
Trace; c016b880 <ext2_get_block+0/5b0>
Trace; c012fdac <filemap_nopage+3fc/5b0>
Trace; c012a49a <do_swap_page+23a/2f0>
Trace; c012a76a <do_no_page+8a/150>
Trace; c012a8cb <handle_mm_fault+9b/150>
Trace; c021814c <sock_sendmsg+6c/90>
Trace; c0113ed0 <do_page_fault+0/550>
Trace; c0114106 <do_page_fault+236/550>
Trace; c0118aa5 <do_syslog+1e5/820>
Trace; c01417d2 <sys_read+c2/d0>
Trace; c011e25b <do_softirq+6b/a0>
Trace; c0113ed0 <do_page_fault+0/550>
Trace; c01075b8 <error_code+34/3c>



void ___wait_on_page(struct page *page)
{
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);

        add_wait_queue(&page->wait, &wait);
        do {
                sync_page(page);
                set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                if (!PageLocked(page))
                        break;
                run_task_queue(&tq_disk);
                schedule();
        } while (PageLocked(page));
        tsk->state = TASK_RUNNING;
        remove_wait_queue(&page->wait, &wait);
}

static void __lock_page(struct page *page)
{
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);

        add_wait_queue_exclusive(&page->wait, &wait);
        for (;;) {
                sync_page(page);
                set_task_state(tsk, TASK_UNINTERRUPTIBLE);
                if (PageLocked(page)) {
                        run_task_queue(&tq_disk);
                        schedule();
                        continue;
                }
                if (!TryLockPage(page))
                        break;
        }
        tsk->state = TASK_RUNNING;
        remove_wait_queue(&page->wait, &wait);
}




