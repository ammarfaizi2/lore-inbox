Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263680AbUJ3Kjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbUJ3Kjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 06:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUJ3Kjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 06:39:40 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:19607 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S263680AbUJ3Kji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 06:39:38 -0400
Date: Sat, 30 Oct 2004 14:39:34 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 hangs in posix_locks_deadlock
Message-ID: <20041030103934.GA25671@tentacle.sectorb.msk.ru>
References: <20040919160342.GA26409@tentacle.sectorb.msk.ru> <20040919200527.GA7184@tentacle.sectorb.msk.ru> <1095625531.7860.59.camel@lade.trondhjem.org> <20040919203619.GA8618@tentacle.sectorb.msk.ru> <1095634303.7860.122.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1095634303.7860.122.camel@lade.trondhjem.org>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 03:51:43PM -0700, Trond Myklebust wrote:
> Hmm...  It appears that it is indeed possible for both leases and flocks
> to be on the global "blocked_list", so the appended check is *not*
> redundant.
> Since flocks in particular do not initialize fl_owner, I suspect that
> you might be seeing wierd loops that were previously being avoided due
> to the ->fl_pid checks...

I just noticed that this fix didn't make it into 2.6.9.

> [PATCH] fix posix_locks_deadlock().
> 
> "blocked_list" may contain both leases and flock locks. Since the latter in
> particular do not initialize the fl_owner field, we have to beware not to
> call posix_same_owner() on them.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>
> ---
>  locks.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.9-rc2-up/fs/locks.c
> ===================================================================
> --- linux-2.6.9-rc2-up.orig/fs/locks.c	2004-09-19 13:55:33.680258334 -0700
> +++ linux-2.6.9-rc2-up/fs/locks.c	2004-09-19 15:37:32.595634679 -0700
> @@ -634,14 +634,13 @@
>  int posix_locks_deadlock(struct file_lock *caller_fl,
>  				struct file_lock *block_fl)
>  {
> -	struct list_head *tmp;
> +	struct file_lock *fl;
>  
>  next_task:
>  	if (posix_same_owner(caller_fl, block_fl))
>  		return 1;
> -	list_for_each(tmp, &blocked_list) {
> -		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
> -		if (posix_same_owner(fl, block_fl)) {
> +	list_for_each_entry(fl, &blocked_list, fl_link) {
> +		if (IS_POSIX(fl) && posix_same_owner(fl, block_fl)) {
>  			fl = fl->fl_next;
>  			block_fl = fl;
>  			goto next_task;

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

