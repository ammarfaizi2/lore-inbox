Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVLBBrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVLBBrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVLBBry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:47:54 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:47082 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S964771AbVLBBry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:47:54 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Rostedt <rostedt@goodmis.org>,
       johnstul@us.ibm.com, george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: dlang@dlang.diginsite.com
References: dlang@dlang.diginsite.com
Date: Thu, 1 Dec 2005 17:47:11 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <Pine.LNX.4.61.0512020219150.1610@scrub.home>
Message-ID: <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de><Pine.LNX.4.61.0512010118200.1609@scrub.home>
 <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com><Pine.LNX.4.61.0512011352590.1609@scrub.home><2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com><20051201165144.GC31551@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0512011828150.1609@scrub.home><1133464097.7130.15.camel@localhost.localdomain>
 <Pine.LNX.4.61.0512012048140.1609@scrub.home><Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com><Pine.LNX.4.61.0512020120180.1609@scrub.home>
 <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com><Pine.LNX.4.61.0512020146310.1609@scrub.home>
 <53ECF38B-8E27-4289-9DEA-06CA8374D97D@mac.com> <Pine.LNX.4.61.0512020219150.1610@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Roman Zippel wrote:

> Hi,
>
> On Thu, 1 Dec 2005, Kyle Moffett wrote:
>
>> My _point_ is that some code doesn't care about accuracy.
>
> That's not how it works, the timer wheel is accurate within its
> resolution.

but the point that is being made is that while this is true, there is a 
large group of functions that really don't care (the timeout case), and 
for that type of use it's possible to do some optimizations that make it 
extremely efficiant.

In addition, once you remove the bulk of these uses from the picture (by 
makeing them use a new timer type that's optimized for their useage 
pattern, the 'unlikly to expire' case) the remainder of the timer users 
easily fall into the catagory where the timer is expected to expire, so 
that code can accept a performance hit for removing events prior to them 
going off that would not be acceptable in a general case version.

the example of this is the networking timers. they almost never go off, 
but one is set for just about every packet that's processed. so adding any 
overhead in removing the unexpired timer has a large impact on 
performance.

but once this large group of timer users are removed, (along with a few 
other similar watchdog timers for disk I/O, etc) the remaining users will 
almost never remove the event before it goes off, so the code can be 
optimized for that situation (including things that would increase the 
cost to remove the unexpired event) and gain precision and possibly 
performance as well.

would the term 'watchdog' or 'watchdog_timer' for what's been refered to 
as the timeout timer make more sense to people? it's used when you need to 
setup a safety net around the possibility that an event won't happen, it's 
guarenteed not to fire before the time specified, but may have it's 
activation delayed slightly past that point.

then the rest of the uses could use the term 'timer', and that code is 
optimized for the timer actually expireing, removing an event that has not 
expired will be relativly costly.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
