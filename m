Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUB0Tci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUB0Tci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:32:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:50827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262996AbUB0Tce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:32:34 -0500
Date: Fri, 27 Feb 2004 11:32:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: r3pek@r3pek.homelinux.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: kexec "problem" [and patch updates]
Message-Id: <20040227113224.72f6dcc5.rddunlap@osdl.org>
In-Reply-To: <m1znb5c5q3.fsf@ebiederm.dsl.xmission.com>
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
	<20040226165446.16a5bb3b.rddunlap@osdl.org>
	<m1znb5c5q3.fsf@ebiederm.dsl.xmission.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 2004 01:00:04 -0700 Eric W. Biederman wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> writes:
| 
| > On Tue, 24 Feb 2004 11:02:21 -0000 (WET) Carlos Silva wrote:
| > 
| > | hi guys,
| > | 
| > | i have just compiled a kernel with the kexec patch. compiled kexec-tools
| > | and when i try to load a kernel, it gives me this:
| > | # ./do-kexec.sh /boot/bzImage-2.6.2-g
| > | kexec_load failed: Invalid argument
| > | entry       = 0x91764
| > | nr_segments = 2
| > | segment[0].buf   = 0x80b3480
| > | segment[0].bufsz = 1880
| > | segment[0].mem   = 0x90000
| > | segment[0].memsz = 1880
| > | segment[1].buf   = 0x40001008
| > | segment[1].bufsz = 19795a
| > | segment[1].mem   = 0x100000
| > | segment[1].memsz = 19795a
| > | 
| > | anyone tried to run kexec and actually did it? i'm trying with kernel 2.6.3
| > | -
| > 
| > I updated the kexec patch for 2.6.2 and 2.6.3.
| > It works fine on 2.6.2.  It works for me on 2.6.3 if not SMP.
| > If the kernel is built for SMP, when running kexec, I get a
| > BUG in arch/i386/kernel/smp.c at line 359.
| > I'm testing various workarounds for that BUG now.
| 
| I will eyeball it...
| 
| Is it the kernel that is shutting down, or the kernel that is being
| brought up that has problems?

the kernel that is shutting down.

| The back trace from the BUG would be interesting.

see below.  my bad.  i should have included it.

| As I see it flush_tlb_others is being called when we have shutdown
| cpus and the kernel still thinks we have the mm present on foreign
| cpus.

Martin Bligh thinks that there is a tlb race here.
I printed the 2 cpu masks on my dual-proc macine and saw
0 in one of them and 0xc in the other one.

| So it appears we simply have a case that was not anticipated
| by the authors of that code.  So we need to adjust either
| the code we are calling or cpu_vm_mask so it does not list
| other cpus after we have shut them down.
| 
| At least that it what it looks like at first glance.

Thanks,
--
~Randy


Feb 25 15:52:21 gargoyle kernel: ------------[ cut here ]------------
Feb 25 15:52:21 gargoyle kernel: kernel BUG at arch/i386/kernel/smp.c:359!
Feb 25 15:52:21 gargoyle kernel: invalid operand: 0000 [#1]
Feb 25 15:52:21 gargoyle kernel: CPU:    1
Feb 25 15:52:21 gargoyle kernel: EIP:    0060:[<c011673d>]    Not tainted
Feb 25 15:52:21 gargoyle kernel: EFLAGS: 00010206
Feb 25 15:52:21 gargoyle kernel: EIP is at flush_tlb_others+0x141/0x15c
Feb 25 15:52:21 gargoyle kernel: eax: 00000000   ebx: c043c9e0   ecx: c043c9e0   edx: 0000000c
Feb 25 15:52:21 gargoyle kernel: esi: f53effc4   edi: 00851da8   ebp: f5449ebc   esp: f5449ea8
Feb 25 15:52:21 gargoyle kernel: ds: 007b   es: 007b   ss: 0068
Feb 25 15:52:21 gargoyle kernel: Process kexec (pid: 1095, threadinfo=f5448000 task=f54719b0)
Feb 25 15:52:21 gargoyle kernel: Stack: f5449ed4 c014eae3 c1851d58 353f0000 00000000 f5449ed4 c01167e9 0000000c 
Feb 25 15:52:21 gargoyle kernel:        c043c9e0 ffffffff 0000000c f5449f20 c0150084 c043c9e0 f61d7610 003f1000 
Feb 25 15:52:21 gargoyle kernel:        003f1000 35000000 35000000 00400000 c0101354 c043ca14 c043c9e0 353f1000 
Feb 25 15:52:21 gargoyle kernel: Call Trace:
Feb 25 15:52:21 gargoyle kernel:  [<c014eae3>] pte_alloc_map+0xd9/0x12e
Feb 25 15:52:21 gargoyle kernel:  [<c01167e9>] flush_tlb_mm+0x47/0x8c
Feb 25 15:52:21 gargoyle kernel:  [<c0150084>] remap_page_range+0x1ae/0x218
Feb 25 15:52:21 gargoyle kernel:  [<c013dae7>] identity_map_pages+0xf7/0x130
Feb 25 15:52:21 gargoyle kernel:  [<c013dbd4>] kimage_alloc_reboot_code_pages+0xb4/0x164
Feb 25 15:52:21 gargoyle kernel:  [<c013d928>] kimage_alloc+0x100/0x186
Feb 25 15:52:21 gargoyle kernel:  [<c013e496>] sys_kexec_load+0x9c/0xff
Feb 25 15:52:21 gargoyle kernel:  [<c0109637>] syscall_call+0x7/0xb
Feb 25 15:52:21 gargoyle kernel: 
Feb 25 15:52:21 gargoyle kernel: Code: 0f 0b 67 01 ee df 3d c0 e9 d7 fe ff ff 0f 0b 64 01 ee df 3d 
