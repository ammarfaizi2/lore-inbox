Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTIHPjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTIHPjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:39:46 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:44977 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263061AbTIHPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:38:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16220.41581.316059.514526@gargle.gargle.HOWL>
Date: Mon, 8 Sep 2003 11:38:21 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4-mm4 - bad floppy hangs keyboard input
In-Reply-To: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
References: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've run into a wierd problem with 2.6.0-test4-mm4 on an SMP Xeon
550Mhz system.  I was dd'ing some images to floppy and when I used a
bad floppy, it would read 17+0 blocks, write 16+0 blocks and then
hang.  At this point, I couldn't use the keyboard at all, and I got an
error message about "lost serial connection to UPS", which is from
apcupsd, which I have talking over my Cyclades Cyclom-8y ISA serial
port card.  

At this point, the load jumps to 1, nothing happes on the floppy
drive, and I can't input data to xterms.  I can browse the web just
fine using the mouse inside Galeon, and other stuff runs just fine.  I
can even cut'n'paste stuff from one xterm and have it run in another.  

But the only way I've found to fix this is to reboot, which requires
an fsck of my disks, which takes a while.  I'll see if I can re-create
this in more detail tonight while at home, and hopefully from a
console.

Strangley enough, Magic SysReq still seems to work, since that's how I
reboot.  Logging out of Xwindows works, but then when I try to reboot
the system from gdm, it hangs at a blank screen.

Whee!

Here's my interrupts:

jfsnew:~> cat /proc/interrupts 
           CPU0       CPU1       
  0:   44911738        411    IO-APIC-edge  timer
  1:       1290          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 11:     861346          2    IO-APIC-edge  Cyclom-Y
 12:       2053          0    IO-APIC-edge  i8042
 14:     141353          0    IO-APIC-edge  ide0
 16:          0          0   IO-APIC-level  ohci-hcd
 17:       6447          0   IO-APIC-level  ohci-hcd, eth0
 18:     214706          1   IO-APIC-level  aic7xxx, aic7xxx, ehci_hcd
 19:         50          0   IO-APIC-level  aic7xxx, uhci-hcd
NMI:          0          0 
LOC:   44911434   44911479 
ERR:          0
MIS:          0

-------------------------------------------------------------------
/var/log/messages
-------------------------------------------------------------------

Sep  7 22:55:26 jfsnew kernel: floppy0: sector not found: track 0, head 1, secto
r 1, size 2
Sep  7 22:55:26 jfsnew kernel: floppy0: sector not found: track 0, head 1, secto
r 1, size 2
Sep  7 22:55:26 jfsnew kernel: end_request: I/O error, dev fd0, sector 18
Sep  7 22:55:26 jfsnew kernel: Unable to handle kernel paging request at virtual
 address eb655050
