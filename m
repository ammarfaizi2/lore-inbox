Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751212AbWFEQLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWFEQLN (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWFEQLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:11:13 -0400
Received: from mail.grok.org.za ([196.1.58.22]:20752 "EHLO mail.grok.org.za")
	by vger.kernel.org with ESMTP id S1751212AbWFEQLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:11:12 -0400
Date: Mon, 5 Jun 2006 18:11:02 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: debugging "irq 7: nobody cared" in my module
Message-ID: <20060605161102.GP32055@grok.co.za>
References: <20060605125132.GN32055@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605125132.GN32055@grok.co.za>
User-Agent: Mutt/1.5.11
From: Thomas Andrews <tandrews@grok.co.za>
X-Scanner: exiscan *1FnHfS-0006jj-GS*Wrrzb5uo7cE* (Grok)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 02:51:32PM +0200, Thomas Andrews wrote:

> What can cause "irq x: nobody cared" ? On exit from my IRQ handler, I am
> checking to make sure that there are no residual/pending unhandled
> events on exit. Here is part of my handler:
> 
> irqreturn_t scx200_acb_irq(int irq_no, void *dev_id, struct pt_regs *regs)
> {
>     struct scx200_acb_iface *iface = dev_id;
>     unsigned long flags;
>     spin_lock_irqsave(lock, flags);
>     if (inb(ACBST)) {
> //      tasklet_schedule(&iface->tasklet);
>         scx200_acb_machine(iface, inb(ACBST));
>         if (iface->state == state_idle)     /* Finished */
>             wake_up_interruptible(&iface->acb_queue);
>     } else {
>         /* Should never get here */
>         printk("causeless IRQ!\n");
>         /* Reset the ACB to clear any pending IRQ */
>         outb((inb(ACBCTL2) & 0xfe), ACBCTL2);
>         outb((inb(ACBCTL2) | 0x01), ACBCTL2);
>     }
>     /* Check to see if some event was not handled */
>     if (inb(ACBST) & 0xBC)
>         printk("============== ACBST=%#x ===============\n",inb(ACBST));
>     spin_unlock_irqrestore(lock, flags);
>     return IRQ_RETVAL(0);
> }

I've found the problem now. The last line is wrong - it should read:

    return IRQ_RETVAL(IRQ_HANDLED);


