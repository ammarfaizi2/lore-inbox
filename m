Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSGAInV>; Mon, 1 Jul 2002 04:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSGAInU>; Mon, 1 Jul 2002 04:43:20 -0400
Received: from zok.SGI.COM ([204.94.215.101]:27797 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S312254AbSGAInT>;
	Mon, 1 Jul 2002 04:43:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: Rusty's module talk at the Kernel Summit
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jul 2002 18:45:31 +1000
Message-ID: <22742.1025513131@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty at Kernel Summit:

  "Keith is not angry yet, but he will be if he hears some of the
  things I am going to say".
  
Having heard the talk, I am not angry, but some corrections are
required.


=== inter_module_{un}register

inter_module_unregister does BUG() because inter_module_register and
unregister _must_ be matching pairs.  The BUG() is to catch coding
errors, i.e. a run time check to ensure that the interface is being
used correctly.  Rusty, was that point 4 or 5 on your "nice interface"
list?

The only way that inter_module_register can fail to register the
interface is if kmalloc fails, hence the check and the use of
kmalloc_failed.  Anything else is a programmer error, hence BUG().

Registering two blobs with the same name is also a programming error,
so that fails as well.  Blob names must be unique.

The checks and BUG calls are done in inter_module_{un}register because
they must be done for all users of this interface.  The alternative was
assuming that every caller would check for their own coding errors.


=== Discarding init sections.

Discarding init sections is relatively easy, just position the sections
where they can be freed after module_init().  Ensuring that the
associated tables in the module such as exception lists, MIPS dbe, ia64
unwind etc. are updated to reflect that some code/data that used to
exist no longer exists is a lot harder.

Since modules are always allocated on page boundaries, discarding init
sections is only a win if it reduces the final size of the module from
m to m-n pages.  So far the pain of loading in multiple areas and
adjusting the associated arch dependent tables after discard has
outweighed any gain from discarding the init sections from modules.


=== modversions

Keep a "list of symbols and their versions and the in kernel module
linker matches them up".  That will not work.  The whole point of
modversions is to identify the ABI used to compile the module, at the
time it was compiled, not when it is loaded.

IOW, the ABI version information must be bound to the module at the
time the module is built, not when it is loaded.  Hence the mangling of
exported symbols at compile time, not at load time.

The Makefiles list the objects that export symbols as a build
optimization.  Because there is no way of telling where an exported
symbol is used and because the exported symbols must reflect the
compile time ABI, kbuild has to calculate the modversion data at the
start of compilation, before anything else can be compiled.

kbuild could 'fgrep -rl EXPORT_SYMBOL .' to get the list of exporting
objects instead of manually specifying them, but that would slow down
every build.  The existing kbuild system is full of these little
optimizations to make it run faster, e.g. only descend into a directory
if CONFIG_FOO is set.  I agree that they are a pain in the neck, but
you should see how much slower the existing build system runs without
them.

kbuild 2.5 does away with almost all of the hand coded build
optimizations and still manages to be as fast or faster than the
existing build system.  Apparently that does not count for most people,
they are happy with a build system that requires manual optimization to
get decent speed.

"md5sum over the source code, .config etc." to verify if a module and
kernel belong together is pointless.  One advantage of modversions is
that the version data allows a module to be loaded into any compatible
kernel as long as the ABI has not changed, so a checksum of the kernel
source is no good.  Changing the config does not necessarily invalidate
a module, turning on CONFIG_DRIVER_FOO only affect the FOO module, not
every module, so a checksum of .config is no good either.

BTW, I have a design for doing modversions correctly that will not
require manual entries in the Makefiles, will not require name
mangling, will provide better error checking than the current
modversions and provides better error messages for users.

It not only detects a mismatch between SMP and non-SMP but it also
detects all the other build differences that slip past the current
modversion algorithm.  It is cheap enough and accurate enough that
modversions can be the default, this will improve error detection at
the time the module is loaded instead of some random oops later.  Only
one problem, it requires kbuild 2.5, so you will not get this design.


=== MOD_INC_USE_COUNT vs try_inc_mod_count

MOD_INC_USE_COUNT is perfectly safe within a module init routine.
sys_init_module() bumps the use count temporarily around the call to
the module init routine.

MOD_INC_USE_COUNT within a module but outside the init routine has a
race between entering the module on one cpu and freeing the module on
another.  However that race also affects try_inc_mod_count, or any
other method that adjusts the use count from with the object itself.

If you solve the problem of lack of reference counting for code
executing with use count == 0 (including all the preempt hassles) then
both MOD_INC_USE_COUNT and try_inc_mod_count are safe.  AFAICT there is
no need to change every module's use of MOD_INC_USE_COUNT for its own
use count.


=== Pointer trampolines

A couple of years ago I looked at putting a trampoline around function
calls that entered a module.  The aim was to bump the use count
_before_ entering the code, removing the unload race.  However the
implementation sucked.  Each architecture needed its own trampoline
code.  Passing parameters from the trampoline to the real code was a
nightmare, especially on ia64 where the hardware says how many
parameters are being passed.

gcc __builtin_apply and __builtin_return would have helped, but they do
not work on all architectures.  I gave up trampolines for module entry
as a nice idea that was just too difficult to implement and maintain.

