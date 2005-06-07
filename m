Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVFGC07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFGC07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFGC07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:26:59 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:5027 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbVFGC0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:26:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qJa/v4YxL8GxzAylvxPRgeqrL7dXW1JDNsDKY4u5wFFv7sgg3+rfIr6H4/sYMn+VuiWDIXRK9RuPNWosbpPexGZ9VfOJLH6JI4iTFiO96/HQgn549uhTXdY81v6f2hcrEWgg+/OspCHg1Pjy89QFJr98vSPmuy7kG/yhRL0n2w4=
Message-ID: <42A505C2.6030206@gmail.com>
Date: Tue, 07 Jun 2005 11:26:10 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 08/09] blk: update IDE to use the
 new blk_ordered.
References: <20050605055337.6301E65A@htj.dyndns.org>	 <20050605055337.ADD601D4@htj.dyndns.org> <42A2A00F.9050402@pobox.com> <58cb370e050605071472e95465@mail.gmail.com>
In-Reply-To: <58cb370e050605071472e95465@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Jeff.
  Hello, Bartlomiej.

Bartlomiej Zolnierkiewicz wrote:
> On 6/5/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Tejun Heo wrote:
>>
>>>@@ -176,6 +176,18 @@ static ide_startstop_t __ide_do_rw_disk(
>>>                      lba48 = 0;
>>>      }
>>>
>>>+     if (blk_fua_rq(rq) &&
>>>+         (!rq_data_dir(rq) || !drive->select.b.lba || !lba48)) {
>>>+             if (!rq_data_dir(rq))
>>>+                     printk(KERN_WARNING "%s: FUA READ unsupported\n",
>>>+                            drive->name);
>>>+             else
>>>+                     printk(KERN_WARNING "%s: FUA request received but "
>>>+                            "cannot use LBA48\n", drive->name);
>>>+             ide_end_request(drive, 0, 0);
>>>+             return ide_stopped;
>>>+     }
>>>+
>>
>>
>>Does this string of tests really need to be added to the main fast path?
>>
>>It would be better to simply guarantee that this check need never exist
>>in the IDE driver, by guaranteeing that the block layer will never send
>>a FUA-READ command to a driver that does not wish it.
>>
>>        Jeff

  I am not particulary proud of the way I've modified the IDE driver 
but, to defend my ass a bit, the structure of __ide_do_rw_disk() was a 
little bit awkward to add FUA support as it first loads all address 
registers and then looks what to execute, and I didn't want to load 
taskfile registers only to abort the command.

  Currently none issues FUA READs, so the rq_data_dir() test can go away 
but I think it's just nice to have it there for completeness.  As the 
whole test is invoked only when blk_fua_rq() is true, I don't think the 
overhead will be anything accountable (or reducible).  And for the 
following select.b.lba and lba48 tests, we actually only need the lba48 
test but I wasn't really sure whether lba48 implies select.b.lba.  It 
seems it currently does but I couldn't find anything that guarantees it 
by design.  Bartlomiej, is it safe to skip select.b.lba test?

  I'll try to make it look better.  If you have any ideas, please let me 
know.

> 
> 
> Seconded, plus please use <linux/ata.h> instead of <linux/hdreg.h>
> for adding new opcodes.

  will do.

  Thank you a lot.

-- 
tejun
