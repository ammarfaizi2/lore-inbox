Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVIYIJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVIYIJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIYIJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:09:09 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:18092 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751238AbVIYIJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:09:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ag48paQMqVznlzFDsfxPYpk5JIdlVKWma8uv6AhFUm+P0ep+W7UPMTXFIa9qjfUdCbGJd5MtOoxrTDJjgRfDp9W+XZEcs2hYyAEnLORtoJx344Y7OnApWuAu3ezIWimruRtwUSAJU/nN8ePzhh4sjUqUS9/br7iVX0X0e8Wt9fM=
Message-ID: <433659E7.5080007@gmail.com>
Date: Sun, 25 Sep 2005 17:03:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 04/04] brsem: convert cpucontrol to brsem
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.642A9DFD@htj.dyndns.org> <4336542D.4000102@yahoo.com.au>
In-Reply-To: <4336542D.4000102@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Tejun Heo wrote:
> 
>> +/*
>> + * cpucontrol is a brsem used to synchronize cpu hotplug events.
>> + * Invoking lock_cpu_hotplug() read-locks cpucontrol and no
>> + * hotplugging events will occur until it's released.
>> + *
>> + * Unfortunately, brsem itself makes use of lock_cpu_hotplug() and
>> + * performing brsem write-lock operations on cpucontrol deadlocks.
>> + * This is avoided by...
>> + *
>> + * a. guaranteeing that cpu hotplug events won't occur during the
>> + *    write-lock operations, and
>> + *
>> + * b. skipping lock_cpu_hotplug() inside brsem.
>> + *
>> + * #a is achieved by acquiring and releasing cpucontrol_mutex outside
>> + * cpucontrol write-lock.  #b is achieved by skipping
>> + * lock_cpu_hotplug() inside brsem if the current task is
>> + * cpucontrol_mutex holder (is_cpu_hotplug_holder() test).
>> + *
>> + * Also, note that cpucontrol is first initialized with
>> + * BRSEM_BYPASS_INITIALIZER and then initialized again with
>> + * __create_brsem() instead of simply using create_brsem().  This is
>> + * necessary as cpucontrol brsem gets used way before brsem subsystem
>> + * becomes up and running.
>> + *
>> + * Until brsem is properly initialized, all brsem ops succeed
>> + * unconditionally.  cpucontrol becomes operational only after
>> + * cpucontrol_init() is finished, which should be called after
>> + * brsem_init_early().
>> + */
> 
> 
> Mmm, this is just insane IMO.
> 
> Note that I happen to also think the idea (brsems) have merit, and
> that cpucontrol may be one of the places where a sane implementation
> would actually be useful... but at least when you're introducing
> this kind of complexity anywhere, you *really* need to be able to
> back it up with numbers.
> 
> As far as the VFS race fix goes, I guess Al or someone else will
> comment on its correctness. But I think it might be nicer to first
> fix it with a regular rwsem and then show some numbers to justify
> its conversion to a brsem.
> 
> If you need interruptible rwsems, I almost got an implementation
> working a while back, and David Howells recently said he was
> interested in doing them... so that's not an impossibility.
> 
> Nick
> 

  Hello, Nick.

  I do agree that it's absolutely ugly.  I thought about ripping the 
3-tage init'ing and cpu hotplug stuff as currently cpu hotplug locking 
isn't used frequently, but was just giving a shot.  I'll strip this 
thing out.

  Thanks.

-- 
tejun
