Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUIAAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUIAAFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269327AbUIAACB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:02:01 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:14266 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S269129AbUIAAAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:00:33 -0400
Date: Tue, 31 Aug 2004 17:00:29 -0700
Message-Id: <200409010000.i8100TvP001852@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Anton Blanchard <anton@samba.org>
X-Fcc: ~/Mail/linus
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Anton Blanchard's message of  Tuesday, 31 August 2004 19:43:48 +1000 <20040831094348.GH26072@krispykreme>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Just about every architecture hasa line
> > 
> > +	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)  ? 0x80 : 0));
> > 
> > you probably want a one-liner inline wrapper with a descriptive name
> > around this
> 
> Yep, and it looks like only some architectures got this recent change:
> 
>         ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
>                                  !test_thread_flag(TIF_SINGLESTEP) ?  0x80 : 0));
> 
> Is there a reason this shouldnt be propogated to all architectures?

It ought to produce the the same result on all, certainly.  TIF_SINGLESTEP
is an implementation detail specific to i386 and x86_64.  The new test here
makes sure that PTRACE_SINGLESTEP never produces an 0x80|SIGTRAP
notification, only PTRACE_SYSCALL, to be consistent with previous behavior.
This i386/x86_64 code path can now be entered for the single-step case, due
to changes that just went in to make single-stepping the system call
instruction work nicely.  If other machines require similar fixes and the
implementation overloads their syscall_trace functions in the same way,
then they will have a change similar to this one to make.


Thanks,
Roland
