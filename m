Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWEASCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWEASCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEASCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:02:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:16008 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932188AbWEASCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:02:11 -0400
Date: Mon, 1 May 2006 13:02:33 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060501170233.GC4592@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it> <20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 10:49:07AM +0200, Heiko Carstens wrote:
> IMHO this is way too complicated. Introducing a ptrace call that returns
> the number of syscalls and forcing user space to pass a complete bitmask
> is much easier. Also the semantics are much easier to understand.

This sounds more complicated than what we are proposing.  

This would make the process care about the number of system calls
implemented by the kernel, which is something that doesn't even come
up in the normal case with the current interface.  You only care about
it if you get a -EINVAL and want to figure out exactly why.

>From a practical point of view, you would want code that looks like
this:
	n = nsyscalls();
	mask = malloc((n + 7)/8);
	if(mask == NULL)
		return;

	/* Zero mask, set bits, call ptrace */

	free(mask);

rather than code like this:

	int mask[(BIGGEST_SYSCALL_I_CARE_ABOUT + 7) / 8];

	/* Zero mask, set bits, call ptrace */

That doesn't seem like an improvement to me.

The second case would be more complicated if it wanted to figure out
what the problem was if ptrace returned -EINVAL.  However, some users
won't care, so that complexity is optional.  For example, UML will
already know by other means what system calls are implemented on the
host, so it won't bother looking at the mask in the case of a
failure.  I'm not sure what the right thing for strace is.

> In addition your proposal would already introduce a rather complicated
> interface to figure out how many syscalls the kernel has. I'm sure this
> will be (mis)used sooner or later.

How?  And, if so, why is that a problem?

There are already complicated ways to figure out what system calls the
kernel has, and I don't recall them causing problems.

				Jeff
