Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTDKVY5 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTDKVY5 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:24:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27378 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261842AbTDKVYz (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:24:55 -0400
Message-ID: <3E973546.70809@mvista.com>
Date: Fri, 11 Apr 2003 14:36:06 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org,
       Chandrashekhar RS <chandra.smurthy@wipro.com>
Subject: Re: [BUG] settimeofday(2) succeeds for microsecond value more than
 USEC_PER_SEC and for negative value
References: <94F20261551DC141B6B559DC491086723E1028@blr-m3-msg.wipro.com>
In-Reply-To: <94F20261551DC141B6B559DC491086723E1028@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> Even then, I think, we can modify the settimeofday  code to check -1 and USEC_PER_SEC
> Conditions, can't we?
> 
Uh, sure.  This is the test I prefer:

	if( (unsigned long)tv->usec > USEC_PER_SEC)
		return EINVAL;

Note that the unsigned picks up the negative value as well as the > 
(and it does it in only one machine code test/jmp :)

This change should go in do_sys_settimeofday() in kernel/time.c.  It 
will fix both settimeofday and clock_settime(CLOCK_REALTIME,...  And 
also fixes it in all archs.

-g
		
> 
> |-----Original Message-----
> |From: george anzinger [mailto:george@mvista.com] 
> |Sent: Friday, April 11, 2003 11:56 AM
> |To: Aniruddha M Marathe
> |Cc: linux-kernel@vger.kernel.org; Chandrashekhar RS
> |Subject: Re: [BUG] settimeofday(2) succeeds for microsecond 
> |value more than USEC_PER_SEC and for negative value
> |
> |
> |Aniruddha M Marathe wrote:
> |> Settimeofday(2) should return EINVAL in case where 
> |tv.tv_usec parameter is more than 
> |> USEC_PER_SEC (more than 10^6 ) or for negative values of tv.tv_usec. 
> |> It returns 0 (success) instead.
> |> 
> |> Clock_settimeofday(2) (kernel/posix-timers.c) also uses 
> |do_sys_settimeofday() and faces the
> |> Same problem.
> |> 
> |> I think this is a bug. If you confirm, I will send a patch.
> |
> |Yes, it is a known problem, turned up by some the posix timers tests. 
> |  I suppose it is too much to ask, but it would be nice if 
> |do_sys_settimeofday() took a timespec instead of a timeval.  Of course 
> |this changes the interface for all the archs, but it would allow the 
> |clock_settimeofday to send in the nsec value.
> |
> |-g
> |
> |> 
> |> Regards,
> |> Aniruddha Marathe
> |> WIPRO Technologies, India
> |> -
> |> To unsubscribe from this list: send the line "unsubscribe 
> |linux-kernel" in
> |> the body of a message to majordomo@vger.kernel.org
> |> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> |> Please read the FAQ at  http://www.tux.org/lkml/
> |> 
> |
> |-- 
> |George Anzinger   george@mvista.com
> |High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> |Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
> |
> |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

