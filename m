Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750951AbWFEQsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWFEQsP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWFEQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:48:15 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:6328
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750851AbWFEQsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:48:14 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Thomas Andrews <tandrews@grok.co.za>
Subject: Re: debugging "irq 7: nobody cared" in my module
Date: Mon, 5 Jun 2006 18:47:59 +0200
User-Agent: KMail/1.9.1
References: <20060605125132.GN32055@grok.co.za> <20060605161102.GP32055@grok.co.za>
In-Reply-To: <20060605161102.GP32055@grok.co.za>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051847.59462.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 18:11, Thomas Andrews wrote:
> On Mon, Jun 05, 2006 at 02:51:32PM +0200, Thomas Andrews wrote:
> 
> > What can cause "irq x: nobody cared" ? On exit from my IRQ handler, I am
> > checking to make sure that there are no residual/pending unhandled
> > events on exit. Here is part of my handler:
> > 
> > irqreturn_t scx200_acb_irq(int irq_no, void *dev_id, struct pt_regs *regs)
> > {
> >     struct scx200_acb_iface *iface = dev_id;
> >     unsigned long flags;
> >     spin_lock_irqsave(lock, flags);
> >     if (inb(ACBST)) {
> > //      tasklet_schedule(&iface->tasklet);
> >         scx200_acb_machine(iface, inb(ACBST));
> >         if (iface->state == state_idle)     /* Finished */
> >             wake_up_interruptible(&iface->acb_queue);
> >     } else {
> >         /* Should never get here */
> >         printk("causeless IRQ!\n");
> >         /* Reset the ACB to clear any pending IRQ */
> >         outb((inb(ACBCTL2) & 0xfe), ACBCTL2);
> >         outb((inb(ACBCTL2) | 0x01), ACBCTL2);
> >     }
> >     /* Check to see if some event was not handled */
> >     if (inb(ACBST) & 0xBC)
> >         printk("============== ACBST=%#x ===============\n",inb(ACBST));
> >     spin_unlock_irqrestore(lock, flags);
> >     return IRQ_RETVAL(0);
> > }
> 
> I've found the problem now. The last line is wrong - it should read:
> 
>     return IRQ_RETVAL(IRQ_HANDLED);

No, either
return IRQ_HANDLED;
or
return IRQ_RETVAL(boolean);

You returned the boolean 0, which is "false".

-- 
Greetings Michael.
