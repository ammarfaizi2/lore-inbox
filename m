Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbSI1CAA>; Fri, 27 Sep 2002 22:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbSI1B77>; Fri, 27 Sep 2002 21:59:59 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64777
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262681AbSI1B76>; Fri, 27 Sep 2002 21:59:58 -0400
Date: Fri, 27 Sep 2002 19:04:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Morton <akpm@digeo.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
In-Reply-To: <3D94EEBF.D6328392@digeo.com>
Message-ID: <Pine.LNX.4.10.10209271835280.13669-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No SLEEPING under a KMALLOC on a spinlock while calling request_irq is not
the brightest thing ever done!

So your finger pointing stinks!

See in 2.4-ac there is a stub to indicate the brokeness.

int init_irq (ide_hwif_t *hwif)
{
        unsigned long flags;
        unsigned int index;
        ide_hwgroup_t *hwgroup, *new_hwgroup;
        ide_hwif_t *match = NULL;

#if 0
        /* Allocate the buffer and no sleep allowed */
        new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_ATOMIC);
#else
        /* Allocate the buffer and potentially sleep first */
        new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
#endif

#ifndef __IRQ_HELL_SPIN
        save_and_cli(flags);
#else
        spin_lock_irqsave(&io_request_lock, flags);
#endif

<snip>

                if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup)) {
                        if (!match)
                                kfree(hwgroup);
#ifndef __IRQ_HELL_SPIN
                        restore_flags(flags);
#else
                        spin_unlock_irqrestore(&io_request_lock, flags);
#endif
                        return 1;
                }

<snip>

        /* all CPUs; safe now that hwif->hwgroup is set up */
#ifndef __IRQ_HELL_SPIN
        restore_flags(flags);
#else
        spin_unlock_irqrestore(&io_request_lock, flags);
#endif


See in trying to move to a spinlock it goes totally south.
So now that you know the where, and why ... please go fix.
See I am off working with AC on the issues for 2.4.

Also with PREMPT, bah never mind.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 27 Sep 2002, Andrew Morton wrote:

> Greg KH wrote:
> > 
> > So I got bold and enabled CONFIG_PREEMPT in 2.5.39, and got the
> > following message at boot time:
> > 
> > Sleeping function called from illegal context at slab.c:1374
> > c12a5ea8 c0117a26 c0296260 c0298202 0000055e c1283060 c013ab4f c0298202
> >        0000055e c03b668c 00000002 00000003 c01ff5ec c03b668c 00000042 c12838e0
> >        c12838e0 c12838e0 00000246 cfdee214 c0207830 04000000 c03b65f0 c0109be2
> > Call Trace:
> >  [<c0117a26>]__might_sleep+0x56/0x5d
> >  [<c013ab4f>]kmalloc+0x4f/0x330
> >  [<c01ff5ec>]piix_tune_chipset+0x33c/0x350
> >  [<c0207830>]ide_intr+0x0/0x320
> >  [<c0109be2>]request_irq+0x52/0xa0
> >  [<c0200a33>]init_irq+0x263/0x400
> >  [<c0207830>]ide_intr+0x0/0x320
> >  [<c0200edc>]hwif_init+0x10c/0x260
> >  [<c02006ad>]probe_hwif_init+0x1d/0x70
> >  [<c02121d1>]ide_setup_pci_device+0x41/0x70
> >  [<c01ff7a5>]piix_init_one+0x35/0x40
> >  [<c010511b>]init+0x8b/0x250
> >  [<c0105090>]init+0x0/0x250
> >  [<c01055f9>]kernel_thread_helper+0x5/0xc
> > 
> 
> Everyone will get this.  It's IDE's init_irq() function doing
> unsafe things inside ide_lock.
> 
> It'll be quite harmless at boot-time, but it'd be nice to get
> it fixed up.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

