Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVJMUiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVJMUiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVJMUiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:38:17 -0400
Received: from jeffindy.licquia.org ([216.37.46.185]:17419 "EHLO
	jeffindy.licquia.org") by vger.kernel.org with ESMTP
	id S964798AbVJMUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:38:16 -0400
Subject: Re: [PATCH] 2.6.13: POSIX violation in pipes on ia64 for kernels >
	2.6.10
From: Jeff Licquia <licquia@progeny.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510131250070.23590@g5.osdl.org>
References: <1129232675.4573.18.camel@laptop1>
	 <Pine.LNX.4.64.0510131250070.23590@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Oct 2005 15:37:26 -0500
Message-Id: <1129235846.4573.36.camel@laptop1>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 12:54 -0700, Linus Torvalds wrote:
> It also sounds like your patch is broken: allowing partial short writes is 
> in explicit violation of the POSIX specs, and breaks the only thing that 
> PIPE_BUF _really_ guarantees, namely that writes smaller than that size 
> must be atomic.

That guarantee is still there, because short writes take place on the
last buffer in use.  We either have a full PAGE_SIZE or more bytes in
the next available buffer(s), or we're on the last buffer, and the
max_write code kicks in and we control writes in PIPE_BUF increments.

I wrote a short test program to make sure writes < PIPE_BUF length are
still atomic (by reading PIPE_BUF/2 bytes from a full pipe and then
trying to write PIPE_BUF * (3/4) bytes to it), and the behavior seems to
be correct (ret = -1, errno = EAGAIN).

> The _only_ guarantees wrt PIPE_BUF is literally that a write smaller than 
> or equal to the PIPE_BUF will always either complete fully or not at all, 
> and that a reader will see the write as an atomic packet (ie two writers 
> will never have their write buffers interleaved within such a single 
> "write()" system call).
> 
> How empty the pipe has to be for a write to be able to do so is outside 
> the spec, and any code (including LSB tests) that depends on it is broken.

Hmm.  My reading was different, but on reflection you seem to be more
accurate.  I suppose I will have to bring this to the attention to the
LSB.

I will give one more reason to consider the patch.  Whatever the spec
said, the kernel's behavior has changed, and only for certain
architectures.  On ia64 (at least), the amount one must read from a pipe
in order to unblock it cannot be determined except via extreme means
(parsing a kernel config, doing test pipe I/O to try and deduce
PAGE_SIZE, etc.)  There may be benefit in restoring the previous
behavior, which my patch does without sacrificing the benefits of the
new pipe code.

Of course, that's up to you to decide.  Thanks for your time.

