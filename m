Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWAZBGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWAZBGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWAZBGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:06:55 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:43268 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932095AbWAZBGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:06:54 -0500
Message-ID: <43D81C8D.5000106@symas.com>
Date: Wed, 25 Jan 2006 16:49:17 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D814E1.7030600@shaw.ca>
In-Reply-To: <43D814E1.7030600@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Howard Chu wrote:
>> Kaz's post clearly interprets the POSIX spec differently from you. 
>> The policy can decide *which of the waiting threads* gets the mutex, 
>> but the releasing thread is totally out of the picture. For good or 
>> bad, the current pthread_mutex_unlock() is not POSIX-compliant. Now 
>> then, if we're forced to live with that, for efficiency's sake, 
>> that's OK, assuming that valid workarounds exist, such as inserting a 
>> sched_yield() after the unlock.
>>
>> http://groups.google.com/group/comp.programming.threads/msg/16c01eac398a1139?hl=en& 
>
>
> Did you read the rest of this post?
>
> "In any event, all the mutex fairness in the world won't solve the
> problem. Consider if this lock/unlock cycle is inside a larger
> lock/unlock cycle. Yielding at the unlock or blocking at the lock will
> increase the dreadlock over the larger mutex.

Basic "fairness" isn't the issue. Fairness is concerned with which of 
*multiple waiting threads* gets the mutex, and that is certainly 
irrelevant here. The issue is that the releasing thread should not be a 
candidate.

The mutex functions are a core part of the thread specification; they 
have a fundamental behavior, and the definition says if there are 
blocked threads waiting on a mutex when it gets unlocked, one of the 
waiting threads gets the mutex. Which of the waiting threads gets it is 
unspecified in the core spec. On a system that implements the scheduling 
option, the scheduling policy specifies which thread. The scheduling 
policy is an optional feature, it serves only to refine the core 
functionality. A program written to the basic core specification should 
not break when run in an environment that implements optional features.

The spec may be mandating a non-optimal behavior, but that's a 
side-issue - someone should file an objection with the Open Group to get 
it redefined if it's such a bad idea. But for now, the NPTL 
implementation is non-conformant.

Standards aren't just academic exercises. They're meant to be useful. If 
the standard is too thinly specified, is ambiguous, or allows 
nonsensical behavior, it's not useful and should be fixed at the source, 
not just ignored and papered over in implementations.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

