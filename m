Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbUKRSDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbUKRSDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbUKRSCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:02:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:35224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262804AbUKRR7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:59:07 -0500
Date: Thu, 18 Nov 2004 09:59:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Matthew Wilcox <willy@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
In-Reply-To: <20041118172606.GA6729@tentacle.sectorb.msk.ru>
Message-ID: <Pine.LNX.4.58.0411180956290.2222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
 <20041118172606.GA6729@tentacle.sectorb.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Vladimir B. Savkin wrote:
> 
> Please accept this fix:
> 
> [PATCH] fix posix_locks_deadlock().
> 
> "blocked_list" may contain both leases and flock locks. Since the latter in
> particular do not initialize the fl_owner field, we have to beware not to
> call posix_same_owner() on them.

Nope. It got fixed differently: by only adding POSIX locks to the list. 
See locks_insert_block(). Since a non-posix lock cannot be blocked by a 
POSIX lock, the "if (IS_POSIX(blocker))" test should make sure we're 
always proper.

At least that's Willy claims. If you think he's wrong, holler.

Willy Cc'd, once more.

		Linus
----
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
> 
> ~
> :wq
>                                         With best regards, 
>                                            Vladimir Savkin. 
> 
