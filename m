Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVHVWMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVHVWMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVHVWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:12:34 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751303AbVHVWMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:12:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4307D320.90902@shaw.ca>
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca> <4306AF26.3030106@yahoo.com.au> <4307788E.1040209@symas.com> <4307D320.90902@shaw.ca>
X-OriginalArrivalTime: 22 Aug 2005 11:44:33.0009 (UTC) FILETIME=[DD0F8610:01C5A70E]
Content-class: urn:content-classes:message
Subject: Re: sched_yield() makes OpenLDAP slow
Date: Mon, 22 Aug 2005 07:44:04 -0400
Message-ID: <Pine.LNX.4.61.0508220735370.18402@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sched_yield() makes OpenLDAP slow
Thread-Index: AcWnDt0Wc6qfMzWSQWKQxoCWmXu/ww==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Aug 2005, Robert Hancock wrote:

> Howard Chu wrote:
>> I'll note that we removed a number of the yield calls (that were in
>> OpenLDAP 2.2) for the 2.3 release, because I found that they were
>> redundant and causing unnecessary delays. My own test system is running
>> on a Linux 2.6.12.3 kernel (installed over a SuSE 9.2 x86_64 distro),
>> and OpenLDAP 2.3 runs perfectly well here, now that those redundant
>> calls have been removed. But I also found that I needed to add a new
>> yield(), to work around yet another unexpected issue on this system - we
>> have a number of threads waiting on a condition variable, and the thread
>> holding the mutex signals the var, unlocks the mutex, and then
>> immediately relocks it. The expectation here is that upon unlocking the
>> mutex, the calling thread would block while some waiting thread (that
>> just got signaled) would get to run. In fact what happened is that the
>> calling thread unlocked and relocked the mutex without allowing any of
>> the waiting threads to run. In this case the only solution was to insert
>> a yield() after the mutex_unlock(). So again, for those of you claiming
>> "oh, all you need to do is use a condition variable or any of the other
>> POSIX synchronization primitives" - yes, that's a nice theory, but
>> reality says otherwise.
>
> I encountered a similar issue with some software that I wrote, and used
> a similar workaround, however this was basically because there wasn't
> enough time available at the time to redesign things to work properly.
> The problem here is essentially caused by the fact that the mutex is
> being locked for an excessively large proportion of the time and not
> letting other threads in. In the case I am thinking of, posting the
> messages to the thread that was hogging the mutex via a signaling queue
> would have been a better solution than using yield and having correct
> operation depend on undefined parts of thread scheduling behavior..
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>

I reported thet sched_yield() wasn't working (at least as expected)
back in March of 2004.

 		for(;;)
                     sched_yield();

... takes 100% CPU time as reported by `top`. It should take
practically 0. Somebody said that this was because `top` was
broken, others said that it was because I didn't know how to
code. Nevertheless, the problem was not fixed, even after
schedular changes were made for the current version.

  One can execute:

 		usleep(0);
... instead of:
 		sched_yield();

... and Linux then performs exactly like other Unixes when
code is waiting on mutexes.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
