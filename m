Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWEOUcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWEOUcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEOUcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:32:12 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:60583 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751341AbWEOUcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:32:10 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: [FIXED] Re: Total machine lockup w/ current kernels while installing from CD
Date: Mon, 15 May 2006 22:32:03 +0200
User-Agent: KMail/1.9.1
References: <200605110322.14774.bero@arklinux.org>
In-Reply-To: <200605110322.14774.bero@arklinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152232.04304.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 11. May 2006 03:22, Bernhard Rosenkraenzer wrote:
> Hi,
> I've built a CD that installs a customized system
> [... crash at a random point ...]
> BUG: soft lockup detected on CPU#0!
>
> Pid: 421, comm: kjournald
> EIP: 0060:[<b01a2f52>] CPU: 0
> EIP is at journal_commit_transaction+0x92e/0xfcc
> EFLAGS: 00000297 Not tainted (2.6.16-rc6 #1)
> EAX: 00000001 EBX: c2d34788 ECX: 00000001 EDX: c785e000
> ESI: b3ff8d04 EDI: 000000f0 EBP: b683b840 DS: 007b ES: 007b
> CR0: 8005003b CR2: 0841f7fc CR3: 17217000 CR4: 000006d0
>  [<b02bd52e>] schedule+0x2ee/0x5b6
>  [<b01a6a88>] kjournald+0x201/0x213
>  [<b0111089>] smp_apic_timer_interrupt+0x32/0x49
>  [<b01a6937>] kjournald+0xb0/0x213
>  [<b01a5ffa>] commit_timeout+0x0/0x9
>  [<b012a789>] autoremove_wake_function+0x0/0x4b
>  [<b01a6887>] kjournald+0x0/0x213
>  [<b0101005>] kernel_thread_helper+0x5/0xb

After backing out lots of changes, I've figured out the problem is caused by 
this bit of 2.6.16-rc6:

diff -urN linux-2.6.16-rc5/kernel/sched.c linux-2.6.16-rc6/kernel/sched.c
--- linux-2.6.16-rc5/kernel/sched.c	2006-05-11 20:04:18.000000000 +0200
+++ linux-2.6.16-rc6/kernel/sched.c	2006-05-11 20:00:00.000000000 +0200
@@ -4028,6 +4021,8 @@
 	 */
 	if (unlikely(preempt_count()))
 		return;
+	if (unlikely(system_state != SYSTEM_RUNNING))
+		return;
 	do {
 		add_preempt_count(PREEMPT_ACTIVE);
 		schedule();


The problem is that (to save a couple of bits of space), my simple installer 
was running inside an initrd -- and system_state isn't set to SYSTEM_RUNNING 
before linuxrc is executed --> scheduler breakage causes the oops.

Since initrds are deprecated anyway, I've used this opportunity to update the 
installer to use initramfs instead, and as expected, the problem went away -- 
nevertheless [unless initrds are being removed in 2.6.18 anyway] we should 
probably fix this or at least document it somewhe.
