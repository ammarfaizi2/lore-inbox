Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSE2UWy>; Wed, 29 May 2002 16:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSE2UWx>; Wed, 29 May 2002 16:22:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50569 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315461AbSE2UWv>; Wed, 29 May 2002 16:22:51 -0400
Date: Wed, 29 May 2002 15:22:52 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
Subject: 2.5.19 - What's up with the kernel build?
Message-ID: <Pine.LNX.4.44.0205291519270.9971-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Okay, as people probably already noticed, I touched quite a lot of
Makefiles lately. Contrary to what the patches (which touched many
files) might imply, not much did actually change, in particular not
much visible outside of the kernel build process.

There is still quite a bit left to do (in particular improving
dependency generation and modversions handling), but I think it makes
sense to explain what happened so far.

There's also some points (marked with >>>) where I'd like to get
feedback on how things should be handled in the future.


For users (i.e. people who compile kernels)
-------------------------------------------
Not much changed at all. Do what you always did, it should still work
the same.

o vmlinux/(b)zImage etc. and modules can now be built in the same
  pass.
  For testing this feature, please use

      make BUILD_MODULES=1 vmlinuz/(b)zImage/whatever,

  i.e. add the "BUILD_MODULES=1" to the command line you normally use,
  and you save the additional "make modules" run.

>>> What do you guys think how this should be handled in the future? -
>>> my suggestion would be to make this behavior the default, and, in
>>> case someone needs it, add the option to say "BUILD_MODULES=0".
  
o you can ask to build a single target, like 

      make some/dir/foo.[iso]

  and it'll give you preprocessed/assembler/object file output, provided
  that some/dir/foo.c or some/dir/foo.S exists. It should get all cases
  correct (well, except for arch/i386/kernel/{head.o,init_task.o}, which
  will cause an entire recursive run), with adding the right flags,
  compiling as modular etc.

o when your source tree changed only little or not at all, performance
  should be quite a bit improved. If you do "make BUILD_MODULES=1 
  vmlinux", the number of "make" invocations should be down by about a 
  factor of three compared to a previous "make vmlinux modules". Also, 
  vmlinux will not be relinked if nothing actually changed. (If lots of 
  files changed, the time make consumes will be down in the noise, the 
  build time will be dominated by gcc).

>>> It's possible with only small changes to provide a quiet mode now,
>>> which would not print the entire command lines but only
>>>
>>>	  Descending into drivers/isdn/kcapi
>>>	  Compiling kcapi.o
>>>	  Compiling capiutil.o
>>>	  Linking kernelcapi.o
>>>	  ...
>>>
>>> Is that considered useful?

For developers:
---------------

If you had clean Makefiles for your subsystem/driver/whatever before,
again, not much changed.

o "list-multi" + associated link rules are gone for good. It's been
  like that for a couple of months now, so that's probably no news
  for you.

o Descending into and linking subdirs was often handled with constructs
  like the following:

       subdir-$(CONFIG_E100) += e100
       ifeq ($(CONFIG_E100),y)
         obj-y += e100/e100.o
       endif 

  This can now be expressed in a much more compact way as

       obj-$(CONFIG_E100) += e100/

  which basically means the exact same thing:
  - if CONFIG_E100=y, descend into the subdir and link the result
  - if CONFIG_E100=m, descend into the subdir and build the modules there
  - otherwise, ignore that subdir

  Only requirement is that the O_TARGET in the subdir (that's what getting
  linked in, "e100.o" in the example above) is named "built-in.o". To
  simplify things even further, just leaving out the "O_TARGET := ..."
  line does the right thing, it uses "built-in.o" as default. Anyway,
  the conversion is mostly done now, so you don't have to actually deal
  with it.

o Once we make "module and built-in in one pass" default, the

       mod-subdirs := ...

  lines can go, too. Nobody understood what they're there for anyway,
  right? ;-)

For arch maintainers:
---------------------

o In the arch specific Makefiles, you needed to build not only 
  O_TARGET (or L_TARGET) out of $(obj-y) and the modules 
  in $(obj-m), but also additional objects, e.g. for i386: 
  "head.o" and "init_task.o"

  This can (and should) be done cleanly now, by adding such targets to
  the variable EXTRA_TARGETS instead of playing games with overriding
  Rules.make's "first_rule:"

  The conversion is basically done, so you don't really need to
  bother.

o Rules.make provides standard rules for assembling files now,

  So use them - again, the conversion is done already, just don't undo
  it.



BTW, yeah, I know, Documentation/kbuild/makefiles.txt could use an
update. Will do that...


--Kai


