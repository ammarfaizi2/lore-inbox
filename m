Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUIOUCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUIOUCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUIOUCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:02:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37883 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267359AbUIOUCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:02:34 -0400
Message-ID: <41489EED.6090400@mvista.com>
Date: Wed, 15 Sep 2004 12:58:37 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Christoph Lameter <clameter@sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1095265942.29408.2847.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com>	 <1095268408.29408.2918.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.58.0409151025090.3219@schroedinger.engr.sgi.com> <1095274131.29408.2990.camel@cog.beaverton.ibm.com>
In-Reply-To: <1095274131.29408.2990.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
~

> 
> 
>>Real time features such as posix-timer's also depend on the ability to
>>deliver a signal at an exact point in time. Soft timers can only give a
>>very rough approximation in these cases.
>>
>>So I think this feature is essential.
> 
> 
> I think the functionality is essential, but that it doesn't belong in the time of day code.
> 
> Basically we have two things we're trying to do: 
> 
> 1. Keep accurate time 
> 2. Generate hardware interrupts accurately
> 
> While frequently the same hardware can do both, not all hardware is
> usable for both functions. Thus I believe we should cleanly split these
> two subsystems. My proposal only provided the keep accurate time part,
> however one could using that functionality, to then manipulate hardware
> interrupts to ensure accuracy in the timer subsystem.
> 
The thing I think is missing in all this is that, in some platforms, the 
hardware to provide the interrupts is more accurate.  We have, IMHO, three cases 
here:
a) The interrupts are accurate but the clock info (e.g. TSC) is not.
b) The clock in accurate but the timer is not, and
c) The clock and interrupt come from the same accurate hardware source.

The X86 is in class a) in that the PIT is accurate and the TSC is not.  The 
muddy part here is the pm-timer which is accurate but takes a _long_ time to access.

PPCs are in class c) as are some MIPS, ARM, and PARISC.  I am not sure about the 
rest and can not lay my hands on one of class b).

For the class a) machines, I think the best approach is to use a clock that has 
reasonable short term accuracy and to use the timer to, from time to time, 
correct it.  This should be on the order of an internal NTP sort of correction.

For the class a) and b) machines, I think it would be wise to not seperated the 
timer and the clock so much as to make it "hard" to use one to correct the other.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

