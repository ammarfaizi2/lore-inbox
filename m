Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVGGExc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVGGExc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 00:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVGGExb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 00:53:31 -0400
Received: from adsl-67-39-48-196.dsl.milwwi.ameritech.net ([67.39.48.196]:8167
	"EHLO mail.wit.org") by vger.kernel.org with ESMTP id S262138AbVGGExb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 00:53:31 -0400
Message-ID: <42CCB662.6030405@linuxmachines.com>
Date: Wed, 06 Jul 2005 21:58:10 -0700
From: Jeff Carr <jcarr@linuxmachines.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Keith Owens <kaos@sgi.com>
Subject: Re: A correct method to use the x86 breakpoint registers (DR0-7)
References: <42CAB369.5020901@linuxmachines.com>
In-Reply-To: <42CAB369.5020901@linuxmachines.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I setup KDB with 2.6.13-rc1. It works well. continuing past a BUG() is
potentially very useful. Well, it's at least fun to see it happen :)

I wanted to set the BR0/7 registers from within running code. I thought
that would trigger KDB, but it doesn't. It seems that the breakpoint
trap is passed through the kernel and into userspace and caught by
glibc. I tried to track this down, but am lost in how or where a int3
actually is handled.

I looked through the Documentation/kdb/ man pages (they are nice) but
didn't see anything on how one might register a breakpoint with KDB from
 some exported function.

The kprobe guys have a patch that I can use to try to solve my problem
(described below), but I thought I would try kdb some more before I
switched to trying kprobe.

Thanks,
Jeff

BTW, I don't know enough about kbuild, but if it is possible, you might
want to force CONFIG_KPROBE off when you have kdb enabled or you get
duplicate do_int3() functions defined in arch/i386/traps.c



On 07/05/2005 09:20 AM, Jeff Carr wrote:
> I'm trying to set the x86 breakpoint registers to trip on write data.
> 
> After they are set, nothing seems to happen when I trigger them.
> 
> It's possible I'm not setting them correctly, I tried putting the
> virt_to_phys() value in them. And, I tried looking at what KPROBE puts
> in them, but it looks like kprobe doesn't use them at all.
> 
> In 2.6.11, arch/i386/ has 5 places where it modifies the db regs:
> 	do_debug()              in traps.c    (??)
> 	do_signal()             in signal.c   (re-enable them)
> 	fix_processor_context() in cpu.c      (reload them)
> 	__switch_to()		in process.c  (reload them)
> 	cpu_init()		in common.c   (clears them)
> 
> Just FYI: sometime after 2.6.11, the macros get_debugreg() and
> set_debugreg() were defined in include/asm-i386/processor.h and set to
> be used in the 5 places above. In any case, the functionality seems the
> same the above routines. (And the registers names corrected s/db/dr/g )
> 
> In any case, setting these registers never seems to do anything. No INT3
> or INT1 (is it really supposed to generate an interrupt?) Perhaps I need
> to have kgdb setup.
> 
> The closest I can get to making anything happen is if I set bit 13 of
> DR7 (triggers on the next access of the breakpoint registers) then when
> I insmod I get:
> 
> root@foxtrot:~/dbregtest# insmod ./dbregtest.ko
> Trace/breakpoint trap
> root@foxtrot:~/dbregtest#
> 
> If I set BR0 with the value from virt_to_phys() I don't get this
> trace/breakpoint trap.
> 
> Enjoy,
> Jeff
> 
> // Current documentation for these registers is in Vol 3 Section 15.2:
> // Also note: EFLAGS BIT 16 (Resume) section 2.3 disables #DB exceptions
> // http://developer.intel.com/design/pentium4/manuals/index_new.htm
> 
> static int __init db_reg_test(void)
> {
>         u32 *i;
>         unsigned int phys_addr;
> 
>         i = kmalloc( 0x1000, GFP_DMA );
>         printk("i == 0x%08X\n", (int) i);
>         phys_addr = virt_to_phys(i);
> 
>         printk("virt_to_phys(i)  == 0x%08X\n", (int) phys_addr);
>         __asm__ __volatile__( "movl %0, %%dr0\n" : : "r" (phys_addr) );
> 
>         // clear out the DR6 status register
>         __asm__ __volatile__( "movl %0, %%dr6\n" : : "r" (0xFFFF0FF0) );
> 
>         // Enable DR0 as a global breakpoint
>         __asm__ __volatile__( "movl %0, %%dr7\n" : : "r" (0x00030002) );
> 
>         // Enables all four BR registers as global breakpoints
>         __asm__ __volatile__( "movl %0, %%dr7\n" : : "r" (0x333300AA) );
> 
>         // shouldn't this trigger a breakpoint exception?
>         i[0] = 0xDEADBEEF;
> 
>         kfree(i);
> 
> 	// this will correctly trigger a breakpoint
> 	// __asm__ ( "movl %0, %%dr7\n" : : "r" (0x333320AA) );
>         // __asm__ ( "movl %0, %%dr7\n" : : "r" (0x333300AA) );
>         return 0;
> }
> 
> module_init(db_reg_test);
> 
> root@foxtrot:~/dbregtest# tail /var/log/kern.log
> Jul  5 09:01:16 localhost kernel: i == 0xC046E000
> Jul  5 09:01:16 localhost kernel: virt_to_phys(i)  == 0x0046E000
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

