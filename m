Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266548AbSKZS5D>; Tue, 26 Nov 2002 13:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKZS5C>; Tue, 26 Nov 2002 13:57:02 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:45268 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266548AbSKZS46>; Tue, 26 Nov 2002 13:56:58 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 26 Nov 2002 11:02:18 -0800
Message-Id: <200211261902.LAA04005@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002 10:34:30 +1100, Rusty Russell wrote:
>In message <200211251916.LAA01830@baldur.yggdrasil.com> you write:
[...]
>> >The ELF dependence will go back in eventually, but that's trivial.
>> 
>> 	I'm guessing this is for symbols.  If it's for something other
>> reason, I'd be curious to know it.
>
>--name support.  It's a hack, but it's 20 lines in total.

	Why not derive the default name from the file name?

	By the way, I have sometimes wanted to be able to load
multiple copies of the same module with different names, usually
little debugging helpers with different command line options.


>> 	[...] I have not seen any convincing
>> accounting of real benefits and costs that shows that it is a win to
>> have the module loader in kernel memory.
>
>Well, the linecount comes out as a wash (it's slightly bigger because
>of the hoops I jump through to avoid a spinlock on module refcount
>acquisition, but that's orthogonal).  Some archs lose 100 lines, some
>gain 400 lines.  The win comes from the cleanliness of two syscalls:
>one to add, one to remove.  For userspace loading you have one to
>allocate, one to insert, one to query so you know how to link.  Turns
>out to be more complicated than just doing the damn linking yourself.

	Sometimes a larger total code size to achieve smaller kernel
code size is a worthwhile trade-off because the userland code is not
always present, is swappable, is more customizable without rebooting
the system, etc.  Whether that is the case with the module loader
is the question that I'm trying to analyze.


>Frankly, linking just *isn't* that hard, especially when you're doing
>it on your own architecture (vs. 32-bit userspace handling both 32-bit
>and 64-bit kernelspaces).

	I think that Roman's approach of having a module-init.o
to initialize the struct module would reduce or eliminate this.

>With RTH's "make it a shared object" patch,
>it becomes even more trivial.

	rth's patch prevents allocating sections separately, so you
won't be able to kmalloc them as much, using TLB entries unnecessarily,
and using memory less efficiently in the case where the non-init
sections would fit in a single area small enough to be kmalloc'ed.
It's a modest cost, but it's something for the score card.



>But the flexibility!  By having a real interface, insmod doesn't need
>to know anything about the module (modprobe still does, but even that
>is very limited).

	Roman's module-init.o reduces or eliminates this difference.

>Shrinking insmod to 20 lines and putting it in
>busybox is nice, but being able to change the way parameters are
>parsed,

	I think the module parameters should be passed as an
argument to the init_module/insmod system call in either case.

>being able to switch reference count schemes, alter
>initialization or shutdown methods, rewrite module versioning to be
>sane, and otherwise tweak the kernel internals without breaking
>userspace is a huge win.

	For some changes, yes, but for some many other changes, a
scheme that uses Roman's module-init.o might not need any insmod
changes.  And, for an insmod as simple as Roman's mini-loader,
we could ship it with the kernel tree and install it in
/lib/modules/<version>/bin/.


>But let's ignore my ideas, and look at three things which have been
>suggested to me by other people since this patch went in.  Ted Ts'o's
>digital signatures on modules.  Obviously much simpler in kernelspace.

	No.  You're much more likely to have random crypto software in
user land.  User level authentication code can allocate memory more
freely, lookup up supporting certificates in external files, do
more elaborate more elaborate error handling like popping up a
dialog to say "The certificate for this module has expired.
Install it anyway?", or attempt to log the problem in
detail to a security server.

>The second is Keith Owens' NUMA text replication.  Now such a change
>is entirely up to the architecture (no modutils upgrade, sure, it will
>almost certainly break oprofile on them though for kernel hackers).

	Yes.  By the way, I assume that we're talking about the
read-only sections of a module being mapped to different physical
pages but having the same virtual addresses across all processors, by
the way.  User level insmod would need to be changed to load the
read-only sections separately.


>The third is David Woodhouse's "multiple init for modules".  There are
>some fundamental questions (each initfn must have a matching exitfn in
>case a later one fails), but this change wouldn't break userspace
>either.

	With something like module-{init,end}.o, this should not
require a further change to insmod.

	There are also a variety of changes which are easier with the
module loader in user land (saving ~100kB of unswappable space by
kicking the symbols out of the kernel, being able to load modules with
dependency loops).  Also, it's a small incremental difference, but
lowering the minimum resource costs of CONFIG_MODULES means that a
standard binary Linux kernel link kit may be a slightly more appealing
option to gadget makers in comparison to Vxworks, Windows NTE, CE, in
terms of engineering risk (e.g., what if the one kernel person who is
working on someone's digital music player quits).

	Anyhow, thank you very much for taking the time to explain
your case for kernel module loading.  I'm still thinking about it.


Regarding module loading tools that could support both user level
and kernel module loading:

>Sure: it'd definitely be worth distributing them together rather than
>the horrible install hack at the moment (there's a RPM which already
>does this).

	Good.

>I'd prefer a static parser which turns modules.conf into modprobe.conf
>rather than reimplementing modules.conf (config files which are so
>complex they need a "hobbled mode" in case they are called from
>untrusted context are in trouble already).

	Could we just use modules.conf and not support certain
commands?

>My plans were:
>
>1) Extend alias to be:
>
>	alias foo bar [and|or baz]...
>
>  Aliases would continue to insist that they resolve where defined (to
>  avoid loops).

	As we discussed, I suspect that we can insist that the names on
the right hand size must be actual module names, not aliases, at least
until someone complains and identifies a real use for aliases to
aliases.

>2) Implement "options" of course, which would stack (in case you
>   attach modules to an alias), and

	There are usually a small number of "options" lines that
people want to add, and I think that external packages that install
kernel module might want to install and remove those lines, so it
might be better to use the filesystem as the database for this, by
having small files like /etc/modules/args/ipsec_tunnel.


>3) Implement "install" (to allow arbitrary stuff like pre and post,
>   weirdass conditional stuff, etc).

	Then why not just run the existing modutils version of
modprobe?

	I've been thinking that perhaps we should eliminate
request_module() from the kernel and instead generate a "want"
hotplug event ("hotplug filesystem want ext3",
"hotplug devfs want /dev/discs/disc0/part3",  "hotplug soundcore want oss")
and move some of this complexity from modprobe to hotplug.  My
reason are:

	1. While we usually want to load a module in response to
	   these events, we might not always want to, and but we still
	   might want the "pre and post, weirdass conditional stuff, etc."
	   For example "hotplug devfs want /dev/discs/disc0/part3" may
	   just invoke "partx -a /dev/discs/disc0/disc".

	2. Walking a tree and loading a kernel module are probably best
	   done in C, while most of this other customization is
	   probably best done from shell scripts.

	3. There is a known security issue that users might
	   be able to cause a "dangerous" module to be loaded by
	   doing things like "ifconfig name-of-a-dangerous-module".

	4. Conceivably, we may want software packages that load a
	   set of hotplug functionality based on bus type, so it
	   would be helpful to use an interface that has the extra
	   argument for bus type as hotplug does.

	Maybe enough as been broken already, and this idea could be
pursued incrementally later if it's worth it.  Any comments would
be welcome.

	Also, thanks again for explaining your case for kernel module
loading.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

