Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUGCKZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUGCKZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 06:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUGCKZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 06:25:39 -0400
Received: from pra68-d187.gd.dial-up.cz ([193.85.68.187]:61056 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S264255AbUGCKZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 06:25:35 -0400
Date: Sat, 3 Jul 2004 12:25:16 +0200
To: linux-kernel@vger.kernel.org
Subject: register dump when press scroll lock
Message-ID: <20040703102516.GA11284@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run 2.6.7 kernel.

Steps to reproduce:
Switch keyboard by "Pause/Break" key from English to Czech map (or another
second keymap, I also tried Slovak). Then press scrolllock. The following
is printed out and scrlock led state is untouched:

Pid: 0, comm:              swapper
EIP: 0060:[<c01e5382>] CPU: 0
EIP is at acpi_processor_idle+0xd4/0x1c7
 EFLAGS: 00000212    Not tainted  (2.6.7)
EAX: 00cf9366 EBX: 00004008 ECX: 00cf90da EDX: 00004008
ESI: cffd28b0 EDI: c0467e80 EBP: cffd2800 DS: 007b ES: 007b
CR0: 8005003b CR2: 080b7f40 CR3: 0ca85000 CR4: 000002d0
 [<c0101f3c>] cpu_idle+0x2c/0x40
 [<c043d5fc>] start_kernel+0x13c/0x160
 [<c043d370>] unknown_bootoption+0x0/0x110

EIP is at c01e5382 or c01e5361. Here is the asm code from gdb:

0xc01e5355 <acpi_processor_idle+167>:   cmp    $0x3,%eax
0xc01e5358 <acpi_processor_idle+170>:   je     0xc01e539f <acpi_processor_idle+241>
0xc01e535a <acpi_processor_idle+172>:   jmp    0xc01e5406 <acpi_processor_idle+344>
0xc01e535f <acpi_processor_idle+177>:   sti
0xc01e5360 <acpi_processor_idle+178>:   hlt
0xc01e5361 <acpi_processor_idle+179>:   or     $0xffffffff,%ebx
0xc01e5364 <acpi_processor_idle+182>:   jmp    0xc01e5409 <acpi_processor_idle+347>
0xc01e5369 <acpi_processor_idle+187>:   mov    0xc04777f4,%ebx
0xc01e536f <acpi_processor_idle+193>:   mov    %ebx,%edx
0xc01e5371 <acpi_processor_idle+195>:   in     (%dx),%eax
0xc01e5372 <acpi_processor_idle+196>:   mov    0xb4(%ebp),%edx
0xc01e5378 <acpi_processor_idle+202>:   mov    %eax,%ecx
0xc01e537a <acpi_processor_idle+204>:   in     (%dx),%al
0xc01e537b <acpi_processor_idle+205>:   mov    %ebx,%edx
0xc01e537d <acpi_processor_idle+207>:   in     (%dx),%eax
0xc01e537e <acpi_processor_idle+208>:   in     (%dx),%eax
0xc01e537f <acpi_processor_idle+209>:   sti
0xc01e5380 <acpi_processor_idle+210>:   cmp    %ecx,%eax
0xc01e5382 <acpi_processor_idle+212>:   jb     0xc01e5388 <acpi_processor_idle+218>
0xc01e5384 <acpi_processor_idle+214>:   sub    %ecx,%eax


	/*
	 * Sleep:
	 * ------
	 * Invoke the current Cx state to put the processor to sleep.
	 */
	switch (pr->power.state) {

	case ACPI_STATE_C1:
		/* Invoke C1. */
		safe_halt();
		/*
                 * TBD: Can't get time duration while in C1, as resumes
		 *      go to an ISR rather than here.  Need to instrument
		 *      base interrupt handler.
		 */
>>>0xc01e5361 >>>>>>>>>>
		sleep_ticks = 0xFFFFFFFF;
		break;

	case ACPI_STATE_C2:
		/* Get start time (ticks) */
		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
		/* Invoke C2 */
		inb(pr->power.states[ACPI_STATE_C2].address);
		/* Dummy op - must do something useless after P_LVL2 read */
		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
		/* Get end time (ticks) */
		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
		/* Re-enable interrupts */
		local_irq_enable();
		/* Compute time (ticks) that we were actually asleep */
>>>0xc01e5382 >>>>>>>>>>
		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
		break;

For primary keymap this doesn't appear. For second keymap it's
100% reproducible now.

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

