Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031531AbWK3WHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031531AbWK3WHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031530AbWK3WHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:07:09 -0500
Received: from c-71-198-216-253.hsd1.ca.comcast.net ([71.198.216.253]:53223
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1031531AbWK3WHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:07:07 -0500
Subject: Re: 2.6.19-rt1 Bug
From: Daniel Walker <dwalker@mvista.com>
To: joel silvestre <j.silvestre@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1164918963.3923.77.camel@zordi>
References: <1164918963.3923.77.camel@zordi>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Nov 2006 14:06:37 -0800
Message-Id: <1164924397.20941.2.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




/*
 * Spinlocks are used for interfaces that can be possibly called at
 * interrupt level
 */
ACPI_EXTERN raw_spinlock_t _acpi_gbl_gpe_lock;  /* For GPE data structs and registers */ 
ACPI_EXTERN raw_spinlock_t _acpi_gbl_hardware_lock;     /* For ACPI H/W except GPE registers */

The problem is these two raw locks. There don't look like they could get
called from real interrupt context.

Daniel

On Thu, 2006-11-30 at 21:36 +0100, joel silvestre wrote:
> Hi,
> 
> comes from an Intel core duo laptop running
> kernel-rt-2.6.19-1.rt1.0001.i686.rpm on Fedora 6.
> 
> joël
> 
> Nov 30 21:24:40 localhost kernel: BUG: scheduling with irqs disabled:
> IRQ 9/0x00000001/77
> Nov 30 21:24:40 localhost kernel: caller is rt_spin_lock_slowlock
> +0x106/0x18a
> Nov 30 21:24:40 localhost kernel:  [<c0104e1b>] dump_trace+0x64/0x1cc
> Nov 30 21:24:40 localhost kernel:  [<c0104f9c>] show_trace_log_lvl
> +0x19/0x2e
> Nov 30 21:24:40 localhost kernel:  [<c01052e0>] show_trace+0x12/0x14
> Nov 30 21:24:40 localhost kernel:  [<c01052f9>] dump_stack+0x17/0x19
> Nov 30 21:24:40 localhost kernel:  [<c032c0ac>] schedule+0x71/0xe7
> Nov 30 21:24:40 localhost kernel:  [<c032cc04>] rt_spin_lock_slowlock
> +0x106/0x18a
> Nov 30 21:24:40 localhost kernel:  [<c032d0a5>] rt_spin_lock+0x20/0x22
> Nov 30 21:24:40 localhost kernel:  [<c0123267>] __wake_up+0x13/0x50
> Nov 30 21:24:40 localhost kernel:  [<c0230bd4>] acpi_ec_gpe_handler
> +0x54/0x8b
> Nov 30 21:24:40 localhost kernel:  [<c021dff5>] acpi_ev_gpe_dispatch
> +0x68/0x163
> Nov 30 21:24:40 localhost kernel:  [<c021e189>] acpi_ev_gpe_detect
> +0x99/0xe0
> Nov 30 21:24:40 localhost kernel:  [<c021c791>]
> acpi_ev_sci_xrupt_handler+0x15/0x1d
> Nov 30 21:24:40 localhost kernel:  [<c0217530>] acpi_irq+0xe/0x18
> Nov 30 21:24:40 localhost kernel:  [<c015925b>] handle_IRQ_event
> +0x45/0xc1
> Nov 30 21:24:40 localhost kernel:  [<c01598ce>] thread_simple_irq
> +0x39/0x6c
> Nov 30 21:24:40 localhost kernel:  [<c0159d11>] do_irqd+0xdd/0x298
> Nov 30 21:24:40 localhost kernel:  [<c013a8cf>] kthread+0xc2/0xef
> Nov 30 21:24:40 localhost kernel:  [<c0104b5b>] kernel_thread_helper
> +0x7/0x10
> Nov 30 21:24:40 localhost kernel:  =======================
> Nov 30 21:24:41 localhost kernel: BUG: scheduling while atomic: IRQ
> 9/0x00000001/77, CPU#1
> Nov 30 21:24:41 localhost kernel:  [<c0104e1b>] dump_trace+0x64/0x1cc
> Nov 30 21:24:41 localhost kernel:  [<c0104f9c>] show_trace_log_lvl
> +0x19/0x2e
> Nov 30 21:24:41 localhost kernel:  [<c01052e0>] show_trace+0x12/0x14
> Nov 30 21:24:41 localhost kernel:  [<c01052f9>] dump_stack+0x17/0x19
> Nov 30 21:24:41 localhost kernel:  [<c032b204>] __schedule+0x84/0xd91
> Nov 30 21:24:41 localhost kernel:  [<c032c106>] schedule+0xcb/0xe7
> Nov 30 21:24:41 localhost kernel:  [<c032cc04>] rt_spin_lock_slowlock
> +0x106/0x18a
> Nov 30 21:24:41 localhost kernel:  [<c032d0a5>] rt_spin_lock+0x20/0x22
> Nov 30 21:24:41 localhost kernel:  [<c0123267>] __wake_up+0x13/0x50
> Nov 30 21:24:41 localhost kernel:  [<c0230bd4>] acpi_ec_gpe_handler
> +0x54/0x8b
> Nov 30 21:24:41 localhost kernel:  [<c021dff5>] acpi_ev_gpe_dispatch
> +0x68/0x163
> Nov 30 21:24:41 localhost kernel:  [<c021e189>] acpi_ev_gpe_detect
> +0x99/0xe0
> Nov 30 21:24:41 localhost kernel:  [<c021c791>]
> acpi_ev_sci_xrupt_handler+0x15/0x1d
> Nov 30 21:24:41 localhost kernel:  [<c0217530>] acpi_irq+0xe/0x18
> Nov 30 21:24:41 localhost kernel:  [<c015925b>] handle_IRQ_event
> +0x45/0xc1
> Nov 30 21:24:41 localhost kernel:  [<c01598ce>] thread_simple_irq
> +0x39/0x6c
> Nov 30 21:24:41 localhost kernel:  [<c0159d11>] do_irqd+0xdd/0x298
> Nov 30 21:24:41 localhost kernel:  [<c013a8cf>] kthread+0xc2/0xef
> Nov 30 21:24:41 localhost kernel:  [<c0104b5b>] kernel_thread_helper
> +0x7/0x10
> Nov 30 21:24:41 localhost kernel:  =======================
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

