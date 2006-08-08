Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWHHJs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWHHJs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWHHJs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:48:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:24557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932166AbWHHJs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:48:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=q0zF7GEdmspaJHbqDZ5Bkt5JgZ01Fsp1Gq9qNUKDxuH32Ui3oK7mgtKIrWSEsInXTrDCStsLa67WjPW/5h0L1LQdymcQpKpl37s1T9ekXTS6tccUfMk6X4xAcf+hRTYD8KGgdyu7MuXaXtm8ONxRj3UXH5kpYdm69UVCoezYRBI=
Message-ID: <44D85DFB.7050806@gmail.com>
Date: Tue, 08 Aug 2006 11:48:20 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@gehennom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex> <200608072247.59184.rjw@sisk.pl> <20060808084116.GF4025@suse.de>
In-Reply-To: <20060808084116.GF4025@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 07 2006, Rafael J. Wysocki wrote:
>> On Monday 07 August 2006 18:23, Jason Lunz wrote:
>>> In gmane.linux.kernel, you wrote:
>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>>>> I tried it and guess what :)... swsusp doesn't work :@.
>>>>
>>>> This time I was able to dump process states with sysrq-t:
>>>> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>>>>
>>>> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
>>>> suspending device 2.0
>>> Does it go away if you revert this?
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
>>>
>>> That should only affect resume, not suspend, but it does mess around
>>> with ide power management. Is this maybe happening on the *second*
>>> suspend?
>>>
>>>> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>>>> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
>>> This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
>> I found that git-block.patch broke the suspend for me.  Still have no idea
>> what's up with it.
> 
> Can you apply this on top of -mm and see if that fixes it?

It doesn't solve the problem for me.

> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index d2339e9..db647a9 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -390,7 +390,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
>  			args[5] = hwif->INB(IDE_HCYL_REG);
>  			args[6] = hwif->INB(IDE_SELECT_REG);
>  		}
> -	} else if (rq->cmd_type & REQ_TYPE_ATA_TASKFILE) {
> +	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
>  		ide_task_t *args = (ide_task_t *) rq->special;
>  		if (rq->errors == 0)
>  			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
> 

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
