Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318851AbSIIUhE>; Mon, 9 Sep 2002 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318853AbSIIUgg>; Mon, 9 Sep 2002 16:36:36 -0400
Received: from crack.them.org ([65.125.64.184]:61713 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318882AbSIIUfi>;
	Mon, 9 Sep 2002 16:35:38 -0400
Date: Mon, 9 Sep 2002 16:40:26 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: do_syslog/__down_trylock lockup in current BK
Message-ID: <20020909204026.GA8719@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020909201516.GA7465@nevyn.them.org> <Pine.LNX.4.44.0209092230550.16779-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209092230550.16779-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 10:33:17PM +0200, Ingo Molnar wrote:
> 
> the attached patch fixes one bug in the way we did zap_thread() - but this
> alone does not fix the lockup.
> 
> the bug was that list_for_each_safe() is not 'safe enough' - zap_thread()  
> drops the tasklist lock at which point anything might happen to the child
> list.
> 
> the lockup is likely in the while loop - ie. zap_thread() not actually
> reparenting a thread and thus causing an infinite loop - is that possible?

Well, it shouldn't be.  forget_original_parent should update
real_parent for every child on either list, and then zap_thread unlinks
each child from the current parent and links it to the new real_parent.
A couple of printks in there should be able to work out if I'm wrong,
though...

> @@ -554,17 +553,16 @@
>  		do_notify_parent(current, current->exit_signal);
>  
>  zap_again:
> -	list_for_each_safe(_p, _n, &current->children)
> -		zap_thread(list_entry(_p,struct task_struct,sibling), current, 0);
> -	list_for_each_safe(_p, _n, &current->ptrace_children)
> -		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current, 1);
> +	while (!list_empty(&current->children))
> +		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
> +	while (!list_empty(&current->ptrace_children))
> +		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,sibling), current, 0);

As Linus points out, typo right there on the last argument.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
