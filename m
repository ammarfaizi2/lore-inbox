Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSIPLhu>; Mon, 16 Sep 2002 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSIPLhu>; Mon, 16 Sep 2002 07:37:50 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:23821 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261395AbSIPLht>; Mon, 16 Sep 2002 07:37:49 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Daniel Jacobowitz <drow@false.org>
Subject: Re: [PATCH] Fix for ptrace breakage
References: <Pine.LNX.4.44.0209161322260.28163-100000@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 16 Sep 2002 20:41:06 +0900
In-Reply-To: <Pine.LNX.4.44.0209161322260.28163-100000@localhost.localdomain>
Message-ID: <87bs6y6u25.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> > This patch fixes the following,
> >
> >    - race condition of ptrace flag
> >    - sent odd signal to the tracer
> >    - broken before behavior
> 
> (looks good to me). I'm wondering about the following:
> 
> -	while (!list_empty(&current->children))
> -		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
> -	while (!list_empty(&current->ptrace_children))
> -		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,ptrace_list), current, 1);
> +	while ((p = eldest_child(current)) != NULL)
> +		zap_thread(p, current);
>  	BUG_ON(!list_empty(&current->children));
> 
> is it guaranteed that at this point current->ptrace_children is empty?

Yes, I think so.

	list_for_each(_p, &father->ptrace_children) {
		p = list_entry(_p,struct task_struct,ptrace_list);
		list_del_init(&p->ptrace_list);
		reparent_thread(p, reaper, child_reaper);
		if (p->parent != p->real_parent)
			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
	}

current->ptrace_children should be empty after this reparent.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
