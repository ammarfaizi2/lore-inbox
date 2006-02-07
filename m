Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWBGJcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWBGJcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBGJcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:32:07 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33556 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932447AbWBGJcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:32:05 -0500
Date: Tue, 7 Feb 2006 10:31:54 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de,
       linuxppc64-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
Message-ID: <20060207093154.GA9311@osiris.boeblingen.de.ibm.com>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au> <20060206.160140.59716704.davem@davemloft.net> <20060207174017.5e3b0ce0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207174017.5e3b0ce0.sfr@canb.auug.org.au>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about the following (modifiying Linus' suggestion and copying what
> sparc64 already does)?
> 
> The assumption is that all arguments have been zero extended by the compat
> syscall entry code, so we just sign extend those that need it.
> 
> I am not sure of the sparc64 code below, s390 doesn't seem to follow our
> "all arguments are zero extended" assumption and x86_64 may not need any
> of these wrappers anyway.

On s390 we do already sign extension for int/long and zero extension for
the unsigned parameters. Even though I wasn't aware that we should do zero
extension for _all_ parameters of the compat system calls, regardless of
their type.
In addition we must do pointer conversion to 64 bit, since the compat tasks
have the most significant bit set (to distinguish between 24- and 31-bit
addressing mode).

Therefore I think Linus' suggestion with having something like

	compat_fn6(sys_waitif, SARG, UARG, UARG, SARG, UARG);

would be better. Just that we would need something for pointers as well.
And to make things just a bit more complicated: only the first five
parameters are in registers. Number six and the following are already on
the stack. E.g. the compat wrapper for the futex syscall would need extra
assembly code to do conversion on the stack.

Maybe having defines like SARG1..SARG6 that would define assembly code
instead of the register would do the job.


Thanks,
Heiko
