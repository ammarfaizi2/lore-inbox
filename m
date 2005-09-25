Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVIYIMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVIYIMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIYIMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:12:15 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:14347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751239AbVIYIMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:12:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b4MTv3bvojAjYx03nvuUGlGnVg1YkMp+RPzniwdn9igHHBNg4OmYVZB8uVGB8XvOh4g8oO+bN8+yjgufVdLPBlkH6EfdTC0y31U4B1D6VrdkgLhPyJFjuNLMNm4Icw0qJlLJzcYA70CybRgAb0YQYIkLXuC2xr0vCFKujN2hMiw=
Message-ID: <43365BCA.6030904@gmail.com>
Date: Sun, 25 Sep 2005 17:11:54 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au>
In-Reply-To: <43364F70.7010705@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Nick.

Nick Piggin wrote:
> Tejun Heo wrote:
> 
>> 01_brsem_implement_brsem.patch
>>
>>     This patch implements big reader semaphore - a rwsem with very
>>     cheap reader-side operations and very expensive writer-side
>>     operations.  For details, please read comments at the top of
>>     kern/brsem.c.
>>
> 
> This thing looks pretty overengineered. It is difficult to
> read with all the little wrapper functions and weird naming
> schemes.

  As I've said in the other reply, I'll first rip off three stage init 
thing for cpucontrol.  That added pretty much complexity to it.  And 
with the weird naming scheme, please tell me how to fix it.  I have no 
problem renaming things.

> What would be wrong with an array of NR_CPUS rwsems? The only
> tiny trick you would have to do AFAIKS is have up_read remember
> what rwsem down_read took, but that could be returned from
> down_read as a token.

  Using array of rwsems means that every reader-side ops performs 
(unnecessary) real down and up operations on the semaphore which involve 
atomic memory op and probably memory barrier.  These are pretty 
expensive operations.

  What brsem tries to do is implementing rwsem semantics while 
performing only normal (as opposed to atomic/barrier) intstructions 
during reader-side operations.  That's why all the call_on_all_cpus 
stuff is needed while write-locking.  Do you think avoiding 
atomic/barrier stuff would be an overkill?

> I have been meaning to do something like this for mmap_sem to
> see what happens to page fault scalability (though the heavy
> write-side would make such a scheme unsuitable for mainline).

  I agree that brsem write-locking would be too heavy for mmap_sep for 
usual cases.

  Thanks.

-- 
tejun
