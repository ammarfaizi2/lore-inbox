Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRIDTYT>; Tue, 4 Sep 2001 15:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIDTYK>; Tue, 4 Sep 2001 15:24:10 -0400
Received: from bgm-24-95-140-16.stny.rr.com ([24.95.140.16]:7165 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268017AbRIDTXx>; Tue, 4 Sep 2001 15:23:53 -0400
Date: Tue, 4 Sep 2001 15:28:46 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: <rostedt@localhost.localdomain>
Reply-To: Steven Rostedt <srostedt@stny.rr.com>
To: <ebuddington@wesleyan.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac5: acpi BUG
In-Reply-To: <20010904150238.A128@ma-northadams1a-387.bur.adelphia.net>
Message-ID: <Pine.LNX.4.33.0109041521180.19465-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just had a similar experience, and also posted to this list (today!).

I noticed that the acpi interrupt handler ec_gpe_handler eventually
calls kmalloc with the GFP_KERNEL flag.  The reason this is a problem
is that kmalloc may call schedule, and you can't do that in an
interrupt. But my failed in slab.c where kmalloc checks to see if
it is not in an interrupt.  So this may not be your problem per se.

The quick fix here is to change:

drivers/acpi/os.c : acpi_os_allocate

change GFP_KERNEL to GFP_ATOMIC


See if this works.
There probably should be more than this to fix the problem,
but I don't know the acpi driver well enough to do so.

-- Steve.

On Tue, 4 Sep 2001, Eric Buddington wrote:

> Andy and whoever else cares,
>
> This is similar (identical?) to previous failures I've had. This is
> 100% repeatable, even with acpi=off. The system is a K6-II. I have an
> almost identical kernel running on my PII Omnibook with no such
> problem.
>
> -Eric
>
> -------------------------------------------------
> ksymoops 2.4.1 on i586 2.4.3-ac3.  Options used
>      -V (default)
>      -K (specified)
>      -L (specified)
>      -o /packages/linux/2.4.9-ac5/k6/lib/modules/2.4.9-ac5 (specified)
>      -m /packages/linux/2.4.9-ac5/k6/boot/System.map (specified)
>
> No modules in ksyms, skipping objects
> kernel BUG at sched.c:712!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0113e2d>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010082
> eax: 0000001b   ebx: c1218000   ecx: 00000001   edx: 00000ae6
> esi: c1219dc0   edi: c0190340   ebp: c1219d84   esp: c1219d58
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=c1219000)
> Stack: c024b86f 000002c8 c024b856 c1219dc0 c1218000 00000000 c1218000 00000711
>        c1218000 c1219dc0 c0190340 c1219e7c c0106f45 00000711 c0189b10 c7fa2540
>        c1219dc0 c0190340 c1219e7c 00000008 00000018 00000018 00000078 c01054ed
> Call Trace: [<c0190340>] [<c0106f45>] [<c0189b10>] [<c0190340>] [<c01054ed>]
>    [<c0189c5e>] [<c0189b10>] [<c0189d9c>] [<c019039a>] [<c0190340>] [<c018fc2f>]
>    [<c018fba8>] [<c0190cdb>] [<c01895fc>] [<c0108329>] [<c01895f0>] [<c01084b6>]
>    [<c010a6c4>] [<c018973a>] [<c0192d0a>] [<c01927ed>] [<c0192447>] [<c019151d>]
>    [<c0190efe>] [<c01903c5>] [<c0190360>] [<c018faa7>] [<c018c830>] [<c01a1b15>]
>    [<c0105000>] [<c0105053>] [<c0105000>] [<c01054f6>] [<c0105040>]
> Code: 0f 0b 83 c4 0c 8d 65 f4 5b 5e 5f 5d c3 8d b6 00 00 00 00 8b
>
> >>EIP; c0113e2d <schedule+5d/400>   <=====
> Trace; c0190340 <acpi_ev_global_lock_thread+0/20>
> Trace; c0106f45 <reschedule+5/10>
> Trace; c0189b10 <acpi_os_queue_exec+0/e0>
> Trace; c0190340 <acpi_ev_global_lock_thread+0/20>
> Trace; c01054ed <kernel_thread+1d/30>
> Trace; c0189c5e <acpi_os_schedule_exec+6e/120>
> Trace; c0189b10 <acpi_os_queue_exec+0/e0>
> Trace; c0189d9c <acpi_os_queue_for_execution+8c/160>
> Trace; c019039a <acpi_ev_global_lock_handler+3a/50>
> Trace; c0190340 <acpi_ev_global_lock_thread+0/20>
> Trace; c018fc2f <acpi_ev_fixed_event_dispatch+3f/d0>
> Trace; c018fba8 <acpi_ev_fixed_event_detect+58/a0>
> Trace; c0190cdb <acpi_ev_sci_handler+1b/30>
> Trace; c01895fc <acpi_irq+c/10>
> Trace; c0108329 <handle_IRQ_event+39/80>
> Trace; c01895f0 <acpi_irq+0/10>
> Trace; c01084b6 <do_IRQ+56/a0>
> Trace; c010a6c4 <call_do_IRQ+5/11>
> Trace; c018973a <acpi_os_out16+a/10>
> Trace; c0192d0a <acpi_hw_low_level_write+19a/1b0>
> Trace; c01927ed <acpi_hw_register_write+9d/260>
> Trace; c0192447 <acpi_hw_register_bit_access+2e7/3f0>
> Trace; c019151d <acpi_enable_event+6d/c0>
> Trace; c0190efe <acpi_install_fixed_event_handler+7e/a0>
> Trace; c01903c5 <acpi_ev_init_global_lock_handler+15/30>
> Trace; c0190360 <acpi_ev_global_lock_handler+0/50>
> Trace; c018faa7 <acpi_ev_initialize+47/60>
> Trace; c018c830 <acpi_enable_subsystem+60/b0>
> Trace; c01a1b15 <acpi_init+135/180>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105053 <init+13/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c01054f6 <kernel_thread+26/30>
> Trace; c0105040 <init+0/140>
> Code;  c0113e2d <schedule+5d/400>
> 00000000 <_EIP>:
> Code;  c0113e2d <schedule+5d/400>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0113e2f <schedule+5f/400>
>    2:   83 c4 0c                  add    $0xc,%esp
> Code;  c0113e32 <schedule+62/400>
>    5:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
> Code;  c0113e35 <schedule+65/400>
>    8:   5b                        pop    %ebx
> Code;  c0113e36 <schedule+66/400>
>    9:   5e                        pop    %esi
> Code;  c0113e37 <schedule+67/400>
>    a:   5f                        pop    %edi
> Code;  c0113e38 <schedule+68/400>
>    b:   5d                        pop    %ebp
> Code;  c0113e39 <schedule+69/400>
>    c:   c3                        ret
> Code;  c0113e3a <schedule+6a/400>
>    d:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
> Code;  c0113e40 <schedule+70/400>
>   13:   8b 00                     mov    (%eax),%eax
>
>  <0>Kernel panic: Aiee, killing interrupt handler!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

