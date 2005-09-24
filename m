Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVIXSdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVIXSdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 14:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVIXSdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 14:33:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19462 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932226AbVIXSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 14:33:42 -0400
Date: Sat, 24 Sep 2005 20:30:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050924183048.GA26197@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924171928.GF3950@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 10:19:28AM -0700, Nishanth Aravamudan wrote:
 
> Here is the patch I was referring to, adapted to the epoll use of
> schedule_timeout(). A similar fix is in -mm for almost identical code in
> sys_poll().
> 
> Description: The @timeout parameter to ep_poll() is in milliseconds but
> we compare it to (MAX_SCHEDULE_TIMEOUT - 1000 / HZ), which is
> (jiffies/jiffies-per-sec) or seconds. That seems blatantly broken.

as you've seen in my last mail, it happens to be valid because it checks
for the multiply overflow before doing it. But it's only after a math
demonstration that it appears valid anyway ;-)

> This
> led to improper overflow checking for @timeout. As Andrew Morton pointed
> out in a similar fix for sys_poll(), the best solution is to to check
> for potential overflow first, then either select an indefinite value or
> convert @timeout.
> 
> To achieve this and clean-up the code, change the prototype of the
> ep_poll() to make it clear that the parameter is in milliseconds and
> rename jtimeout to timeout_jiffies to hold the corresonding jiffies
> value.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> ---
> 
>  fs/eventpoll.c |   46 ++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff -urpN 2.6.14-rc2-mm1/fs/eventpoll.c 2.6.14-rc2-mm1-dev/fs/eventpoll.c
> --- 2.6.14-rc2-mm1/fs/eventpoll.c	2005-09-21 23:50:28.000000000 -0700
> +++ 2.6.14-rc2-mm1-dev/fs/eventpoll.c	2005-09-24 10:07:51.000000000 -0700
> @@ -260,7 +260,7 @@ static int ep_events_transfer(struct eve
>  			      struct epoll_event __user *events,
>  			      int maxevents);
>  static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> -		   int maxevents, long timeout);
> +		   int maxevents, long timeout_msecs);
>  static int eventpollfs_delete_dentry(struct dentry *dentry);
>  static struct inode *ep_eventpoll_inode(void);
>  static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
> @@ -1494,11 +1494,12 @@ static int ep_events_transfer(struct eve
>  
>  
>  static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> -		   int maxevents, long timeout)
> +		   int maxevents, long timeout_msecs)
>  {
>  	int res, eavail;
> +	int overflow;
>  	unsigned long flags;
> -	long jtimeout;
> +	long timeout_jiffies;
>  	wait_queue_t wait;
>  
>  	/*
> @@ -1506,8 +1507,36 @@ static int ep_poll(struct eventpoll *ep,
>  	 * and the overflow condition. The passed timeout is in milliseconds,
>  	 * that why (t * HZ) / 1000.
>  	 */
> -	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> -		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> +
> +	if (timeout_msecs) {

Why not check for < 0 here ? it's the right moment, instead of doing all
the math first ? gcc will emit only one check with 3 results resumed in
just two consecutive cond jumps for 0, <0, >0.

> +		/*
> +		 * We compare HZ with 1000 to work out which side of the
> +		 * expression needs conversion.  Because we want to
> +		 * avoid converting any value to a numerically higher
> +		 * value, which could overflow.
> +		 */
> +#if HZ > 1000
> +		overflow = timeout_msecs >=
> +				jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
> +#else
> +		overflow = msecs_to_jiffies(timeout_msecs) >=
> +				MAX_SCHEDULE_TIMEOUT;
> +#endif

Although this seems clean, what worries me here is that for HZ <= 1000,
we're doing maths on a variable to compare it to a constant. The
msec_to_jiffies() function exists to return exact conversions, while
we're just checking for bounds. The magics here clearly depends on the
jiffies_to_msecs() implementation. So the real problem is not to check
for which values for timeout_msecs we can get an overflow, but to check
if timeout_msecs is higher than an HZ-dependant constant above which some
conversion functions will overflow.

Oh, BTW, while reading msecs_to_jiffies(), I noticed that it can overflow
too for small values of HZ (HZ < 1000) :

#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)

static inline unsigned int jiffies_to_msecs(const unsigned long j)
{
#if HZ <= 1000 && !(1000 % HZ)
        return (1000 / HZ) * j;
#elif HZ > 1000 && !(HZ % 1000)
        return (j + (HZ / 1000) - 1)/(HZ / 1000);
#else
        return (j * 1000) / HZ;
#endif
}


static inline unsigned long msecs_to_jiffies(const unsigned int m)
{
        if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
                return MAX_JIFFY_OFFSET;
#if HZ <= 1000 && !(1000 % HZ)
        return (m + (1000 / HZ) - 1) / (1000 / HZ);
#elif HZ > 1000 && !(HZ % 1000)
        return m * (HZ / 1000);
#else
        return (m * HZ + 999) / 1000;
#endif
}

Calling jiffies_to_msecs(MAX_JIFFY_OFFSET) is not valid if 1000/HZ >=2 or
if (1000 % HZ != 0 || HZ % 1000 != 0). Eg: for HZ=300, the max is set to
0xda7406 while it is set to 0xfffffff8 for HZ=250 !

This clearly shows that we need some common macros to define some absolute
bounds for each unit and avoid any computation on the timers before having
checked them against the bounds.

I'll see if I can get something working.

> +
> +		/*
> +		 * If we would overflow in the conversion or a negative
> +		 * timeout is requested, sleep indefinitely.
> +		 */
> +		if (overflow || timeout_msecs < 0)
> +			timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
> +		else
> +			timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
> +	} else {
> +		/*
> +		 * 0 millisecond requests become 0 jiffy requests
> +		 */
> +		timeout_jiffies = 0;
> +	}
>  
>  retry:
>  	write_lock_irqsave(&ep->lock, flags);
> @@ -1529,7 +1558,7 @@ retry:
>  			 * to TASK_INTERRUPTIBLE before doing the checks.
>  			 */
>  			set_current_state(TASK_INTERRUPTIBLE);
> -			if (!list_empty(&ep->rdllist) || !jtimeout)
> +			if (!list_empty(&ep->rdllist) || !timeout_jiffies)
>  				break;
>  			if (signal_pending(current)) {
>  				res = -EINTR;
> @@ -1537,7 +1566,7 @@ retry:
>  			}
>  
>  			write_unlock_irqrestore(&ep->lock, flags);
> -			jtimeout = schedule_timeout(jtimeout);
> +			timeout_jiffies = schedule_timeout(timeout_jiffies);
>  			write_lock_irqsave(&ep->lock, flags);
>  		}
>  		remove_wait_queue(&ep->wq, &wait);
> @@ -1556,7 +1585,8 @@ retry:
>  	 * more luck.
>  	 */
>  	if (!res && eavail &&
> -	    !(res = ep_events_transfer(ep, events, maxevents)) && jtimeout)
> +	    !(res = ep_events_transfer(ep, events, maxevents)) &&
> +	    timeout_jiffies)
>  		goto retry;
>  
>  	return res;


Regards,
Willy

