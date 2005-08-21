Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVHUBRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVHUBRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 21:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVHUBRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 21:17:39 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:48440 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750755AbVHUBRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 21:17:39 -0400
Date: Sat, 20 Aug 2005 19:04:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: sched_yield() makes OpenLDAP slow
In-reply-to: <4307788E.1040209@symas.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4307D320.90902@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>
 <4306AF26.3030106@yahoo.com.au> <4307788E.1040209@symas.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> I'll note that we removed a number of the yield calls (that were in 
> OpenLDAP 2.2) for the 2.3 release, because I found that they were 
> redundant and causing unnecessary delays. My own test system is running 
> on a Linux 2.6.12.3 kernel (installed over a SuSE 9.2 x86_64 distro), 
> and OpenLDAP 2.3 runs perfectly well here, now that those redundant 
> calls have been removed. But I also found that I needed to add a new 
> yield(), to work around yet another unexpected issue on this system - we 
> have a number of threads waiting on a condition variable, and the thread 
> holding the mutex signals the var, unlocks the mutex, and then 
> immediately relocks it. The expectation here is that upon unlocking the 
> mutex, the calling thread would block while some waiting thread (that 
> just got signaled) would get to run. In fact what happened is that the 
> calling thread unlocked and relocked the mutex without allowing any of 
> the waiting threads to run. In this case the only solution was to insert 
> a yield() after the mutex_unlock(). So again, for those of you claiming 
> "oh, all you need to do is use a condition variable or any of the other 
> POSIX synchronization primitives" - yes, that's a nice theory, but 
> reality says otherwise.

I encountered a similar issue with some software that I wrote, and used 
a similar workaround, however this was basically because there wasn't 
enough time available at the time to redesign things to work properly. 
The problem here is essentially caused by the fact that the mutex is 
being locked for an excessively large proportion of the time and not 
letting other threads in. In the case I am thinking of, posting the 
messages to the thread that was hogging the mutex via a signaling queue 
would have been a better solution than using yield and having correct 
operation depend on undefined parts of thread scheduling behavior..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

