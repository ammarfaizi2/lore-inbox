Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWJXMTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWJXMTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWJXMTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:19:25 -0400
Received: from mx03.stofanet.dk ([212.10.10.13]:16808 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S1161020AbWJXMTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:19:24 -0400
Date: Tue, 24 Oct 2006 14:19:02 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: rtmutex's wait_lock in 2.6.18-rt7
In-Reply-To: <1161683163.22373.68.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610241408480.30444@frodo.shire>
References: <Pine.LNX.4.64.0610231150500.12557@frodo.shire>
 <1161683163.22373.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Oct 2006, Thomas Gleixner wrote:

> On Mon, 2006-10-23 at 11:55 +0200, Esben Nielsen wrote:
>> Hi,
>>   I see that in 2.6.18-rt7 the rtmutex's wait_lock is sudden interrupt
>> disabling. I don't see the need as no (hard) interrupt-handlers should be
>> touching any mutex.
>
> It does not touch mutexes, but the dynamic priority adjustment of the
> hrtimer softirq needs it.
>
> The correct solution will be moving the timer callback into the process
> context, as it will be woken up anyway, but that's more complex to do
> than it looks in the first place.
>

I have send out patches doing the correct priority adjustment without 
touching the wait_lock. Why not use that?

I found it in the archives:
  http://www.uwsg.iu.edu/hypermail/linux/kernel/0610.0/0049.html
(or more specific in 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0610.0/0051.html, look for 
changes to sched.c)

It is very bad to do PI traversal in interrupt context. In the general 
case, where there are user-space locks, that operation unbounded. I 
know that in your case you can only traverse kernel locks, but I think it 
is bad to open for such posibilities if it can be avoided.


Esben

> 	tglx
>
>
