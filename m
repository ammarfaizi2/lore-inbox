Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269439AbTGOVi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269514AbTGOVi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:38:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45555 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269439AbTGOVi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:38:56 -0400
Message-ID: <3F1477B2.6090106@mvista.com>
Date: Tue, 15 Jul 2003 14:52:50 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au, rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: Re: do_div64 generic
References: <3F1360F4.2040602@mvista.com> <200307150717.54981.bernie@develer.com> <20030714223805.4e5bee3f.akpm@osdl.org> <200307150823.01602.bernie@develer.com>
In-Reply-To: <200307150823.01602.bernie@develer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> On Tuesday 15 July 2003 07:38, Andrew Morton wrote:
> 
> 
>>> Here's a patch that takes care of all architectures.
>>
>>AFAICT, we can just rework posix-timers.c to use the standard do_div() and
>>be done with it, can we not?  ie: no div_long_long_rem(), no
>>div_ll_X_l_rem().  Just do_div().
> 
> 
> We could, and it would be easy and almost as efficient in all places
> where div_long_long_rem() is being used:
> 
>    value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
> 
> becomes:
> 
>    value->tv_nsec = do_div(nsec, NSEC_PER_SEC);
>    value->tv_sec = nsec;
> 
> George, do you agree? May I go on and post a patch killing
> div_long_long_rem() everywhere?

The issue is that div is a very long instruction and the do_div() 
thing uses 2 or three of them, while the div_long_long_rem() is just 
1.  Also, a lot of archs already have the required div by a different 
name.  It all boils down to a performance thing.

-g
> 
> 
>>Please use `static inline', not `extern inline', btw.
> 
> 
> Oops. Fixed. I had just copied it over from asm-i386/div64.h.
> 
> Is it worth posting a big patch to replace all remaining
> occurrences of 'extern inline' all over the kernel?
> 
> I'd also like to point out that __inline__ is often being
> used inconsistently. We should be using __inline__ rather
> than inline in public headers needed by glibc for apps
> compiled with -ansi. Since it's so ugly, it shouldn't
> be used in other places.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

