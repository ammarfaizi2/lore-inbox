Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSFWSjx>; Sun, 23 Jun 2002 14:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSFWSjw>; Sun, 23 Jun 2002 14:39:52 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:59885 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317073AbSFWSju>; Sun, 23 Jun 2002 14:39:50 -0400
Date: Sun, 23 Jun 2002 13:39:51 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
Subject: kbuild fixes and more
Message-ID: <Pine.LNX.4.44.0206231325280.6241-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I suppose we won't see any official / -dj releases any time soon, since
everybody is at OLS, so I figured it may make sense to publish my
current tree, which fixes some outstanding build problems and adds more
cleanup.

Most notably:

make KBUILD_VERBOSE= bzImage

(or export KBUILD_VERBOSE=0 / setenv KBUILD_VERBOSE 0; make bzImage)

looks certainly improved now.

Fixes include:
o the defkeymap/loadkeys issue
o calling host programs for khttpd / soundmodem
o make net_dev_init() a subsys_initcall, to make sure it's called
  before any net device registers.

Patch is available from 

http://www.tp1.ruhr-uni-bochum.de/~kai/kbuild/patch-2.5.24-kg1.gz

	or

bk pull http://linux-isdn.bkbits.net/linux-2.5.make


Feedback is very welcome, of course ;)

--Kai


ChangeLog:

