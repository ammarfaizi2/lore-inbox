Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUHWP6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUHWP6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUHWPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:51:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:740 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265805AbUHWPso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:48:44 -0400
Date: Mon, 23 Aug 2004 08:46:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: rjw@sisk.pl, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4 (strange behavior on dual Opteron w/ NUMA)
Message-Id: <20040823084640.1195f4f3.rddunlap@osdl.org>
In-Reply-To: <798.1093274973@redhat.com>
References: <200408221620.00692.rjw@sisk.pl>
	<20040822013402.5917b991.akpm@osdl.org>
	<798.1093274973@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 16:29:33 +0100 David Howells wrote:

| 
| Rafael J. Wysocki <rjw@sisk.pl> wrote:
| > It has the same problems that I've reported for 2.6.8.1-mm3:
| > 
| > 1) ALT-SysRq-<command key> does not work, although "echo <command> > 
| > /proc/sysrq-trigger" does (may be specific to x86-64).
| 
| I'm seeing this on my Dual PPro testbox too. I'm running 2.6.8.1-mm4 using the
| i386 arch. I get an oops (which I've attached) from SysRq+B and from normal
| reboot.
| 
| > 2) After issuing:
| > 
| > # rmmod snd_seq_oss
| > 
| > the kernel goes into a strange state:
| 
| And that too; except that I'm seeing it with NFS and modules of my own
| devising. I've attached an excerpt of a SysRq trace of this. Note that it
| doesn't start executing the module exit function as far as I can tell.
| 
| Both these problems are 100% reproducible.
| 
| David
| 
| 
| ===========
| REBOOT OOPS
| ===========

This oops is fixed by this trivial patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109313574928853&w=2

