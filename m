Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUHMTaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUHMTaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUHMTaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:30:14 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:34613 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267319AbUHMTZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:25:42 -0400
Date: Fri, 13 Aug 2004 21:28:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: kbuild updates
Message-ID: <20040813192804.GA10486@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the accumulated list of kbuild patches.
Mostly trivial stuff but also a bit of interest:

o replaced host-progs with hostprogs-y
o Use a shell script to generate System.map
	Includes check for undefined symbols in vmlinux
	Filter out __crc_ from System.map
  -> This replaces two other patches in -mm
	- rmk's ldchk function
	- wli btfixup patch, number 13 in his serie
  This patch replaces both
o Randy's patch to put version in .config
o One patch to a few files so we use POSIX header in some of the
  tools. 
  This is a slow start on improving the build on non-linux platforms.

This does in no way clear my kbuild queue - but the rest
is put on hold for a while.

Everything pushed to:
bk://linux-sam.bkbits.net/kbuild

When the patches has been in -mm for a while they will be pushed
to Linus.
None of this is pre 2.6.8 material.

Patches will follow in seperate mails.

	Sam

 
 

Files touched:

 Documentation/DocBook/Makefile     |    4 
 Documentation/kbuild/makefiles.txt |   50 ++++++++----
 Makefile                           |   37 ++++++--
 arch/alpha/boot/Makefile           |    2 
 arch/i386/boot/Makefile            |    4 
 arch/ppc/boot/Makefile             |    4 
 arch/ppc64/boot/Makefile           |    4 
 arch/sparc/boot/Makefile           |   42 +++++++---
 arch/sparc64/boot/Makefile         |    2 
 arch/um/sys-i386/util/Makefile     |    4 
 arch/x86_64/boot/Makefile          |    2 
 drivers/atm/Makefile               |    2 
 drivers/md/Makefile                |    2 
 drivers/media/dvb/ttpci/Makefile   |    2 
 drivers/pci/Makefile               |    2 
 drivers/zorro/Makefile             |    2 
 lib/Makefile                       |    2 
 scripts/Makefile                   |   17 ++--
 scripts/Makefile.build             |   94 ++--------------------
 scripts/Makefile.clean             |   32 +++++--
 scripts/Makefile.host              |  154 +++++++++++++++++++++++++++++++++++++
 scripts/Makefile.lib               |   49 -----------
 scripts/basic/Makefile             |    4 
 scripts/basic/fixdep.c             |    2 
 scripts/genksyms/Makefile          |    4 
 scripts/kconfig/Makefile           |    2 
 scripts/kconfig/confdata.c         |   17 +++-
 scripts/lxdialog/Makefile          |    4 
 scripts/mksysmap                   |   61 ++++++++++++++
 scripts/mod/Makefile               |    4 
 scripts/mod/sumversion.c           |    2 
 scripts/package/Makefile           |    6 -
 sound/oss/Makefile                 |    2 
 usr/Makefile                       |    2 
 34 files changed, 406 insertions(+), 217 deletions(-)

through these ChangeSets:

