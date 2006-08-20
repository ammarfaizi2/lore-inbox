Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWHTWQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWHTWQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWHTWQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:16:34 -0400
Received: from mother.openwall.net ([195.42.179.200]:31695 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751644AbWHTWQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:16:34 -0400
Date: Mon, 21 Aug 2006 02:12:08 +0400
From: Solar Designer <solar@openwall.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820221208.GA21754@openwall.com>
References: <20060820003840.GA17249@openwall.com> <1156097640.4051.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156097640.4051.24.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Let me argue with you a little bit.  Please do not misinterpret this as
me pushing for this change (or any other change) to be included; I have
no problem maintaining them all in -ow patches.

On Sun, Aug 20, 2006 at 07:14:00PM +0100, Alan Cox wrote:
> Ar Sul, 2006-08-20 am 04:38 +0400, ysgrifennodd Solar Designer:
> > Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> > set*uid() kill the current process rather than proceed with -EAGAIN when
> > the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> > and return anyway due to properties of the allocator, in which case the
> > patch does not change a thing.  But better safe than sorry.
> 
> Major behaviour change,

Huh?  The code path is hardly even triggerable on 2.4, while 2.2 and
earlier kernels did not even have this "functionality".

> non-standards compliant

Huh?

Are you referring to killing of processes on OOM?  That was in Linux
already, this patch does not introduce it.

As it relates to setuid() in particular, POSIX.1-2001 says:

     The setuid() function shall fail, return -1, and set errno to the
     corresponding value if one or more of the following are true:

     [EINVAL]
             The value of the uid argument is invalid and not supported by
             the implementation.
     [EPERM]                                                                                 The process does not have appropriate privileges and uid does
             not match the real user ID or the saved set-user-ID.

No other error conditions are defined.  No transient errors.  No EAGAIN.
And the language used does not imply that implementation-specific errors
may be returned.

I'd say that the behavior of returning EAGAIN is non-compliant.

> and is just an attempt to wallpaper over problems.

There are two problems: one is the kernel implementing this unsafe
behavior in 2.4 and beyond and the other is userspace apps not
checking return value from set*[ug]id().  In my opinion, both need to
be fixed.

> Was rejected by previous maintainers already.

Oh, I was not aware of that.  I certainly did not submit this before.

In fact, Linus appeared to agree that set*uid() failing on transient
errors is bad (specifically, when discussing RLIMIT_NPROC on 2.6) in the
discussion that occurred on vendor-sec and security at kernel.org a
couple of months back.  He did not mind the RLIMIT_NPROC check on
set*uid() dropped, while my suggestion was to move it to execve(2) (like
it is done in -ow patches under a configurable option).

> NAK  (think /usr/games/banner "NAK")

OK, if you say so.

In another message, you wrote:

> ... redesigning expected behaviour

I'd say that set*uid() returning EAGAIN is unexpected behavior for most
userspace programmers.  It is also non-standards compliant as I have
shown above.

> to cause obscure random kills that won't even be noticed/explained.

Now this makes sense - we should make those kills similar to regular OOM
kills, providing rate-limited messages.

But the kills are needed.  They are more correct and safer than
returning EAGAIN.  An alternative would be to not allocate memory on
set*uid() at all - like we did not in older kernels - but that would
be an inappropriate behavior change for 2.4.

Thanks for your time anyway,

Alexander
