Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbTAZVh2>; Sun, 26 Jan 2003 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTAZVh2>; Sun, 26 Jan 2003 16:37:28 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58825 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267003AbTAZVhW>; Sun, 26 Jan 2003 16:37:22 -0500
Date: Sun, 26 Jan 2003 15:46:30 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Christian Zander <zander@minion.de>
cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
In-Reply-To: <20030126215714.GA394@kugai>
Message-ID: <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, Christian Zander wrote:

> On Sun, Jan 26, 2003 at 11:51:22AM -0600, Kai Germaschewski wrote:
> > 
> > Well, what I'm trying to say is that external build system will
> > always break one way or other. Since they're external, they're
> > naturally out of reach for me to influence, so there's really
> > nothing I can do it but telling people to using the internal system
> > instead.
> > 
> 
> External build systems have been working just fine even after kbuild
> was adopted as the build system of choice for the Linux kernel, there
> should be more convincing reasons for deliberately breaking them now.

That's not true. For example, how would an old external build system 
magically starting to compile modules as .ko without updating? How would 
it have added -DKBUILD_BASENAME and -DKBUILD_MODNAME, which are required 
by the new module code. And, how did they avoid subtle breakage like not 
giving the same switches on the command line? (This list goes on...)

Also, it's not true that they've been broken deliberately. As work 
progresses, breakage occurs, that's just a fact of live. However, 
introduction of __vermagic was not introduced in order to make live for 
maintainers of external modules harder, it was introduced since loading 
modules compiled with gcc3 into a kernel compiled with gcc2 caused crashes 
for people.

> > When you're using the kernel build, the above cannot happen, since
> > the kernel build system knows about this dependency and builds a new
> > init/vermagic.o with the correct information before it gets linked
> > into the external module.
> 
> Is that so? Does kbuild determine that vermagic.o needs rebuilding if
> the compiler version changed?

Okay, you have a point here, there's still a bug. vermagic.o will be 
rebuilt when the version changes or any of the recorded config options 
change, but it doesn't pick up changes in the compiler version, if the 
new gcc has the same name.

That's a bug for internal use as well, the patch below fixes it.

Two more things:

o You say kbuild has been adopted as the build system of choice. That's
  misleading, the new build system for 2.5, called kbuild-2.5 has never
  been adopted. It's just that the existing build system has been improved
  quite a bit by me and others.

o One thing I do not understand at all: What is the problem with using
  the internal build system? It makes maintainance of external modules
  much easier than keeping track of what happens in the kernel and
  patching a private solution all the time.

  I don't even see any license issues, first of all you don't even 
  distribute it, the user who's building the module will already have it 
  along with his kernel source. And if you're using it to compile 
  (possibly binary) modules you want to distribute, you can just use it 
  just like gcc without any further obligations, so no problem there
  either. (IANAL, of course)

--Kai


===== init/Makefile 1.18 vs edited =====
--- 1.18/init/Makefile	Tue Jan 14 14:29:02 2003
+++ edited/init/Makefile	Sun Jan 26 15:24:21 2003
@@ -12,6 +12,13 @@
 
 $(obj)/version.o: include/linux/compile.h
 
+# vermagic doesn't actually include compile.h, but it records
+# the compiler version. To make sure we notice when the compiler
+# changes, add a dependency on compile.h, which changes when the
+# compiler changes.
+
+$(obj)/vermagic.o: include/linux/compile.h
+
 # compile.h changes depending on hostname, generation number, etc,
 # so we regenerate it always.
 # mkcompile_h will make sure to only update the