<sam@mars.ravnborg.org> (04/08/13 1.1912)
   kbuild: __crc_* symbols in System.map
   
   David S. Miller <davem@redhat.com> wrote:
   Shouldn't we be grepping __crc_ symbols out of the System.map file?
   
   For one thing, these can confuse readprofile.  It's algorithm is
   to start at _stext, then stop when it sees a line in the System.map
   which is not text (mode is one of 'T' 't' 'W' or 'w')
   
   It will exit early if there are some intermixed __crc_* things in
   there (since they are are mode 'A').
   
   For example, in my current sparc64 kernel I have this:
   
   00000000004cef80 t do_split
   00000000004cf2a0 t add_dirent_to_buf
   00000000004cf5a7 A __crc_init_special_inode
   00000000004cf640 t make_indexed_dir
   00000000004cf900 t ext3_add_entry
   
   So no symbols after add_dirent_to_buf will be shown in the profiling
   output of readprofile.
   
   Implementation ported to mksysmap by Sam.
   Included two System.map related fixes:
   - Print "SYSMAP  System.map" during build
   - Sort symbols in System.map
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/10 1.1911)
   kbuild: Use POSIX headers for ntoh functions
   
   From: Benno <benjl@cse.unsw.edu.au>
   When compiling Linux on Mac OSX I had trouble with scripts/sumversion.c.
   It includes <netinet/in.h> to obtain to definitions of htonl and ntohl.
   
   On Mac OSX these are found in <arpa/inet.h>. After checking the POSIX
   specification it appears that this is the correct place to get
   the definitons for these functions.
   
   (http://www.opengroup.org/onlinepubs/009695399/functions/htonl.html)
   
   Using this header also appears to work on Linux (at least with
   Glibc-2.3.2).
   
   It seems clearer to me to go with the POSIX standard than implementing
   #if __APPLE__ style macros, but if such an approach is preferred I can
   supply patches for that instead.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/10 1.1910)
   kbuild: Fix hostprogs-y
   
   Allow the same target to be specified more than once without causing a warnign from make.
   The same target may be specified twice when using the following pattern:
   hostprogs-$(CONFIG_FOO) += program
   hostprogs-$(CONFIG_BAR) += program
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/10 1.1909)
   kbuild: Replace host-progs with hostprogs-y
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/10 1.1908)
   kbuild: Introduce hostprogs-y, deprecate host-progs
   
   Introducing hostprogs-y allows a user to use the typical Kbuild
   pattern in a Kbuild file:
   hostprogs-$(CONFIG_KALLSYMS) += ...
   
   And then during cleaning the referenced file are still deleted.
   Deprecate the old host-progs assignment but kept the functionlity.
   
   External modules will continue to use host-progs for a while - drawback is
   that they now see a warning.
   Workaround - just assign both variables:
   hostprogs-y := foo
   host-progs  := $(hostprogs-y)
   
   All in-kernel users will be converted in next patch.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/10 1.1907)
   kbuild: Separate out host-progs handling
   
   Concentrating all host-progs functionality in one file made a more
   readable Makefile.lib - and allow for potential reuse of host-progs
   functionality.
   Processing of host-progs related stuff are avoided when no host-progs are specified. 
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/09 1.1906)
   kbuild: Accept absolute paths in clean-files and introduce clean-dirs
   
   Teach kbuild to accept absolute paths in clean-files. This avoids using
   clean-rules in several places.
   Introduced clean-dirs to delete complete directories.
   Kept clean-rule - but do not print anything when used.
   Cleaned up a few places now the infrastructure are improved.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/08 1.1905)
   kbuild: Use LINUXINCLUDE to specify include/ directory
   
   Peter Chubb <peterc@gelato.unsw.edu.au> reported that building i386
   on a non-i386 platform failed, because gcc could not locate boot.h.
   Root cause was the extra include2 directory used when using O=
   to specify the output directory.
   Added LINUXINCLUDE as a portable way to specify the include/
   directory, and changed the two users.
   This avoids hardcoding 'include2' in non-kbuild core files.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/08 1.1904)
   kbuild: Selective compile of targets in scripts/
   
   Do not build executables unless needed.
   Same goes for scripts/mod/, descend only when CONFIG_MODULES are enabled.
   With inputs form: Russell King <rmk+lkml@arm.linux.org.uk> and  Brian Gerst <bgerst@quark.didntduck.org>
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<rddunlap@osdl.org> (04/08/08 1.1903)
   kconfig: save kernel version in .config file
   
   Save kernel version info and date when writing .config file.
   Tested with 'make {menuconfig|xconfig|gconfig}'.
   
   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/08 1.1902)
   kbuild/sparc: Use new generic mksysmap script to generate System.map
   
   o Introduced usage of the mksysmap script.
   o Improved the non-verbose output to look like this:
     BTFIX   arch/sparc/boot/btfix.S
     AS      arch/sparc/boot/btfix.o
     LD      arch/sparc/boot/image
     SYSMAP  arch/sparc/boot/System.map
   
   o No longer generate System.map for each build
   o Use normal AS rule to compile btfix.S
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

<sam@mars.ravnborg.org> (04/08/07 1.1901)
   kbuild: Check for undefined symbols in vmlinux
   
   At least one bin-utils version for ARM is know to ignore undefined
   symbols when performing the final link of vmlinux.
   Add an explicit check for undefined symbols to catch this.
   The check is made in combination with generating the System.map file
   and the actual algorithm is moved to a small shell script - mksysmap.
   
   External symbols with three leading underscores are ignored - sparc
   uses them for the BTFIXUP logic.
   
   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

