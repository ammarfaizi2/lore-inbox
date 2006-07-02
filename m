Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWGBMqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWGBMqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 08:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWGBMqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 08:46:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:42897 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751365AbWGBMqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 08:46:23 -0400
Message-ID: <44A7C00A.7040001@tw.ibm.com>
Date: Sun, 02 Jul 2006 20:46:02 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com> <44A78599.9060405@free.fr> <44A7A0C8.80108@free.fr>
In-Reply-To: <44A7A0C8.80108@free.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> matthieu castet wrote:
> 
>> Hi Albert,
>>
>> Albert Lee wrote:
>>
>>> castet.matthieu@free.fr wrote:
>>>
>>>>
>>>>> Could you please test the current libata-upstream tree and
>>>>> turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.
>>>>>
>>>>
>>>> Is there a easy way to get libata-upstream tree ?
>>>> Do I need to install git for that or there are some snapshots
>>>> somewhere ?
>>>>
>>>>
>>>
>>>
>>> Hi Matthieu,
>>>
>>> Tejun has a patch against 2.6.17:
>>> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2
>>>
>>>
>> I don't know if I did someting wrong, but it didn't apply cleanly.
>> So I enable the trace on lastest -mm kernel and I disable the via quirk.
>>
>> But the printk in the interrupt handler takes some times and hides the
>> altstatus delay.
>>
>> I will try to send you a trace, where I move the printk at the end of
>> the interrupt handler.
>>
>>
> After apllying the following patch to -mm, I got
> http://castet.matthieu.free.fr/tmp/ata_log
> 
> Matthieu

Hi Matthieu,

Thanks for the log. But could you please keep the 
VPRINTK() in the entrance of ata_host_intr() and add some message to
distinguish the three VPRINTK()s?

(This will make the log easier to read. Detail below.)


> 
> 
> ------------------------------------------------------------------------
> 
> Index: linux-2.6.16/drivers/scsi/libata-core.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/scsi/libata-core.c	2006-07-02 10:32:33.000000000 +0200
> +++ linux-2.6.16/drivers/scsi/libata-core.c	2006-07-02 10:38:03.000000000 +0200
> @@ -4722,9 +4722,6 @@
>  {
>  	u8 status, host_stat = 0;
>  
> -	VPRINTK("ata%u: protocol %d task_state %d\n",
> -		ap->id, qc->tf.protocol, ap->hsm_task_state);
> -

Please keep this VPRINTK() and add "ENTER" to it. Something like
"ata%u: ENTER protocol...".

>  	/* Check whether we are expecting interrupt in this state */
>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> @@ -4780,6 +4777,9 @@
>  	ap->ops->irq_clear(ap);
>  
>  	ata_hsm_move(ap, qc, status, 0);
> +	VPRINTK("ata%u: protocol %d task_state %d\n",
> +		ap->id, qc->tf.protocol, ap->hsm_task_state);
> +
>  	return 1;	/* irq handled */
>  

Please add additional message "HANDLED" to this VPRINTK(). Something like
"ata%u: HANDLED protocol...".

>  idle_irq:
> @@ -4792,6 +4792,9 @@
>  		return 1;
>  	}
>  #endif
> +	VPRINTK("ata%u: protocol %d task_state %d\n",
> +		ap->id, qc->tf.protocol, ap->hsm_task_state);
> +
>  	return 0;	/* irq not handled */
>  }

Please add additional message "IGNORED" to this VPRINTK(). Something like
"ata%u: IGNORED protocol ...". 



Thanks,

Albert


