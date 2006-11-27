Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758596AbWK0XQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758596AbWK0XQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758598AbWK0XQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:16:51 -0500
Received: from junsun.net ([66.29.16.26]:13578 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1758596AbWK0XQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:16:50 -0500
Date: Mon, 27 Nov 2006 15:16:46 -0800
From: Jun Sun <jsun@junsun.net>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed 'ljmp' in linear addressing mode
Message-ID: <20061127231646.GA21627@srv.junsun.net>
References: <20061122234111.GA8499@srv.junsun.net> <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 27, 2006 at 08:58:57AM -0500, linux-os (Dick Johnson) wrote:
> 
> I think it probably resets the instant that you turn off paging. To
> turn off paging, you need to copy some code (properly linked) to an
> area where there is a 1:1 mapping between virtual and physical addresses.
> A safe place is somewhere below 1 megabyte. Then you need to set up a
> call descriptor so you can call that code (you can ljump if you never
> plan to get back). You then need to clear interrupts on all CPUs (use a 
> spin-lock). Once you are executing from the new area, you reset your
> segments to the new area. The call descriptor would have already set
> CS, as would have the long-jump. At this time you can turn off paging
> and flush the TLB. You are now in linear-address protected mode.
>

Thanks for the reply.  But I am pretty much sure I did above correctly.
I use single-instruction infinite loop in the call path to verify
that control does reach last 'ljmp' but not the jump destination.

Below is the hack I made to machine_kexec.c file.  As you can see, I
managed to make the identical mapping between virtual and physical addresses.

Note I did not copy the code into the first 1M.  In fact the code
is located at 0xc0477000 (0x00477000 in physical).  I thought that should be
OK as I did not really go all the way back to real-address mode.

That last suspect I have now is the wrong value in CS descriptor.  Does kernel
have a suitable CS descriptor for the last ljmep to 0x10000000 in linear
addressing mode?  The CS descriptor seems to be a pretty dark magic to me ...

Cheers.

Jun

-----------------
diff -Nru linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c.orig linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c
--- linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c.orig   2006-10-13 11:55:04.000000000 -0700
+++ linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c        2006-11-22 15:01:45.000000000 -0800
@@ -212,3 +212,19 @@
        rnk = (relocate_new_kernel_t) reboot_code_buffer;
        (*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
 }
+
+extern void do_os_switching(void);
+void os_switch(void)
+{
+       void (*foo)(void);
+
+       /* absolutely no irq */
+       local_irq_disable();
+
+       /* create identity mapping */
+       foo=virt_to_phys(do_os_switching);
+       identity_map_page((unsigned long)foo);
+
+       /* jump to the real address */
+       foo();
+}

