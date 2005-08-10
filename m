Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVHJWkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVHJWkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVHJWkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:40:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61181 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932582AbVHJWkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:40:11 -0400
Message-ID: <42FA81B9.9020801@mvista.com>
Date: Wed, 10 Aug 2005 15:37:45 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com> <42F905DA.4070308@mvista.com> <20050810140528.GA20893@in.ibm.com>
In-Reply-To: <20050810140528.GA20893@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Tue, Aug 09, 2005 at 12:36:58PM -0700, George Anzinger wrote:
> 
>>IMNOHO, this is the ONLY way to keep proper time.  As soon as you 
>>reprogram the PIT you have lost track of the time.
> 
> 
> George,
> 	Can't TSC (or equivalent) serve as a backup while PIT is disabled,
> especially considering that we disable PIT only for short duration 
> in practice (few seconds maybe) _and_ that we don't have HRT support yet?
> 
I think it really depends on what you want.  If you really want to keep 
good time, the only rock in town is the one connected to the PIT (and 
the pmtimer).  The problem is, if you want the jiffie edge to be stable, 
there is just now way to reprogram the PIT to get it back to where it was.

In an old version of HRT I did a trick of loading a short count (based 
on reading the TSC or pmtimer) and then put the LATCH count on top of 
it.  In a correctly performing PIT, it should count down the short 
count, interrupt, load the long count and continue from there.  Aside 
from the machines that had BAD PITs (they reset on the load instead of 
the expiry of the current count) there were other problems that, in the 
end, cause loss of time (too fast, too slow, take your pick).  I also 
found PITs that signaled that they had loaded the count (they set a 
status bit) prior to actually loading it.  All in all, I find the PIT is 
just an ugly beast to try to program.  On the other hand, if you want 
regular interrupts at some fixed period, it will do this forever (give 
or take a epoch or two;) with out touching anything after the initial 
program set up.

In the end, I concluded that, for the community kernel, it is really 
best to just interrupt the irq line and leave the PIT run.  Then you use 
the TSC or pmtimer to figure the gross loss of interrupts and leave the 
PIT interrupt again to define the jiffie edge.  If you have other, more 
pressing, concerns I suppose you can program the PIT, but don't expect 
your wall clock to be as stable as it is now.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
