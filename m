Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269005AbUHZOMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269005AbUHZOMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUHZOIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:08:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5893 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268961AbUHZOEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:04:12 -0400
Date: Thu, 26 Aug 2004 15:04:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       thomas@undata.org
Subject: Re: [PATCH] Fix shared interrupt handling of SA_INTERRUPT and SA_SAMPLE_RANDOM
Message-ID: <20040826150404.D21364@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	thomas@undata.org
References: <s5heklxhjbg.wl@alsa2.suse.de> <20040824204508.3b31449f.akpm@osdl.org> <s5hoekzfowc.wl@alsa2.suse.de> <20040825134112.5aefaf8e.akpm@osdl.org> <s5h1xhum5ar.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s5h1xhum5ar.wl@alsa2.suse.de>; from tiwai@suse.de on Thu, Aug 26, 2004 at 02:50:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:50:52PM +0200, Takashi Iwai wrote:
> At Wed, 25 Aug 2004 13:41:12 -0700,
> Andrew Morton wrote:
> > 
> > Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > Anyway, suppressing the unnecessary call of add_interrupt_randomness()
> > >  should be still valid.  The reduced patch is below.
> (snip)
> > 
> > Shouldn't that be `if (ret == IRQ_HANDLED)'?
> 
> Yes, it's more strict.

I don't think so.  Look at what's going on.  If "ret" is IRQ_HANDLED
all well and fine.  However, look at how "retval" is being used:

static void __report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
{
...
        if (action_ret != IRQ_HANDLED && action_ret != IRQ_NONE) {
                printk(KERN_ERR "irq event %d: bogus return value %x\n",
                                irq, action_ret);
        } else {
                printk(KERN_ERR "irq %d: nobody cared!\n", irq);
        }

So, we're looking to see not only if a handler returned IRQ_HANDLED,
but also if a handler returned _some other value_ other than IRQ_HANDLED
or IRQ_NONE.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
