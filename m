Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWHUAXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWHUAXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWHUAXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:23:42 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:4506 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932119AbWHUAXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:23:41 -0400
Message-ID: <44E8FD07.1010104@bigpond.net.au>
Date: Mon, 21 Aug 2006 10:23:35 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Solar Designer <solar@openwall.com>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
References: <20060820003840.GA17249@openwall.com>	 <1156097640.4051.24.camel@localhost.localdomain>	 <20060820221208.GA21754@openwall.com> <1156114275.4051.71.camel@localhost.localdomain>
In-Reply-To: <1156114275.4051.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Mon, 21 Aug 2006 00:23:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-08-21 am 02:12 +0400, ysgrifennodd Solar Designer:
>> Are you referring to killing of processes on OOM?  That was in Linux
>> already, this patch does not introduce it.
> 
> (pedantic) Only if you have overcommit disabled.
> 
>> As it relates to setuid() in particular, POSIX.1-2001 says:
>>
>>      The setuid() function shall fail, return -1, and set errno to the
>>      corresponding value if one or more of the following are true:
>>
>>      [EINVAL]
>>              The value of the uid argument is invalid and not supported by
>>              the implementation.
>>      [EPERM]                                                                                 The process does not have appropriate privileges and uid does
>>              not match the real user ID or the saved set-user-ID.
>>
>> No other error conditions are defined.  
> 
>> I'd say that the behavior of returning EAGAIN is non-compliant.
> 
> You are allowed to return other errors. What you must not do is return a
> different error for the description described in the text as I
> understand it.
> 
>> But the kills are needed.  They are more correct and safer than
>> returning EAGAIN.  An alternative would be to not allocate memory on
>> set*uid() at all - like we did not in older kernels - but that would
>> be an inappropriate behavior change for 2.4.
> 
> It is certainly an awkward case to get right when setuid code is not
> being audited but I still think you are chasing the symptom, and its not
> symptom of crap code, so you are not likely to "fix" security. A lot of
> BSD code for example doesn't check malloc returns but you don't want an
> auto-kill if mmap fails ?
> 
> The kill has the advantage that it stops the situation but it may also
> be that you kill a program which can handle the case and you create a
> new DoS attack (eg against a daemon switching to your uid). The current
> situation is not good, the updated situation could be far worse.
> 
> The message is important, we want to know it happened in the memory
> shortage case anyway.

How about going ahead with the uid change (if the current user is root) 
BUT still return -EAGAIN.  That way programs that ignore the return 
value will at least no longer have root privileges.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
