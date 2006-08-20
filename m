Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWHTXE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWHTXE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWHTXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:04:25 -0400
Received: from mother.openwall.net ([195.42.179.200]:62671 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750772AbWHTXEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:04:24 -0400
Date: Mon, 21 Aug 2006 02:58:10 +0400
From: Solar Designer <solar@openwall.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820225810.GA22052@openwall.com>
References: <20060820003840.GA17249@openwall.com> <1156097640.4051.24.camel@localhost.localdomain> <20060820221208.GA21754@openwall.com> <1156114275.4051.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156114275.4051.71.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 11:51:15PM +0100, Alan Cox wrote:
> A lot of
> BSD code for example doesn't check malloc returns but you don't want an
> auto-kill if mmap fails ?

That's quite different in that things happen to be fail-close anyway:
malloc() returns NULL, a program does not check for that but tries to
access memory via the pointer - and almost definitely crashes.  Yes,
there are special cases when only *(p + large_value) is accessed and
thus there might be misbehavior rather than crash, but those cases are
very uncommon.

> The kill has the advantage that it stops the situation but it may also
> be that you kill a program which can handle the case and you create a
> new DoS attack (eg against a daemon switching to your uid).

I doubt it (speaking of 2.4 and the proposed patch only).  The error
path that I proposed to change from EAGAIN to kill is only potentially
invoked when the kernel is running out of memory so badly that the
entire system is essentially already DoS'ed.

As it relates to fixing 2.6, I would _not_ propose killing the process
when it is about to exceed RLIMIT_NPROC.  Instead, I would propose that
the RLIMIT_NPROC check be removed (to match the behavior of 2.4 and
earlier kernels) or moved to execve (to match -ow patches with this
option enabled).

> The current
> situation is not good, the updated situation could be far worse.

Well, I disagree.

> The message is important, we want to know it happened in the memory
> shortage case anyway.

This I agree with.

> Containers are also likely to create more such problems.

Implementations should be careful to not break expectations of existing
application programs in dangerous ways.

Thanks,

Alexander
