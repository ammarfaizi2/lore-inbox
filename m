Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWBQTiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWBQTiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWBQTiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:38:16 -0500
Received: from [217.7.64.195] ([217.7.64.195]:36497 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1751412AbWBQTiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:38:14 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc3 macromedia flash regression...
Date: Fri, 17 Feb 2006 20:38:10 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200602170508.52712.list-lkml@net4u.de> <20060216232315.06c659f5.akpm@osdl.org>
In-Reply-To: <20060216232315.06c659f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602172038.10408.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag 17 Februar 2006 08:23, Andrew Morton wrote:
> Ernst Herzberg <list-lkml@net4u.de> wrote:
> > .... or not regession, that's the question.
> >
> >  2.6.16-rc2 works without problems.
> >
> >  With -rc3 a .swf that opens a ip connection back to the server takes
> > ages to load. strace shows that the player hangs for long times in
> > select().
> >
> >  Digging through the changelog brings up
> >
> >  commit 643a654540579b0dcc7a206a4a7475276a41aff0
> >  Author: Andrew Morton <akpm@osdl.org>
> >  Date:   Sat Feb 11 17:55:52 2006 -0800
> >
> >      [PATCH] select: fix returned timeval
>
> y'know, when I sent that patch out to reviewers I said "Could you guys
> please double-check this like hawks?  Especially the handy-dandy new
> timespec/timeval comparison functions.  I invariably screw that sort of
> thing up."
>
> Does this help?
>
>
> diff -puN fs/select.c~select-time-comparison-fixes fs/select.c
> --- devel/fs/select.c~select-time-comparison-fixes	2006-02-16
> 23:17:54.000000000 -0800 +++ devel-akpm/fs/select.c	2006-02-16
> 23:19:21.000000000 -0800
> @@ -404,7 +404,7 @@ asmlinkage long sys_select(int n, fd_set
>  			goto sticky;
>  		rtv.tv_usec = jiffies_to_usecs(do_div((*(u64*)&timeout), HZ));
>  		rtv.tv_sec = timeout;
> -		if (timeval_compare(&rtv, &tv) < 0)
> +		if (timeval_compare(&rtv, &tv) >= 0)
>  			rtv = tv;
>  		if (copy_to_user(tvp, &rtv, sizeof(rtv))) {
>  sticky:
> @@ -471,7 +471,7 @@ asmlinkage long sys_pselect7(int n, fd_s
>  		rts.tv_nsec = jiffies_to_usecs(do_div((*(u64*)&timeout), HZ)) *
>  						1000;
>  		rts.tv_sec = timeout;
> -		if (timespec_compare(&rts, &ts) < 0)
> +		if (timespec_compare(&rts, &ts) >= 0)
>  			rts = ts;
>  		if (copy_to_user(tsp, &rts, sizeof(rts))) {
>  sticky:
> @@ -775,7 +775,7 @@ asmlinkage long sys_ppoll(struct pollfd
>  		rts.tv_nsec = jiffies_to_usecs(do_div((*(u64*)&timeout), HZ)) *
>  						1000;
>  		rts.tv_sec = timeout;
> -		if (timespec_compare(&rts, &ts) < 0)
> +		if (timespec_compare(&rts, &ts) >= 0)
>  			rts = ts;
>  		if (copy_to_user(tsp, &rts, sizeof(rts))) {
>  		sticky:
> diff -puN fs/compat.c~select-time-comparison-fixes fs/compat.c
> --- devel/fs/compat.c~select-time-comparison-fixes	2006-02-16
> 23:17:54.000000000 -0800 +++ devel-akpm/fs/compat.c	2006-02-16
> 23:19:33.000000000 -0800
> @@ -1757,7 +1757,7 @@ asmlinkage long compat_sys_select(int n,
>  			goto sticky;
>  		rtv.tv_usec = jiffies_to_usecs(do_div((*(u64*)&timeout), HZ));
>  		rtv.tv_sec = timeout;
> -		if (compat_timeval_compare(&rtv, &tv) < 0)
> +		if (compat_timeval_compare(&rtv, &tv) >= 0)
>  			rtv = tv;
>  		if (copy_to_user(tvp, &rtv, sizeof(rtv))) {
>  sticky:
> @@ -1834,7 +1834,7 @@ asmlinkage long compat_sys_pselect7(int
>  			rts.tv_sec++;
>  			rts.tv_nsec -= NSEC_PER_SEC;
>  		}
> -		if (compat_timespec_compare(&rts, &ts) < 0)
> +		if (compat_timespec_compare(&rts, &ts) >= 0)
>  			rts = ts;
>  		copy_to_user(tsp, &rts, sizeof(rts));
>  	}
> @@ -1934,7 +1934,7 @@ asmlinkage long compat_sys_ppoll(struct
>  		rts.tv_nsec = jiffies_to_usecs(do_div((*(u64*)&timeout), HZ)) *
>  					1000;
>  		rts.tv_sec = timeout;
> -		if (compat_timespec_compare(&rts, &ts) < 0)
> +		if (compat_timespec_compare(&rts, &ts) >= 0)
>  			rts = ts;
>  		if (copy_to_user(tsp, &rts, sizeof(rts))) {
>  sticky:
> _

---------------------------

The patch does _not_ fix the problem.

sorry...
<earny/>
