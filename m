Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263949AbUKZV4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbUKZV4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbUKZTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:51:05 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:61899 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S262420AbUKZT3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:33 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Badari Pulavarty <pbadari@us.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
Date: Fri, 26 Nov 2004 02:21:49 +0900
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
References: <419CACE2.7060408@in.ibm.com> <41A20DB5.2050302@in.ibm.com> <1101170617.4987.268.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1101170617.4987.268.camel@dyn318077bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411260221.49888.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 09:43, Badari Pulavarty wrote:
> gdb is not showing the stack info properly, on my saved vmcore.
> I thought vmlinux is not matching the vmcore, so I verified that
> vmcore and vmlinux matchup. But still no luck...
>
> # gdb  ../linux-2.6.9/vmlinux vmcore.2

[...]

> (gdb) bt
> #0  default_idle () at arch/i386/kernel/process.c:108
> #1  0xc04cdff8 in init_thread_union ()
> #2  0xc0101b86 in cpu_idle () at arch/i386/kernel/process.c:196
> #3  0xc04cea20 in start_kernel () at init/main.c:523
> #4  0xc0100211 in L6 () at /tmp/cch2z2jk.s:2054
> Cannot access memory at address 0x550007


I think the panic was happened on the CPU except for CPU#0.

Currently vmcore contains only CPU#0's register contents.
Therefore, GDB always shows backtrace of CPU#0.


fs/proc/vmcore.c:

static void elf_vmcore_store_hdr(char *bufp, int nphdr, int dataoff)
{
...
        /* 1 - Get the registers from the reserved memory area */
        reg_ppos = BACKUP_END + CRASH_RELOCATE_SIZE;
        read_from_oldmem(reg_buf, REG_SIZE, &reg_ppos, 0);
        elf_core_copy_regs(&prstatus.pr_reg, (struct pt_regs *)reg_buf);
        buf = storenote(&notes[0], buf);


In this place, "reg_ppos" is the pointer to the copy of relocated
crash_smp_regs[0].
kdump should save the "crash_smp_regs[**panic_cpu**]".

Or, it is better to save all crash_smp_regs[NR_CPUS].
In other words:

# readelf --note /proc/vmcore

Notes at offset 0x00000074 with length 0x0000069c:
  Owner         Data size       Description
  CORE          0x00000090      NT_PRSTATUS (prstatus structure)
  CORE          0x0000007c      NT_PRPSINFO (prpsinfo structure)
  CORE          0x00000560      NT_TASKSTRUCT (task structure)
  :
  :
  :
  ...(repeat NR_CPU times)




