Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUHYRwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUHYRwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUHYRwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:52:12 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:36876 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268182AbUHYRvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:51:48 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
References: <200408250243.i7P2h7hq014081@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 26 Aug 2004 02:51:26 +0900
In-Reply-To: <200408250243.i7P2h7hq014081@magilla.sf.frob.com>
Message-ID: <877jrnm7hd.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> I believe I understand the case you are referring to now that I've looked
> at it.  But I think this is the first I've heard about this issue.

ptrace() is frangible, and racy. And looks like few things can't improve
without user visible change. So, I'm thinking I would like to rewrite
it by another interface.

> While ptrace_getsiginfo is examining child->last_siginfo, another processor
> could be resuming that child via SIGCONT so that it clears last_siginfo and
> reuses the stack space it was pointing to.  With the right timing of the
> race, the ptrace_getsiginfo call could crash with an unexpected kernel-mode
> null pointer reference.  This is what you are talking about, right?

Yes. Or siginfo is changed while it's using.


[...]

Quick read... Looks good to me

Thanks.

> +	read_lock_irq(&tasklist_lock); /* Protects child->sighand.  */
                 ^^^^
_irq is unneeded?

> +	if (unlikely(child->sighand == NULL))
> +		ret = -EINVAL;
> +	else {
> +		spin_lock_irq(&child->sighand->siglock);
> +		if (child->last_siginfo == NULL)
> +			ret = -EINVAL;
> +		else
> +			*child->last_siginfo = info;
> +		spin_unlock_irq(&child->sighand->siglock);
> +	}
> +	read_unlock_irq(&tasklist_lock);
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
