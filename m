Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270017AbRHJWOf>; Fri, 10 Aug 2001 18:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270018AbRHJWOZ>; Fri, 10 Aug 2001 18:14:25 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:36605 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S270017AbRHJWOS>; Fri, 10 Aug 2001 18:14:18 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE04D@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'ebuddington@wesleyan.edu'" <ebuddington@wesleyan.edu>,
        linux-kernel@vger.kernel.org
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: 2.4.7-ac10 acpi BUG (again)
Date: Fri, 10 Aug 2001 15:12:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I believe I know what's happening. The stack trace was very helpful.

The Global Lock is used to synchronize access to the hardware between the
BIOS and the OS. This is not a spinlock -- if the BIOS has it when the OS
(that's us) needs it, we set a "pending" bit, so that we get an interrupt
when it's available.

We're enabling the interrupt and we're immediately taking one. This is
strange because at this stage of initialization, we've never attempted to
acquire the Global Lock, which means we've never set the pending bit.

I think this means we either need to explicitly clear it before we enable
the interrupt, or treat it as spurious when we get it.

If I'm right, our next patch should fix this. Thanks for the report.

Regards -- Andy

> From: Eric Buddington [mailto:eric@sparrow.bur.adelphia.net]
> I earlier reported a BUG on boot with 2.4.3-ac3 in the acpi
> code. Andy's patches made the kernel not boot (out of data while
> decompressing), so here's another shot with 2.4.7-ac10.
> 
> I enabled ACPI_DEBUG in the kernel config - is that the same as your
> earlier patch, Andy? In any case, I get the same problem, pretty much.
> Here it is. Oh, yeah - my Penguin is an AMD K6-2. Can'd give an ID on
> the motherboard offhand (Gigabyte, I think).
> 
> -Eric

> >>EIP; c011310d <schedule+5d/3c0>   <=====
> Trace; c0189e7c <acpi_ev_global_lock_thread+0/18>
> Trace; c0106d31 <reschedule+5/c>
> Trace; c0184238 <acpi_os_queue_exec+0/e0>
> Trace; c0189e7c <acpi_ev_global_lock_thread+0/18>
> Trace; c0105471 <kernel_thread+1d/30>
> Trace; c0184386 <acpi_os_schedule_exec+6e/118>
> Trace; c0184238 <acpi_os_queue_exec+0/e0>
> Trace; c01844b9 <acpi_os_queue_for_execution+89/14c>
> Trace; c0189ece <acpi_ev_global_lock_handler+3a/44>
> Trace; c0189e7c <acpi_ev_global_lock_thread+0/18>
> Trace; c0189829 <acpi_ev_fixed_event_dispatch+41/a4>
> Trace; c01897a9 <acpi_ev_fixed_event_detect+55/94>
> Trace; c018a723 <acpi_ev_sci_handler+1b/2c>
> Trace; c0183dfc <acpi_irq+c/10>
> Trace; c0107e81 <handle_IRQ_event+31/68>
> Trace; c0183df0 <acpi_irq+0/10>
> Trace; c0107fd4 <do_IRQ+54/a0>
> Trace; c010a14e <call_do_IRQ+5/b>
> Trace; c0183efe <acpi_os_out16+a/c>
> Trace; c018c4a6 <acpi_hw_low_level_write+176/180>
> Trace; c018bff5 <acpi_hw_register_write+91/240>
> Trace; c018bc86 <acpi_hw_register_bit_access+28a/37c>
> Trace; c018aef1 <acpi_enable_event+6d/ac>
> Trace; c018a922 <acpi_install_fixed_event_handler+76/94>
> Trace; c0189eed <acpi_ev_init_global_lock_handler+15/2c>
> Trace; c0189e94 <acpi_ev_global_lock_handler+0/44>
> Trace; c01896bc <acpi_ev_initialize+48/5c>
> Trace; c0186a61 <acpi_enable_subsystem+55/80>
> Trace; c01999d9 <acpi_init+121/15c>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105000 <_stext+0/0>
> Trace; c010503f <init+b/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c010547a <kernel_thread+26/30>
> Trace; c0105034 <init+0/140>
