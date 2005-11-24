Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVKXL7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVKXL7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVKXL7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 06:59:05 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:20154 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932636AbVKXL7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 06:59:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X93VEsDyrjt/aSAFOJo+jeO/bva4aWwSfzNwLpfUGbjGzeUJf2RTWzqlKyaZkWaaJJJKLlinLeHX2b40lnRVktfqI2xbus23DH7zHV2o0EZnpiiKGqYLvlrQPPLbDskLSba2XlEabuK+oEiBVKdaGhRs4oRhetAxXprrUjFyywM=
Message-ID: <4385AAFB.5070605@gmail.com>
Date: Thu, 24 Nov 2005 20:58:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support
 to IDE
References: <20051117153509.B89B4777@htj.dyndns.org>	 <20051117153509.5A77ED53@htj.dyndns.org>	 <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>	 <437DF271.6050702@gmail.com> <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com>
In-Reply-To: <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bartlomiej.

Bartlomiej Zolnierkiewicz wrote:
> On 11/18/05, Tejun Heo <htejun@gmail.com> wrote:
> 
>>Hi, Bartlomiej.
>>
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
>>>
>>>What does happen for fua && drive->vdma case?
>>>
>>
>>Thanks for pointing out, wasn't thinking about that.  Hmmm... When using
>>vdma, single-sector PIO commands are issued instead but there's no
>>single-sector FUA PIO command.  Would issuing
>>ATA_CMD_WRITE_MULTI_FUA_EXT instead of ATA_CMD_WRITE_FUA_EXT work?  Or
>>should I just disable FUA on vdma case?
> 
> 
> Probably it should work fine given that drive->mult_count is on.
> 
> The only controller using drive->vdma in the current tree is cs5520
> so you should confirm this with Mark Lord & Alan Cox.
> 

This is done without too much trouble.

> 
>>>>                       } else {
>>>>                               command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
>>>>                               if (drive->vdma)
>>>>@@ -284,8 +298,20 @@ static ide_startstop_t __ide_do_rw_disk(
>>>>       } else {
>>>>               if (drive->mult_count) {
>>>>                       hwif->data_phase = TASKFILE_MULTI_OUT;
>>>>-                       command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
>>>>+                       if (!fua)
>>>>+                               command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
>>>>+                       else
>>>>+                               command = ATA_CMD_WRITE_MULTI_FUA_EXT;
>>>>               } else {
>>>>+                       if (unlikely(fua)) {
>>>>+                               /*
>>>>+                                * This happens if multisector PIO is
>>>>+                                * turned off during operation.
>>>>+                                */
>>>>+                               printk(KERN_ERR "%s: FUA write but in single "
>>>>+                                      "sector PIO mode\n", drive->name);
>>>>+                               goto fail;
>>>>+                       }
>>>
>>>
>>>Wouldn't it be better to do the following check at the beginning
>>>of __ide_do_rw_disk() (after checking for dma vs lba48):
>>>
>>>        if (fua) {
>>>                if (!lba48 || ((!dma || drive->vdma) && !drive->mult_count))
>>>                        goto fail_fua;
>>>        }
>>>
>>>...
>>>
>>>and fail the request if needed *before* actually touching any
>>>hardware registers?
>>>
>>>fail_fua:
>>>        printk(KERN_ERR "%s: FUA write unsupported (lba48=%u dma=%u"
>>>                                       " vdma=%u mult_count=%u)\n", drive->name,
>>>                                       lba48, dma, drive->vdma,
>>>drive->mult_count);
>>>        ide_end_request(drive, 0, 0);
>>>        return ide_stopped;
>>>
>>
>>Hmmm... The thing is that those failure cases will happen extremely
>>rarely if at all.  Remember this post?
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=111798102108338&w=3
>>
>>It's mostly guaranteed that those failure cases don't occur, so I
>>thought avoiding IO on failure case wasn't that helpful.
> 
> 
> There are two problems with this approach:
> 
> * configuration can change dynamically
> * locking for configuration changes is flakey
> 
> so it can happen that FUA request will slip into __ide_do_rw_disk().
> 
> The best way to deal with such case is to kill it early without
> touching I/O registers and/or DMA engine and causing big havoc.
> 

I've taken your advice and added the test at the top.

> 
>>>>@@ -967,10 +997,19 @@ static void idedisk_setup (ide_drive_t *
>>>>                       barrier = 0;
>>>>       }
>>>>
>>>>-       printk(KERN_INFO "%s: cache flushes %ssupported\n",
>>>>-               drive->name, barrier ? "" : "not ");
>>>>+       fua = barrier && idedisk_supports_lba48(id) && ide_id_has_fua(id);
>>>>+       /* When using PIO, FUA needs multisector. */
>>>>+       if ((!drive->using_dma || drive->hwif->no_lba48_dma) &&
>>>>+           drive->mult_count == 0)
>>>>+               fua = 0;
>>>
>>>
>>>Shouldn't this check also for drive->vdma?
>>>
>>
>>Yes, it does.  Thanks for pointing out.  One question though.  FUA
>>support should be changed if using_dma/mult_count settings are changed.
>>  As using_dma configuration is handled by IDE midlayer, we might need
>>to add a callback there.  What do you think?
> 
> 
> It seems it is needed nowadays as there are multiple I/O barrier methods.
> 
> Maybe the other alternative is to add ->rq_select_barrier() hook to the
> block layer and for each request check what kind of barrier should be
> issued (it still won't help for flakey configuration locking but you won't
> have to add any callbacks etc).
> 
> Long-term we should see if it is possible to remove dynamic IDE
> drive configuration and always just use the best possible settings.

Well, this one is quite a pain in the ass.

I'm not very fond of ->rq_select_barrier() approach for the following 
reasons.

* That removes possibility of correct synchronization.  With 
blk_queue_ordered() approach, we can later add 
blk_queue_[un]lock_ordered() to achieve correct synchronization if that 
becomes necessary, but with ->rq_select_barrier() approach, the 
low-level driver ends up having less control over what's gonna happen when.

* Changing ordered mode is not supposed to be a frequent operation and 
the blk_queue_ordered() interface makes that explicit.

So, I added ide_driver_t->protocol_changed() callback which gets called 
whenever dma/multimode changes occur.  Unfortunately, dma/multmode 
changes can be committed with or without context, and with or without 
queue lock.  As blk_queue_ordered uses the queue lock for 
synchronization, this becomes issue.

I tried to distinguish places where the changes occur while queue lock 
is held from the other.  Not only was it highly error-prone, it couldn't 
be done without modifying/auditing all low-level drivers as some drivers 
(cs5520) use the same function which touches dma setting 
(cs5520_tune_chipset) from both ->speedproc (called with queuelock) and 
->ide_dma_check (called without queuelock).

One alternative I'm thinking of is using a workqueue to call 
blk_queue_ordered, such that we don't have to guess whether or not we're 
called with queuelock held.  Unfortunately, this will give us a small 
window where wrong barrier requests can hit the drive.

Bartlomiej, any ideas?

Jens, as this one seems to need some time to settle, I'm gonna post 
updated patchset for post-2.6.15 without ide-fua patch, so that the 
other stuff can be pushed into -mm.  I think we can live without ide-fua 
for a while.  :-)

Thanks.

-- 
tejun
