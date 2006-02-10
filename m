Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWBJAVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWBJAVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWBJAVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:21:12 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:42567 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750831AbWBJAVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:21:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rYOMgc4m/8rfb/HN9yAJR3MnB3k2yqtBG1OV5KODROacZ5yorOE4zidgd5pQfhgj8Nn6wpMpPIIiqenitLQ/0i60yFryrBjw6yRzrDnckaw+jfd1p30qCI9vzHCmszdSZ0gBLTDP2wlV/HCnmbHfofOi42c8uyE2+UZkAzJBLok=
Message-ID: <43EBDC70.6050302@gmail.com>
Date: Fri, 10 Feb 2006 09:21:04 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: kill not-so-popular simple flag testing macros
References: <20060208085728.GA21065@htj.dyndns.org> <43EB8D2C.6020708@pobox.com>
In-Reply-To: <43EB8D2C.6020708@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> This patch kills the following request flag testing macros.
>>
>> blk_noretry_request()
>> blk_rq_started()
>> blk_pm_suspend_request()
>> blk_pm_resume_request()
>> blk_sorted_rq()
>> blk_barrier_rq()
>> blk_fua_rq()
>>
>> All above macros test for single request flag and not used widely and
>> seem to contribute more to obscurity than readability.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> heh, I guess that's a manner of opinion :)
> 
> To me, your patch makes things less readable.  Example:
> 
>> -    int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
>> +    int is_barrier = blk_fs_request(rq) && rq->flags & REQ_HARDBARRIER;
> 
> 
> After your change is applied, the above statement is no longer visually 
> consistent with itself.  The reader must decode two different styles of 
> test in his brain, as opposed to one.
> 

Hello, Jeff.

Yeah, I didn't like that line either, but the thing that triggered this 
patch is this message from Linus.  This is a reply to Andrew's 
dropped-from-rc message so not on lkml.


> I'm applying this under protest.
> 
> The code may be right, but it visually makes _zero_ sense.
> 
> The fact that "blk_barrier_rq()" only triggers on hard barriers means that 
> it does what you describe in the changelog, but read the code and see how 
> little sense it makes when you _read_ it. You just checked that the rq has 
> a barrier (either a soft or a hard one), and now you check "again" whether 
> it has a barrier.
> 
> That's what it looks like from reading the code. Confusing. And thus prone 
> to bugs.
> 

The code he was talking about looks like.

if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER) {
	....
	if (blk_barrier_rq(rq))
		q->ordcolor ^= 1;
	....
}

We could add blk_barrier_rq() to test for both flags and add 
blk_hardbarrier_rq() and blk_softbarrier_rq(), but the flags are not 
used that widely and some other flag testing macros are used only few 
times in core block layer, so I determined to kill infrequently used macros.

I agree that the change makes code harder to eyes in some places, but it 
doesn't obfuscate the code and results in less maintenance overhead in 
general.  Remember a few testing macros is okay but remembering a dozen 
gets a bit annoying, IMHO.

Thanks.

-- 
tejun
