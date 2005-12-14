Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVLNPzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVLNPzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 10:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVLNPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 10:55:33 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:17615 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932198AbVLNPzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 10:55:33 -0500
Message-ID: <43A0406C.8020108@us.ibm.com>
Date: Wed, 14 Dec 2005 07:55:24 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
References: <439FCECA.3060909@us.ibm.com> <20051214100841.GA18381@elf.ucw.cz>
In-Reply-To: <20051214100841.GA18381@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>The overall purpose of this patch series is to all a system administrator
>>to reserve a number of pages in a 'critical pool' that is set aside for
>>situations when the system is 'in emergency'.  It is up to the individual
>>administrator to determine when his/her system is 'in emergency'.  This is
>>not meant to (necessarily) anticipate OOM situations, though that is
>>certainly one possible use.  The purpose this was originally designed for
>>is to allow the networking code to keep functioning despite the sytem
>>losing its (potentially networked) swap device, and thus temporarily
>>putting the system under exreme memory pressure.
> 
> 
> I don't see how this can ever work.
> 
> How can _userspace_ know about what allocations are critical to the
> kernel?!

Well, it isn't userspace that is determining *which* allocations are
critical to the kernel.  That is statically determined at compile time by
using the flag __GFP_CRITICAL on specific *kernel* allocations.  Sridhar,
cc'd on this mail, has a set of patches that sprinkle the __GFP_CRITICAL
flag throughout the networking code to take advantage of this pool.
Userspace is in charge of determining *when* we're in an emergency
situation, and should thus use the critical pool, but not *which*
allocations are critical to surviving this emergency situation.


> And as you noticed, it does not work for your original usage case,
> because reserved memory pool would have to be "sum of all network
> interface bandwidths * ammount of time expected to survive without
> network" which is way too much.

Well, I never suggested it didn't work for my original usage case.  The
discussion we had is that it would be incredibly difficult to 100%
iron-clad guarantee that the pool would NEVER run out of pages.  But we can
size the pool, especially given a decent workload approximation, so as to
make failure far less likely.


> If you want few emergency pages for some strange hack you are doing
> (swapping over network?), just put swap into ramdisk and swapon() it
> when you are in emergency, or use memory hotplug and plug few more
> gigabytes into your machine. But don't go introducing infrastructure
> that _can't_ be used right.

Well, that's basically the point of posting these patches as an RFC.  I'm
not quite so delusional as to think they're going to get picked up right
now.  I was, however, hoping for feedback to figure out how to design
infrastructure that *can* be used right, as well as trying to find other
potential users of such a feature.

Thanks!

-Matt
