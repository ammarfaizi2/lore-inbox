Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310457AbSCLHKa>; Tue, 12 Mar 2002 02:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310464AbSCLHKU>; Tue, 12 Mar 2002 02:10:20 -0500
Received: from ns.suse.de ([213.95.15.193]:23047 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310457AbSCLHKD>;
	Tue, 12 Mar 2002 02:10:03 -0500
Date: Tue, 12 Mar 2002 08:10:02 +0100
From: Andi Kleen <ak@suse.de>
To: Brad Pepers <brad@linuxcanada.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Multi-threading
Message-ID: <20020312081002.A14745@wotan.suse.de>
In-Reply-To: <20020311182111Z310364-889+120750@vger.kernel.org.suse.lists.linux.kernel> <p73zo1e4voi.fsf@oldwotan.suse.de> <20020312000310.DBCF41EDB9@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312000310.DBCF41EDB9@Cantor.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 05:02:50PM -0700, Brad Pepers wrote:
> > atomic_dec_and_return() doesn't strike me as too useful, because
> > it would need to lie to you. When you have a reference count
> > and you unlink the object first from public view you can trust
> > a 0 check (as atomic_dec_and_test does). As long as the object
> > is in public view someone else can change the counts and any
> > "atomic return" of that would be just lying. You can of course
> > always use atomic_read(), but it's not really atomic. I doubt the
> > microsoft equivalent is atomic neither, they are probably equivalent
> > to atomic_inc(); atomic_read(); or atomic_dec(); atomic_read() and
> > some hand weaving.
> 
> Apparently the Microsoft one really is in Windows 98 and up (not in 95).  
> I've had it explained that the asm code (semi-pseudo code here) is like this:
> 
>         movl       reg, #-1
>         lock xadd  reg, counter
>         decl       reg
>         movl       result, reg
> 
> This is in comparison to the current code which does something like this:
> 
>         lock decl counter
>         sete      result
> 
> I don't see how the first asm code lies to you.  It is returning the value as 
> it was decremented to and the lock on the xadd keeps it safe.

Just it might change immediately afterwards if you don't remove the 
object from public view first. An "atomic" value that you cannot depend
on is not very useful. The Linux convention of using atomic_dec_and_test()
is also only safe when you remove it first, but the dec_and_test encourages
this at least.  atomic_inc_and_read() could only be safe when you remove
the object first too, but I don't see how it could be ever useful assuming
you keep the convention that reference count == 0 means freeable object. 

> 
> > BTW regarding atomic.h: while it is nicely usable on i386 in userspace
> > it isn't completely portable. Some architectures require helper functions
> > that are hard to implement in user space.
> 
> Its too bad Linux didn't have a nice wrapper around atom inc/dec/test that 
> was completely portable.  Do you know what arch's have trouble implementing 
> this?

sparc32 at least. 
I think pa-risc32 too. 

-Andi
