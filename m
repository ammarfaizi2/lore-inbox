Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVFIGpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVFIGpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVFIGpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:45:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262304AbVFIGoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:44:07 -0400
Message-ID: <42A7E52E.5040101@pobox.com>
Date: Thu, 09 Jun 2005 02:43:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Grant Coady <grant_lkml@dodo.com.au>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #4
References: <20050608102857.GC18490@suse.de> <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com> <20050608114150.GE18490@suse.de> <20050608114526.GF18490@suse.de> <tbgea15ls0a5kovgnsr62fkhtgnspmjfeg@4ax.com> <20050609062338.GC5140@suse.de> <20050609064031.GF5140@suse.de>
In-Reply-To: <20050609064031.GF5140@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jun 09 2005, Jens Axboe wrote:
> 
>>On Thu, Jun 09 2005, Grant Coady wrote:
>>
>>>On Wed, 8 Jun 2005 13:45:26 +0200, Jens Axboe <axboe@suse.de> wrote:
>>>
>>>>Any chance you can log the boot process when it fails, using serial
>>>>console or something similar? At least write down the EIP of where it
>>>>fails :-)
>>>
>>>Guess what?  I switched box on this morning with monitor off and 
>>>the boot completed, 'cos I'd logged in much time later ssh.  Didn't 
>>>give it enough time yesterday :(
>>>
>>>I have one very large syslog... 139MB
>>>
>>>How much of that would you like :)
>>>
>>>Jun  9 04:27:45 sempro kernel:  [<c0100ad3>] default_idle+0x23/0x30
>>>Jun  9 04:27:45 sempro kernel:  [<c0100b58>] cpu_idle+0x48/0x60
>>>Jun  9 04:27:45 sempro kernel:  [<c04867b8>] start_kernel+0x148/0x170
>>>Jun  9 04:27:45 sempro kernel:  [<c04863a0>] unknown_bootoption+0x0/0x1b0
>>>Jun  9 04:27:45 sempro kernel: Badness in __ata_qc_complete at drivers/scsi/libata-core.c:3062
>>
>>Ah duh, I never tested on UP, you have to use assert_spin_locked() there
>>not the direct spin_is_locked().
>>
>>So your system was functioning just fine, you just got a warning for
>>every completed request slowing it down a lot :)
>>
>>This should fix it. Jeff, can you apply that incremental to the ncq
>>branch? Thanks!
>>
>>--- linux-2.6/drivers/scsi/libata-core.c~	2005-06-09 08:20:34.000000000 +0200
>>+++ linux-2.6/drivers/scsi/libata-core.c	2005-06-09 08:22:24.000000000 +0200
>>@@ -3059,7 +3059,7 @@
>> 	struct ata_port *ap = qc->ap;
>> 	unsigned int tag, do_clear = 0;
>> 
>>-	WARN_ON(!spin_is_locked(&ap->host_set->lock));
>>+	WARN_ON(!assert_spin_locked(&ap->host_set->lock));
>> 
>> 	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
>> 		assert(ap->queue_depth);
> 
> 
> Or just kill the check completely, it has served its purpose.

The solution that included the patch won the battle ;-)

I'll be pushing your incremental update out to kernel.org in a sec.

	Jeff



