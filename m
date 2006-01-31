Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWAaPgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWAaPgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWAaPgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:36:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20626 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750988AbWAaPgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:36:04 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Cleanup exec from a non thread group leader.
References: <43DDFDE3.58C01234@tv-sign.ru> <43DE2730.795468DC@tv-sign.ru>
	<m1vew15ud4.fsf@ebiederm.dsl.xmission.com>
	<43DF36EF.C38E6C4B@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 31 Jan 2006 08:35:28 -0700
In-Reply-To: <43DF36EF.C38E6C4B@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 31 Jan 2006 13:07:43 +0300")
Message-ID: <m1hd7k4dhb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> We can't just remove this list_del, note __ptrace_link() above.
> So if we remove list_add from switch_exec_pids() (like you did
> in your patch) we should also place list_add before ptrace_link()
> in de_thread(), otherwise I beleive it is a bug.

Ok.  I see it now.  The REMOVE_LINKS/SET_LINKS deep in __ptrace_link()
touching the task list is sneaky.

> I agree, we should cleanup this. I just noticed that I forgot
> to add you on CC: list while sending this patch:
>
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113862839924746
>
> Btw, I don't understand why __ptrace_link() use REMOVE_LINKS/SET_LINKS
> instead of remove_parent/add_parent.

I see one of two possibilities.
- Either there is a magic invariant that is supposed to be preserved
  about always being on the task list with a parent.
  (And the code in this part of exec is already broken).
- Or the code is just being inefficient.

A corollary is why is any of this code safe to run without holding
the tasklist_lock?

Eric
