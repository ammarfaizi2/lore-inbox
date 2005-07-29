Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVG2Kki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVG2Kki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVG2Kki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:40:38 -0400
Received: from pop.gmx.net ([213.165.64.20]:47752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262562AbVG2Kkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:40:35 -0400
Date: Fri, 29 Jul 2005 12:40:31 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Matt Mackall <mpm@selenic.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       akpm@osdl.org, chrisw@osdl.org
MIME-Version: 1.0
References: <20050729061318.GD7425@waste.org>
Subject: =?ISO-8859-1?Q?Re:_Broke_nice_range_for_RLIMIT_NICE?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <32007.1122633631@www71.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matt,

> > I'm guessing that it was you that added the RLIMIT_NICE resource 
> > limit in 2.6.12.
> 
> The original patch was from Chris Wright, but I did most of the
> cheerleading for it.

Okay -- thanks for the pointer.  There was no record of the
pach in the (incomplete-because-of-git-changeover) changelog 
for 2.6.12...

> > (A passing note to all kernel developers: when 
> > making changes that affect userland-kernel interfaces, please 
> > send me a man-pages patch, or at least a notification of the 
> > change, so that some information makes its way into the manual 
> > pages).
> 
> You might want to make an effort to make yourself more visible around
> here. Most of us have no idea that anyone's actually trying to
> maintain the manpages or who that might be.

Fair comment.  I do appear now and then here, but I'll try to be 
a litle more noisy from now on...
 
> > I started documenting RLIMIT_NICE and then noticed an 
> > inconsistency between the use of this limit and the nice
> > value as manipulated by [sg]etpriority().
> > 
> > This is the documentation I've drafted for RLIMIT_NICE
> > in getrlimit.2:
> > 
> >    RLIMIT_NICE(since kernel 2.6.12)
> >       Specifies  a  ceiling  to  which  the process nice
> >       value  can  be  raised  using  setpriority(2)   or
> >       nice(2).  The actual ceiling for the nice value is
> >       calculated as  19 - rlim_cur.
> >                      ^^^^^^^^^^^^^
> > 
> > And recently I've redrafted the discussion of the nice value
> > in getpriority.2 and it now reads:
> > 
> >       Since kernel 1.3.43 Linux has  the  range  -20..19.
> >       Within  the kernel, nice values are actually repre-
> >       sented using the corresponding range  40..1  (since
> >       negative numbers are error codes) and these are the
> >       values employed by the setpriority and  getpriority
> >       system  calls.   The  glibc  wrapper  functions for
> >       these system calls handle the translations  between
> >       the  user-land  and  kernel  representations of the
> >       nice    value    according    to    the     formula
> >       user_nice = 20 - kernel_nice.
> >       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > In other words, there is an off-by-one mismatch between 
> > these two interfaces: RLIMIT_NICE is expecting to deal 
> > with values in the range 39..0, while [gs]etpriority() 
> > works with the range 40..1.
> > 
> > I suppose that glibc could paper over the cracks here in
> > a wrapper for getrlimit(), but it seems more sensible 
> > to make RLIMIT_NICE consistent with [gs]etpriority() --
> > i.e., change the RLIMIT_NICE interface in 2.6.13 before it 
> > sees wide use in userland.  What do you think?

[I I should have added here, that looking at the latest 
glibc snapshot, RLIMIT_NICE still isn't present, so still
not very visible to user-land.]

> Well, it's easy enough to do, but some thought has to be given to the
> corner cases. Specifically, does this do the right thing when the
> rlimit is set to zero? I think it does, as the nice range is nicely
> bound here:
> 
>         nice = PRIO_TO_NICE(current->static_prio) + increment;
>         if (nice < -20)
>                 nice = -20;
>         if (nice > 19)
>                 nice = 19;
> 
>         if (increment < 0 && !can_nice(current, nice))
>                 return -EPERM;
> 
> And we allow task to do negative increment. Chris?

Yes, I believe it is safely bounded also.

> The other downside is, this obviously changes any existing configs
> actually using this by one nice level..

I don't expect there are likely to be any existing yet.

> Index: l/kernel/sched.c
> ===================================================================
> --- l.orig/kernel/sched.c	2005-06-22 17:55:14.000000000 -0700
> +++ l/kernel/sched.c	2005-07-28 22:55:54.000000000 -0700
> @@ -3231,8 +3231,8 @@ EXPORT_SYMBOL(set_user_nice);
>   */
>  int can_nice(const task_t *p, const int nice)
>  {
> -	/* convert nice value [19,-20] to rlimit style value [0,39] */
> -	int nice_rlim = 19 - nice;
> +	/* convert nice value [19,-20] to rlimit style value [1,40] */
> +	int nice_rlim = 20 - nice;
>  	return (nice_rlim <= p->signal->rlim[RLIMIT_NICE].rlim_cur ||
>  		capable(CAP_SYS_NICE));
>  }

Thanks.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
