Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTLNUic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTLNUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:38:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:59048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262425AbTLNUia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:38:30 -0500
Date: Sun, 14 Dec 2003 12:38:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312142032310.9900@earth>
Message-ID: <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Ingo Molnar wrote:
>
> the code is a bit ugly, but it's necessary - a parent can decide _after_
> starting the child that it wants to detach it. (by setting SIGCHLD to
> SIG_IGN. The testcase doesnt do this.) So the only place where we can
> detect the detached-ness of a process is in do_notify_parent().

Hmm.. What if "leader->exit_signal" was -1 already _before_ we call
"do_notify_parent()"? In that case we'd never call "do_notify_parent()"
for the leader at all, and we would also not release it outselves, the way
you've done the test.

Or is that case impossible to trigger? Looks a bit like that. But if it
_is_ impossible to trigger (ie exit_signal cannot be -1 for a thread
leader), then why does the current code test for "&& leader->exit_signal
!= -1)" at all?

That code looks fragile as hell. I think you fixed a bug and it might be
the absolutely proper fix, but I'd be happier about it if it was more
obvious what the rules are and _why_ that is the only case that matters..

		Linus