-----------------------------------------------------------------------------
ChangeSet@1.490.1.62, 2002-06-20 11:57:34-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Assorted cleanups
      
  o Provide $(obj),$(objtree) and friends in the top-level Makefile as well
    for consistency (Sam Ravnborg)
  o Make $(call cmd,whatever) consistent with $(call if_changed,whatever),
    i.e. both will execute $(cmd_whatever)
  o Add $(echo_target), which will print the current target in a suitable
    way for the quiet output format (i.e. target name relative to the
    top-level directory)
  o Fix the dependencies for host compiled programs to work for files in
    subdirectories (missed converting them when introducing $(depfile))
  o Add commands which will be useful when generating boot images.

 ----------------------------------------------------------------------------
 Makefile   |   13 ++++++++---
 Rules.make |   70 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 61 insertions(+), 22 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.63, 2002-06-20 12:07:42-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Prepare LDFLAGS for general use
  
  Some arch Makefiles use LDFLAGS to keep special flags for the final
  vmlinux link. However, we'd rather use LDFLAGS along the lines of
  CFLAGS, AFLAGS etc, so get rid of these special cases.

 ----------------------------------------------------------------------------
 i386/Makefile   |    3 +--
 parisc/Makefile |    3 +--
 s390/Makefile   |    3 +--
 s390x/Makefile  |    3 +--
 x86_64/Makefile |    3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.64, 2002-06-20 12:25:11-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Rename ld flags for vmlinux to LDFLAGS_vmlinux
  
  Everywhere else we use CFLAGS_<target> etc to designate special flags
  for an object, so handle vmlinux the same way.

 ----------------------------------------------------------------------------
 Makefile              |    4 ++--
 arch/alpha/Makefile   |    2 +-
 arch/arm/Makefile     |    2 +-
 arch/cris/Makefile    |    2 +-
 arch/i386/Makefile    |    2 +-
 arch/ia64/Makefile    |    2 +-
 arch/m68k/Makefile    |    4 ++--
 arch/mips/Makefile    |    4 ++--
 arch/mips64/Makefile  |   10 +++++-----
 arch/parisc/Makefile  |    2 +-
 arch/ppc/Makefile     |    2 +-
 arch/ppc64/Makefile   |    2 +-
 arch/s390/Makefile    |    2 +-
 arch/s390x/Makefile   |    2 +-
 arch/sh/Makefile      |    8 ++++----
 arch/sparc/Makefile   |    4 ++--
 arch/sparc64/Makefile |    2 +-
 arch/x86_64/Makefile  |    2 +-
 18 files changed, 29 insertions(+), 29 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.65, 2002-06-20 12:50:29-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Put flags for ld into LDFLAGS
  
  Some archs sneaked additional flags for ld into $(LD). This can be done
  cleaner now, by just using $(LDFLAGS).

 ----------------------------------------------------------------------------
 Makefile                                |    2 +-
 Rules.make                              |    4 ++--
 arch/i386/Makefile                      |    2 +-
 arch/i386/boot/Makefile                 |    8 ++++----
 arch/i386/boot/compressed/Makefile      |    6 +++---
 arch/m68k/Makefile                      |    2 +-
 arch/mips/Makefile                      |    2 +-
 arch/mips/philips/nino/ramdisk/Makefile |    2 +-
 arch/mips64/Makefile                    |    2 +-
 arch/s390/Makefile                      |    2 +-
 arch/s390/boot/Makefile                 |    2 +-
 arch/s390x/Makefile                     |    2 +-
 arch/sh/Makefile                        |    1 -
 arch/sh/boot/compressed/Makefile        |    4 ++--
 arch/sparc/Makefile                     |    2 +-
 arch/sparc/boot/Makefile                |    2 +-
 arch/sparc64/Makefile                   |    2 +-
 drivers/message/fusion/Makefile         |    6 ------
 18 files changed, 23 insertions(+), 30 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.66, 2002-06-20 13:35:15-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Put flags for objcopy into OBJCOPYFLAGS
  
  Again, don't just add flags into $(OBJCOPY), but use the
  variable $(OBJCOPYFLAGS) instead.

 ----------------------------------------------------------------------------
 arm/Makefile                    |    1 +
 arm/boot/Makefile               |    6 +++---
 arm/boot/compressed/Makefile    |    2 +-
 cris/Makefile                   |    4 ++--
 cris/boot/compressed/Makefile   |    4 ++--
 cris/boot/rescue/Makefile       |    7 ++++---
 i386/Makefile                   |    4 ++--
 i386/boot/Makefile              |    4 ++--
 i386/boot/compressed/Makefile   |    2 +-
 ia64/Makefile                   |    3 ++-
 parisc/Makefile                 |    2 +-
 ppc64/boot/Makefile             |    4 ++--
 s390/Makefile                   |    2 +-
 s390/boot/Makefile              |    6 ++----
 s390x/Makefile                  |    2 +-
 s390x/boot/Makefile             |    6 ++----
 sh/Makefile                     |    2 +-
 sh/boot/Makefile                |    4 ++--
 sh/boot/compressed/Makefile     |    2 +-
 x86_64/Makefile                 |    2 +-
 x86_64/boot/Makefile            |    4 ++--
 x86_64/boot/compressed/Makefile |    2 +-
 22 files changed, 37 insertions(+), 38 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.67, 2002-06-20 15:23:45-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: clean up arch/i386/boot, part 1
  
  Use the Rules.make provided objcopy command and untangle piggy.o
  generation.

 ----------------------------------------------------------------------------
 Makefile                           |    2 +-
 arch/i386/boot/Makefile            |   26 +++++++++++++++++---------
 arch/i386/boot/compressed/Makefile |   23 ++++++++++++-----------
 3 files changed, 30 insertions(+), 21 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.68, 2002-06-20 15:39:35-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: clean up arch/i386/boot, part 2
  
  Use standard Rules.make rules for compiling and assembling.

 ----------------------------------------------------------------------------
 Makefile            |   39 +++++++++------------------------------
 compressed/Makefile |   11 ++---------
 2 files changed, 11 insertions(+), 39 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.69, 2002-06-20 15:47:59-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: clean up arch/i386/boot, part 3
  
  Unify zImage and bzImage generation.

 ----------------------------------------------------------------------------
 Makefile            |   32 ++++++++------------------------
 compressed/Makefile |   14 ++------------
 2 files changed, 10 insertions(+), 36 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.70, 2002-06-20 16:11:03-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: clean up arch/i386/boot, part 4
  
  Use the provided rule for linking files and final polish.
  Apart from being internally more logically structured, 
  "make KBUILD_VERBOSE= bzImage" output looks much improved now as
  well.

 ----------------------------------------------------------------------------
 Makefile               |   25 +++++++++++++++----------
 compressed/Makefile    |   25 ++++++++++---------------
 compressed/vmlinux.scr |    9 +++++++++
 3 files changed, 34 insertions(+), 25 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.490.1.71, 2002-06-20 16:29:43-05:00, sam@mars.ravnborg.org
  kbuild: Add "make help" support
  
  Added the new target "help" that list the most common targets
  Calls down to Documentation/Makefile to list documentation targets.
  Furthermore calls down to the architecture specific Makefile
  to list architecture specific targets.
  So far only i386 is supporting this.

 ----------------------------------------------------------------------------
 Documentation/DocBook/Makefile |    4 +++
 Makefile                       |   45 ++++++++++++++++++++++++++++++++++++++++-
 arch/i386/boot/Makefile        |   12 ++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

