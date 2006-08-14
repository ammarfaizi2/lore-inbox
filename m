Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752063AbWHNU76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWHNU76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWHNU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:59:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10894 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752063AbWHNU7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:59:54 -0400
Date: Mon, 14 Aug 2006 16:59:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>,
       fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060814205921.GE2519@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com> <20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com> <20060814181118.GB2519@in.ibm.com> <44E0CFD0.3060506@zytor.com> <20060814194252.GC2519@in.ibm.com> <44E0D2DB.7030003@zytor.com> <m18xlrt6wk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xlrt6wk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 02:10:51PM -0600, Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > Vivek Goyal wrote:
> >>>>
> >>> What about once the kernel is booted?
> >> Sorry did not understand the question. Few more lines will help.
> >>
> >
> > Is this field intended to protect any kind of memory during the early boot phase
> > of the kernel proper, or only the decompressor?
> 
> Yes, the field should account for memory usage until the kernel starts
> doing the accounting at run time.
> 
> I'm actually surprised that taking into account the .bss was not enough to
> cover up anything the decompressor was doing.  Usually the kernel's .bss
> is more than the extra 32K or so that the decompressor uses.
>

I think .bss section size will act as a buffer for decompressor only if
.bss is not part of compressed data hence decompressor does not have to
move beyond bss and it can run very well from kernel bss space. 

But somehow on my machine, it looks like that bss is very much part
of raw binary image hence part of compressed data (vmlinux.bin.gz).
memsz exported in bzImage is same as size of raw output binary.

Probably that's the reason that we are stomping other segments in my
case and if my understanding is right then it should happen irrespective
of kernel bss size.

Here I am pasting how kernel vmlinux file program headers look like.
.bss is mapped by first program header along with .text.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000200000 0xffffffff80000000 0x0000000000000000
                 0x0000000000546bf8 0x00000000005dbc28  RWE    200000
  LOAD           0x00000000007dc000 0xffffffff805dc000 0x00000000005dc000
                 0x000000000000ede0 0x000000000000ede0  RW     200000
  LOAD           0x0000000000800000 0xffffffffff600000 0x00000000005eb000
                 0x0000000000000c08 0x0000000000000c08  RWE    200000
  LOAD           0x00000000009ec000 0xffffffff805ec000 0x00000000005ec000
                 0x0000000000044004 0x0000000000044004  RWE    200000
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RWE    8

 Section to Segment mapping:
  Segment Sections...
   00     .text __ex_table .rodata .pci_fixup __ksymtab __ksymtab_gpl
__ksymtab_unused __ksymtab_gpl_future __ksymtab_strings __param
.eh_frame .data .bss
   01     .data.cacheline_aligned .data.read_mostly
   02     .vsyscall_0 .xtime_lock .vxtime .wall_jiffies .sys_tz
.sysctl_vsyscall .xtime .jiffies .vsyscall_1 .vsyscall_2 .vsyscall_3
   03     .data.init_task .data.page_aligned .smp_altinstructions
.smp_locks .smp_altinstr_replacement .init.text .init.data .init.setup
.initcall.init .con_initcall.init .altinstructions .altinstr_replacement
.exit.text .init.ramfs .data.percpu .data_nosave
   04
 
Thanks
Vivek
 
