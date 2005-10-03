Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVJCOaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVJCOaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJCOaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:30:22 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:3791 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932254AbVJCOaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:30:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0B8t7qpotSii6nYvhXLbHY/o9JhOUqG0tLQ132KfDLWtgvmBF7qXe4F4qFTcrsvcIQ+hJ5HstqevYvcpRxRbc88sdgH5BBSjsvt6WfaL1b82OuyrqM9KEEMnPqHmJljWU7v06AUrgHbgWXRpA4m7BOudDHeqwU2OAkWMluSyqY=
Message-ID: <355e5e5e0510030730q2b3e295creaec6ebd129999f9@mail.gmail.com>
Date: Mon, 3 Oct 2005 10:30:18 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <433AEAAE.2070003@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e05092618018840fc3@mail.gmail.com>
	 <433AEAAE.2070003@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> > +     dev->flags &= ~ATA_DFLAG_LBA48;
> > +
>
> probably should just clear out all the flags...

I'll look into making this cleaner :)  During testing this was the
only one that was necessary, but I'll do some clean-up foo on this.

> is ata_chk_err() call in ata_to_sense_error() the only place that needs
> to talk to the hardware?  If so, maybe we could work around that by
> making sure it is passed register values, avoiding the need to poke the h/w.

Yep, it is the only place as far as I can see.  As for passing
register values, the reason I decided not to do that is because, say,
a user unplugged his drive because there WAS some kind of error which
set ATA_ERR.  This would attempt to perform some kind of error check
which would compound the problem.  However, I agree this is dirty :)
Should I just check the register values, & ~ATA_ERR, and then pass that in?

> > +     spin_lock(&ap->host_set->lock);
> > +     hotplug_todo = ap->plug; // Make sure we don't modify while reading!
> > +     spin_unlock(&ap->host_set->lock);
>
> this lock should always be acquired using spin_lock_irqsave()

Oops.

> > +             ata_scsi_handle_unplug(ap);
> > +
> > +             // The following flag is necessary on some Seagate drives.
> > +             ap->flags |= ATA_FLAG_SATA_RESET;
>
> we can't unconditionally set this for all controllers
>
> For PATA hotplug, which this code will eventually handle, the SATA
> SControl register doesn't even exist :)

if (ap & ATA_FLAG_SATA) ap->flags |= ATA_FLAG_SATA_RESET
? :)

> > +             ap->udma_mask = ap->orig_udma_mask;
>
> dumb question -- what is this for?
>
> for hotplug we'll want to go through the entire probe sequence,
> configuring pio/dma masks all over again.

OK I'll admit I may not have looked through the code enough on that
one, but here's a situation I remember about this:
Had a drive which supported UDMA 5 max.  Unplugged it, plugged in a
drive which supported UDMA 6, but libata reported UDMA 5 max.  Since
the flags aren't reset, and ata_mode_string() works from slowest to
fastest, this will always happen unless we reset the flags to some
default value.  So... voila.  Do you have a suggestion for making this
cleaner?

> > +static void ata_hotplug_timer_func(unsigned long _data)
> > +{
> > +     struct ata_port *ap = (struct ata_port *)_data;
> > +
> > +     queue_work(ata_hotplug_wq, &ap->hotplug_task);
> > +}
>
> if this is all the timer function needs to do, then you can just use
> queue_work_delayed()

I agree.

> > +void ata_hotplug_plug(struct ata_port *ap)

<snip>

> > +void ata_hotplug_unplug(struct ata_port *ap)
>
> I prefer the names ata_hot_plug() and ata_hot_unplug()

Sure.

> > +static int ata_scsi_qc_abort(struct ata_queued_cmd *qc, u8 drv_stat)
> > +{
> > +     struct scsi_cmnd *cmd = qc->scsicmd;
> > +
> > +     cmd->result = SAM_STAT_TASK_ABORTED; //FIXME:  Is this what we want?
>
> Just trace through the error handling code, the answer should fall out
> from there...

Yeah... I put that fixme in there in August to remind myself to do
that... apparently the reminder didn't help.  I'll look into it.

> > +void ata_scsi_handle_plug(struct ata_port *ap)
> > +{
> > +     //Currently SATA only
>
> Please change comments to follow the standard style in the rest of the
> drivers:  /* foo */

Righto.

> > +void ata_scsi_handle_unplug(struct ata_port *ap)
> > +{
> > +     //SATA only, no PATA
>
> why?  This function looks generic enough to work for PATA

This just refers to the fact that I'm currently just looking for a
drive with channel, id, and lun all equal to 0.  I'll remove the
comment.

OK, looks like I have my work cut out for me.  Thanks for the feedback
Jeff, I'll resubmit this as soon as I've made changes and done some
more testing to ensure it's still stable.
