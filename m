Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTB1K0h>; Fri, 28 Feb 2003 05:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267776AbTB1K0h>; Fri, 28 Feb 2003 05:26:37 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:43225 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267775AbTB1K0f>; Fri, 28 Feb 2003 05:26:35 -0500
Date: Fri, 28 Feb 2003 11:36:09 +0100
From: Andi Kleen <ak@muc.de>
To: sfr@canb.auug.org.au
Cc: ak@muc.de, anton@samba.org, davem@redhat.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, matthew@wil.cx, ralf@gnu.org,
       schwidefsky@de.ibm.com, torvalds@transmeta.com
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-ID: <20030228103609.GA29955@averell>
References: <200302280950.h1S9oZdx014060@supreme.pcug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302280950.h1S9oZdx014060@supreme.pcug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 10:50:35AM +0100, sfr@canb.auug.org.au wrote:
> > 
> > On Fri, Feb 28, 2003 at 05:33:49AM +0100, Stephen Rothwell wrote:
> > > +static int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
> > > +{
> > > +	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
> > > +	    __get_user(kfl->l_type, &ufl->l_type) ||
> > > +	    __get_user(kfl->l_whence, &ufl->l_whence) ||
> > > +	    __get_user(kfl->l_start, &ufl->l_start) ||
> > > +	    __get_user(kfl->l_len, &ufl->l_len) ||
> > > +	    __get_user(kfl->l_pid, &ufl->l_pid))
> > 
> > Perhaps there should be really a big fat comment on top of compat.c
> > that it depends on a hole on __PAGE_OFFSET if the arch allows passing
> > 64bit pointers to the compat functions.
> 
> One of my tasks is to document all the assumptions in hte comapt code
> (and there a a few - and I find more as I go :-)).  However, could you
> elaborate a bit here - do you mean passing 64 bit pointers from user mode?

On some architectures it may be possible to smuggle 64bit pointers into
function arguments of the 32bit emulation. It should be able to handle
that without security holes.

e.g. on x86-64 it was for some time using ptrace - you could do 
a syscall trace and restart a system call and modify the input arguments
again to contain 64bit pointers. I closed this, but there may be similar
holes on other ports. IMHO the 32bit emulation layer should be 64bit
input argument clean to avoid such subtle problems.

Now there used to be some code that did:

	if (get_user(a, &userstruct->firstmember) ||
	   __get_user(b, &userstruct->secondmember))
		return -EFAULT;

Assuming that the access_ok in get_user for sizeof(firstmember) covers
secondmember too which doesn't do access_ok in __get_user. This only
works assuming it should handle 64bit pointers when there is a memory
hole at the end of the user process space, otherwise it could
access kernel pages directly after TASK_SIZE. x86-64 has a big enough 
hole there, i assume sparc64 and ia64 have too, but i don't know 
about the other 64bit ports.

Actually your fcntl code is ok in this regard because it 
uses access_ok with the correct argument, but other code sometimes doesn't.

> > > +asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
> > > +		unsigned long arg)
> > > +{
> > > +	if ((cmd == F_GETLK64) || (cmd == F_SETLK64) || (cmd == F_SETLKW64))
> > > +		return -EINVAL;
> > 
> > That won't work for IA32 emulation. There are programs that call
> > old style fcntl() with F_*LK64. Just drop the if here.
> 
> I was going to elaborate on this when I sent the x86_64 part of the patch.
> If you read the "normal" kernel fcntl function, it does NOT accept
> F_GETLK64, F_SETLK64 or F_SETLKW64 through the fcntl sys call only
> through the fcntl64 syscall.  So any program that does call the old
> style fcntl() with one of those will fail on ia32 - which is what you are
> trying to emulate.

Are you sure? I thought it did. But perhaps I'm confusing it with 
fcntl64 here. fcntl64 definitely needs to accept the old style calls
(I remember debugging a problem in some application that relied on that)

-Andi
