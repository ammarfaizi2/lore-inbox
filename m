Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267838AbUHRVuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267838AbUHRVuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUHRVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:50:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54256 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267838AbUHRVtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:49:52 -0400
Subject: Re: 2.6.8.1-mm1
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1092791073.27352.183.camel@bach>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	 <1092722342.3081.68.camel@booger> <20040817113839.GB7005@in.ibm.com>
	 <20040817105322.6f596061.akpm@osdl.org>  <1092791073.27352.183.camel@bach>
Content-Type: text/plain
Message-Id: <1092850612.2995.162.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 12:36:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 20:04, Rusty Russell wrote:
> Name: Don't Sleep After We're Out Of Task List
> Status: Booted on 2.6.8.1-mm1
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)
> Version: -mm

I tried this and I see might_sleep warnings from proc_pid_flush during
boot and during the test:

Debug: sleeping function called from invalid context at
fs/proc/base.c:1532
in_atomic():1, irqs_disabled():0
 [<c0108317>] dump_stack+0x17/0x20
 [<c0123196>] __might_sleep+0xb6/0xe0
 [<c01a2985>] proc_pid_flush+0x15/0x40
 [<c0128066>] release_task+0x1a6/0x270
 [<c011f49c>] finish_task_switch+0xac/0xe0
 [<c041acea>] schedule+0x53a/0xa70
 [<c041be29>] schedule_timeout+0xb9/0xc0
 [<c0180ebe>] do_select+0x18e/0x2f0
 [<c01812e3>] sys_select+0x293/0x4e0
 [<c010746f>] syscall_call+0x7/0xb

And I still hit the same BUG_ON when running the test:

kernel BUG at kernel/sched.c:4038!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0122b2b>]    Not tainted VLI
EFLAGS: 00010202   (2.6.8.1-mm1) 
EIP is at migration_call+0x1bb/0x300
eax: 00000001   ebx: c1410f60   ecx: 00000000   edx: dea71ec8
esi: dea71000   edi: 00000001   ebp: dea71ee0   esp: dea71eb8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 2956, threadinfo=dea71000 task=de4f0210)
Stack: dea71ed4 de4f07f0 de4f07f0 dea71ed4 00000296 dea71ee4 00000296 c04a5b78 
       00000001 00000006 dea71ef4 c01368c8 dea71000 00000001 c04a7a40 dea71f2c 
       c014054c c01a8d19 c04f5700 00000000 dea71000 00000001 00000001 000000ff 
Call Trace:
 [<c01082ea>] show_stack+0x7a/0x90
 [<c0108472>] show_registers+0x152/0x1c0
 [<c01086a0>] die+0x110/0x200
 [<c0108b99>] do_invalid_op+0xe9/0xf0
 [<c0107ed9>] error_code+0x2d/0x38
 [<c01368c8>] notifier_call_chain+0x28/0x50
 [<c014054c>] cpu_down+0x11c/0x230
 [<c02a5d38>] store_online+0x38/0x40
 [<c02a30b7>] sysdev_store+0x37/0x40
 [<c01a8b2e>] flush_write_buffer+0x2e/0x40
 [<c01a8b8a>] sysfs_write_file+0x4a/0x60
 [<c016b302>] vfs_write+0xa2/0x100
 [<c016b411>] sys_write+0x41/0x70
 [<c010746f>] syscall_call+0x7/0xb
Code: 0b d0 0f 0f 54 43 c0 eb 8e c7 04 24 0f 34 43 c0 b8 64 2a 12 c0 89 44 24 04
 e8 e2 3f 00 00 0f 0b 89 00 22 d4 42 c0 e9 4a ff ff ff <0f> 0b c6 0f 0f 54 43 c0
 e9 2c ff ff ff e8 e3 86 2f 00 e9 17 ff 

Anything else I can try?

Nathan


