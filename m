Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759031AbWK3Exp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759031AbWK3Exp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759032AbWK3Exp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:53:45 -0500
Received: from junsun.net ([66.29.16.26]:23563 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1759030AbWK3Exo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:53:44 -0500
Date: Wed, 29 Nov 2006 20:53:41 -0800
From: Jun Sun <jsun@junsun.net>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed 'ljmp' in linear addressing mode
Message-ID: <20061130045341.GA11469@srv.junsun.net>
References: <20061122234111.GA8499@srv.junsun.net> <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com> <20061127231646.GA21627@srv.junsun.net> <Pine.LNX.4.61.0611280806280.7116@chaos.analogic.com> <20061128194530.GB28891@srv.junsun.net> <Pine.LNX.4.61.0611281815520.8163@chaos.analogic.com> <20061129014056.GA31798@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129014056.GA31798@srv.junsun.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 05:40:56PM -0800, Jun Sun wrote:
> 
> Can you elaborate more why this last ljmp will fail?  I thought at this point
> the paging is turned off, and 0x1000-0000 would simply mean a physical
> address - which is a valid physical address in RAM, btw.
>
<snip>

I finally got it working, even though I don't understand at all. :)

I realized that after paging mode is turned off, 0x1000-0000 is actually
at the same flag 4G code segment as caller code.  So I tried to just
"call" and that worked.

Here is the excerpt of the related code in case someone else needs to
do the same:

In arch/i386/kernel/machine_kexec.c:

extern void do_os_switching(void);
void os_switch(void)
{
        void (*foo)(void);

        /* absolutely no irq */
        local_irq_disable();

        /* create identity mapping */
        foo=virt_to_phys(do_os_switching);
        identity_map_page((unsigned long)foo);

        /* jump to the real address */
        load_segments();
        set_gdt(phys_to_virt(0),0);
        set_idt(phys_to_virt(0),0);
        foo();
}

In arch/i386/kernel/acpi/wakeup.S:

        .align  4096
ENTRY(do_os_switching)
        /* JSUN, 0x11 was the boot up value for cr0. */
        movl    $0x11, %eax
        movl    %eax, %cr0

        /* clear cr4 */
        movl    $0, %eax
        movl    %eax, %cr4

        /* clear cr3, flush TLB */
        movl    $0, %eax
        movl    %eax, %cr3

        movl    $0x10000000,%eax
        call    *%eax

I have a second Linux kernel loaded at 0x1000-0000.  Now the only matter
remaining is to figure out why the tsc timer stopped working ... :)

Cheers.

Jun
