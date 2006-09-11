Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWIKBFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWIKBFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIKBFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:05:44 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:62434 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932158AbWIKBFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:05:44 -0400
Date: Mon, 11 Sep 2006 05:05:34 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
Message-ID: <20060911010534.GA108@oleg>
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com> <20060910142942.GA7384@oleg> <m18xkreb42.fsf@ebiederm.dsl.xmission.com> <20060910203324.GA121@oleg> <m1slizcouy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1slizcouy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Eric W. Biederman wrote:
>
> Ok.  I think I see the where the confusion is.  We were looking
> at different parts of the puzzle.  But I we need to resolve this
> to make certain I didn't do something clever and racy.

Yes, I think we misunderstood each other :)

> As for the rest of your suggestion it would not be hard to be able to
> follow a struct pid pointer in an rcu safe way, and we do in the pid
> hash table.  In other contexts so far I always have other variables
> that need to be updated in concert, so there isn't a point in coming
> up with a lockless implementation.  I believe vt_pid is the only
> case that I have run across where this is a problem and I have
> at least preliminary patches for every place where signals are
> sent.
> 
> Updating this old code is painful.

No, no, we shouldn't change the old code, it is fine.

Just in case, to avoid any possible confusion.

put_pid(pid) has the following restrictions. The caller should ensure
that any other possible reference to this pid "owns" it (did get_pid()).

So we can add a new helper, put_pid_rcu(). It is ok if this pid is used
in parallel under rcu_read_lock() without bumping pid->count. Contrary,
the only restriction those users must not call get_pid(pid).

But yes, you are right, I don't see an immediate usage of put_pid_rcu().

Oleg.


