Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUGaH5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUGaH5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 03:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267874AbUGaH5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 03:57:54 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:54626 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265006AbUGaH5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 03:57:44 -0400
Date: Sat, 31 Jul 2004 09:58:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: kbuild: Various updates for 2.6.8
Message-ID: <20040731075838.GA7469@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

I have arranged with Andrew that he sucks my kbuild tree in -mm,
and this is the fist update I send direct to you.

The following set of patches has been in -mm for a few days now
with no complaints. Please include these before 2.6.8.

	bk pull bk://linux-sam.bkbits.net/kbuild

The most important fix is the $LANG fix. Without this users
from .cz, .fr etc. cannot use menuconfig/xconfig with good result.

The cset's:
o kbuild: Introduce source symlink in /lib/modules/.../
o kbuild: Create Makefile in output directory if != kernel tree
o drivers: move STANDALONE to drivers/base/Kconfig
o kbuild: Two simple kbuild patches
o kbuild: Fix up moving of modpost
o kbuild: Move modpost files to a new subdir scripts/mod
o kbuild: scripts/genksyms/parse.c_shipped needs to be rebuilt
o kbuild: Less intrusive LANG override, fixes menuconfig
o kbuild: Rebuild .spec file when kernel version changes
o kbuild: Allow `make O=<obj> {cscope,tags}` to work
o kbuild: build binary rpm from pre-built tree

Full descriptions below.
Regular diffs available at http://linux-sam.bkbits.net:8080/kbuild

	Sam
	
	

