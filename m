Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbWJ3Sfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbWJ3Sfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWJ3Sfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:35:43 -0500
Received: from rtr.ca ([64.26.128.89]:51465 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030546AbWJ3Sfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:35:41 -0500
Message-ID: <454645FA.3060203@rtr.ca>
Date: Mon, 30 Oct 2006 13:35:38 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk> <454644C1.4080702@rtr.ca>
In-Reply-To: <454644C1.4080702@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And while we're at it:
> 
> (gdb) l *cfq_set_request+0x33e
> 0xc021780e is in cfq_set_request (block/cfq-iosched.c:1224).
> 1219            if (unlikely(!cfqd))
> 1220                    return;
> 1221
> 1222            spin_lock(cfqd->queue->queue_lock);
> 1223
> 1224            cfqq = cic->cfqq[ASYNC];
> 1225            if (cfqq) {
> 1226                    struct cfq_queue *new_cfqq;
> 1227                    new_cfqq = cfq_get_queue(cfqd, CFQ_KEY_ASYNC, cic->ioc->task,
> 1228                                             GFP_ATOMIC);

(gdb) l *scsi_device_unbusy+0x67
0xc029ee87 is in scsi_device_unbusy (drivers/scsi/scsi_lib.c:466).
461                          (shost->host_failed || shost->host_eh_scheduled)))
462                     scsi_eh_wakeup(shost);
463             spin_unlock(shost->host_lock);
464             spin_lock(sdev->request_queue->queue_lock);
465             sdev->device_busy--;
466             spin_unlock_irqrestore(sdev->request_queue->queue_lock, flags);
467     }
468
469     /*
470      * Called for single_lun devices on IO completion. Clear starget_sdev_user,
