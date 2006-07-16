Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWGPQPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWGPQPe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWGPQPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:15:34 -0400
Received: from khc.piap.pl ([195.187.100.11]:54745 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751112AbWGPQPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:15:33 -0400
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.17.3 kernel panic
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 16 Jul 2006 18:15:30 +0200
Message-ID: <m3psg5a5lp.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got a kernel panic, it tried to print something:

BUG: unable to handle kernel paging request at virtual address d47ddc68
eip = c010b247
*pde = 0
(repeated throughout the screen)

It's a laptop - mobile Celeron Coppermine 600 MHz, 128 MB RAM, i440BX
- Fujitsu-Siemens Liteline Plus 419A (LF6).
The kernel is 2.6.17.3 + Alan's IDE patch, standard config.

Restarted the machine and it seems it's do_page_fault:

c010ae3d T do_page_fault
c010b368 t .text.lock.fault

Not sure if the following means anything:

.L138:
	.loc 1 551 0
	movl	8(%esp), %edx
	movl	%ebx, 496(%edx) <<<<<<<<<<<<<<<< faults here
	.loc 1 552 0
	movl	$14, 500(%edx)
	.loc 1 553 0
	movl	(%esp), %eax
	movl	%eax, 504(%edx)
	.loc 1 554 0
	movl	%eax, %ecx
	movl	$.LC12, %eax
	movl	4(%esp), %edx
.LCFI53:
	call	die


arch/i386/mm.c:
/*
 * Oops. The kernel tried to access some bad page. We'll have to
 * terminate things with extreme prejudice.
 */
...
	tsk->thread.cr2 = address; <<<<<<<<<<<<<<<< left side faults here
	tsk->thread.trap_no = 14;
	tsk->thread.error_code = error_code;
	die("Oops", regs, error_code);
	bust_spinlocks(0);
	do_exit(SIGKILL);

This machine has a history of mysterious hard freezes since ca 2.6.0
(black screen of death, I think there were no such problems with 2.4).
The CPU lacks LAPIC. It could be hardware, but I've never spotted any
specific problem, memtest86 doesn't show anything either.

While this time the machine was almost (but not completely) idle,
the hard freezes seems to occur mostly with simultaneous disk and LAN
activity (Ethernet is Tulip 21143 32-bit PC Card, by DLink, the disk
is IBM/Hitachi IC25N020ATMR04-0 Rev: MO1O).

$ cat /proc/iomem 
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-002a889a : Kernel code
  002a889b-00349233 : Kernel data
07ff0000-07fffbff : ACPI Tables
07fffc00-07ffffff : ACPI Non-volatile Storage
10000000-11ffffff : PCI CardBus #02
  10000000-1003ffff : 0000:02:00.0
12000000-13ffffff : PCI CardBus #02
  12000000-120003ff : 0000:02:00.0
    12000000-120003ff : tulip
14000000-15ffffff : PCI CardBus #06
16000000-17ffffff : PCI CardBus #06
18000000-18000fff : 0000:00:0a.0
  18000000-18000fff : yenta_socket
18001000-18001fff : 0000:00:0a.1
  18001000-18001fff : yenta_socket
f4000000-f7ffffff : 0000:00:00.0
f8000000-fbffffff : PCI Bus #01
  f8000000-fbffffff : 0000:01:00.0
fedfe000-fedfffff : 0000:00:0d.0
  fedfe000-fedfffff : Maestro3
fffeac00-ffffffff : reserved

What could it be?
How could I debug it?
-- 
Krzysztof Halasa
