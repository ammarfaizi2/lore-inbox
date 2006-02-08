Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWBHPaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWBHPaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWBHPaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:30:13 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:44394 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030347AbWBHPaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:30:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c5ZaJYkLA9dA/yHNEy/YCzMNJ11cV5i+ZAIFwzt8d1OudGX9fYBqpbdvx7sXA5xmZXAjXJ1+e0G9XaiZ56W6clKcbPpuM7hGsqu+cYlRjqxWgSQFcMLuAGHCAR+WqyPJ27zbc9uN1ZAadQpNzyBQQUqL2gpRBNhMnMT3w/b70Jk=
Message-ID: <43EA0E7D.3030302@gmail.com>
Date: Thu, 09 Feb 2006 00:30:05 +0900
From: Tejun <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add execute_in_process_context() API
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>	 <p737j86l1es.fsf@verdi.suse.de> <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2006-02-08 at 09:06 +0100, Andi Kleen wrote:
> 
>>In general this seems like a lot of code for a simple problem.
>>It might be simpler to just put the work structure into the parent
>>object and do the workqueue unconditionally
> 
> 
> We can't do this.  For the target release, there may be multiple calls
> to the reap function ... if we embed in the structure we have no room
> for more than one.
> 
> 
>>>+	if (unlikely(!wqw)) {
>>>+		printk(KERN_ERR "Failed to allocate memory\n");
>>>+		WARN_ON(1);
>>
>>WARN_ON for GFP_ATOMIC failure is bad. It is not really a bug.
> 
> 
> Here, it means that the requested work wasn't executed.  In SCSI that
> would mean an object is now in place permanently.  The problem is that
> there's no real way to cope with failure in this case.
> 

Hi, James.

I haven't really looked at the code carefully, but I think one work 
struct + atomic counter (say pending_reap_cnt) should do it. 
queue_work() guarantees the work is run at least once after the call, so 
bumping pending_reap_cnt and queueing the work in target reap and 
reaping pending_reap_cnt times in the work should work.

-- 
tejun
