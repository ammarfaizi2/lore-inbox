Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbTH1Kee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbTH1Ked
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:34:33 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:13712 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263950AbTH1KeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:34:24 -0400
Date: Thu, 28 Aug 2003 14:30:52 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: blkdev_requests "memory before object was overwritten" and oops in __iget
Message-ID: <20030828103052.GA16356@linuxhacker.ru>
References: <20030826183850.GA4781@linuxhacker.ru> <20030826143635.1c218d06.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826143635.1c218d06.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Aug 26, 2003 at 02:36:35PM -0700, Andrew Morton wrote:
> Oleg Drokin <green@linuxhacker.ru> wrote:
> >    Found one of my test boxes freezed today (or may be even yesterday).
> >    That's what was in logs:
> > 
> > Aug 25 00:50:37 dwarf kernel: [drm] DMA Cleanup
> > Aug 25 21:46:31 dwarf kernel: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
> > Aug 25 21:46:31 dwarf kernel: [drm] Using POST v1.2 init.
> > Aug 25 21:46:31 dwarf kernel: PCI: Found IRQ 11 for device 0000:00:02.0
> > Aug 25 21:46:39 dwarf kernel: slab error in cache_alloc_debugcheck_after(): cache `blkdev_requests': memory before object was overwritten
> Setting CONFIG_DEBUG_PAGEALLOC might help us trap this.

Actually I usually compile with this option, but not that time.
Well, so I run with CONFIG_DEBUG_PAGEALLOC and after two more nights (seems it
only crashes after two nights sitting idle) I got this:

PCI: Found IRQ 11 for device 0000:00:02.0
[drm] DMA Cleanup

I tried to start X at this point

mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
[drm] Using POST v1.2 init.
PCI: Found IRQ 11 for device 0000:00:02.0
[drm:i810_wait_ring] *ERROR* space: 65520 wanted 65528
[drm:i810_wait_ring] *ERROR* lockup

And now X server segfaulted at this point, but no oops yet.

So I tried to start it again

mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
[drm] Using POST v1.2 init.
PCI: Found IRQ 11 for device 0000:00:02.0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018ecfd
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c018ecfd>]    Not tainted
EFLAGS: 00010206
EIP is at prune_dcache+0x9d/0x640
eax: c033f544   ebx: cc3d7028   ecx: 000000d0   edx: 00000000
esi: d3184004   edi: 00000015   ebp: df975e80   esp: df975e58
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=df974000 task=df9a5000)
Stack: 0000010b 0000010b df975e60 df975e60 00000000 00000029 df975e70 00000080 
       df974000 00000270 df975e90 c018ff0e 00000080 00000080 df975ec4 c01579ff 
       00000080 000000d0 00007819 01d90d30 00000000 000003f0 00000000 dfebed08 
Call Trace:
 [<c018ff0e>] shrink_dcache_memory+0x3e/0x40
 [<c01579ff>] shrink_slab+0x11f/0x170
 [<c0159850>] balance_pgdat+0x1e0/0x220
 [<c0159975>] kswapd+0xe5/0x100
 [<c0123ac0>] autoremove_wake_function+0x0/0x50
 [<c0123ac0>] autoremove_wake_function+0x0/0x50
 [<c0159890>] kswapd+0x0/0x100
 [<c0108269>] kernel_thread_helper+0x5/0xc

Code: 89 02 a1 48 f5 33 c0 89 1b 0f 18 00 90 ff 0d 50 f5 33 c0 8d 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/369

And other oopses that are probably because of first one.
Looks like some memory corruption to me, but the memory on the box is fine.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018fb9f
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c018fb9f>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0xcf/0x200
eax: 00000000   ebx: d04cd004   ecx: d04cd028   edx: d9bb2028
esi: dde05038   edi: dde05038   ebp: d0b2bec0   esp: d0b2be90
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 6132, threadinfo=d0b2a000 task=d57bd000)
Stack: 00000001 00000000 d0b2bed0 00000086 c10b8dd0 00000001 00000000 00000000 
       dde05004 c770e004 c770e004 000017f5 d0b2bed0 c018fce8 c770e004 c770e004 
       d0b2bee0 c01ad658 c770e004 dd3ab000 d0b2bf0c c0128108 c770e004 dfebd940 
Call Trace:
 [<c018fce8>] shrink_dcache_parent+0x18/0x30
 [<c01ad658>] proc_pid_flush+0x18/0x30
 [<c0128108>] release_task+0x1c8/0x2d0
 [<c0120b57>] schedule+0x2c7/0x530
 [<c012a710>] wait_task_zombie+0x130/0x190
 [<c012aaea>] sys_wait4+0x20a/0x250
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c012ab57>] sys_waitpid+0x27/0x2b
 [<c010aedd>] sysenter_past_esp+0x52/0x71

Code: 8b 10 89 4a 04 89 53 24 89 41 04 89 08 ff 05 50 f5 33 c0 ff 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/533
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018fb9f
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c018fb9f>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0xcf/0x200
eax: 00000000   ebx: c23ee004   ecx: c23ee028   edx: c033f544
esi: d2b36038   edi: d2b36038   ebp: d0b2bec0   esp: d0b2be90
ds: 007b   es: 007b   ss: 0068
Process dcopserver_shut (pid: 6134, threadinfo=d0b2a000 task=d57bd000)
Stack: 00000001 00000000 d0b2bed0 00000086 c10b8dd0 00000001 00000000 00000000 
       d2b36004 cecd9004 cecd9004 000017f7 d0b2bed0 c018fce8 cecd9004 cecd9004 
       d0b2bee0 c01ad658 cecd9004 c80f7000 d0b2bf0c c0128108 cecd9004 cb609004 
Call Trace:
 [<c018fce8>] shrink_dcache_parent+0x18/0x30
 [<c01ad658>] proc_pid_flush+0x18/0x30
 [<c0128108>] release_task+0x1c8/0x2d0
 [<c0120a8a>] schedule+0x1fa/0x530
 [<c012a710>] wait_task_zombie+0x130/0x190
 [<c012aaea>] sys_wait4+0x20a/0x250
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c012ab57>] sys_waitpid+0x27/0x2b
 [<c010aedd>] sysenter_past_esp+0x52/0x71

Code: 8b 10 89 4a 04 89 53 24 89 41 04 89 08 ff 05 50 f5 33 c0 ff 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/533
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018fb9f
*pde = 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<c018fb9f>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0xcf/0x200
eax: 00000000   ebx: d526e004   ecx: d526e028   edx: cc94f028
esi: db032038   edi: db032038   ebp: cbaa9ec0   esp: cbaa9e90
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 6130, threadinfo=cbaa8000 task=c336c000)
Stack: 00000001 00000000 cbaa9ed0 00000086 c14d1ea8 00000001 00000000 00000000 
       db032004 c6b5b004 c6b5b004 000017f6 cbaa9ed0 c018fce8 c6b5b004 c6b5b004 
       cbaa9ee0 c01ad658 c6b5b004 d57bd000 cbaa9f0c c0128108 c6b5b004 cb609004 
Call Trace:
 [<c018fce8>] shrink_dcache_parent+0x18/0x30
 [<c01ad658>] proc_pid_flush+0x18/0x30
 [<c0128108>] release_task+0x1c8/0x2d0
 [<c0120a8a>] schedule+0x1fa/0x530
 [<c012a710>] wait_task_zombie+0x130/0x190
 [<c012aaea>] sys_wait4+0x20a/0x250
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c012ab57>] sys_waitpid+0x27/0x2b
 [<c010aedd>] sysenter_past_esp+0x52/0x71

Code: 8b 10 89 4a 04 89 53 24 89 41 04 89 08 ff 05 50 f5 33 c0 ff 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/533
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018fb9f
*pde = 00000000
Oops: 0000 [#5]
CPU:    0
EIP:    0060:[<c018fb9f>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0xcf/0x200
eax: 00000000   ebx: cfc98004   ecx: cfc98028   edx: c033f544
esi: da1fe038   edi: da1fe038   ebp: cfa97ec0   esp: cfa97e90
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 6142, threadinfo=cfa96000 task=cc3e4000)
Stack: 00000001 00000000 cfa97ed0 00000086 c13837b8 00000001 00000000 00000000 
       da1fe004 cf59e004 cf59e004 000017ff cfa97ed0 c018fce8 cf59e004 cf59e004 
       cfa97ee0 c01ad658 cf59e004 df9a5000 cfa97f0c c0128108 cf59e004 d6d0fbfc 
Call Trace:
 [<c018fce8>] shrink_dcache_parent+0x18/0x30
 [<c01ad658>] proc_pid_flush+0x18/0x30
 [<c0128108>] release_task+0x1c8/0x2d0
 [<c012a710>] wait_task_zombie+0x130/0x190
 [<c012aaea>] sys_wait4+0x20a/0x250
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c01261a6>] __mmdrop+0x36/0x47
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c012ab57>] sys_waitpid+0x27/0x2b
 [<c010aedd>] sysenter_past_esp+0x52/0x71

Code: 8b 10 89 4a 04 89 53 24 89 41 04 89 08 ff 05 50 f5 33 c0 ff 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/533
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018fb9f
*pde = 00000000
Oops: 0000 [#6]
CPU:    0
EIP:    0060:[<c018fb9f>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0xcf/0x200
eax: 00000000   ebx: c5b9e004   ecx: c5b9e028   edx: d68f7028
esi: c89f9038   edi: c89f9038   ebp: cfa97ec0   esp: cfa97e90
ds: 007b   es: 007b   ss: 0068
Process dcopserver_shut (pid: 6144, threadinfo=cfa96000 task=cc3e4000)
Stack: 00000001 00000000 cfa97ed0 00000086 c13837b8 00000001 00000000 00000000 
       c89f9004 c4124004 c4124004 00001801 cfa97ed0 c018fce8 c4124004 c4124004 
       cfa97ee0 c01ad658 c4124004 c69b3000 cfa97f0c c0128108 c4124004 d05cdbfc 
Call Trace:
 [<c018fce8>] shrink_dcache_parent+0x18/0x30
 [<c01ad658>] proc_pid_flush+0x18/0x30
 [<c0128108>] release_task+0x1c8/0x2d0
 [<c012a710>] wait_task_zombie+0x130/0x190
 [<c012aaea>] sys_wait4+0x20a/0x250
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c01261a6>] __mmdrop+0x36/0x47
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c012ab57>] sys_waitpid+0x27/0x2b
 [<c010aedd>] sysenter_past_esp+0x52/0x71

Code: 8b 10 89 4a 04 89 53 24 89 41 04 89 08 ff 05 50 f5 33 c0 ff 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/533
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018fb9f
*pde = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<c018fb9f>]    Not tainted
EFLAGS: 00010246
EIP is at select_parent+0xcf/0x200
eax: 00000000   ebx: c4b0c004   ecx: c4b0c028   edx: d68f7028
esi: da14e038   edi: da14e038   ebp: deda5ec0   esp: deda5e90
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 6140, threadinfo=deda4000 task=da608000)
Stack: 00000001 00000000 deda5ed0 00000086 c13967f0 00000001 00000000 00000000 
       da14e004 d3919004 d3919004 00001800 deda5ed0 c018fce8 d3919004 d3919004 
       deda5ee0 c01ad658 d3919004 cc3e4000 deda5f0c c0128108 d3919004 cb609004 
Call Trace:
 [<c018fce8>] shrink_dcache_parent+0x18/0x30
 [<c01ad658>] proc_pid_flush+0x18/0x30
 [<c0128108>] release_task+0x1c8/0x2d0
 [<c0120a8a>] schedule+0x1fa/0x530
 [<c012a710>] wait_task_zombie+0x130/0x190
 [<c012aaea>] sys_wait4+0x20a/0x250
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c0120dc0>] default_wake_function+0x0/0x30
 [<c012ab57>] sys_waitpid+0x27/0x2b
 [<c010aedd>] sysenter_past_esp+0x52/0x71

Code: 8b 10 89 4a 04 89 53 24 89 41 04 89 08 ff 05 50 f5 33 c0 ff 
 lib/dec_and_lock.c:32: spin_lock(fs/dcache.c:c033f510) already locked by fs/dcache.c/533

Bye,
    Oleg
