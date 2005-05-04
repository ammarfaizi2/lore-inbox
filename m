Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVEDFB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVEDFB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 01:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVEDFB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 01:01:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48741
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262021AbVEDFB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 01:01:27 -0400
Date: Wed, 4 May 2005 07:01:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: avoid infinite loop in x86_64 interrupt return
Message-ID: <20050504050132.GA3899@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A few minutes ago I've got an unkillable task in R state with vanilla
2.6.12-rc3 on x86_64, luckily system was still up with the other cpu (on
the desktop, so I had no kgdb environment set). Debugging revelaed rdi
corrupt when entering retint_signal (not set to $_TIF_WORK_MASK as
expected). This lead the rdx&rdi to return 0x20000 -> infinite loop.
Precisely rdi is set to ffff810030923f58 instead of $_TIF_WORK_MASK. So
it was the combination of ...2xxxx as rsp with TIF_IA32 in the task
flags. After noticing the rdi screwup the bug was quite clear: rdi was
set to pt_regs instead of $_TIF_WORK_MASK. Of course rsp is set to
ffff810030923f58 too (which also means do_notify_resume didn't clobber
rdi even if it could).

The below should fix the problem, I've no idea how to reproduce the
problem but it works on basic testing. The task looping was java (32bit,
that's where the 0x20000 come from), but it wasn't me starting java, it
must have been some random website (java was hanging around with 100%
system time for half an hour once I noticed it).

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- 2.6.12-rc3/arch/x86_64/kernel/entry.S.orig	2005-05-04 06:47:02.000000000 +0200
+++ 2.6.12-rc3/arch/x86_64/kernel/entry.S	2005-05-04 06:50:34.000000000 +0200
@@ -489,6 +489,7 @@ retint_signal:
 	movq %rsp,%rdi		# &pt_regs
 	call do_notify_resume
 	RESTORE_REST
+	movl $_TIF_WORK_MASK,%edi
 	cli
 	GET_THREAD_INFO(%rcx)	
 	jmp retint_check
