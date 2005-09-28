Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVI1TKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVI1TKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVI1TKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:10:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35813 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750733AbVI1TKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:10:42 -0400
Message-ID: <433AEAAE.2070003@pobox.com>
Date: Wed, 28 Sep 2005 15:10:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
References: <355e5e5e05092618018840fc3@mail.gmail.com>
In-Reply-To: <355e5e5e05092618018840fc3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> @@ -1147,6 +1148,11 @@ static void ata_dev_identify(struct ata_
>  		return;
>  	}
>  
> +	/* Necessary if we had an LBA48 drive in, we pulled it out, and put a
> +	 * non-LBA48 drive on the same ap.
> +	 */
> +	dev->flags &= ~ATA_DFLAG_LBA48;
> +

probably should just clear out all the flags...


> @@ -3692,6 +3698,102 @@ idle_irq:
>  	return 0;	/* irq not handled */
>  }
>  
> +void ata_check_kill_qc(struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
> +
> +	if (unlikely(qc)) {
> +		/* This is SO bad.  But we can't just run
> +		 * ata_qc_complete without doing this, because
> +		 * ata_scsi_qc_complete wants to talk to the device,
> +		 * and we can't let it do that since it doesn't exist
> +		 * anymore.
> +		 */

is ata_chk_err() call in ata_to_sense_error() the only place that needs 
to talk to the hardware?  If so, maybe we could work around that by 
making sure it is passed register values, avoiding the need to poke the h/w.



> +		ata_scsi_prepare_qc_abort(qc);
> +		ata_qc_complete(qc, ATA_ERR);
> +	}
> +}
> +
> +static void ata_hotplug_task(void *_data)
> +{
> +	struct ata_port *ap = (struct ata_port *)_data;
> +	enum hotplug_states hotplug_todo;
> +
> +	spin_lock(&ap->host_set->lock);
> +	hotplug_todo = ap->plug; // Make sure we don't modify while reading!
> +	spin_unlock(&ap->host_set->lock);

this lock should always be acquired using spin_lock_irqsave()


> +	if (hotplug_todo == ATA_HOTPLUG_PLUG) {
> +		DPRINTK("Got a plug request on port %d\n", ap->id);
> +
> +		/* This might be necessary if we unplug and plug in a drive
> +		 * within ATA_TMOUT_HOTSWAP / HZ seconds... due to the debounce
> +		 * timer, one event is generated.  Since the last event was a
> +		 * plug, the unplug routine never gets called, so we need to
> +		 * clean up the mess first.  If there was never a drive here in
> +		 * the first place, this will just do nothing.  Otherwise, it
> +		 * basically prevents 'plug' from being called twice with no
> +		 * unplug in between.
> +		 */
> +		ata_scsi_handle_unplug(ap);
> +
> +		// The following flag is necessary on some Seagate drives.
> +		ap->flags |= ATA_FLAG_SATA_RESET; 

we can't unconditionally set this for all controllers

For PATA hotplug, which this code will eventually handle, the SATA 
SControl register doesn't even exist :)


> +		ap->udma_mask = ap->orig_udma_mask;

dumb question -- what is this for?

for hotplug we'll want to go through the entire probe sequence, 
configuring pio/dma masks all over again.


> +		if (!ata_bus_probe(ap))  //Drive found!  Tell the SCSI layer!
> +			ata_scsi_handle_plug(ap);	
> +	} else if (hotplug_todo == ATA_HOTPLUG_UNPLUG) {
> +		DPRINTK("Got an unplug request on port %d\n", ap->id);
> +
> +		ata_scsi_handle_unplug(ap);
> +	} else /* FIXME:  Some kind of error condition? */
> +		BUG();
> +}
> +
> +static void ata_hotplug_timer_func(unsigned long _data)
> +{
> +	struct ata_port *ap = (struct ata_port *)_data;
> +
> +	queue_work(ata_hotplug_wq, &ap->hotplug_task);
> +}

if this is all the timer function needs to do, then you can just use 
queue_work_delayed()


> +void ata_hotplug_plug(struct ata_port *ap)
> +{
> +	del_timer(&ap->hotplug_timer);
> +
> +	if (ap->ops->hotplug_plug_janitor)
> +		ap->ops->hotplug_plug_janitor(ap);
> +
> +	/* This line should be protected by a host_set->lock.  If we follow the
> +	 * call chain up from this, it should be called from ata_hotplug_unplug
> +	 * or ata_hotplug_plug, which should be called from an interrupt
> +	 * handler.  Make sure the call to either of those functions is
> +	 * protected.
> +	 */
> +	ap->plug = ATA_HOTPLUG_PLUG;
> +
> +	ap->hotplug_timer.expires = jiffies + ATA_TMOUT_HOTSWAP;
> +	add_timer(&ap->hotplug_timer);
> +}
> +
> +void ata_hotplug_unplug(struct ata_port *ap)

I prefer the names ata_hot_plug() and ata_hot_unplug()


