Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUFNOWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUFNOWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUFNOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:20:37 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:36777 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263134AbUFNOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:19:24 -0400
Date: Mon, 14 Jun 2004 23:20:40 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 0/4]Diskdump Update
In-reply-to: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <B4C4521AC512CCindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004 20:34:01 +0900, Takao Indoh wrote:

>On Thu, 27 May 2004 14:51:34 +0100, Christoph Hellwig wrote:
>
>>> +/******************************** Disk dump ****************************
>>> *******/
>>> +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
>>> +#undef  add_timer
>>> +#define add_timer       diskdump_add_timer
>>> +#undef  del_timer_sync
>>> +#define del_timer_sync  diskdump_del_timer
>>> +#undef  del_timer
>>> +#define del_timer       diskdump_del_timer
>>> +#undef  mod_timer
>>> +#define mod_timer       diskdump_mod_timer
>>> +
>>> +#define tasklet_schedule        diskdump_tasklet_schedule
>>> +#endif
>>
>>Yikes.  No way in hell we'll place code like this in drivers. This needs
>>to be handled in common code.
>
>Another approach is insering some codes into the core timer and tasklet
>routines.
>
>For example, 
>
>static inline void add_timer(struct timer_list * timer)
>{
>	if(crashdump_mode())
>		__diskdump_add_timer(timer);
>	else
>		__mod_timer(timer, timer->expires);
>}
>
>But I do not want to make common codes dirty...
>Please let me know more good idea!


I forgot to explain what is problem. At first, I explain how diskdump
writes the system memory to the disk.

disk_dump() in drivers/block/diskdump.c is main routine of diskdump.
It is called from die()/panic().

First, disk_dump() silences system as follows.

	local_save_flags(flags);
	local_irq_disable();
	smp_call_function(freeze_cpu, NULL, 1, 0);

Diskdump disables interrupt and stops other cpus.
Next, after preparing for dump, diskdump starts dumping. Diskdump calls
driver's handler via scis_dump module. Driver's handler writes data to
the disk with polling mode.


What is a problem?  Scsi driver uses timer/tasklet to complete I/O.
But, diskdump disables interrupt, so timer/taslket doesn't work!

The current diskdump uses the following macros to solve this problem.

#define add_timer       diskdump_add_timer
#define del_timer_sync  diskdump_del_timer
#define del_timer       diskdump_del_timer
#define mod_timer       diskdump_mod_timer
#define tasklet_schedule        diskdump_tasklet_schedule

ex.
static inline void diskdump_add_timer(struct timer_list *timer)
{
	if (crashdump_mode())
		_diskdump_add_timer(timer);
	else
		add_timer(timer);
}

It's very easy way. If diskdump is working, timer is registered with
diskdump. Otherwise timer is registered with normal kernel timer. The
timer registered with diskdump is called by diskdump itself during
dumping.

This way is easy but ugly. Another way is add new codes into the core
timer and tasklet routines as I wrote in the previous mail.  I wondered
whether it is possible to insert general-purpose hooks into the timer/
taslket routine.

Please let me know if there is another good idea!


Best Regards,
Takao Indoh
