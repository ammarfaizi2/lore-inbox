Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSIBN3J>; Mon, 2 Sep 2002 09:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSIBN3J>; Mon, 2 Sep 2002 09:29:09 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:42513 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S318293AbSIBN3I>; Mon, 2 Sep 2002 09:29:08 -0400
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BUG_ON(p->ptrace) in release_task()
References: <87fzwthapw.fsf@devron.myhome.or.jp>
	<20020901193313.GA23985@nevyn.them.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 02 Sep 2002 22:33:16 +0900
In-Reply-To: <20020901193313.GA23985@nevyn.them.org>
Message-ID: <87k7m4ikir.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> writes:

> On Mon, Sep 02, 2002 at 02:38:03AM +0900, OGAWA Hirofumi wrote:
> > Hi,
> > 
> > I think, BUG_ON(p->ptrace) will be called if the CLONE_DETACH process
> > is traced.  This patch removes BUG_ON(p->ptrace), and also removes
> > BUG_ON(p->ptrace) workaround in sys_wait4().
> 
> The BUG_ON is correct, and that isn't a workaround - if the list is not
> empty, then it will be garbage after the task struct is freed.  Your
> patch breaks tracing of normal processes again, because the ptrace_list
> will not be empty.

Whoops, yes, I'm wrong. Sorry. My fixes wasn't enough. However, looks
like your case called the following BUG().

sys_ptrace()
    -> ptrace_attach()
        -> __ptrace_link()

void __ptrace_link(task_t *child, task_t *new_parent)
{
	if (!list_empty(&child->ptrace_list))
		BUG();
	if (child->parent == new_parent)
		BUG();		<--- this
	list_add(&child->ptrace_list, &child->parent->ptrace_children);
	REMOVE_LINKS(child);

So, I need to look source more. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