> +{
> +	ata_port_disable(ap);  //Gone gone gone!
> +	
> +	del_timer(&ap->hotplug_timer);
> +
> +	if (ap->ops->hotplug_unplug_janitor)
> +		ap->ops->hotplug_unplug_janitor(ap);
> +	
> +	/* See comment near similar line in ata_hotplug_plug function.
> +	 */
> +	ap->plug = ATA_HOTPLUG_UNPLUG;
> +
> +	ap->hotplug_timer.expires = jiffies + ATA_TMOUT_HOTSWAP;
> +	add_timer(&ap->hotplug_timer);
> +}
> +
>  /**
>   *	ata_interrupt - Default ATA host interrupt handler
>   *	@irq: irq line (unused)
> @@ -3925,7 +4027,12 @@ static void ata_host_init(struct ata_por
>  	ap->cbl = ATA_CBL_NONE;
>  	ap->active_tag = ATA_TAG_POISON;
>  	ap->last_ctl = 0xFF;
> +	ap->orig_udma_mask = ent->udma_mask;
>  
> +	ap->hotplug_timer.function = ata_hotplug_timer_func;
> +	ap->hotplug_timer.data = (unsigned int)ap;
> +	init_timer(&ap->hotplug_timer);
> +	INIT_WORK(&ap->hotplug_task, ata_hotplug_task, ap);
>  	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
>  	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
>  
> @@ -4541,6 +4648,11 @@ static int __init ata_init(void)
>  	ata_wq = create_workqueue("ata");
>  	if (!ata_wq)
>  		return -ENOMEM;
> +	ata_hotplug_wq = create_workqueue("ata_hotplug");
> +	if (!ata_hotplug_wq) {
> +		destroy_workqueue(ata_wq);
> +		return -ENOMEM;
> +	}
>  
>  	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
>  	return 0;
> @@ -4549,6 +4661,7 @@ static int __init ata_init(void)
>  static void __exit ata_exit(void)
>  {
>  	destroy_workqueue(ata_wq);
> +	destroy_workqueue(ata_hotplug_wq);
>  }
>  
>  module_init(ata_init);
> @@ -4604,6 +4717,8 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
>  EXPORT_SYMBOL_GPL(ata_dev_id_string);
>  EXPORT_SYMBOL_GPL(ata_dev_config);
>  EXPORT_SYMBOL_GPL(ata_scsi_simulate);
> +EXPORT_SYMBOL_GPL(ata_hotplug_plug);
> +EXPORT_SYMBOL_GPL(ata_hotplug_unplug);
>  
>  #ifdef CONFIG_PCI
>  EXPORT_SYMBOL_GPL(pci_test_config_bits);
> diff -rpuN linux-2.6.14-rc1/drivers/scsi/libata.h linux-2.6.14-rc1-new/drivers/scsi/libata.h
> --- linux-2.6.14-rc1/drivers/scsi/libata.h	2005-09-12 23:12:09.000000000 -0400
> +++ linux-2.6.14-rc1-new/drivers/scsi/libata.h	2005-09-14 19:57:53.000000000 -0400
> @@ -44,6 +44,7 @@ extern struct ata_queued_cmd *ata_qc_new
>  extern void ata_qc_free(struct ata_queued_cmd *qc);
>  extern int ata_qc_issue(struct ata_queued_cmd *qc);
>  extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
> +extern void ata_check_kill_qc(struct ata_port *ap);
>  extern void ata_dev_select(struct ata_port *ap, unsigned int device,
>                             unsigned int wait, unsigned int can_sleep);
>  extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
> @@ -79,6 +80,9 @@ extern void ata_scsi_badcmd(struct scsi_
>  extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
>                          unsigned int (*actor) (struct ata_scsi_args *args,
>                                             u8 *rbuf, unsigned int buflen));
> +extern void ata_scsi_prepare_qc_abort(struct ata_queued_cmd *qc);
> +extern void ata_scsi_handle_plug(struct ata_port *ap);
> +extern void ata_scsi_handle_unplug(struct ata_port *ap);
>  
>  static inline void ata_bad_scsiop(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
>  {
> diff -rpuN linux-2.6.14-rc1/drivers/scsi/libata-scsi.c linux-2.6.14-rc1-new/drivers/scsi/libata-scsi.c
> --- linux-2.6.14-rc1/drivers/scsi/libata-scsi.c	2005-09-12 23:12:09.000000000 -0400
> +++ linux-2.6.14-rc1-new/drivers/scsi/libata-scsi.c	2005-09-14 19:57:53.000000000 -0400
> @@ -716,6 +716,53 @@ static int ata_scsi_qc_complete(struct a
>  	return 0;
>  }
>  
> +static int ata_scsi_qc_abort(struct ata_queued_cmd *qc, u8 drv_stat)
> +{
> +	struct scsi_cmnd *cmd = qc->scsicmd;
> +
> +	cmd->result = SAM_STAT_TASK_ABORTED; //FIXME:  Is this what we want?

Just trace through the error handling code, the answer should fall out 
from there...


> +	qc->scsidone(cmd);
> +
> +	return 0;
> +}
> +
> +void ata_scsi_prepare_qc_abort(struct ata_queued_cmd *qc)
> +{
> +	/* For some reason or another, we can't allow a normal scsi_qc_complete.
> +	 * Note that at this point, we must be SURE the command is going to time
> +	 * out, or else we might be changing this as it's being called.  Never a
> +	 * good thing.
> +	 */
> +	if (qc->complete_fn == ata_scsi_qc_complete);
> +		qc->complete_fn = ata_scsi_qc_abort;
> +}
> +
> +void ata_scsi_handle_plug(struct ata_port *ap)
> +{
> +	//Currently SATA only

Please change comments to follow the standard style in the rest of the 
drivers:  /* foo */


> +	scsi_add_device(ap->host, 0, 0, 0);
> +}
> +
> +void ata_scsi_handle_unplug(struct ata_port *ap)
> +{
> +	//SATA only, no PATA

why?  This function looks generic enough to work for PATA

