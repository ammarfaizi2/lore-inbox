Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUHSVs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUHSVs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUHSVs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:48:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36829 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267436AbUHSVsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:48:19 -0400
Message-ID: <4125208D.5070809@sgi.com>
Date: Thu, 19 Aug 2004 16:50:05 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408191237.16959.jbarnes@engr.sgi.com> <253460000.1092939952@flay> <200408191711.04776.jbarnes@engr.sgi.com>
In-Reply-To: <200408191711.04776.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse,

Jesse Barnes wrote:
> On Thursday, August 19, 2004 2:25 pm, Martin J. Bligh wrote:
> 
>>Does lockmeter not work for you? It's sitting in my tree still, and
>>Andrew's last time I looked.
> 
> 
> Ok, it seems to work at least a little (btw, oprofile cause the machine to be 
> unusable whenever a bunch of processes started up).
> 
> I got a bunch of scary messages like these though:
> 
> For cpu 140 entry 998 incremented kernel count=3
> Bad kernel cum_hold_ticks=-8658575876528 (FFFFF82004A91E50) for cpu=140 
> index=999
> For cpu 140 entry 999 incremented kernel count=3
> 
> John, what does that mean?  The lock contention was heavy, but I wouldn't 
> think that we'd overflow a 64 bit tick counter...
> 

What it means is that a read lock was found at the end of the measurement
interval in "read locked" state.  This is due to a trick used to account for
read lock hold times (rather than keeping track of the acquire and release
times and then incrementing the hold time at release time as in:

	hold_time += (release_time - acquire_time);

what is done instead is:

         hold_time -= acquire_time;

when the lock is acquired, then

         hold_time += release_time;

when the lock is released.  If the lock is still being held at the end of
the interval, then the 2nd hasn't been done, so the hold time appears
negative.

Anyway, the read lock handling is sufficiently busticated that we should
probably just remove it.  I have a patch someplace (years old) to fix this,
but it never seemed to be important to anyone, so it is still unapplied.

The stats for the spinlocks should be fine.

> The output is attached (my mailer insists on wrapping it if I inline it).  I 
> used 'lockstat -w'.
> 
> Jesse
> 
> 


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

