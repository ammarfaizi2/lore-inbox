Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSFAPIs>; Sat, 1 Jun 2002 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSFAPIr>; Sat, 1 Jun 2002 11:08:47 -0400
Received: from pool-129-44-55-198.ny325.east.verizon.net ([129.44.55.198]:28175
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S312457AbSFAPIq>; Sat, 1 Jun 2002 11:08:46 -0400
Date: Sat, 1 Jun 2002 11:08:40 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel compile quiet mode
Message-ID: <20020601110840.A13076@arizona.localdomain>
In-Reply-To: <20020531230153.A12477@arizona.localdomain> <Pine.LNX.4.44.0206010228460.21152-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 02:34:25AM -0500, Kai Germaschewski wrote:
> > > gcc $CFLAGS -DKBUILD_BASENAME=raw -c -o raw.o raw.c
> > > gcc $CFLAGS -DKBUILD_BASENAME=pty -DEXPORT_SYMTAB -c -o pty.o pty.c
> > > gcc $CFLAGS -DKBUILD_BASENAME=misc -DEXPORT_SYMTAB -c -o misc.o misc.c
> > > gcc $CFLAGS -DKBUILD_BASENAME=random -DEXPORT_SYMTAB -c -o random.o random.c
> > > gcc $CFLAGS -DKBUILD_BASENAME=vt -c -o vt.o vt.c
> > > gcc $CFLAGS -DKBUILD_BASENAME=vc_screen -c -o vc_screen.o vc_screen.c
> 
> Not bad, I suppose different people prefer different approaches, anyway. 
> There is, however, still redundant output there, the "-o vt.o" and 
> "KBUILD_BASENAME=vt" should go away as well too, IMO.

I agree about the "-o vt.o" part.  I'm not so sure about KBUILD_BASENAME -
it's a little redundant, but it is sent to the compiler and is different on
each compile.  Anyway, fixing the '-o' redundancy is simple - just don't
send it to the compiler in the first place (the compiler will always do it
anyway).

I've attached another example patch to the end of this message.  Output
looks like:

gcc $CFLAGS -fno-omit-frame-pointer -DKBUILD_BASENAME=sched -c sched.c
gcc $CFLAGS -DKBUILD_BASENAME=dma -c dma.c
gcc $CFLAGS -DKBUILD_BASENAME=fork -c fork.c
gcc $CFLAGS -DKBUILD_BASENAME=exec_domain -DEXPORT_SYMTAB -c exec_domain.c
gcc $CFLAGS -DKBUILD_BASENAME=panic -c panic.c

> 
> [Answered a follow-up mail and didn't realize that l-k was CC'ed in
>  the first one, so here's my reply again.]

Sorry about that.  This one is also CC'ed to lkml.

Thanks,
-Kevin



--- ../gold-2.5/Rules.make      Fri May 31 22:10:04 2002
+++ ./Rules.make        Sat Jun  1 10:57:18 2002
@@ -127,7 +127,7 @@
 %.i: %.c FORCE
        $(call if_changed,cmd_cc_i_c)
 
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
+cmd_cc_o_c = $(CC) $(c_flags) -c $<
 
 %.o: %.c FORCE
        $(call if_changed,cmd_cc_o_c)
@@ -396,8 +396,9 @@
 
 # function to only execute the passed command if necessary
 
+echo_cmd = echo '$(strip $(subst $(CFLAGS),$$CFLAGS,$(subst $(CFLAGS_MODULE),$$CFLAGS_MODULE,$($(1)))))'
+
 if_changed = $(if $(strip $? \
                          $(filter-out $($(1)),$(cmd_$(@F)))\
                          $(filter-out $(cmd_$(@F)),$($(1)))),\
-              @echo '$($(1))' && $($(1)) && echo 'cmd_$@ := $($(1))' > $(@D)/.$(@F).cmd)
-
+              @$(call echo_cmd,$(1)) && $($(1)) && echo 'cmd_$@ := $($(1))' > $(@D)/.$(@F).cmd)



-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
