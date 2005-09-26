Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVIZEFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVIZEFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVIZEFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:05:36 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:24122 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932365AbVIZEFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:05:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ox2oXvLuGU73lCJyP1IopZLiua0ZcYojMuK11OsusRUx7E/na9DXzboEt5W2ogNzWx6COcAwuFf4eQy0PPE9thHujz65HC0JVTUFjtnXSQkO4ActvF1oFHuq3ztjebJ9ofsKOQ748I1TH8kK2jWXq/2KhBo77FIoUV574sqBvro=
Message-ID: <43377388.9000004@gmail.com>
Date: Mon, 26 Sep 2005 13:05:28 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Nathan Lynch <ntl@pobox.com>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 04/04] brsem: convert cpucontrol to brsem
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.642A9DFD@htj.dyndns.org> <4336542D.4000102@yahoo.com.au> <20050925234603.GA3577@otto> <43374AC6.8070805@yahoo.com.au>
In-Reply-To: <43374AC6.8070805@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Nathan & Nick.

Nick Piggin wrote:
> Nathan Lynch wrote:
> 
>> Nick Piggin wrote:
>>
>>>
>>> Note that I happen to also think the idea (brsems) have merit, and
>>> that cpucontrol may be one of the places where a sane implementation
>>> would actually be useful... but at least when you're introducing
>>> this kind of complexity anywhere, you *really* need to be able to
>>> back it up with numbers.
>>>
>>
>> The only performance-related complaint with cpu hotplug of which I'm
>> aware -- that taking a cpu down on a large system can be painfully
>> slow -- resides in the "write side" of the code, which is not the case
>> that the brsem implementation optimizes.  I think this patch would
>> make that case even worse.  So I don't think it's appropriate to use a
>> brsem for cpu hotplug, especially without trying rwsem first.
>>
>>

  Actually, a patch which converts cpucontrol to rwsem was once in -mm. 
  I don't know what happened to it.  I can't see it in 2.6.13-rc2-mm1.

> 
> I'm not sure that a brsem would make a noticable difference.
> 
> It isn't that cpu hotplug semaphore is a performance problem
> now, but that it isn't being used in as many cases as it could
> be due to its unscalable nature. For example, a while back I
> wanted to use it in the fork() path in the scheduler but
> couldn't.

  I couldn't have put it better.  As it currently stands, cpucontrol 
doesn't have any heavy readers.  It's partly because it's not necessary 
but at least for some part it's because it cannot be used in such cases 
as the overhead is too big.  The same is true for super->s_umount rwsem 
- read_down'ing per-fs rwsem on every write(2) will hurt performance on 
SMP machines.  I think we'll have more and more of this class of 
synchronization problems as we add hotplug capability to subsystems.

  Having spent a week on implementing something very ugly :-), I'm a bit 
embarrased here but I still want to point out that we need something to 
solve this problem.

> Anyway, as I said, you need to be able to back it up with
> numbers ;)

  Right, gotta benchmark before committing full implementation.

  Thanks.

-- 
tejun
