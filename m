Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756666AbWKSNjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbWKSNjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 08:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbWKSNjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 08:39:46 -0500
Received: from mout1.freenet.de ([194.97.50.132]:52877 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1756666AbWKSNjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 08:39:45 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
Date: Sun, 19 Nov 2006 15:39:41 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061118163032.GA14625@elte.hu>
In-Reply-To: <20061118163032.GA14625@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191539.42023.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Boot bugs happening here on fc6 running locally compiled 2.6.19-rc-rt
UP i386 kernels on a K8.
They happen on some boots, some are ok.
If bug happens, boot seams to stop after the
"for interactive setup , press 'I'" sort of message
and continues after I enter control+c.
Next message after that is about the time having been set.
If bug happened, the time is incorrectly set mostly to 3600s
in the future.

This is the last part of SysRq+T right after such a bug happened:

 =======================
init          S [f7e6d000] F7EB1F60     0   296      1   297           286 (NOTLB)
       f7eb1f28 00000086 c014928e f7eb1f60 f7fb07b8 c191d6c4 f7eeb1a0 c191d600
       00000007 f7e6d12c f7e6d000 d4b9b4a7 00000007 0000262b c014a6ab f6867568
       00018a21 00000000 f7fc1000 00000001 f7eb1f88 f7eb1f40 c02ca94b f7feee00
Call Trace:
 [<c014928e>] do_wp_page+0x34a/0x395
 [<c014a6ab>] __handle_mm_fault+0x7b9/0x7db
 [<c02ca94b>] schedule+0xcd/0xe9
 [<c0118903>] eligible_child+0x9f/0xb0
 [<c0119d53>] do_wait+0x9f1/0xacd
 [<c0114409>] default_wake_function+0x0/0x16
 [<c0119e60>] sys_wait4+0x31/0x34
 [<c0119e8a>] sys_waitpid+0x27/0x2b
 [<c0102e49>] sysenter_past_esp+0x56/0x79
 =======================
rc.sysinit    S [f7fc1000] FF889000     0   297    296   322               (NOTLB)
       f7e76f28 00000086 c01492cf ff889000 08113fcc f6873860 f7fee600 c17f5760
       00000006 f7fc112c f7fc1000 dd1e3416 00000008 0000df7d c014a642 f687744c
       011543fb 00000000 f7e7baa0 00000001 f7e76f88 f7e76f40 c02ca94b f7fee600
Call Trace:
 [<c01492cf>] do_wp_page+0x38b/0x395
 [<c014a642>] __handle_mm_fault+0x750/0x7db
 [<c02ca94b>] schedule+0xcd/0xe9
 [<c0118903>] eligible_child+0x9f/0xb0
 [<c0119d53>] do_wait+0x9f1/0xacd
 [<c012fd91>] rt_down+0xe/0x25
 [<c0114409>] default_wake_function+0x0/0x16
 [<c0119e60>] sys_wait4+0x31/0x34
 [<c0119e8a>] sys_waitpid+0x27/0x2b
 [<c0102e49>] sysenter_past_esp+0x56/0x79
 =======================
hwclock       R [f7e7baa0] F6873224 [on rq #0]     0   322    297                     (NOTLB)
       c1902fb4 00003086 f7fee434 f6873224 f7fee434 c02cd498 00000000 00000000
       00000001 f7e7bbcc f7e7baa0 795f1ab5 0000000d 003cda22 c02e8fc2 00000004
       4e8951e9 00000002 00240384 00000000 00000000 c1902000 c0102f22 00240384
Call Trace:
 [<c02cd498>] do_page_fault+0x2b9/0x552
 [<c0102f22>] work_resched+0x6/0x19
 =======================

work_resched sits in entry.S:

work_resched:
	DISABLE_INTERRUPTS
	call __schedule
					# make sure we don't miss an interrupt
					# setting need_resched or sigpending
					# between sampling and the iret
	movl TI_flags(%ebp), %ecx
	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
					# than syscall tracing?
	jz restore_all
	testl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED), %ecx
	jnz work_resched

The hwclock page_fault happens at the
 	movl TI_flags(%ebp), %ecx
line.

Will try the yum repo kernel next.

      Karsten

