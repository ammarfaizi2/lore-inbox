Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWDWQgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWDWQgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWDWQgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:36:42 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37841 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751419AbWDWQgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:36:42 -0400
Subject: Re: [PATCH] Shrink rbtree
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20060421180915.1f2d61a4.akpm@osdl.org>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <20060421180915.1f2d61a4.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 12:36:09 -0400
Message-Id: <1145810169.13155.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just adding Thomas Gleixner and Roman Zippel to the CC field since
the part in question came from a debate to get rid of a state field in
hrtimer.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114215996918851&w=2

-- Steve

On Fri, 2006-04-21 at 18:09 -0700, Andrew Morton wrote:
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > git://git.infradead.org/~dwmw2/rbtree-2.6
> 
> include/linux/hrtimer.h: In function `hrtimer_active':
> include/linux/hrtimer.h:130: structure has no member named `rb_parent'
> 
> Might I cast aspersions upon the quality of your testing?
> 
> 
> 
> #define HRTIMER_INACTIVE	((void *)1UL)
> 
> ...
> 
> static inline int hrtimer_active(const struct hrtimer *timer)
> {
> 	return rb_parent(timer->node) != HRTIMER_INACTIVE;
> }
> 
> 
> So we have somewhat-competing hackery here.
> 
> Testing this...
> 
> --- devel/include/linux/hrtimer.h~git-rbtree-hrtimer-fix	2006-04-21 18:03:44.000000000 -0700
> +++ devel-akpm/include/linux/hrtimer.h	2006-04-21 18:08:02.000000000 -0700
> @@ -34,7 +34,7 @@ enum hrtimer_restart {
>  	HRTIMER_RESTART,
>  };
>  
> -#define HRTIMER_INACTIVE	((void *)1UL)
> +#define HRTIMER_INACTIVE	((void *)-2)
>  
>  struct hrtimer_base;
>  
> @@ -127,7 +127,7 @@ extern ktime_t hrtimer_get_next_event(vo
>  
>  static inline int hrtimer_active(const struct hrtimer *timer)
>  {
> -	return timer->node.rb_parent != HRTIMER_INACTIVE;
> +	return rb_parent(&timer->node) != HRTIMER_INACTIVE;
>  }
>  
>  /* Forward a hrtimer so it expires after now: */
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

