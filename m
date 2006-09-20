Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWITBOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWITBOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWITBOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:14:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45071 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750829AbWITBOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:14:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=ZXBRT8isuXdRuq72PJz2q+If3LjZPQIlF25MHedB1WxrF1pjkUnxzbYjd2L5/m9uF
	IwOW5B/4qb/fFxRi/Syzw==
Message-ID: <451095F1.3000304@google.com>
Date: Tue, 19 Sep 2006 18:14:25 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
References: <1158274508.14473.88.camel@localhost.localdomain>	 <20060915001151.75f9a71b.akpm@osdl.org>  <45107ECE.5040603@google.com> <1158709835.6002.203.camel@localhost.localdomain>
In-Reply-To: <1158709835.6002.203.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Tue, 2006-09-19 at 16:35 -0700, Mike Waychison wrote:
> 
>>Patch attached.
>>
>>As Andrew points out, the logic is a bit hacky and using a flag in 
>>current->flags to determine whether we have done the retry or not already.
>>
>>I too think the right approach to being able to handle these kinds of 
>>retries in a more general fashion is to introduce a struct 
>>pagefault_args along the page faulting path.  Within it, we could 
>>introduce a reason for the retry so the higher levels would be able to 
>>better understand what to do.
> 
> 
>  .../...
> 
> I need to re-read your mail and Andrew as at this point, I don't quite
> see why we need that args and/or that current->flags bit instead of
> always returning all the way to userland and let the faulting
> instruction happen again (which means you don't block in the kernel, can
> take signals etc... thus do you actually need to prevent multiple
> retries ?)
> 
> Ben.
> 
> 

I think the disconnect here is that the retries in the mmap_sem case and 
the returning short for a signal are two different beasts, but they 
would both want to use a NOPAGE_RETRY return code.

In the case of a signal, we definitely want to return back to userspace 
and deliver it.  However, for dropping the mmap_sem while waiting for 
the synchronous IO, it's a lot easier to directly rerun the fault 
handler so that we can make another pass without allowing the for the 
drop (avoiding livelock).

If we were to return to userspace after having dropped mmap_sem (without 
updating pte, because mm/vmas may change) we would lose major vs minor 
fault accounting as well.

Mike Waychison
