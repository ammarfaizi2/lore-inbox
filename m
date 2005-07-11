Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVGKWos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVGKWos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGKWms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:42:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262143AbVGKWk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:40:57 -0400
Date: Mon, 11 Jul 2005 15:41:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, dwalker@mvista.com,
       mingo@elte.hu, sct@redhat.com
Subject: Re: kjournald wasting CPU in invert_lock fs/jbd/commit.c
Message-Id: <20050711154113.5abc81dd.akpm@osdl.org>
In-Reply-To: <1121120222.6087.44.camel@localhost.localdomain>
References: <1121120222.6087.44.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I noticed that the code in commit.c of the jbd system can waste CPU
> cycles.

How did you notice?  By code inspection or by runtime observation?  If the
latter, please share.

> The offending code is as follows.
> 
> static int inverted_lock(journal_t *journal, struct buffer_head *bh)
> {
>         if (!jbd_trylock_bh_state(bh)) {
>                 spin_unlock(&journal->j_list_lock);
>                 schedule();
>                 return 0;
>         }
>         return 1;
> }

"offending" is a good description.  That code sucks.  But it sits on the
edge between two subsystems which really really want to take those locks in
opposite order.


> This code makes a loop if the jbd_trylock_bh_state fails. This code will
> wait till whoever owns the lock releases it. But it is really in a busy
> loop and will only be interrupted when the kjournald uses up all its
> quota.  So it's basically just wasting CPU cycles here.

Yeah.  But these _are_ spinlocks, so spinning is what's supposed to happen.
 Maybe we should dump that silly schedule() and just do cpu_relax(). 
Although I do recall once theorising that the time we spend in the
schedule() might be preventing livelocks.

>  The following
> patch should fix this.
> 
> Signed-off-by: Steven Rostedt rostedt@goodmis.org

Please put "<>" around the email address.

> ---
> --- a/fs/jbd/commit.c	2005-07-11 17:51:37.000000000 -0400
> +++ b/fs/jbd/commit.c	2005-07-11 17:51:58.000000000 -0400
> @@ -87,7 +87,7 @@ static int inverted_lock(journal_t *jour
>  {
>  	if (!jbd_trylock_bh_state(bh)) {
>  		spin_unlock(&journal->j_list_lock);
> -		schedule();
> +		yield();
>  		return 0;
>  	}
>  	return 1;

Nope, yield() can cause terribly long delays when other tasks are cpu-bound.