-----------------------------------------------------------------------------
ChangeSet@1.606, 2002-06-23 12:00:50-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Fix calling of make_times_h and gentbl
  
  make did normalize away the "./", so we better put the command
  explicitly.
  
  (Geert Uytterhoeven, Adam Richter and others)

 ----------------------------------------------------------------------------
 drivers/net/hamradio/soundmodem/Makefile |    2 +-
 net/khttpd/Makefile                      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.607, 2002-06-23 12:17:36-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Provide shipped versions of the keymap files
  
  The keyboard maps are generated from appropriate .map files by running
  loadkeys --mktable. However, there are two reasons to provide shipped
  versions and use those by default
  
  1) Not everybody has loadkeys installed.
  2) As pointed out by Andries Brouwer, if changes to the tables occur in
     the kernel tree, that may require a new/recompiled version of loadkeys,
     so that the version of loadkeys required for the kernel build is
     often ahead of the installed base.
  
  For these reasons, we provide shipped versions of the generated files and
  use them unless the user explicitly asks for regenerating by uncommenting
  the appropriate line in the Makefile.
   

 ----------------------------------------------------------------------------
 b/drivers/acorn/char/Makefile                  |   13 +
 b/drivers/acorn/char/defkeymap-acorn.c_shipped |  262 ++++++++++++++++++++++++
 b/drivers/char/Makefile                        |   16 +
 b/drivers/char/defkeymap.c_shipped             |  262 ++++++++++++++++++++++++
 b/drivers/char/qtronixmap.c_shipped            |  265 +++++++++++++++++++++++++
 b/drivers/tc/Makefile                          |   13 +
 b/drivers/tc/lk201-map.c_shipped               |  265 +++++++++++++++++++++++++
 drivers/acorn/char/defkeymap-acorn.c           |  262 ------------------------
 8 files changed, 1088 insertions(+), 270 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.608, 2002-06-23 12:30:04-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Distribute "make clean" knowledge
  
  Currently, the top-level Makefile needs to know about all generated
  files in the sub directories in order to clean them up.
  
  This patch adds the variable "clean-files" which can be used in the
  subdir Makefiles instead, to list files which should be removed by
  "make clean".

 ----------------------------------------------------------------------------
 Makefile                                 |   36 +++----------------------------
 Rules.make                               |   27 +++++++++++++++--------
 drivers/atm/Makefile                     |    5 +++-
 drivers/char/Makefile                    |    1 
 drivers/net/Makefile                     |    3 --
 drivers/net/hamradio/soundmodem/Makefile |    9 ++++++-
 drivers/net/sk98lin/Makefile             |    9 -------
 drivers/net/skfp/Makefile                |    6 -----
 drivers/net/wan/lmc/Makefile             |    4 ---
 drivers/pci/Makefile                     |    2 +
 drivers/scsi/Makefile                    |    5 ++--
 drivers/scsi/aic7xxx/Makefile            |   10 ++++++--
 drivers/scsi/sym53c8xx_2/Makefile        |    3 --
 drivers/video/Makefile                   |    2 +
 drivers/video/matrox/Makefile            |    3 --
 drivers/zorro/Makefile                   |    2 +
 fs/umsdos/Makefile                       |    3 --
 init/Makefile                            |   10 +++++---
 net/802/Makefile                         |    3 ++
 net/khttpd/Makefile                      |    4 ++-
 sound/oss/Makefile                       |    2 +
 21 files changed, 64 insertions(+), 85 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.609, 2002-06-23 12:40:50-05:00, kai@tp1.ruhr-uni-bochum.de
  Make net_dev_init() a subsys_initcall()
  
  This does make sure that net_dev_init() has been called before any
  driver calls register_netdev().
  
  Since net_dev_init() calls net_device_init() which in turn will initialize
  old style built-in network drivers, it is important that the other
  subsystems, PCI in particular are already initialized at this point.
  This is currently guaranteed by the link order.

 ----------------------------------------------------------------------------
 dev.c |   52 ++++++++++++++++++++++++----------------------------
 1 files changed, 24 insertions(+), 28 deletions(-)