| nfsd: last server has exited
| nfsd: unexporting all filesystems
| Restarting system.
| Unable to handle kernel paging request at virtual address c041a3e0
|  printing eip:
| c041a3e0
| *pde = 00463027
| *pte = 0041a000
| Oops: 0000 [#1]
| SMP DEBUG_PAGEALLOC
| Modules linked in: nfs cachefs
| CPU:    0
| EIP:    0060:[<c041a3e0>]    Not tainted VLI
| EFLAGS: 00010282   (2.6.8.1-mm4) 
| EIP is at find_isa_irq_pin+0x0/0x70
| eax: 00000003   ebx: 00000000   ecx: 000100fe   edx: 00000000
| esi: 01234567   edi: c4d6c000   ebp: c4d6c000   esp: c4d6de60
| ds: 007b   es: 007b   ss: 0068
| Process reboot (pid: 2751, threadinfo=c4d6c000 task=c5527a40)
| Stack: c011227f 00000000 00000003 00000000 00000001 00000000 c010ebc8 00000000 
|        c4d6c000 c010ebe9 01234567 c4d6c000 c011c167 c0351071 00000000 c012ba1d 
|        00000000 00000001 00000000 c10bb7c0 00000001 00000000 c01452ef c10bb7c0 
| Call Trace:
|  [<c011227f>] disable_IO_APIC+0x1f/0x140
|  [<c010ebc8>] machine_shutdown+0x48/0x60
|  [<c010ebe9>] machine_restart+0x9/0x90
|  [<c011c167>] printk+0x17/0x20
|  [<c012ba1d>] sys_reboot+0x19d/0x400
|  [<c01452ef>] cache_free_debugcheck+0x17f/0x2b0
|  [<c02d41fb>] sock_destroy_inode+0x1b/0x20
|  [<c02d41fb>] sock_destroy_inode+0x1b/0x20
|  [<c017dc65>] destroy_inode+0x35/0x60
|  [<c017f67e>] generic_forget_inode+0x14e/0x1c0
|  [<c01452ef>] cache_free_debugcheck+0x17f/0x2b0
|  [<c017f773>] iput+0x63/0x90
|  [<c017abd3>] dput+0x33/0x340
|  [<c0160168>] __fput+0xa8/0x110
|  [<c0160170>] __fput+0xb0/0x110
|  [<c015e5d9>] filp_close+0x59/0x90
|  [<c015e68f>] sys_close+0x7f/0x100
|  [<c0113ae0>] do_page_fault+0x0/0x5c0
|  [<c010459f>] syscall_call+0x7/0xb
| Code:  Bad EIP value.
|  Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:167
|  [<c010f5c4>] send_IPI_mask_bitmask+0x74/0x80
|  [<c010f9df>] smp_send_reschedule+0x1f/0x30
|  [<c01155b0>] try_to_wake_up+0x2b0/0x2e0
|  [<c0117041>] __wake_up_common+0x41/0x70
|  [<c01170bb>] __wake_up+0x4b/0xb0
|  [<c012e44f>] __queue_work+0x5f/0xc0
|  [<c012e505>] queue_work+0x55/0x70
|  [<c012e3c9>] call_usermodehelper+0xc9/0xd6
|  [<c012e290>] __call_usermodehelper+0x0/0x70
|  [<c02565ef>] sprintf+0x1f/0x30
|  [<c0253486>] kset_hotplug+0x1f6/0x290
|  [<c0253587>] kobject_hotplug+0x67/0x70
|  [<c02538fb>] kobject_del+0x1b/0x40
|  [<c02875d9>] class_device_del+0x99/0xc0
|  [<c0287613>] class_device_unregister+0x13/0x30
|  [<c0287c53>] class_simple_device_remove+0xa3/0x127
|  [<c026d42c>] vcs_remove_devfs+0x1c/0x39
|  [<c0275145>] con_close+0x85/0x90
|  [<c0263a1d>] release_dev+0x6ad/0x6d0
|  [<c01452a1>] cache_free_debugcheck+0x131/0x2b0
|  [<c014f3da>] remove_vm_struct+0x8a/0xd0
|  [<c0263f95>] tty_release+0x45/0xc0
|  [<c010f829>] flush_tlb_mm+0x49/0xa0
|  [<c01601be>] __fput+0xfe/0x110
|  [<c015e5d9>] filp_close+0x59/0x90
|  [<c011da54>] put_files_struct+0x64/0xd0
|  [<c011ea90>] do_exit+0x1f0/0x590
|  [<c015f361>] sys_read+0x51/0x80
|  [<c011ee63>] sys_exit+0x13/0x20
|  [<c010459f>] syscall_call+0x7/0xb
| 
| 
| =====================
| RMMOD SYSRQ+T EXCERPT
| =====================
| 
| rmmod         D C0341C03     0  2010   1932                     (NOTLB)
| c4737e80 00000082 00000002 c0341c03 c4737ec4 c012e505 c4737e64 0dfec5b1 
|        00000007 3e5a438a 00015b43 c41fddb0 15b433e8 00000000 c1104f60 c3c72bec 
|        c01150a5 c3d95a40 c11054ac c4737f04 c4737f08 c4737ec0 c4737ee8 c0341c03 
| Call Trace:
|  [<c0341c03>] wait_for_completion+0xb3/0x1a0
|  [<c012e505>] queue_work+0x55/0x70
|  [<c01150a5>] activate_task+0xf5/0x120
|  [<c0341c03>] wait_for_completion+0xb3/0x1a0
|  [<c0116fe0>] default_wake_function+0x0/0x20
|  [<c0116fe0>] default_wake_function+0x0/0x20
|  [<c01155fd>] wake_up_process+0x1d/0x30
|  [<c0139b3c>] __stop_machine_run+0x9c/0xc0
|  [<c0138e80>] __try_stop_module+0x0/0x41
|  [<c0139b7f>] stop_machine_run+0x1f/0x38
|  [<c0138e80>] __try_stop_module+0x0/0x41
|  [<c01360d8>] try_stop_module+0x38/0x40
|  [<c0138e80>] __try_stop_module+0x0/0x41
|  [<c01362a2>] sys_delete_module+0x122/0x180
|  [<c01212ea>] __do_softirq+0xba/0xd0
|  [<c01103dd>] smp_apic_timer_interrupt+0x8d/0x100
|  [<c010456c>] system_call+0x0/0x2c
|  [<c010459f>] syscall_call+0x7/0xb
| kstopmachine  R running     0  2011      6  2012            36 (L-TLB)
| kstopmachine  R running     0  2012   2011                     (L-TLB)
| -


--
~Randy
