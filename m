Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSFADCB>; Fri, 31 May 2002 23:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSFADCA>; Fri, 31 May 2002 23:02:00 -0400
Received: from pool-129-44-55-198.ny325.east.verizon.net ([129.44.55.198]:53518
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S316519AbSFADB7>; Fri, 31 May 2002 23:01:59 -0400
Date: Fri, 31 May 2002 23:01:53 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Kernel compile quiet mode
Message-ID: <20020531230153.A12477@arizona.localdomain>
In-Reply-To: <Pine.LNX.4.44.0205291519270.9971-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 03:22:52PM -0500, Kai Germaschewski wrote:
[...]
> >>> It's possible with only small changes to provide a quiet mode now,
> >>> which would not print the entire command lines but only
> >>>
> >>>	  Descending into drivers/isdn/kcapi
> >>>	  Compiling kcapi.o
> >>>	  Compiling capiutil.o
> >>>	  Linking kernelcapi.o
> >>>	  ...
> >>>
> >>> Is that considered useful?

Hi Kai,

I think it would be useful, but in a slightly different way.  The
information printed during make can be informative, but too much of the
output is just redundant.  I'd prefer a change something like the
following:

--- ../gold-2.5/Rules.make      Fri May 31 22:10:04 2002
+++ ./Rules.make        Fri May 31 22:56:33 2002
@@ -399,5 +399,5 @@
 if_changed = $(if $(strip $? \
                          $(filter-out $($(1)),$(cmd_$(@F)))\
                          $(filter-out $(cmd_$(@F)),$($(1)))),\
-              @echo '$($(1))' && $($(1)) && echo 'cmd_$@ := $($(1))' > $(@D)/.$(@F).cmd)
+              @echo '$(subst $(CFLAGS),$$CFLAGS,$(strip $($(1))))' && $($(1)) && echo 'cmd_$@ := $($(1))' > $(@D)/.$(@F).cmd)
 

which causes output to look like:

gcc $CFLAGS -DKBUILD_BASENAME=raw -c -o raw.o raw.c
gcc $CFLAGS -DKBUILD_BASENAME=pty -DEXPORT_SYMTAB -c -o pty.o pty.c
gcc $CFLAGS -DKBUILD_BASENAME=misc -DEXPORT_SYMTAB -c -o misc.o misc.c
gcc $CFLAGS -DKBUILD_BASENAME=random -DEXPORT_SYMTAB -c -o random.o random.c
gcc $CFLAGS -DKBUILD_BASENAME=vt -c -o vt.o vt.c
gcc $CFLAGS -DKBUILD_BASENAME=vc_screen -c -o vc_screen.o vc_screen.c

IMO, this has all the advantages of the "quiet" output, but none of the
information loss.  (The only thing suppressed is CFLAGS which doesn't
change.)

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
