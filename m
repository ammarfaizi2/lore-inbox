Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751080AbWFEMvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWFEMvq (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWFEMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:51:46 -0400
Received: from mail.grok.org.za ([196.1.58.22]:41231 "EHLO mail.grok.org.za")
	by vger.kernel.org with ESMTP id S1751080AbWFEMvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:51:45 -0400
Date: Mon, 5 Jun 2006 14:51:32 +0200
To: linux-kernel@vger.kernel.org
Subject: debugging "irq 7: nobody cared" in my module
Message-ID: <20060605125132.GN32055@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Thomas Andrews <tandrews@grok.co.za>
X-Scanner: exiscan *1FnEYO-0005s3-A3*GmpPI7GSuCY* (Grok)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What can cause "irq x: nobody cared" ? On exit from my IRQ handler, I am
checking to make sure that there are no residual/pending unhandled
events on exit. Here is part of my handler:

irqreturn_t scx200_acb_irq(int irq_no, void *dev_id, struct pt_regs *regs)
{
    struct scx200_acb_iface *iface = dev_id;
    unsigned long flags;
    spin_lock_irqsave(lock, flags);
    if (inb(ACBST)) {
//      tasklet_schedule(&iface->tasklet);
        scx200_acb_machine(iface, inb(ACBST));
        if (iface->state == state_idle)     /* Finished */
            wake_up_interruptible(&iface->acb_queue);
    } else {
        /* Should never get here */
        printk("causeless IRQ!\n");
        /* Reset the ACB to clear any pending IRQ */
        outb((inb(ACBCTL2) & 0xfe), ACBCTL2);
        outb((inb(ACBCTL2) | 0x01), ACBCTL2);
    }
    /* Check to see if some event was not handled */
    if (inb(ACBST) & 0xBC)
        printk("============== ACBST=%#x ===============\n",inb(ACBST));
    spin_unlock_irqrestore(lock, flags);
    return IRQ_RETVAL(0);
}

I've also had the problem when I move everything into a tasklet, and
just have a very short IRQ handler.

Many thanks,
Thomas
