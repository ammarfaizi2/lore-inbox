Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758985AbWLAOUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758985AbWLAOUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758995AbWLAOUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:20:34 -0500
Received: from nebensachen.de ([195.225.107.202]:16523 "EHLO nebensachen.de")
	by vger.kernel.org with ESMTP id S1758954AbWLAOUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:20:33 -0500
From: Elias Oltmanns <eo@nebensachen.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Christoph Schmid <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it>
	<7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local>
	<20061130171910.GD1860@elf.ucw.cz>
X-Hashcash: 1:20:061201:linux-kernel@vger.kernel.org::yR7GDeFKpj0iKMJR:0000000000000000000000000000000002jB1
X-Hashcash: 1:20:061201:chris@schlagmichtod.de::qRKmPquMif5i0Ch0:0000000000000000000000000000000000000002Ifq
X-Hashcash: 1:20:061201:jens.axboe@oracle.com::U+SuPQmxtxocSXyv:00000000000000000000000000000000000000004jOv
X-Hashcash: 1:20:061201:pavel@ucw.cz::Cb67UvKnZg1M7bvH:000001Xf/
Date: Fri, 01 Dec 2006 15:19:55 +0100
In-Reply-To: <20061130171910.GD1860@elf.ucw.cz> (Pavel Machek's message of
	"Thu\, 30 Nov 2006 18\:19\:10 +0100")
Message-ID: <87k61bpuk4.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

thanks a lot for your first review. See comments below.

Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
[...]
>> Here is a short description of what the patch does in its current
>> shape:
>> 
>> 1. Adds functions to ide-disk.c and scsi_lib.c that issue an idle
>>    immediate with head unload or a standby immediate command as
>>    appropriate and stop the queue on command completion.
>
> Can we get short Documentation/ patch?

Sure. Would Documentation/block/disk-protection.txt be an appropriate
location?

[...]
>> +module_param_named(protect_method, libata_protect_method, int, 0444);
>> +MODULE_PARM_DESC(protect_method, "hdaps disk protection method  (0=autodetect, 1=unload, 2=standby)");
>
> Should this be configurable by module parameter? Why not tell each
> unload what to do?

As I understand, ATA specs expect drives to indicate whether they
support the head unload feature of the idle immediate command or not.
Unfortunately, a whole lot of them doesn't, well, mine doesn't anyway.
Since I know that my drive does actually support head unloading, I'd
like to tell the module so in order to prevent it from falling back to
standby immediate. Applications that issue disk parking requests
should not be bothered with this issue, in my opinion.

>
> Is /sys interface right thing to do?

Probably, you're right here. Since this feature is actually drive
specific, it should not really be set globally as a libata or ide-disk
parameter but specifically for each drive connected. Perhaps we should
add another attribute to /sys/block/*/queue or enhance the scope of
/sys/block/*/queue/protect?

[...]
>> +	else if (libata_protect_method == 2) {
>> +		unload = 0;	
>> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): standby method requested, overriding drive capability check..\n");
>> +	}
>> +	else if (ata_id_has_unload(dev->id)) {
>> +		unload = 1;
>> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support reported by drive..\n");
>> +	}
>> +	else {
>> +		unload = 0;
>> +		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support NOT reported by drive!..\n");
>> +	}
>
> Can we consolidate the strings somehow?

Actually, I'd like to move this to the initialisation sequence of the
drive. I still have to figure out how to do this properly.

[...]
>> +	/*
>> +	 * Auto-unfreeze state
>> +	 */
>> +	struct timer_list	unfreeze_timer;
>> +	int			max_unfreeze;	/* At most this many seconds */
>> +	struct work_struct	unfreeze_work;
>> +
>>  	struct backing_dev_info	backing_dev_info;
>>
>
> Should we have kernel doing auto-unfreeze? Perhaps we can just mlock()
> the daemon?
> 								Pavel

I'd strongly second Shem's comments on this. Besides, anybody with
root privileges can issue diks park requests, not just hdapsd. Please
note that this is not a hard timeout as userspace can always refresh
the timer before it has actually expired. On the other hand I would
not want to rely on user space to unfreeze my drives.

Regards

Elias
