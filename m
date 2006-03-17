Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752494AbWCQGsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbWCQGsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbWCQGsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:48:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:37831 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752494AbWCQGr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:47:59 -0500
Date: Thu, 16 Mar 2006 22:48:30 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Janak Desai <janak@us.ibm.com>,
       Al Viro <viro@ftp.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Michael Kerrisk <mtk-manpages@gmx.net>, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
Message-ID: <20060317064829.GG1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com> <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 10:31:38AM -0700, Eric W. Biederman wrote:
> 
> The sighand pointer only needs the rcu_read_lock on the
> read side.  So only depending on task_lock protection
> when setting this pointer is not enough.  We also need
> a memory barrier to ensure the initialization is seen first.
> 
> Use rcu_assign_pointer as it does this for us, and clearly
> documents that we are setting an rcu readable pointer.

Good catch!

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> 
> 
> ---
> 
>  kernel/fork.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> f0cdb649b7140927777f4355631648b396ee235b
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2706e9..2f24553 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1573,7 +1573,7 @@ asmlinkage long sys_unshare(unsigned lon
>  
>  		if (new_sigh) {
>  			sigh = current->sighand;
> -			current->sighand = new_sigh;
> +			rcu_assign_pointer(current->sighand, new_sigh);
>  			new_sigh = sigh;
>  		}
>  
> -- 
> 1.2.4.g2d33
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