Sep  7 22:55:26 jfsnew kernel:  printing eip:
Sep  7 22:55:26 jfsnew kernel: c02ac816
Sep  7 22:55:26 jfsnew kernel: *pde = 00541063
Sep  7 22:55:26 jfsnew kernel: *pte = 2b655000
Sep  7 22:55:26 jfsnew kernel: Oops: 0000 [#1]
Sep  7 22:55:26 jfsnew kernel: SMP DEBUG_PAGEALLOC
Sep  7 22:55:26 jfsnew kernel: CPU:    0
Sep  7 22:55:26 jfsnew kernel: EIP:    0060:[bad_flp_intr+150/224]    Not tainte
d VLI
Sep  7 22:55:26 jfsnew kernel: EIP:    0060:[<c02ac816>]    Not tainted VLI
Sep  7 22:55:26 jfsnew kernel: EFLAGS: 00010246
Sep  7 22:55:26 jfsnew kernel: EIP is at bad_flp_intr+0x96/0xe0
Sep  7 22:55:26 jfsnew kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   e
dx: eb655050
Sep  7 22:55:26 jfsnew kernel: esi: c0520c00   edi: eb655050   ebp: 00000002   e
sp: efea7f5c
Sep  7 22:55:26 jfsnew kernel: ds: 007b   es: 007b   ss: 0068
Sep  7 22:55:26 jfsnew kernel: Process events/0 (pid: 6, threadinfo=efea6000 tas
k=c17ef000)
Sep  7 22:55:26 jfsnew kernel: Stack: 00000000 00000000 00000001 c02ad0ba 000000
00 c0430940 00000003 c0471680 
Sep  7 22:55:26 jfsnew kernel:        00000283 c17f0004 00000000 c02aa5f1 c04716
c0 c013547d 00000000 5a5a5a5a 
Sep  7 22:55:26 jfsnew kernel:        c02aa5e0 00000001 00000000 c011f840 000100
00 00000000 00000000 c17dbf1c 
Sep  7 22:55:26 jfsnew kernel: Call Trace:
Sep  7 22:55:26 jfsnew kernel:  [rw_interrupt+474/800] rw_interrupt+0x1da/0x320
Sep  7 22:55:26 jfsnew kernel:  [<c02ad0ba>] rw_interrupt+0x1da/0x320
Sep  7 22:55:26 jfsnew kernel:  [main_command_interrupt+17/32] main_command_inte
rrupt+0x11/0x20
Sep  7 22:55:26 jfsnew kernel:  [<c02aa5f1>] main_command_interrupt+0x11/0x20
Sep  7 22:55:26 jfsnew kernel:  [worker_thread+525/816] worker_thread+0x20d/0x33
0
Sep  7 22:55:26 jfsnew kernel:  [<c013547d>] worker_thread+0x20d/0x330
Sep  7 22:55:26 jfsnew kernel:  [main_command_interrupt+0/32] main_command_inter
rupt+0x0/0x20
Sep  7 22:55:26 jfsnew kernel:  [<c02aa5e0>] main_command_interrupt+0x0/0x20
Sep  7 22:55:26 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:55:26 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:55:26 jfsnew kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Sep  7 22:55:26 jfsnew kernel:  [<c03b5fd2>] ret_from_fork+0x6/0x14
Sep  7 22:55:26 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:55:26 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:55:26 jfsnew kernel:  [worker_thread+0/816] worker_thread+0x0/0x330
Sep  7 22:55:26 jfsnew kernel:  [<c0135270>] worker_thread+0x0/0x330
Sep  7 22:55:26 jfsnew kernel:  [kernel_thread_helper+5/12] kernel_thread_helper
+0x5/0xc
Sep  7 22:55:26 jfsnew kernel:  [<c010ac69>] kernel_thread_helper+0x5/0xc
Sep  7 22:55:26 jfsnew kernel: 
Sep  7 22:55:26 jfsnew kernel: Code: 52 c0 8d 04 9b 8d 04 43 8b 44 c6 28 39 07 7
6 0b 6a 00 a1 24 1c 52 c0 ff 50 0c 5b 0f b6 0d 84 1c 52 c0 8b 15 20 1c 52 c0 8d 
04 89 <8b> 12 8d 04 41 c1 e0 03 3b 54 06 30 76 11 a1 80 1c 52 c0 c1 e0 
Sep  7 22:55:38 jfsnew apcupsd[1324]: Serial communications with UPS lost 
Sep  7 22:55:46 jfsnew kernel:  
Sep  7 22:55:46 jfsnew kernel: floppy driver state
Sep  7 22:55:46 jfsnew kernel: -------------------
Sep  7 22:55:46 jfsnew kernel: now=4294937721 last interrupt=4294917720 diff=200
01 last called handler=c02aa5e0
Sep  7 22:55:46 jfsnew kernel: timeout_message=request done %%d
Sep  7 22:55:46 jfsnew kernel: last output bytes:
Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:46 jfsnew kernel: 13 80 4294917324
Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:46 jfsnew kernel: 1a 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  3 80 4294917324
Sep  7 22:55:46 jfsnew kernel: c1 90 4294917324
Sep  7 22:55:46 jfsnew kernel: 10 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  7 80 4294917324
Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  8 81 4294917324
Sep  7 22:55:46 jfsnew kernel: e6 80 4294917324
Sep  7 22:55:46 jfsnew kernel:  4 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  1 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  1 90 4294917324
Sep  7 22:55:46 jfsnew kernel:  2 90 4294917325
Sep  7 22:55:46 jfsnew kernel: 12 90 4294917325
Sep  7 22:55:46 jfsnew kernel: 1b 90 4294917325
Sep  7 22:55:46 jfsnew kernel: ff 90 4294917325
Sep  7 22:55:46 jfsnew kernel: last result at 4294917720
Sep  7 22:55:46 jfsnew kernel: last redo_fd_request at 4294917324
Sep  7 22:55:46 jfsnew kernel: 44  1  0  0  1  1  2 
Sep  7 22:55:46 jfsnew kernel: status=80
Sep  7 22:55:46 jfsnew kernel: fdc_busy=1
Sep  7 22:55:46 jfsnew kernel: cont=c0471720
Sep  7 22:55:46 jfsnew kernel: current_req=00000000
Sep  7 22:55:46 jfsnew kernel: command_status=-1
Sep  7 22:55:46 jfsnew kernel: 
Sep  7 22:55:46 jfsnew kernel: floppy0: floppy timeout called
Sep  7 22:55:46 jfsnew kernel: floppy.c: no request in request_done
Sep  7 22:55:49 jfsnew kernel: 
Sep  7 22:55:49 jfsnew kernel: floppy driver state
Sep  7 22:55:49 jfsnew kernel: -------------------
Sep  7 22:55:49 jfsnew kernel: now=4294940721 last interrupt=4294937722 diff=299
9 last called handler=c02abc40
Sep  7 22:55:49 jfsnew kernel: timeout_message=redo fd request
Sep  7 22:55:49 jfsnew kernel: last output bytes:
Sep  7 22:55:49 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  3 80 4294917324
Sep  7 22:55:49 jfsnew kernel: c1 90 4294917324
Sep  7 22:55:49 jfsnew kernel: 10 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  7 80 4294917324
Sep  7 22:55:49 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  8 81 4294917324
Sep  7 22:55:49 jfsnew kernel: e6 80 4294917324
Sep  7 22:55:49 jfsnew kernel:  4 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  1 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  1 90 4294917324
Sep  7 22:55:49 jfsnew kernel:  2 90 4294917325
Sep  7 22:55:49 jfsnew kernel: 12 90 4294917325
Sep  7 22:55:49 jfsnew kernel: 1b 90 4294917325
Sep  7 22:55:49 jfsnew kernel: ff 90 4294917325
Sep  7 22:55:49 jfsnew kernel:  8 80 4294937722
Sep  7 22:55:49 jfsnew last message repeated 3 times
Sep  7 22:55:49 jfsnew kernel: last result at 4294937722
Sep  7 22:55:49 jfsnew kernel: last redo_fd_request at 4294937721
Sep  7 22:55:49 jfsnew kernel: c3  0 
Sep  7 22:55:49 jfsnew kernel: status=80
Sep  7 22:55:49 jfsnew kernel: fdc_busy=1
Sep  7 22:55:49 jfsnew kernel: floppy_work.func=c02abc40
Sep  7 22:55:49 jfsnew kernel: cont=c0471720
Sep  7 22:55:49 jfsnew kernel: current_req=eb794004
Sep  7 22:55:49 jfsnew kernel: command_status=-1
Sep  7 22:55:49 jfsnew kernel: 
Sep  7 22:55:49 jfsnew kernel: floppy0: floppy timeout called
Sep  7 22:55:49 jfsnew kernel: end_request: I/O error, dev fd0, sector 0
Sep  7 22:55:49 jfsnew kernel: Buffer I/O error on device fd0, logical block 0
Sep  7 22:55:49 jfsnew kernel: lost page write due to I/O error on fd0
Sep  7 22:55:52 jfsnew kernel: 
Sep  7 22:55:52 jfsnew kernel: floppy driver state
Sep  7 22:55:52 jfsnew kernel: -------------------
Sep  7 22:55:52 jfsnew kernel: now=4294943721 last interrupt=4294940722 diff=299
9 last called handler=c02abc40
Sep  7 22:55:52 jfsnew kernel: timeout_message=redo fd request
Sep  7 22:55:52 jfsnew kernel: last output bytes:
Sep  7 22:55:52 jfsnew kernel:  7 80 4294917324
Sep  7 22:55:52 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:52 jfsnew kernel:  8 81 4294917324
Sep  7 22:55:52 jfsnew kernel: e6 80 4294917324
Sep  7 22:55:52 jfsnew kernel:  4 90 4294917324
Sep  7 22:55:52 jfsnew kernel:  0 90 4294917324
Sep  7 22:55:52 jfsnew kernel:  1 90 4294917324
Sep  7 22:55:52 jfsnew kernel:  1 90 4294917324
Sep  7 22:55:52 jfsnew kernel:  2 90 4294917325
Sep  7 22:55:52 jfsnew kernel: 12 90 4294917325
Sep  7 22:55:52 jfsnew kernel: 1b 90 4294917325
Sep  7 22:55:52 jfsnew kernel: ff 90 4294917325
Sep  7 22:55:52 jfsnew kernel:  8 80 4294937722
Sep  7 22:55:52 jfsnew last message repeated 3 times
Sep  7 22:55:52 jfsnew kernel:  8 80 4294940722
Sep  7 22:55:52 jfsnew last message repeated 3 times
Sep  7 22:55:52 jfsnew kernel: last result at 4294940722
Sep  7 22:55:52 jfsnew kernel: last redo_fd_request at 4294940721
Sep  7 22:55:52 jfsnew kernel: c3  0 
Sep  7 22:55:52 jfsnew kernel: status=80
Sep  7 22:55:52 jfsnew kernel: fdc_busy=1
Sep  7 22:55:52 jfsnew kernel: floppy_work.func=c02abc40
Sep  7 22:55:52 jfsnew kernel: cont=c0471720
Sep  7 22:55:52 jfsnew kernel: current_req=eb794004
Sep  7 22:55:52 jfsnew kernel: command_status=-1
Sep  7 22:55:52 jfsnew kernel: 
Sep  7 22:55:52 jfsnew kernel: floppy0: floppy timeout called
Sep  7 22:55:52 jfsnew kernel: end_request: I/O error, dev fd0, sector 8
Sep  7 22:55:52 jfsnew kernel: Buffer I/O error on device fd0, logical block 1
Sep  7 22:55:52 jfsnew kernel: lost page write due to I/O error on fd0
Sep  7 22:55:55 jfsnew kernel: work still pending
Sep  7 22:56:04 jfsnew kernel: SysRq : Emergency Sync
Sep  7 22:56:05 jfsnew kernel: Emergency Sync complete
Sep  7 22:56:05 jfsnew kernel: SysRq : Emergency Sync
Sep  7 22:56:05 jfsnew kernel: Emergency Sync complete
Sep  7 22:56:06 jfsnew kernel: SysRq : Emergency Sync
Sep  7 22:56:06 jfsnew kernel: Emergency Sync complete
Sep  7 22:56:06 jfsnew kernel: SysRq : Emergency Sync
Sep  7 22:56:06 jfsnew kernel: Emergency Sync complete
Sep  7 22:56:10 jfsnew kernel: e a625280b 
Sep  7 22:56:10 jfsnew kernel:        00000018 c179a0c4 c1799c20 ebbcd000 e9c9a0
00 e9c9a000 c026bc0e e9c9a000 
Sep  7 22:56:10 jfsnew kernel:        00000008 7fffffff ec7ff0a4 00000000 c012d4
34 00000001 00000282 c0435500 
Sep  7 22:56:10 jfsnew kernel: Call Trace:
Sep  7 22:56:10 jfsnew kernel:  [opost_block+478/496] opost_block+0x1de/0x1f0
Sep  7 22:56:10 jfsnew kernel:  [<c026bc0e>] opost_block+0x1de/0x1f0
Sep  7 22:56:10 jfsnew kernel:  [schedule_timeout+20/192] schedule_timeout+0x14/
0xc0
Sep  7 22:56:10 jfsnew kernel:  [<c012d434>] schedule_timeout+0x14/0xc0
Sep  7 22:56:10 jfsnew kernel:  [generic_file_aio_read+38/48] generic_file_aio_r
ead+0x26/0x30
Sep  7 22:56:10 jfsnew kernel:  [<c0140f86>] generic_file_aio_read+0x26/0x30
Sep  7 22:56:10 jfsnew kernel:  [read_chan+1282/3248] read_chan+0x502/0xcb0
Sep  7 22:56:10 jfsnew kernel:  [<c026dbe2>] read_chan+0x502/0xcb0
Sep  7 22:56:10 jfsnew kernel:  [release_pages+541/560] release_pages+0x21d/0x23
0
Sep  7 22:56:10 jfsnew kernel:  [<c014bb2d>] release_pages+0x21d/0x230
Sep  7 22:56:10 jfsnew kernel:  [acquire_console_sem+42/80] acquire_console_sem+
0x2a/0x50
Sep  7 22:56:10 jfsnew kernel:  [<c0124e7a>] acquire_console_sem+0x2a/0x50
Sep  7 22:56:10 jfsnew kernel:  [write_chan+515/544] write_chan+0x203/0x220
Sep  7 22:56:10 jfsnew kernel:  [<c026e593>] write_chan+0x203/0x220
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [tty_read+281/416] tty_read+0x119/0x1a0
Sep  7 22:56:10 jfsnew kernel:  [<c0267b69>] tty_read+0x119/0x1a0
Sep  7 22:56:10 jfsnew kernel:  [vfs_read+170/224] vfs_read+0xaa/0xe0
Sep  7 22:56:10 jfsnew kernel:  [<c016014a>] vfs_read+0xaa/0xe0
Sep  7 22:56:10 jfsnew kernel:  [do_munmap+347/368] do_munmap+0x15b/0x170
Sep  7 22:56:10 jfsnew kernel:  [<c0153e4b>] do_munmap+0x15b/0x170
Sep  7 22:56:10 jfsnew kernel:  [sys_read+47/80] sys_read+0x2f/0x50
Sep  7 22:56:10 jfsnew kernel:  [<c016036f>] sys_read+0x2f/0x50
Sep  7 22:56:10 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:10 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:10 jfsnew kernel: 
Sep  7 22:56:10 jfsnew kernel: mingetty      S E7944000  1374      1          13
75  1373 (NOTLB)
Sep  7 22:56:10 jfsnew kernel: e79d1e28 00000082 e79ca000 e7944000 e7944020 c179
1c20 000ca26a a68e9177 
Sep  7 22:56:10 jfsnew kernel:        00000018 c17920c4 c1791c20 e79ca000 e7ad30
00 e7ad3000 c026bc0e e7ad3000 
Sep  7 22:56:10 jfsnew kernel:        00000008 7fffffff e80670a4 00000000 c012d4
34 00000001 00000286 c0435500 
Sep  7 22:56:10 jfsnew kernel: Call Trace:
Sep  7 22:56:10 jfsnew kernel:  [opost_block+478/496] opost_block+0x1de/0x1f0
Sep  7 22:56:10 jfsnew kernel:  [<c026bc0e>] opost_block+0x1de/0x1f0
Sep  7 22:56:10 jfsnew kernel:  [schedule_timeout+20/192] schedule_timeout+0x14/
0xc0
Sep  7 22:56:10 jfsnew kernel:  [<c012d434>] schedule_timeout+0x14/0xc0
Sep  7 22:56:10 jfsnew kernel:  [generic_file_aio_read+38/48] generic_file_aio_r
ead+0x26/0x30
Sep  7 22:56:10 jfsnew kernel:  [<c0140f86>] generic_file_aio_read+0x26/0x30
Sep  7 22:56:10 jfsnew kernel:  [read_chan+1282/3248] read_chan+0x502/0xcb0
Sep  7 22:56:10 jfsnew kernel:  [<c026dbe2>] read_chan+0x502/0xcb0
Sep  7 22:56:10 jfsnew kernel:  [release_pages+541/560] release_pages+0x21d/0x23
0
Sep  7 22:56:10 jfsnew kernel:  [<c014bb2d>] release_pages+0x21d/0x230
Sep  7 22:56:10 jfsnew kernel:  [acquire_console_sem+42/80] acquire_console_sem+
0x2a/0x50
Sep  7 22:56:10 jfsnew kernel:  [<c0124e7a>] acquire_console_sem+0x2a/0x50
Sep  7 22:56:10 jfsnew kernel:  [write_chan+515/544] write_chan+0x203/0x220
Sep  7 22:56:10 jfsnew kernel:  [<c026e593>] write_chan+0x203/0x220
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:10 jfsnew kernel:  [tty_read+281/416] tty_read+0x119/0x1a0
Sep  7 22:56:10 jfsnew kernel:  [<c0267b69>] tty_read+0x119/0x1a0
Sep  7 22:56:10 jfsnew kernel:  [vfs_read+170/224] vfs_read+0xaa/0xe0
Sep  7 22:56:10 jfsnew kernel:  [<c016014a>] vfs_read+0xaa/0xe0
Sep  7 22:56:10 jfsnew kernel:  [do_munmap+347/368] do_munmap+0x15b/0x170
Sep  7 22:56:11 jfsnew kernel:  [<c0153e4b>] do_munmap+0x15b/0x170
Sep  7 22:56:11 jfsnew kernel:  [sys_read+47/80] sys_read+0x2f/0x50
Sep  7 22:56:11 jfsnew kernel:  [<c016036f>] sys_read+0x2f/0x50
Sep  7 22:56:11 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel: 
Sep  7 22:56:11 jfsnew kernel: mingetty      S 00000246  1375      1          13
76  1374 (NOTLB)
Sep  7 22:56:11 jfsnew kernel: e7a0fe28 00000082 ea36f000 00000246 00000008 c179
1c20 000517e7 a62e1bc3 
Sep  7 22:56:11 jfsnew kernel:        00000018 00000000 c1791c20 ea36f000 e790c0
00 e790c000 c026bc0e e790c000 
Sep  7 22:56:11 jfsnew kernel:        00000008 7fffffff e790d0a4 00000000 c012d4
34 00000001 00000286 c0435500 
Sep  7 22:56:11 jfsnew kernel: Call Trace:
Sep  7 22:56:11 jfsnew kernel:  [opost_block+478/496] opost_block+0x1de/0x1f0
Sep  7 22:56:11 jfsnew kernel:  [<c026bc0e>] opost_block+0x1de/0x1f0
Sep  7 22:56:11 jfsnew kernel:  [schedule_timeout+20/192] schedule_timeout+0x14/
0xc0
Sep  7 22:56:11 jfsnew kernel:  [<c012d434>] schedule_timeout+0x14/0xc0
Sep  7 22:56:11 jfsnew kernel:  [generic_file_aio_read+38/48] generic_file_aio_r
ead+0x26/0x30
Sep  7 22:56:11 jfsnew kernel:  [<c0140f86>] generic_file_aio_read+0x26/0x30
Sep  7 22:56:11 jfsnew kernel:  [read_chan+1282/3248] read_chan+0x502/0xcb0
Sep  7 22:56:11 jfsnew kernel:  [<c026dbe2>] read_chan+0x502/0xcb0
Sep  7 22:56:11 jfsnew kernel:  [release_pages+541/560] release_pages+0x21d/0x23
0
Sep  7 22:56:11 jfsnew kernel:  [<c014bb2d>] release_pages+0x21d/0x230
Sep  7 22:56:11 jfsnew kernel:  [acquire_console_sem+42/80] acquire_console_sem+
0x2a/0x50
Sep  7 22:56:11 jfsnew kernel:  [<c0124e7a>] acquire_console_sem+0x2a/0x50
Sep  7 22:56:11 jfsnew kernel:  [write_chan+515/544] write_chan+0x203/0x220
Sep  7 22:56:11 jfsnew kernel:  [<c026e593>] write_chan+0x203/0x220
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [tty_read+281/416] tty_read+0x119/0x1a0
Sep  7 22:56:11 jfsnew kernel:  [<c0267b69>] tty_read+0x119/0x1a0
Sep  7 22:56:11 jfsnew kernel:  [vfs_read+170/224] vfs_read+0xaa/0xe0
Sep  7 22:56:11 jfsnew kernel:  [<c016014a>] vfs_read+0xaa/0xe0
Sep  7 22:56:11 jfsnew kernel:  [do_munmap+347/368] do_munmap+0x15b/0x170
Sep  7 22:56:11 jfsnew kernel:  [<c0153e4b>] do_munmap+0x15b/0x170
Sep  7 22:56:11 jfsnew kernel:  [sys_read+47/80] sys_read+0x2f/0x50
Sep  7 22:56:11 jfsnew kernel:  [<c016036f>] sys_read+0x2f/0x50
Sep  7 22:56:11 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel: 
Sep  7 22:56:11 jfsnew kernel: mingetty      S 00000246  1376      1          13
77  1375 (NOTLB)
Sep  7 22:56:11 jfsnew kernel: e9c41e28 00000082 eb264000 00000246 00000008 c179
9c20 00048372 a62ece1c 
Sep  7 22:56:11 jfsnew kernel:        00000018 00000000 c1799c20 eb264000 e841e0
00 e841e000 c026bc0e e841e000 
Sep  7 22:56:11 jfsnew kernel:        00000008 7fffffff e7c740a4 00000000 c012d4
34 00000001 00000282 c0435500 
Sep  7 22:56:11 jfsnew kernel: Call Trace:
Sep  7 22:56:11 jfsnew kernel:  [opost_block+478/496] opost_block+0x1de/0x1f0
Sep  7 22:56:11 jfsnew kernel:  [<c026bc0e>] opost_block+0x1de/0x1f0
Sep  7 22:56:11 jfsnew kernel:  [schedule_timeout+20/192] schedule_timeout+0x14/
0xc0
Sep  7 22:56:11 jfsnew kernel:  [<c012d434>] schedule_timeout+0x14/0xc0
Sep  7 22:56:11 jfsnew kernel:  [generic_file_aio_read+38/48] generic_file_aio_r
ead+0x26/0x30
Sep  7 22:56:11 jfsnew kernel:  [<c0140f86>] generic_file_aio_read+0x26/0x30
Sep  7 22:56:11 jfsnew kernel:  [read_chan+1282/3248] read_chan+0x502/0xcb0
Sep  7 22:56:11 jfsnew kernel:  [<c026dbe2>] read_chan+0x502/0xcb0
Sep  7 22:56:11 jfsnew kernel:  [release_pages+541/560] release_pages+0x21d/0x23
0
Sep  7 22:56:11 jfsnew kernel:  [<c014bb2d>] release_pages+0x21d/0x230
Sep  7 22:56:11 jfsnew kernel:  [acquire_console_sem+42/80] acquire_console_sem+
0x2a/0x50
Sep  7 22:56:11 jfsnew kernel:  [<c0124e7a>] acquire_console_sem+0x2a/0x50
Sep  7 22:56:11 jfsnew kernel:  [write_chan+515/544] write_chan+0x203/0x220
Sep  7 22:56:11 jfsnew kernel:  [<c026e593>] write_chan+0x203/0x220
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:11 jfsnew kernel:  [tty_read+281/416] tty_read+0x119/0x1a0
Sep  7 22:56:11 jfsnew kernel:  [<c0267b69>] tty_read+0x119/0x1a0
Sep  7 22:56:11 jfsnew kernel:  [vfs_read+170/224] vfs_read+0xaa/0xe0
Sep  7 22:56:11 jfsnew kernel:  [<c016014a>] vfs_read+0xaa/0xe0
Sep  7 22:56:11 jfsnew kernel:  [do_munmap+347/368] do_munmap+0x15b/0x170
Sep  7 22:56:11 jfsnew kernel:  [<c0153e4b>] do_munmap+0x15b/0x170
Sep  7 22:56:11 jfsnew kernel:  [sys_read+47/80] sys_read+0x2f/0x50
Sep  7 22:56:11 jfsnew kernel:  [<c016036f>] sys_read+0x2f/0x50
Sep  7 22:56:11 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel: 
Sep  7 22:56:11 jfsnew kernel: gdm           S C0435F00  1377      1  1385    15
68  1376 (NOTLB)
Sep  7 22:56:11 jfsnew kernel: e79b3ee4 00000082 e7944000 c0435f00 00000000 c179
9c20 0003a879 5efbfc83 
Sep  7 22:56:11 jfsnew kernel:        00000025 e7abb004 c1799c20 e7944000 000000
00 c0174503 00000246 eb69e004 
Sep  7 22:56:11 jfsnew kernel:        00000000 7fffffff e79b3f30 7fffffff c012d4
34 e79b3fa0 e8035004 00000145 
Sep  7 22:56:11 jfsnew kernel: Call Trace:
Sep  7 22:56:11 jfsnew kernel:  [__pollwait+51/160] __pollwait+0x33/0xa0
Sep  7 22:56:11 jfsnew kernel:  [<c0174503>] __pollwait+0x33/0xa0
Sep  7 22:56:11 jfsnew kernel:  [schedule_timeout+20/192] schedule_timeout+0x14/
0xc0
Sep  7 22:56:11 jfsnew kernel:  [<c012d434>] schedule_timeout+0x14/0xc0
Sep  7 22:56:11 jfsnew kernel:  [do_pollfd+69/128] do_pollfd+0x45/0x80
Sep  7 22:56:11 jfsnew kernel:  [<c0174f55>] do_pollfd+0x45/0x80
Sep  7 22:56:11 jfsnew kernel:  [do_pollfd+89/128] do_pollfd+0x59/0x80
Sep  7 22:56:11 jfsnew kernel:  [<c0174f69>] do_pollfd+0x59/0x80
Sep  7 22:56:11 jfsnew kernel:  [do_poll+111/224] do_poll+0x6f/0xe0
Sep  7 22:56:11 jfsnew kernel:  [<c0174fff>] do_poll+0x6f/0xe0
Sep  7 22:56:11 jfsnew kernel:  [do_poll+178/224] do_poll+0xb2/0xe0
Sep  7 22:56:11 jfsnew kernel:  [<c0175042>] do_poll+0xb2/0xe0
Sep  7 22:56:11 jfsnew kernel:  [sys_poll+486/688] sys_poll+0x1e6/0x2b0
Sep  7 22:56:11 jfsnew kernel:  [<c0175256>] sys_poll+0x1e6/0x2b0
Sep  7 22:56:11 jfsnew kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Sep  7 22:56:11 jfsnew kernel:  [<c01744d0>] __pollwait+0x0/0xa0
Sep  7 22:56:11 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:11 jfsnew kernel:  [xdr_decode_string_inplace+11/48] xdr_decode_str
ing_inplace+0xb/0x30
Sep  7 22:56:11 jfsnew kernel:  [<c03b007b>] xdr_decode_string_inplace+0xb/0x30
Sep  7 22:56:12 jfsnew kernel: 
Sep  7 22:56:12 jfsnew kernel: gdm           S 00000001  1385   1377  1386      
         (NOTLB)
Sep  7 22:56:12 jfsnew kernel: ebb4ff60 00000082 eb84b000 00000001 e740eb1c c1791c20 0001200d 5efcae4c 
Sep  7 22:56:12 jfsnew kernel:        00000025 405bde34 c1791c20 eb84b000 000000
00 00000000 405425e1 00000073 
Sep  7 22:56:12 jfsnew kernel:        00000001 fffffe00 eb84b000 00000000 c01277
b1 ebb4e000 00000001 00000000 
Sep  7 22:56:12 jfsnew kernel: Call Trace:
Sep  7 22:56:12 jfsnew kernel:  [sys_wait4+593/656] sys_wait4+0x251/0x290
Sep  7 22:56:12 jfsnew kernel:  [<c01277b1>] sys_wait4+0x251/0x290
Sep  7 22:56:12 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:12 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:12 jfsnew kernel:  [sys_sigreturn+277/320] sys_sigreturn+0x115/0x14
0
Sep  7 22:56:12 jfsnew kernel:  [<c010c445>] sys_sigreturn+0x115/0x140
Sep  7 22:56:12 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
on+0x0/0x20
Sep  7 22:56:12 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
Sep  7 22:56:12 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:12 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:12 jfsnew kernel: 
Sep  7 22:56:12 jfsnew kernel: X             S 00000000  1386   1385          14
37       (NOTLB)
Sep  7 22:56:12 jfsnew kernel: e73c3e60 00003082 e73ea000 00000000 c179a580 c179
9c20 00003f46 f11d73ed 
Sep  7 22:56:12 jfsnew kernel:        00000042 00003246 c1799c20 e73ea000 e79db0
00 00000000 00010b0d e73c3e68 
Sep  7 22:56:12 jfsnew kernel:        00010b0d e73c3e68 00000000 00000000 c012d4
bc c179afb0 c179afb0 00010b0d 
Sep  7 22:56:12 jfsnew kernel: Call Trace:
Sep  7 22:56:12 jfsnew kernel:  [schedule_timeout+156/192] schedule_timeout+0x9c
/0xc0
Sep  7 22:56:12 jfsnew kernel:  [<c012d4bc>] schedule_timeout+0x9c/0xc0
Sep  7 22:56:12 jfsnew kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
Sep  7 22:56:12 jfsnew kernel:  [<c012d410>] process_timeout+0x0/0x10
Sep  7 22:56:12 jfsnew kernel:  [do_select+767/832] do_select+0x2ff/0x340
Sep  7 22:56:12 jfsnew kernel:  [<c017494f>] do_select+0x2ff/0x340
Sep  7 22:56:12 jfsnew kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Sep  7 22:56:12 jfsnew kernel:  [<c01744d0>] __pollwait+0x0/0xa0
Sep  7 22:56:12 jfsnew kernel:  [select_bits_alloc+23/32] select_bits_alloc+0x17
/0x20
Sep  7 22:56:12 jfsnew kernel:  [<c01749a7>] select_bits_alloc+0x17/0x20
Sep  7 22:56:12 jfsnew kernel:  [sys_select+904/1360] sys_select+0x388/0x550
Sep  7 22:56:12 jfsnew kernel:  [<c0174d48>] sys_select+0x388/0x550
Sep  7 22:56:12 jfsnew kernel:  [do_gettimeofday+32/160] do_gettimeofday+0x20/0x
a0
Sep  7 22:56:12 jfsnew kernel:  [<c0112cd0>] do_gettimeofday+0x20/0xa0
Sep  7 22:56:12 jfsnew kernel:  [sys_gettimeofday+85/192]
sys_gettimeofday+0x55/
0xc0
Sep  7 22:56:12 jfsnew kernel:  [<c0127e45>] sys_gettimeofday+0x55/0xc0
Sep  7 22:56:12 jfsnew kernel:  [sys_ioctl+631/736] sys_ioctl+0x277/0x2e0
Sep  7 22:56:12 jfsnew kernel:  [<c0173ea7>] sys_ioctl+0x277/0x2e0
Sep  7 22:56:12 jfsnew kernel:  [sys_sigreturn+277/320] sys_sigreturn+0x115/0x14
0
Sep  7 22:56:12 jfsnew kernel:  [<c010c445>] sys_sigreturn+0x115/0x140
Sep  7 22:56:12 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:12 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:12 jfsnew kernel: 
Sep  7 22:56:12 jfsnew kernel: tcsh          S 00000000  1437   1385  1491      
    1386 (NOTLB)
Sep  7 22:56:12 jfsnew kernel: e6473f78 00000082 e672a000 00000000 e6473f68 c179
9c20 00045179 9ce57cd0 
Sep  7 22:56:12 jfsnew kernel:        00000025 bfff55f0 c1799c20 e672a000 000000
00 00000002 00000000 00000008 
Sep  7 22:56:12 jfsnew kernel:        e6472000 e6473f80 bfff5670 e6473fc4 c010c0
7d 00010002 00000000 00000002 
Sep  7 22:56:12 jfsnew kernel: Call Trace:
Sep  7 22:56:12 jfsnew kernel:  [sys_rt_sigsuspend+365/400] sys_rt_sigsuspend+0x
16d/0x190
Sep  7 22:56:12 jfsnew kernel:  [<c010c07d>] sys_rt_sigsuspend+0x16d/0x190
Sep  7 22:56:12 jfsnew kernel:  [sys_fork+25/32] sys_fork+0x19/0x20
Sep  7 22:56:12 jfsnew kernel:  [<c010b3f9>] sys_fork+0x19/0x20
Sep  7 22:56:12 jfsnew kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 22:56:12 jfsnew kernel:  [<c03b60b3>] syscall_call+0x7/0xb
Sep  7 22:56:12 jfsnew kernel: 
Sep  7 22:56:12 jfsnew kernel: fvwm2         S E5749000  1491   1437  1495      
         (NOTLB)
Sep  7 22:56:12 jfsnew kernel: e5945e60 00000082 e62fa000 e5749000 e5749020 c179
1c20 00064040 4970d179 
Sep  7 22:56:12 jfsnew kernel:        0000003a c17920c4 c1791c20 e62fa000 000000
01 000000d0 e5945eec e720f004 
Sep  7 22:56:12 jfsnew kernel:        00000000 7fffffff 00000000 00000000 c012d4
34 e5c2b004 00000145 00000246 
Sep  7 22:56:12 jfsnew kernel: Call Trace:
Sep  7 22:56:12 jfsnew kernel:  [schedule_timeout+20/192] schedule_timeout+0x14/
0xc0
Sep  7 22:56:12 jfsnew kernel:  [<c012d434>] schedule_timeout+0x14/0xc0
Sep  7 22:56:12 jfsnew kernel:  [pipe_poll+35/112] pipe_poll+0x23/0x70


and so on.... I'm not sure if any of the rest really helps here.

John
