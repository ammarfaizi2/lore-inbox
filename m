Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSJQBvn>; Wed, 16 Oct 2002 21:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSJQBvm>; Wed, 16 Oct 2002 21:51:42 -0400
Received: from dp.samba.org ([66.70.73.150]:29591 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261622AbSJQBvh>;
	Wed, 16 Oct 2002 21:51:37 -0400
Date: Thu, 17 Oct 2002 11:41:27 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: davem@redhat.com, becker@scyld.com, jmorris@intercode.com.au,
       kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] change format of LSM hooks
Message-Id: <20021017114127.759e0e81.rusty@rustcorp.com.au>
In-Reply-To: <20021016000706.GI16966@kroah.com>
References: <20021015194545.GC15864@kroah.com>
	<20021015.124502.130514745.davem@redhat.com>
	<20021015201209.GE15864@kroah.com>
	<20021015.131037.96602290.davem@redhat.com>
	<20021015202828.GG15864@kroah.com>
	<20021016000706.GI16966@kroah.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002 17:07:06 -0700
Greg KH <greg@kroah.com> wrote:

> On Tue, Oct 15, 2002 at 01:28:28PM -0700, Greg KH wrote:
> > On Tue, Oct 15, 2002 at 01:10:37PM -0700, David S. Miller wrote:
> > > 
> > > I will not even look at the networking LSM bits until
> > > CONFIG_SECURITY=n is available.
> > 
> > Good enough reason for me, I'll start working on this.  Help from the
> > other LSM developers is appreciated :)
> 
> Ok, this wasn't that tough...
> 
> Here's a first cut at what will need to be changed.  It's a patch
> against Linus's latest BK tree.  I only converted one hook (the ptrace
> one), and this will not link, but will build and gives people an idea of
> where I'm heading.
> 
> David, does something like this look acceptable?
> 
> With it, and CONFIG_SECURITY=n the size of the security/*.o files are
> now:
>    text    data     bss     dec     hex filename
>     138       0       0     138      8a security/built-in.o
> 
> which I hope are a bit more to your liking :)
> I still need an empty sys_security stub in order to link properly,
> that's the only function needed.  The extra #includes are needed as
> some files were getting security.h picked up from shed.h in the past.
> 
> I'll work on fixing up the rest of the hooks, and removing the external
> reference to security_ops, and actually test this thing, later this
> evening.
> 
> thanks,
> 
> greg k-h
> 
> diff -Naur -X ../dontdiff bleeding_edge-2.5/arch/i386/kernel/ptrace.c lsm-2.5/arch/i386/kernel/ptrace.c
> --- bleeding_edge-2.5/arch/i386/kernel/ptrace.c	Tue Oct 15 16:47:14 2002
> +++ lsm-2.5/arch/i386/kernel/ptrace.c	Tue Oct 15 16:41:44 2002
> @@ -160,8 +160,7 @@
>  		/* are we already being traced? */
>  		if (current->ptrace & PT_PTRACED)
>  			goto out;
> -		ret = security_ops->ptrace(current->parent, current);
> -		if (ret)
> +		if ((ret = security_ptrace(current->parent, current)))

Um, rather than one macro per security_ops function, how about:

#ifdef CONFIG_SECURITY
	#define security_call(func, default_ret, ...) \
		(security_ops->func(__VA_ARGS__))
#else
	#define security_call(func, default_ret, ...) \
		(default_ret)
#endif

This also allows someone in the future to do:

	#define security_call(func, default_ret, ...) \
		({ if (try_inc_mod_count(security_ops->owner))
			(security_ops->func(__VA_ARGS__));
		   else
			(default_ret);
		})

Of course, you could skip the default_ret arg, and use
#ifndef CONFIG_SECURITY
	#define security_call(func, ...) \
		(security_default_##func)
#endif

Then all the defaults can be in a header somewhere.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
