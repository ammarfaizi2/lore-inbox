Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030822AbWK3RTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbWK3RTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030827AbWK3RTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:19:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50881 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030822AbWK3RTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:19:21 -0500
Date: Thu, 30 Nov 2006 18:19:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Christoph Schmid <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061130171910.GD1860@elf.ucw.cz>
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it> <7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5783fms.fsf@denkblock.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > After some googeling and digging in gamne i read that someone said that
> >> > there are plans for some generic support for HD-parking in the kernel
> >> > and thus making such patches obsolete.
> [...]
> >> I'm afraid we need your help with development here. Porting old patch
> >> to 2.6.19-rc6 should be easy, and then you can start 'how do I
> >> makethis generic' debate.
> >
> > 2.6.19 will finally have the generic block layer commands, so this can
> > be implemented properly.
> 
> Eventually, I've ported the patch to 2.6.19-rc6 (attached). However,
> I'll need some gentle guidance by you developers for the next steps,
> I'm afraid. What exactly do you mean by "making this generic".
> Perhaps, you could give me a hint as to which generic block layer
> commands you have in mind that should be used in such a patch.
> 
> 
> Here is a short description of what the patch does in its current
> shape:
> 
> 1. Adds functions to ide-disk.c and scsi_lib.c that issue an idle
>    immediate with head unload or a standby immediate command as
>    appropriate and stop the queue on command completion.

Can we get short Documentation/ patch?

> +       if (!pending)
> +	       q->issue_unprotect_fn(q);

Minor tab vs spaces problem here.

> +	spin_unlock_irq(q->queue_lock);
> +       return queue_var_show(seconds, (page));

And here.

> +static ssize_t queue_protect_store(struct request_queue *q, const char *page, size_t count)
> +{

80 colums would be nice.

> +	if(freeze>0) {

...and space between if and (

> +static struct queue_sysfs_entry queue_protect_entry = {
> +       .attr = {.name = "protect", .mode = S_IRUGO | S_IWUSR },

And space between { and . .

> +	/* create the attribute */
> +	error = sysfs_create_file(&q->kobj, &queue_protect_entry.attr);
> +	if(error){

if (error) {

> +module_param_named(protect_method, libata_protect_method, int, 0444);
> +MODULE_PARM_DESC(protect_method, "hdaps disk protection method  (0=autodetect, 1=unload, 2=standby)");

Should this be configurable by module parameter? Why not tell each
unload what to do?

Is /sys interface right thing to do?

> +	if (libata_protect_method == 1) {
> +		unload = 1;	
> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload method requested, overriding drive capability check..\n");
> +	}

} and else on same line...

> +	else if (libata_protect_method == 2) {
> +		unload = 0;	
> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): standby method requested, overriding drive capability check..\n");
> +	}
> +	else if (ata_id_has_unload(dev->id)) {
> +		unload = 1;
> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support reported by drive..\n");
> +	}
> +	else {
> +		unload = 0;
> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support NOT reported by drive!..\n");
> +	}

Can we consolidate the strings somehow?

> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -72,6 +72,10 @@ #include <asm/uaccess.h>
>  #include <asm/io.h>
>  #include <asm/div64.h>
>  
> +int idedisk_protect_method = 0;
> +module_param_named(protect_method, idedisk_protect_method, int, 0444);
> +MODULE_PARM_DESC(protect_method, "hdaps disk protection method (0=autodetect, 1=unload, 2=standby)");
> +

Oh and do not mention hdaps, there are more different accelerometer
types.

> +	/*
> +	 * Auto-unfreeze state
> +	 */
> +	struct timer_list	unfreeze_timer;
> +	int			max_unfreeze;	/* At most this many seconds */
> +	struct work_struct	unfreeze_work;
> +
>  	struct backing_dev_info	backing_dev_info;
>

Should we have kernel doing auto-unfreeze? Perhaps we can just mlock()
the daemon?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
