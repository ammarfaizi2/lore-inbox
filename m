Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbTCFXoy>; Thu, 6 Mar 2003 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbTCFXoy>; Thu, 6 Mar 2003 18:44:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51441 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261304AbTCFXov>;
	Thu, 6 Mar 2003 18:44:51 -0500
Message-ID: <3E67DF8E.9080005@mvista.com>
Date: Thu, 06 Mar 2003 15:53:50 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>
In-Reply-To: <200303062306.h26N6hrd008442@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> Syscall stubs must be declared to return "long", to ensure things work
> properly on all 64-bit platforms (see earlier discussion on this
> topic).  Patch below.
> 
> On a related note: as far as I can see, timer_t is declared as "int"
> on all platforms (both by kernel and glibc).  Yet if my reading of the
> kernel code is right, it's supposed to be "long" (and allegedly some
> standard claims that timer_t should be the "widest" integer on a
> platform).  But then again, I'm not familiar with the POSIX timer
> interface myself, so perhaps I'm completely off base here.

Leaving the standard aside, I think there is a bit of a problem in the 
idr code (.../lib/idr.c) which manages the id allocation.  Seems we 
are returning "long" from functions declared as int.  If I remember 
the code correctly this will work, but it does eliminate the sequence 
number that should be in the high 8 bits of the id.  This assumes that 
you never allocate more than 2,147,483,647 timers at once :)  I will 
look at this and send in a patch.  I think we should return what ever 
timer_t is, so we should run that to ground first.

I suspect we should also have a look at all the structures with a view 
to alignment issues or is this not a problem?  I.e. is this struct ok:

struct {
	long a;
	int  b;
	long c;
}

-g
> 
> 	--david
> 
> diff -Nru a/kernel/posix-timers.c b/kernel/posix-timers.c
> --- a/kernel/posix-timers.c	Thu Mar  6 14:59:46 2003
> +++ b/kernel/posix-timers.c	Thu Mar  6 14:59:46 2003
> @@ -423,7 +423,7 @@
>  
>  /* Create a POSIX.1b interval timer. */
>  
> -asmlinkage int
> +asmlinkage long
>  sys_timer_create(clockid_t which_clock,
>  		 struct sigevent *timer_event_spec, timer_t * created_timer_id)
>  {
> @@ -663,7 +663,7 @@
>  	}
>  }
>  /* Get the time remaining on a POSIX.1b interval timer. */
> -asmlinkage int
> +asmlinkage long
>  sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
>  {
>  	struct k_itimer *timr;
> @@ -695,7 +695,7 @@
>  
>   */
>  
> -asmlinkage int
> +asmlinkage long
>  sys_timer_getoverrun(timer_t timer_id)
>  {
>  	struct k_itimer *timr;
> @@ -848,7 +848,7 @@
>  }
>  
>  /* Set a POSIX.1b interval timer */
> -asmlinkage int
> +asmlinkage long
>  sys_timer_settime(timer_t timer_id, int flags,
>  		  const struct itimerspec *new_setting,
>  		  struct itimerspec *old_setting)
> @@ -922,7 +922,7 @@
>  }
>  
>  /* Delete a POSIX.1b interval timer. */
> -asmlinkage int
> +asmlinkage long
>  sys_timer_delete(timer_t timer_id)
>  {
>  	struct k_itimer *timer;
> @@ -1054,7 +1054,7 @@
>  	return -EINVAL;
>  }
>  
> -asmlinkage int
> +asmlinkage long
>  sys_clock_settime(clockid_t which_clock, const struct timespec *tp)
>  {
>  	struct timespec new_tp;
> @@ -1069,7 +1069,7 @@
>  	new_tp.tv_nsec /= NSEC_PER_USEC;
>  	return do_sys_settimeofday((struct timeval *) &new_tp, NULL);
>  }
> -asmlinkage int
> +asmlinkage long
>  sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
>  {
>  	struct timespec rtn_tp;
> @@ -1088,7 +1088,7 @@
>  	return error;
>  
>  }
> -asmlinkage int
> +asmlinkage long
>  sys_clock_getres(clockid_t which_clock, struct timespec *tp)
>  {
>  	struct timespec rtn_tp;
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

