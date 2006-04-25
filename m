Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWDYR3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWDYR3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWDYR3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:29:17 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:948 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751599AbWDYR3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:29:17 -0400
Date: Tue, 25 Apr 2006 12:29:41 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060425162941.GB22807@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604212034.53486.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604212034.53486.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 08:34:52PM +0200, Blaisorblade wrote:
> >  #define PTRACE_GET_THREAD_AREA    25
> >  #define PTRACE_SET_THREAD_AREA    26
> > +#define PTRACE_SYSCALL_MASK	  27
> 
> I think there could be a reason we skipped that for SYSEMU - that's to see. 
> Also, if this capability will be implemented in other archs, we should use 
> the 0x4200-0x4300 range for it.

Yeah, we need to decide somewhat carefully which number to use.

> > +		for(i = NR_syscalls; i < len * 8; i++){
> > +			get_user(c, &mask[i / 8]);
> 
> This get_user() inside a loop is poor, it could slow down a valid call. It'd 
> be simpler to copy the mask from userspace in a local variable (with 400 
> syscalls that's 50 bytes, i.e. fully ok), and then perform the checks, if 
> wanted (I disagree with Heiko's message, this check is needed
> sometimes - see  my response to that).

Agree, except that we need to be careful about when userspace knows
about more system calls than the kernel.  We should copy-user as many
bits as the kernel knows about (or the process passes in, which ever
is less) and if the process knows about more system calls than the
kernel, the extra bits should be checked (maybe in a get_user(c, ...)
loop) to make sure that special treatment isn't being requested for
unknown syscalls.

> And only after that set all at once child->syscall_mask. You copy twice that 
> little quantity of data but that's not at all time-critical, and you're 
> forced to do that to avoid partial updates; btw you've saved getting twice 
> the content from userspace (slow when address spaces are distinct, like for 
> 4G/4G or SKAS implementation of copy_from_user).

Yup.

> Actually we would copy the whole struct in my API proposal (as I've
> described in the other message, we need to pass another param IMHO,
> so we'd pack them in a struct and pass its address).

You mean adding a fifth argument to ptrace?  I don't really like that
idea.  We could either make two new PTRACE_* operations (I don't like
the MASK_STRICT_VERIFY option since that seems unnecessary and
fragile) or make the data argument something like this
	struct {
		int flag;
		void *mask;
	}

which seems to be something like what you're suggesting.  You'll want
to stick the mask length in there as well, and leave the data argument
unused.

Except that passing pointers to pointers into system calls seems like
a bad idea - it makes ptrace look (more) like ioctl.  So, you'd want
something like
	struct {
		int flag;
		char mask[(NR_syscalls + 7)/8];
	}

then you'd want the length back in data so you know how much data the
process is giving you.  But then, you'll read the smaller of the
kernel's and process's version of the structure, and if the process
one is bigger, you need to read the extra bits to sanity-check them.
Given that you'll need this extra treatment, I think it's simpler to
just leave the addr argument as a pointer to the bits and add an extra
ptrace op.

				Jeff
