Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSKYXh1>; Mon, 25 Nov 2002 18:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSKYXh1>; Mon, 25 Nov 2002 18:37:27 -0500
Received: from dp.samba.org ([66.70.73.150]:4328 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261573AbSKYXhZ>;
	Mon, 25 Nov 2002 18:37:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep 
In-reply-to: Your message of "Mon, 25 Nov 2002 11:16:32 -0800."
             <200211251916.LAA01830@baldur.yggdrasil.com> 
Date: Tue, 26 Nov 2002 10:34:30 +1100
Message-Id: <20021125234441.EFBEE2C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211251916.LAA01830@baldur.yggdrasil.com> you write:
> Rusty Russell wrote:
> >Hmm, I like it.  But I prefer to pull the depmod code into the source
> >too, to keep it all under one roof.
> 
> 	I have been thinking about splitting depmod into two programs:
> the program as originally designed that generates modules.dep and one
> that generates hardware support files.  The latter could be
> distributed in the Linux kernel tree and perhaps installed in
> /lib/modules/<version>/bin/ to make it easy to change support table
> formats as needed.

Makes sense, but the plan was to migrate to using module aliases
anyway (you took out module alias support in your patch, though) 8(.

The modules are postprocessed on built to convert the device tables
into a series of aliases, eg. "usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*"
for drivers/usb/net/pegasus.o.  Then /sbin/hotplug just goes "modprobe
usb:v0506p4601dl01dh01dc01dsc01dp01ic01isc01ip01" or whatever, and voila.

The alias system also allows a driver to alias to an older driver, eg:

	/* We can be used in place of the older driver if it isn't present */
	MODULE_ALIAS("foo2000");

I've put a FIXME:, under your scheme the alias information from the
modules themselves needs to be extracted by depmod.

> >The ELF dependence will go back in eventually, but that's trivial.
> 
> 	I'm guessing this is for symbols.  If it's for something other
> reason, I'd be curious to know it.

--name support.  It's a hack, but it's 20 lines in total.

> >Hmm, Adam, do you want to reverse positions and become
> >module-init-tools maintainer?  I'll send patches to you, instead of
> >vice versa.  I'll release a 0.8 with the patches I have so far, then
> >hand it over if you want.
> 
> >Thoughts?
> >Rusty.
> 
> 	I'm honored by the offer, but I have not seen any convincing
> accounting of real benefits and costs that shows that it is a win to
> have the module loader in kernel memory.

Well, the linecount comes out as a wash (it's slightly bigger because
of the hoops I jump through to avoid a spinlock on module refcount
acquisition, but that's orthogonal).  Some archs lose 100 lines, some
gain 400 lines.  The win comes from the cleanliness of two syscalls:
one to add, one to remove.  For userspace loading you have one to
allocate, one to insert, one to query so you know how to link.  Turns
out to be more complicated than just doing the damn linking yourself.

Frankly, linking just *isn't* that hard, especially when you're doing
it on your own architecture (vs. 32-bit userspace handling both 32-bit
and 64-bit kernelspaces).  With RTH's "make it a shared object" patch,
it becomes even more trivial.

But the flexibility!  By having a real interface, insmod doesn't need
to know anything about the module (modprobe still does, but even that
is very limited).  Shrinking insmod to 20 lines and putting it in
busybox is nice, but being able to change the way parameters are
parsed, being able to switch reference count schemes, alter
initialization or shutdown methods, rewrite module versioning to be
sane, and otherwise tweak the kernel internals without breaking
userspace is a huge win.

But let's ignore my ideas, and look at three things which have been
suggested to me by other people since this patch went in.  Ted Ts'o's
digital signatures on modules.  Obviously much simpler in kernelspace.
The second is Keith Owens' NUMA text replication.  Now such a change
is entirely up to the architecture (no modutils upgrade, sure, it will
almost certainly break oprofile on them though for kernel hackers).
The third is David Woodhouse's "multiple init for modules".  There are
some fundamental questions (each initfn must have a matching exitfn in
case a later one fails), but this change wouldn't break userspace
either.

Even if the code had added 500 lines to the kernel, I'd say it was a
win.

> I might be interested in
> maintaining a small modutils that could be compiled to support either
> the in-kernel module load or a user level method (or both) so as to
> avoid unnecessary differences between the user level and in-kernel
> methods, given that the code that is specific to the kernel module
> loader would be small.

Sure: it'd definitely be worth distributing them together rather than
the horrible install hack at the moment (there's a RPM which already
does this). 

I'd prefer a static parser which turns modules.conf into modprobe.conf
rather than reimplementing modules.conf (config files which are so
complex they need a "hobbled mode" in case they are called from
untrusted context are in trouble already).  My plans were:

1) Extend alias to be:

	alias foo bar [and|or baz]...

  Aliases would continue to insist that they resolve where defined (to
  avoid loops).

2) Implement "options" of course, which would stack (in case you
   attach modules to an alias), and

3) Implement "install" (to allow arbitrary stuff like pre and post,
   weirdass conditional stuff, etc).

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
