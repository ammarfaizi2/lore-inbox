Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTB1JlI>; Fri, 28 Feb 2003 04:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTB1JlH>; Fri, 28 Feb 2003 04:41:07 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:5837 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267699AbTB1JlF>;
	Fri, 28 Feb 2003 04:41:05 -0500
Date: Fri, 28 Feb 2003 20:50:35 +1100 (EST)
Message-Id: <200302280950.h1S9oZdx014060@supreme.pcug.org.au>
From: sfr@canb.auug.org.au
To: ak@muc.de, sfr@canb.auug.org.au
Cc: anton@samba.org, davem@redhat.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, matthew@wil.cx, ralf@gnu.org,
       schwidefsky@de.ibm.com, torvalds@transmeta.com
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Thanks for the comments.

From: Andi Kleen <ak@muc.de>
> 
> On Fri, Feb 28, 2003 at 05:33:49AM +0100, Stephen Rothwell wrote:
> > +static int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
> > +{
> > +	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
> > +	    __get_user(kfl->l_type, &ufl->l_type) ||
> > +	    __get_user(kfl->l_whence, &ufl->l_whence) ||
> > +	    __get_user(kfl->l_start, &ufl->l_start) ||
> > +	    __get_user(kfl->l_len, &ufl->l_len) ||
> > +	    __get_user(kfl->l_pid, &ufl->l_pid))
> 
> Perhaps there should be really a big fat comment on top of compat.c
> that it depends on a hole on __PAGE_OFFSET if the arch allows passing
> 64bit pointers to the compat functions.

One of my tasks is to document all the assumptions in hte comapt code
(and there a a few - and I find more as I go :-)).  However, could you
elaborate a bit here - do you mean passing 64 bit pointers from user mode?

> > +asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
> > +		unsigned long arg)
> > +{
> > +	if ((cmd == F_GETLK64) || (cmd == F_SETLK64) || (cmd == F_SETLKW64))
> > +		return -EINVAL;
> 
> That won't work for IA32 emulation. There are programs that call
> old style fcntl() with F_*LK64. Just drop the if here.

I was going to elaborate on this when I sent the x86_64 part of the patch.
If you read the "normal" kernel fcntl function, it does NOT accept
F_GETLK64, F_SETLK64 or F_SETLKW64 through the fcntl sys call only
through the fcntl64 syscall.  So any program that does call the old
style fcntl() with one of those will fail on ia32 - which is what you are
trying to emulate.

Cheers,
Stephen
