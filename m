Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVHWAwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVHWAwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHWAwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:52:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30713 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750743AbVHWAwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:52:50 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124756775.5350.14.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124749192.17515.16.camel@dhcp153.mvista.com>
	 <1124756775.5350.14.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 22 Aug 2005 17:51:31 -0700
Message-Id: <1124758291.9158.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 20:26 -0400, Steven Rostedt wrote:

> 
> How would you add to a lock with just holding a lock for a task?  When
> you are grabbing a lock, you must first grab a raw lock associated to
> the lock being grabbed.  Although, I'm starting to look into this idea,
> and I'm going to first see if the current wait_lock could suffice.  I
> may also need to add an additional lock to the task to follow the lock
> -> task -> lock route.  The tasks order should be the same as the locks
> when the are bound (holding) a lock. Since the task won't be able to
> release it without holding the raw lock of the lock it is releasing.
> (boy this gets confusing to talk about, since you need to talk about
> locks and the locking method within the lock!)

You might need to explain that one more time . I'm sure it needs more
though, but the pi_lock just protects another cpu from enter
pi_setprio() . What we really want is to protect only the specific
structures modified inside pi_setprio() . Or that's my understanding .
Are you thinking of something else?

I think you would at least need to lock the wait_lock for each lock that
is looped over inside pi_setprio() . Because you access the wait_list
inside the loop .

There is also a pi_waiters list that is per task. You would need to make
a lock for that, I think . Or protect it somehow .

Daniel




