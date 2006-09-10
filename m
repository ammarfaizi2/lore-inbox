Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWIJUdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWIJUdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWIJUdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:33:54 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:1175 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964892AbWIJUdx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:33:53 -0400
Date: Mon, 11 Sep 2006 00:33:42 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
Message-ID: <20060910203324.GA121@oleg>
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com> <20060910142942.GA7384@oleg> <m18xkreb42.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xkreb42.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > On 09/09, Eric W. Biederman wrote:
> >> 
> >> This patch does several things.
> >> - The variables used are moved into a structure and declared in vt_kern.h
> >> - A spinlock is added so we don't have SMP races updating the values.
> >> - Instead of raw pid_t value a struct_pid is used to guard against
> >>   pid wrap around issues, if the daemon to spawn a new console dies.
> >
> > I am not arguing against this patch, but it's a pity we can't use 'struct pid'
> > lockless. What dou you think about this:
> 
> Actually with xchg I can use a reference counted struct pid lockless.
>
> ...
>
> Perhaps:
> void update_pid(struct pid **ref, struct pid *new)
> {
>         struct pid *old;
>         get_pid(new);
>         old = xchg(ref, new);
>         put_pid(old);
> }

This can't work. This put_pid() can actually free the memory, while
'old' is still in use (lockless).

> rcu is definitely not the solution in these cases as the struct pid
> is stored for a long time so we need the reference count.

Surely we need the reference count, I don't understand you.
Look at put_pid_rcu().

That said,

> In the general case you have more then one variable you want to keep
> in sync and you need the lock for that.

Yes.

> But since I can write it as a moderately clear one liner in the
> case that matters I don't much care.

Ok.

Oleg.

