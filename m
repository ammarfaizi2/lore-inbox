Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbUKVJYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbUKVJYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUKVJYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:24:38 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:33038 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262013AbUKVJXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:23:36 -0500
Date: Mon, 22 Nov 2004 01:23:02 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041122092302.GA7210@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 09:29:23PM +0100, Esben Nielsen wrote:
> Hi,
>  From realfeel I wrote a small, simple test to test how well priority
> inheritance mechanism works. 
> 
> Basicly it samples how long a real-time task have to wait to get into a
> protected region while non-real-time tasks also try to get into the
> region (a character device). Their "job" in the region is to busy-loop for
> 1 ms. This ought to mimic how drivers and other parts of the kernel would
> work in a real real-time application: Real time tasks using the driver
> while non-real-time tasks also use the same driver.
> 
> With an ideal PI mutex the time the real-time task has to wait to get the
> lock should be between 0 and 1 ms. 0 when the mutex is uncongested and 1
> ms when one of the non-real-time tasks just got the mutex.

[private reply cut and pastes to the list as requested]

IMO, their needs to be statistical code in the mutex itself so that it can
measure the frequency of PI events as well as depth of the inheritance
chains and all data structure traversals. The problem with writing that
stuff now is that there isn't proper priority propagation through the entire
dependency chain in any mutex code that I've publically seen yet. Patching
this instrumentation in a mutex require a mutex with this built in
functionality. IMO, PI should be considered a kind of contention overload
condition and really a kind of fallback device to deal with these kind
of exceptional circumstances.

Turning this into a "priority inheritance world" is just going to turn
this project into the FreeBSD SMP project where nobody is working on fixing
the actual contention problems in the kernel and everybody is dependent on
overloading an already half-overloaded scheduler with priority calculations.
This eventually leads the kernel doing little effective work and is the main
technical reason why DragonFly BSD exists, a vastly superior BSD development
group (for many reasons).

http://citeseer.nj.nec.com/yodaiken01dangers.html

IMO, is a pretty fair assessment some of the failures of using a "late" PI.
It's not the whole story, but a pretty solid view of how it's been misunderstood,
overused and then flat out abused. There might be places where, if algorithmically
bounded somehow, reverting some of the heavy hammered sleeping locks back to
spinlocks would make the system faster and more controlled. rtc_lock possibly
could be one of those places and other places that are as heavily as used as
that.

That's my take on it.

bill

