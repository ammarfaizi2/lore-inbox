Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUFWO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUFWO1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFWO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:27:12 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:11689 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265234AbUFWO1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:27:06 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Keith Moore <keithmo@exmsft.com>
Date: Wed, 23 Jun 2004 16:26:52 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.7-mm1 PCNet Problems under VMWare 4.5.2
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <A212D9E4842@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 04 at 11:23, Keith Moore wrote:
> -    /* Clear any other interrupt, and set interrupt enable. */
> -    lp->a.write_csr (ioaddr, 0, 0x7940);
> +    /* Set interrupt enable. */
> +    lp->a.write_csr (ioaddr, 0, 0x0040);
> 
> Reverting this one section of the patch makes eth0 happy again.
> 
> I poked around with the values written to the csr register, and it 
> appears the virtual PCNet-II adapter needs bit 0x0100 (initialzation 
> done) set. So, writing 0x0140 instead of 0x0040 seems to work well.
> 
> I have no idea how accurate VMWare's emulation of this adapter is, or if 
> this change may cause problems with other (physical) adapters.

I believe that it is not emulation bug. What happens is that you do not
confirm INIT DONE irq, causing endless stream of interrupts from card to
the CPU. This happens because CSR3 default value is 0 (enable all 
interrupts), and driver does not modify it in any way (f.e. for
preventing INIT from causing interrupt). So when init is done, IDON
irq fires. In old driver it was acked by 0x7940 (or by 0x0140 in your
modified driver), but in new driver it is not acked in any way,
triggering this very same IRQ over and over.

pcnet32_interrupt should loop while csr0 contains some pending
interrupts (current mask 0x8600 should be changed to 0xDE00 to be 100%
sure that all interrupts we handle in loop are catched), and then
clear all other interrupts sources (0x2140) out of the loop.

Other possibility is masking these unused sources in CSR3...

But I believe that driver from -mm1 will hang even on real Am79C970A
hardware.
                                            Best regards,
                                                Petr Vandrovec
                                                

