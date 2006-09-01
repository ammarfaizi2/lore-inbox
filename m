Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWIAVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWIAVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWIAVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38095 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750901AbWIAVYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:24:06 -0400
Message-ID: <44F8A4F1.4060506@redhat.com>
Date: Fri, 01 Sep 2006 17:24:01 -0400
From: Chris Snook <csnook@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.33.2] enforce RLIMIT_NOFILE in poll()
References: <20060901.PbR.07536400@egw.corp.redhat.com> <20060901034834.GB28317@1wt.eu> <200608312125.14564.vlobanov@speakeasy.net> <44F859CC.6060404@redhat.com> <20060901193135.GA28388@1wt.eu>
In-Reply-To: <20060901193135.GA28388@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Fri, Sep 01, 2006 at 12:03:24PM -0400, Chris Snook wrote:
>>Willy and Vadim --
>>
>>	We have received reports of apps which poll a large set of 
>>not-necessarily-valid file descriptors which worked fine under 2.4.18, 
>>when the check was only against NR_OPEN, which is 1024*1024, that fail 
>>under newer kernels.  So there is a real motivation to change the 
>>current code.  As for the patch breaking existing apps, there are really 
>>3 scenarios:
>>
>>1)	RLIMIT_NOFILE is at the default value of 1024
>>
>>	In this (default) case, the patch changes nothing.  Calls with nfds 
>>	> 1024 fail with EINVAL both before and after the patch, and calls with 
>>nfds <= 1024 pass the check both before and after the patch, since 1024 
>>is the initial value of max_fdset.
>>
>>2)	RLIMIT_NOFILE has been raised above the default
>>
>>	In this case, poll() becomes more permissive, allowing polling up to 
>>RLIMIT_NOFILE file descriptors even if less than 1024 have been opened. 
>> The patch won't introduce new errors here.  If an application somehow 
>>depends on poll() failing when it polls with duplicate or invalid file 
>>descriptors, it's already broken, since this is already allowed below 
>>1024, and will also work above 1024 if enough file descriptors have been 
>>open at some point to cause max_fdset to have been increased above nfds.
>>
>>3)	RLIMIT_NOFILE has been lowered below the default
>>
>>	In this case, the system administrator or the user has gone out of 
>>their way to protect the system from inefficient (or malicious) 
>>applications wasting kernel memory.  The current code allows polling up 
>>to 1024 file descriptors even if RLIMIT_NOFILE is much lower, which is 
>>not what the user or administrator intended.  Well-written applications 
>>which only poll valid, unique file descriptors will never notice the 
>>difference, because they'll hit the limit on open() first.  If an 
>>application gets broken because of the patch in this case, then it was 
>>already poorly/maliciously designed, and allowing it to work in the past 
>>was a violation of POSIX and a DoS risk on low-resource systems.
> 
> 
> OK, thanks very much for the details. Now, call me an idiot, but why
> don't you consider broken the apps which are currently failing on
> newer kernels ? I'm starting to suspect that we have to sets of apps :

I do consider them poorly designed, but they're out there, and they used 
to work, and it doesn't violate POSIX to allow them to work again, so 
all things being equal, I'd like them to work on new kernels.

>   - those which rely on poll() failing for invalid fds (do they really
>     exist ?)

I hope not.  If so, they're already broken in most situations anyway.

>   - those which rely on poll() not failing for invalid fds.

This is what we've gotten reports of.  I suspect we haven't heard much 
about this because in most cases the offending apps get fixed to not 
poll invalid fds, but for some deployed proprietary apps that may not be 
an option.

> The poll(2) man page suggests what you're saying. Man pages from other
> OSes found on the net suggest various behaviours. I guess it's better
> to stick to what has been documented (ie: your fix) but with *infinite
> care*. Apps which need more than 1024 fds are not end-user mp3 players.
> Breaking them in a stable branch can have a huge impact. I'd like this
> patch to be tested in 2.6 long before 2.4, and also it would be good
> if we could find some feedback from affected people which could confirm
> that your patch really fixes their problems. If you have some customers
> reporting the problem in RHEL who confirm the fix, it would be nice if
> they accepted to inform us about the application(s) which need this fix. 

I agree.  The 2.6 patch is in -mm now.  The patch has been tested 
successfully with a synthetic reproducer under various vanilla and RHEL 
2.4 and 2.6 kernels, but we're still waiting on real-world customer 
results.  Let's wait and see how the customer tests and the -mm patch go.

-- Chris

-- 
VGER BF report: H 4.82384e-11
