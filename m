Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVGWUOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVGWUOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGWUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 16:14:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31919 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261870AbVGWUNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 16:13:05 -0400
Date: Sat, 23 Jul 2005 22:12:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <20050723191004.GB4345@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507232151150.3743@scrub.home>
References: <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com>
 <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home>
 <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home>
 <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home>
 <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home>
 <20050723191004.GB4345@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:

> > Jiffies are the basic time unit for kernel timers, hiding that fact gives 
> > users only wrong expectations about them.
> 
> We already have msleep() and msleep_interruptible(), which hide jiffies
> in milliseconds. These interfaces are their parallel in the wait-queue
> case. If you don't want to use them, or their use is not appropriate,
> then the callers won't be changed.

I'm not exactly impressed with their implementation, it's completely silly 
that there is no such convience function based on jiffies, e.g. if you 
look at the msleep_interruptible(), you'll find quite a few 
"msleep_interruptible(jiffies_to_msecs())".
msleep_interruptible() is especially bad as there are a few users who 
check the return value and since it adds one to the timeout, you can 
create loops which may never timeout (as e.g. in drivers/w1/w1_therm.c: 
w1_therm_read_bin()), this is nice example of a bad interface.

These two function should actually look like this:

static inline void msleep(unsigned int msecs)
{
	sleep(msecs_to_jiffies(msecs));
}

static inline int msleep_interruptible(unsigned int msecs)
{   
	sleep_interruptible(msecs_to_jiffies(msecs)) != 0;
}

> My goal is to distinguish between these cases in sleeping-logic:
> 
> 1) tick-oriented
> 	use schedule_timeout(), add_timer(), etc.
> 
> 2) time-oriented
> 	use schedule_timeout_msecs()

There is _no_ difference, the scheduler is based on ticks. Even if we soon 
have different time sources, the scheduler will continue to measure the 
time in ticks and for a simple reason - portability. Jiffies _are_ simple, 
don't throw that away.

bye, Roman
