Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSK0WqF>; Wed, 27 Nov 2002 17:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSK0WpO>; Wed, 27 Nov 2002 17:45:14 -0500
Received: from dp.samba.org ([66.70.73.150]:52446 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264890AbSK0WpH>;
	Wed, 27 Nov 2002 17:45:07 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep 
In-reply-to: Your message of "Tue, 26 Nov 2002 11:02:18 -0800."
             <200211261902.LAA04005@baldur.yggdrasil.com> 
Date: Wed, 27 Nov 2002 16:02:08 +1100
Message-Id: <20021127225227.6B1952C088@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211261902.LAA04005@baldur.yggdrasil.com> you write:
> On Tue, 26 Nov 2002 10:34:30 +1100, Rusty Russell wrote:
> >In message <200211251916.LAA01830@baldur.yggdrasil.com> you write:
> [...]
> >> >The ELF dependence will go back in eventually, but that's trivial.
> >> 
> >> 	I'm guessing this is for symbols.  If it's for something other
> >> reason, I'd be curious to know it.
> >
> >--name support.  It's a hack, but it's 20 lines in total.
> 
> 	Why not derive the default name from the file name?

Yes, it's a choice.  But inside the kernel, modules know their own
name for module_parm() support.  Changing it outside the kernel is
counterintuitive, and hence generally inadvisable.

> 	By the way, I have sometimes wanted to be able to load
> multiple copies of the same module with different names, usually
> little debugging helpers with different command line options.

Yes, this is exactly why this hack exists (dummy.o and ethertap.o kind
of rely on it).

> >Frankly, linking just *isn't* that hard, especially when you're doing
> >it on your own architecture (vs. 32-bit userspace handling both 32-bit
> >and 64-bit kernelspaces).
> 
> 	I think that Roman's approach of having a module-init.o
> to initialize the struct module would reduce or eliminate this.

Yes, and, we could ship libc with the kernel and avoid having to keep
stable system call interfaces too.  But there's benifit in not doing
it: we keep the kernel fairly standalone and it is good discipline for
us.

> >With RTH's "make it a shared object" patch,
> >it becomes even more trivial.
> 
> 	rth's patch prevents allocating sections separately, so you
> won't be able to kmalloc them as much, using TLB entries unnecessarily,
> and using memory less efficiently in the case where the non-init
> sections would fit in a single area small enough to be kmalloc'ed.
> It's a modest cost, but it's something for the score card.

Even in total, most modules are fairly small, so I don't think it's a
big issue really.  Maybe.

> >But let's ignore my ideas, and look at three things which have been
> >suggested to me by other people since this patch went in.  Ted Ts'o's
> >digital signatures on modules.  Obviously much simpler in kernelspace.
> 
> 	No.  You're much more likely to have random crypto software in
> user land.

Yes, but I believe the problem is that the kernel has to authenticate
it somehow.

> 	There are also a variety of changes which are easier with the
> module loader in user land (saving ~100kB of unswappable space by
> kicking the symbols out of the kernel, being able to load modules with
> dependency loops).

The first one is definitely a valid point, which I hadn't considered
before.  Of course, compression takes it down to 14k, which implies we
should at least be doing something with it 8(

> >I'd prefer a static parser which turns modules.conf into modprobe.conf
> >rather than reimplementing modules.conf (config files which are so
> >complex they need a "hobbled mode" in case they are called from
> >untrusted context are in trouble already).
> 
> 	Could we just use modules.conf and not support certain
> commands?

Hmm, I'd prefer to convert.

> 
> >My plans were:
> >
> >1) Extend alias to be:
> >
> >	alias foo bar [and|or baz]...
> >
> >  Aliases would continue to insist that they resolve where defined (to
> >  avoid loops).
> 
> 	As we discussed, I suspect that we can insist that the names on
> the right hand size must be actual module names, not aliases, at least
> until someone complains and identifies a real use for aliases to
> aliases.

Sure.

> >2) Implement "options" of course, which would stack (in case you
> >   attach modules to an alias), and
> 
> 	There are usually a small number of "options" lines that
> people want to add, and I think that external packages that install
> kernel module might want to install and remove those lines, so it
> might be better to use the filesystem as the database for this, by
> having small files like /etc/modules/args/ipsec_tunnel.

Hmm, Debian actually compiles up modules.conf at the moment as it is:
it's probably better to leave this to the distros anyway.

> >3) Implement "install" (to allow arbitrary stuff like pre and post,
> >   weirdass conditional stuff, etc).
> 
> 	Then why not just run the existing modutils version of
> modprobe?

Because three commands should do everything we need?  Because it's
infinitely simpler?  But mainly because I *want* people to customize
modprobe for their own uses (that's why /proc/sys/kernel/modprobe
exists), and simplicity is good.

> 	I've been thinking that perhaps we should eliminate
> request_module() from the kernel and instead generate a "want"

Hmm, I'll have to take time to think about it.  One kernel change at a
time, I think 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