ChangeSet@1.1859, 2004-07-28 00:36:33+02:00, sam@mars.ravnborg.org
  kbuild: Introduce source symlink in /lib/modules/.../
                                                                                                       
  Traditionally when building a kernel the source and the
  output files are mixed.
                                                                                                       
  When building a kernel using the O= syntax to save output
  files in a separate directory a way is needed to locate
  the kernel source.
  The implemented solution is a new symlink 'source' being
  added to /lib/modules/.../
  used to locate source for an installed kernel.
  The original symlink build points to the directory
  containing the output files.
                                                                                                       
  Please note that when the kernel is build with source and
  output files mixed the two symlinks 'build' and 'source'
  will point to the same directory, thus no changes
  compared to before.
                                                                                                       
  Two options was considered:
                                                                                                        a) Adding a new symlink pointing to the output files "object"
          => All external modules have to specify O= to build
          => External modules grepping in .config or .h files
             in include/asm needs to be updated
          => External modules that do grep in source code and
             ordinary header files just works
                                                                                                       
  b) Let the build symlink point to the output files and introduce a new
     symlink "source" pointing to the kernel source
          => External module can be build without specifying O=
          => External modules grepping in .config or .h files
             in include/asm just works
          => External modules that do grep in source code and
             ordinary header files needs to be updated
                                                                                                       
  Based on the above option b) is considered the least painfull alternative.
                                                                                                       
  So to sum up:
  - If a distro does not use separate output dir => no change
  - If a distro uses separate output dir =>
          - Trivial external module just builds
          - Non-trivial (build-wise) external modules are probarly broken
                                                                                                       
  Without this patch
  - If a distro does not use separate output dir => no change
  - If a distro uses separate output dir =>
          - Trivial external modules had to specify O= to build,
            and the directory being pointed at was not obvious
          - grep in .config or include files in asm/ required
            knowledge where to locate output files
                                                                                                       
  Preferred syntax for building external modules are the following:
  
         make -C /lib/modules/`uname -r`/build M=`pwd`
  
  [Substituting 'M=...' with 'SUBDIRS=... modules' give same effect].
                                                                                                       
  When the kernel is built using separate output directory the above
  invocation of make will invoke the generated Makefile located in the output
  directory - that again will invoke the Makefile located in the kernel
  source tree root.
                                                                                                       
  Patch includes contributions from:
          Andreas Gruenbacher <agruen@suse.de>
                                                                                                       
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1858, 2004-07-27 23:54:53+02:00, sam@mars.ravnborg.org
  kbuild: Create Makefile in output directory if != kernel tree
  
  When building a kernel using the O= syntax to save output
  files in a separate output directory now create a small Makefile in
  that same dir.
  This Makefile allow one to use make in the output directory without
  the hassle of going back to the kernel source tree.
  The O= option is added by this Makefile stub.
  Please note that the Makefile silently overwrite an old one, so changes
  will be lost if modified.
  If there is a need to tweak a Makefile in the output directory it is recommended
  to use the filename 'makefile', which GNU Make will try first.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1857, 2004-07-27 23:44:01+02:00, sam@mars.ravnborg.org
  drivers: move STANDALONE to drivers/base/Kconfig
  
  Move STANDALONE from init/Kconfig to drivers/base/Kconfig .
  This way, it's besides PREVENT_FIRMWARE_BUILD.
                                                                                  
  Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1856, 2004-07-23 01:29:55+02:00, kkourt@cslab.ece.ntua.gr
  kbuild: Two simple kbuild patches
  
  foo1.patch:   spelling correction in Makefile
  foo2.patch:   replace SUBDIRS with M in Documentation/kbuild/modules.txt
  
  From: Kornilios Kourtis <kkourt@cslab.ece.ntua.gr>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1855, 2004-07-23 01:28:19+02:00, sam@mars.ravnborg.org
  kbuild: Fix up moving of modpost
  
  A few small issues to fix the moving of modpost.
  A few files was missing in the commit and one change needed.
  Also bk ignored the files in their new location.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1854, 2004-07-23 00:59:36+02:00, bgerst@didntduck.org
  kbuild: Move modpost files to a new subdir scripts/mod
  
  Move modpost and support files to scripts/mod.
  Directory named mod by Sam.
  
  From: Brian Gerst <bgerst@didntduck.org>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1853, 2004-07-23 00:39:37+02:00, schwab@suse.de
  kbuild: scripts/genksyms/parse.c_shipped needs to be rebuilt
  
  parse.c_shipped has never been regenerated after parse.y has been modified
  4 months ago.
  
  Signed-off-by: Andreas Schwab <schwab@suse.de>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1852, 2004-07-23 00:32:23+02:00, sam@mars.ravnborg.org
  kbuild: Less intrusive LANG override, fixes menuconfig
  
  The locale override caused problems for some people with locale setiings
  different from 'C'. make menuconfig was looking bad / unuseable.
  This patch limit the override of locales to the part where we actually descend the kernel
  doing the full build of the kernel.
  The speed improvement is the same.
  
  make menuconfig should now be useable for all locale settings again.
  Thanks to Marcel Sebek <sebek64@post.cz> for pointing out this problem and being
  paitent in testing.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1851, 2004-07-21 00:14:47+02:00, sam@mars.ravnborg.org
  kbuild: Rebuild .spec file when kernel version changes
  
  Make a dependency in scripts/package/Makefile to top-level Makefile forcing
  .spec file to be generated when kernel version changes.
  
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



ChangeSet@1.1850, 2004-07-21 00:03:20+02:00, gdavis@mvista.com
  kbuild: Allow `make O=<obj> {cscope,tags}` to work
  
  Allow `make O=<obj> {cscope,tags}` to work



ChangeSet@1.1849, 2004-07-20 23:57:07+02:00, edwardsg@sgi.com
  kbuild: build binary rpm from pre-built tree
  
  Many times it would be nice to quickly package up a kernel tree you're
  working on, without having to rebuild the whole thing again from a clean
  source tree (like the current rpm-pkg target does).  The patch below
  adds an "binrpm-pkg" target which uses your existing (already built)
  tree.
  Modified by me to always do a make and use binrpm-pkg.
  
  Signed-off-by: Greg Edwards <edwardsg@sgi.com>
  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>



