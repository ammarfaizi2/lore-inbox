Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUIYLrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUIYLrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 07:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUIYLrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 07:47:42 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:37381 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S266275AbUIYLrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 07:47:40 -0400
Date: Sat, 25 Sep 2004 14:46:37 +0300 (EAT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.orgRe:
 [PATCH] Updated patches for PCI IRQ resource deallocation support [3/3]
In-Reply-To: <2HRhX-6Ad-21@gated-at.bofh.it>
Message-ID: <Pine.LNX.4.53.0409251436390.2914@musoma.fsmlabs.com>
References: <2HRhX-6Ad-21@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kenji,

On Fri, 24 Sep 2004, Kenji Kaneshige wrote:

> +		/*
> +		 * If interrupt handlers still exists on the irq
> +		 * associated with the gsi, don't unregister the
> +		 * interrupt.
> +		 */
> +		if (unlikely(idesc->action)) {
> +			iosapic_intr_info[vector].refcnt++;
> +			spin_unlock_irqrestore(&idesc->lock, flags);
> +			printk(KERN_WARNING "Cannot unregister GSI. IRQ %u is still in use.\n", irq);
> +			return;
> +		}
> +
> +		/* Clear the interrupt controller descriptor. */
> +		idesc->handler = &no_irq_type;

Hmm, what happens here if that vector was queued just before the local irq 
disable in spin_lock_irqsave(idesc->lock...) ? Then when we unlock we'll 
call do_IRQ to handle the irq associated with that vector. I haven't seen 
the usage but it appears that iosapic_unregister_intr requires some 
serialisation.

Thanks,
	Zwane
