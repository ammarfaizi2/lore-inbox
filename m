Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTDROYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTDROYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:24:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:26826 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S263051AbTDROXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:23:24 -0400
Date: Fri, 18 Apr 2003 09:35:21 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] archs: vmlinux.lds.S unification
Message-ID: <Pine.LNX.4.44.0304180925320.9070-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm wondering if anybody (particularly arch maintainers) have comments or
objections for changes like the appended, which separate out common bits
from arch/$ARCH/vmlinux.lds.S and put them into
include/asm-generic/vmlinux.lds.h. These patches don't complete the job,
nor do they touch all archs (which is a feature, archs who want to do
their stuff independently can still do so), but you get the idea.

There are virtually no changes, except decrease of alignment in some cases 
(why did S390 use 128 byte in the first place, the only reason I can think 
of is that otherwise the label wouldn't match the real beginning of a 
session, which is now fixed, anyway). Does IA-64 still need to discard
.comment, .note? (is SoftDSV still buggy and in use?)

Also does anybody know a reason why we explicitly align the exception 
table to 16 bytes? Again, I see no reason, so I'd like to get rid of the 
magic alignments and document those which are really necessary, so please 
share your knowledge ;-)

--Kai


(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.1056, 2003-04-15 17:00:51-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce EXTABLE macro
  
  All vmlinux linker scripts duplicate the code to generate the __ex_table
  section, so introduce a macro for this section.
  
  It'd be still nicer to actually just merge this into the RODATA macro, since
  __ex_table is just another section in the read-only segment, but this would
  incur moving sections around for some archs, so it needs more careful
  checking.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |    6 +-----
 arch/cris/vmlinux.lds.S           |    6 +-----
 arch/i386/vmlinux.lds.S           |    6 +-----
 arch/ia64/vmlinux.lds.S           |    9 +--------
 arch/mips/vmlinux.lds.S           |    5 +----
 arch/mips64/vmlinux.lds.S         |    5 +----
 arch/parisc/vmlinux.lds.S         |    6 +-----
 arch/ppc/vmlinux.lds.S            |    4 +---
 arch/ppc64/vmlinux.lds.S          |    4 +---
 arch/s390/vmlinux.lds.S           |    6 +-----
 arch/sh/vmlinux.lds.S             |    6 +-----
 arch/sparc/vmlinux.lds.S          |    5 ++---
 arch/sparc64/vmlinux.lds.S        |    7 ++-----
 arch/v850/vmlinux.lds.S           |    5 +----
 arch/x86_64/vmlinux.lds.S         |    6 +-----
 include/asm-generic/vmlinux.lds.h |    8 ++++++++
 16 files changed, 25 insertions(+), 69 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1057, 2003-04-15 17:23:05-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITCALLS
  
  Replace the duplicated statements for the initcall sections by the
  macro INITCALLS now defined in include/asm-generic/vmlinux.lds.h

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |   20 +-------------------
 arch/cris/vmlinux.lds.S           |   27 ++++++---------------------
 arch/i386/vmlinux.lds.S           |   17 +++--------------
 arch/ia64/vmlinux.lds.S           |   19 +++----------------
 arch/mips/vmlinux.lds.S           |   17 +++--------------
 arch/mips64/vmlinux.lds.S         |   17 +++--------------
 arch/parisc/vmlinux.lds.S         |   17 +++--------------
 arch/ppc/vmlinux.lds.S            |   15 +--------------
 arch/ppc64/vmlinux.lds.S          |   17 +++--------------
 arch/s390/vmlinux.lds.S           |   17 +++--------------
 arch/sh/vmlinux.lds.S             |   17 +++--------------
 arch/sparc/vmlinux.lds.S          |   17 +++--------------
 arch/sparc64/vmlinux.lds.S        |   17 +++--------------
 arch/x86_64/vmlinux.lds.S         |   17 +++--------------
 include/asm-generic/vmlinux.lds.h |   18 ++++++++++++++++++
 15 files changed, 59 insertions(+), 210 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1058, 2003-04-15 17:41:59-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Move __param, .init.setup into INITCALLS macro
  
  Basically all archs have code in the linker script for the __param and
  .init.setup sections for parsing new/old-style command line parameters,
  which can be unified by putting them into the INITCALLS macro.
  
  Few archs didn't have those sections in their linker script at all,
  suggesting they rely on the linker to generate the labels for them or being
  currently broken. Doing things explicitly now should definitely not worsen
  the state, though.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |   10 ----------
 arch/cris/vmlinux.lds.S           |    4 ----
 arch/i386/vmlinux.lds.S           |    8 --------
 arch/ia64/vmlinux.lds.S           |   14 --------------
 arch/mips/vmlinux.lds.S           |    4 ----
 arch/mips64/vmlinux.lds.S         |    4 ----
 arch/parisc/vmlinux.lds.S         |    7 -------
 arch/ppc/vmlinux.lds.S            |    7 -------
 arch/ppc64/vmlinux.lds.S          |    7 -------
 arch/s390/vmlinux.lds.S           |    7 -------
 arch/sh/vmlinux.lds.S             |    4 ----
 arch/sparc/vmlinux.lds.S          |    7 -------
 arch/sparc64/vmlinux.lds.S        |    7 -------
 arch/x86_64/vmlinux.lds.S         |    7 -------
 include/asm-generic/vmlinux.lds.h |   14 ++++++++++++++
 15 files changed, 14 insertions(+), 97 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1059, 2003-04-15 17:58:53-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITRAMFS macro
  
  Replace the individual initramfs statements by a new INITRAMFS macro.
  
  Note: We used to page-align the initramfs section, which however seemed
  to be for no good reason, so I removed this alignment. This sections
  contains a CPIO archive and is read byte by byte, so there should be
  no alignment whatsoever needed.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |    6 ----
 arch/i386/vmlinux.lds.S           |    5 ----
 arch/ia64/vmlinux.lds.S           |    8 ------
 arch/parisc/vmlinux.lds.S         |    5 ----
 arch/ppc/vmlinux.lds.S            |    5 ----
 arch/ppc64/vmlinux.lds.S          |    5 ----
 arch/s390/vmlinux.lds.S           |    5 ----
 arch/sparc/vmlinux.lds.S          |    5 ----
 arch/sparc64/vmlinux.lds.S        |    5 ----
 arch/x86_64/vmlinux.lds.S         |    5 ----
 include/asm-generic/vmlinux.lds.h |    8 ++++++
 include/asm-um/common.lds.S       |   46 ++++----------------------------------
 12 files changed, 24 insertions(+), 84 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1060, 2003-04-15 18:17:01-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITTEXT, INITDATA
  
  Introduce macros for .init.text and .init.data

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |    9 ++-------
 arch/i386/vmlinux.lds.S           |    9 +++------
 arch/ia64/vmlinux.lds.S           |   11 ++---------
 arch/parisc/vmlinux.lds.S         |    8 ++------
 arch/ppc/vmlinux.lds.S            |    8 +++-----
 arch/ppc64/vmlinux.lds.S          |    8 ++------
 arch/s390/vmlinux.lds.S           |    8 ++------
 arch/sparc/vmlinux.lds.S          |   10 +++-------
 arch/sparc64/vmlinux.lds.S        |    8 ++------
 arch/x86_64/vmlinux.lds.S         |    8 ++------
 include/asm-generic/vmlinux.lds.h |   17 ++++++++++++++---
 11 files changed, 37 insertions(+), 67 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1061, 2003-04-15 18:31:11-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITPERCPU
  
  Nearly all archs share the generic per_cpu implementation, so they
  can share the necessary linker magic as well.
  
  This one again has a magic alignment which I just kept, though I suspect
  it could just as well be dropped.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |    6 +-----
 arch/i386/vmlinux.lds.S           |    5 +----
 arch/parisc/vmlinux.lds.S         |    5 +----
 arch/ppc/vmlinux.lds.S            |    6 +-----
 arch/ppc64/vmlinux.lds.S          |    5 +----
 arch/s390/vmlinux.lds.S           |    5 +----
 arch/sparc/vmlinux.lds.S          |    5 +----
 arch/sparc64/vmlinux.lds.S        |    5 +----
 arch/x86_64/vmlinux.lds.S         |    5 +----
 include/asm-generic/vmlinux.lds.h |    8 ++++++++
 10 files changed, 17 insertions(+), 38 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1062, 2003-04-15 18:58:16-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INIT_BEGIN, INIT_END
  
  and counter parts __INIT_BEGIN, __INIT_END which allow for arbitrary
  alignment, whereas the former just uses PAGE_SIZE for alignment.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |    8 ++------
 arch/cris/vmlinux.lds.S           |   13 ++++++-------
 arch/i386/vmlinux.lds.S           |   11 ++++-------
 arch/ia64/vmlinux.lds.S           |    8 ++------
 arch/mips/vmlinux.lds.S           |   15 ++++++---------
 arch/mips64/vmlinux.lds.S         |   15 ++++++---------
 arch/parisc/vmlinux.lds.S         |    8 ++------
 arch/ppc/vmlinux.lds.S            |   12 ++++--------
 arch/ppc64/vmlinux.lds.S          |   11 ++++-------
 arch/s390/vmlinux.lds.S           |   11 ++++-------
 arch/sh/vmlinux.lds.S             |   15 ++++++++-------
 arch/sparc/vmlinux.lds.S          |    9 ++++-----
 arch/sparc64/vmlinux.lds.S        |    9 ++++-----
 arch/x86_64/vmlinux.lds.S         |   10 ++++------
 include/asm-generic/vmlinux.lds.h |   11 +++++++++++
 15 files changed, 71 insertions(+), 95 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1063, 2003-04-15 19:14:08-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INIT macro
  
  archs which just use the standard .init sections can just use the
  INIT macro instead of listing the contents separately.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |   11 +++--------
 arch/cris/vmlinux.lds.S           |   10 +---------
 arch/i386/vmlinux.lds.S           |    9 +--------
 arch/mips/vmlinux.lds.S           |    6 +-----
 arch/mips64/vmlinux.lds.S         |    6 +-----
 arch/parisc/vmlinux.lds.S         |    8 +-------
 arch/ppc/vmlinux.lds.S            |    2 +-
 arch/ppc64/vmlinux.lds.S          |    9 +--------
 arch/s390/vmlinux.lds.S           |    9 +--------
 arch/sparc64/vmlinux.lds.S        |   10 ++--------
 arch/x86_64/vmlinux.lds.S         |    8 +-------
 include/asm-generic/vmlinux.lds.h |   10 ++++++++++
 12 files changed, 24 insertions(+), 74 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1064, 2003-04-16 13:16:34-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce BSS, DEBUG
  
  Introduce the macros BSS, DEBUG, containing the shared descriptions for
  .bss and the debugging sections.

 ----------------------------------------------------------------------------
 arch/alpha/vmlinux.lds.S          |   39 +-----------------------------
 arch/cris/vmlinux.lds.S           |    7 +----
 arch/i386/vmlinux.lds.S           |   14 +----------
 arch/ia64/vmlinux.lds.S           |   46 +++---------------------------------
 arch/mips/vmlinux.lds.S           |   35 +++------------------------
 arch/mips64/vmlinux.lds.S         |   24 +------------------
 arch/parisc/vmlinux.lds.S         |    4 ---
 arch/ppc/vmlinux.lds.S            |   10 -------
 arch/ppc64/vmlinux.lds.S          |    4 ---
 arch/s390/vmlinux.lds.S           |   14 +----------
 arch/sh/vmlinux.lds.S             |   41 ++------------------------------
 arch/sparc/vmlinux.lds.S          |   27 +++------------------
 arch/sparc64/vmlinux.lds.S        |   26 ++------------------
 arch/x86_64/vmlinux.lds.S         |   23 +-----------------
 include/asm-generic/vmlinux.lds.h |   48 ++++++++++++++++++++++++++++++++++++++
 15 files changed, 84 insertions(+), 278 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.1056, 2003-04-15 17:00:51-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce EXTABLE macro
  
  All vmlinux linker scripts duplicate the code to generate the __ex_table
  section, so introduce a macro for this section.
  
  It'd be still nicer to actually just merge this into the RODATA macro, since
  __ex_table is just another section in the read-only segment, but this would
  incur moving sections around for some archs, so it needs more careful
  checking.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -22,11 +22,7 @@
   } :kernel
   _etext = .;					/* End of text section */
 
-  . = ALIGN(16);
-  __start___ex_table = .;			/* Exception table */
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
   RODATA
 
   /* Will be freed after init */
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -32,11 +32,7 @@
 	_etext = . ;                  /* End of text section */ 
 	__etext = .;
 
-	. = ALIGN(4);                /* Exception table */
-  	__start___ex_table = .;
-  	__ex_table : { *(__ex_table) }
-  	__stop___ex_table = .;
-
+	EXTABLE
 	RODATA
 
 	. = ALIGN (4);
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -21,11 +21,7 @@
 
   _etext = .;			/* End of text section */
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
   RODATA
 
   /* writeable */
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -45,14 +45,7 @@
 
   /* Read-only data */
 
-  /* Exception table */
-  . = ALIGN(16);
-  __ex_table : AT(ADDR(__ex_table) - PAGE_OFFSET)
-	{
-	  __start___ex_table = .;
-	  *(__ex_table)
-	  __stop___ex_table = .;
-	}
+  EXTABLE
 
   __mckinley_e9_bundles : AT(ADDR(__mckinley_e9_bundles) - PAGE_OFFSET)
 	{
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -15,10 +15,7 @@
     *(.gnu.warning)
   } =0
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   __start___dbe_table = .;	/* Exception table for data bus errors */
   __dbe_table : { *(__dbe_table) }
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -13,10 +13,7 @@
     *(.gnu.warning)
   } =0
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   __start___dbe_table = .;	/* Exception table for data bus errors */
   __dbe_table : { *(__dbe_table) }
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -32,11 +32,7 @@
 
   _etext = .;			/* End of text section */
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
   RODATA
 
   .data BLOCK(8192) : {			/* Data without special */
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -50,9 +50,7 @@
 
   .fixup   : { *(.fixup) }
 
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   /* Read-write section, merged into data segment: */
   . = ALIGN(4096);
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -61,9 +61,7 @@
   _edata  =  .;
   PROVIDE (edata = .);
 
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   . = ALIGN(16384);		/* init_task */
   .data.init_task : { *(.data.init_task) }
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -29,11 +29,7 @@
 
   _etext = .;			/* End of text section */
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
   RODATA
 
 #ifdef CONFIG_SHARED_KERNEL
diff -Nru a/arch/sh/vmlinux.lds.S b/arch/sh/vmlinux.lds.S
--- a/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -28,11 +28,7 @@
 	*(.gnu.warning)
 	} = 0x0009
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
   RODATA
 
   _etext = .;			/* End of text section */
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -28,9 +28,8 @@
   __start___fixup = .;
   .fixup   : { *(.fixup) }
   __stop___fixup = .;
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+
+  EXTABLE
 
   . = ALIGN(4096);
   __init_begin = .;
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -34,11 +34,8 @@
   PROVIDE (edata = .);
   .fixup   : { *(.fixup) }
 
-  . = ALIGN(16);
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
+	
   . = ALIGN(8192);
   __init_begin = .;
   .init.text : { 
diff -Nru a/arch/v850/vmlinux.lds.S b/arch/v850/vmlinux.lds.S
--- a/arch/v850/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/v850/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -46,10 +46,7 @@
 		. = ALIGN (4) ;						      \
 		    	*(.call_table_data)				      \
 			*(.call_table_text)				      \
-		. = ALIGN (16) ;	/* Exception table.  */		      \
-		___start___ex_table = . ;				      \
-			*(__ex_table)					      \
-		___stop___ex_table = . ;				      \
+		EXTABLE							      \
 		. = ALIGN (4) ;						      \
 		__etext = . ;
 
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:15 2003
@@ -21,11 +21,7 @@
 
   _etext = .;			/* End of text section */
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
+  EXTABLE
   RODATA
 
   .data : {			/* Data */
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:15 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:15 2003
@@ -45,3 +45,11 @@
 		*(__ksymtab_strings)					\
 	}
 
+#define EXTABLE								\
+	. = ALIGN(16);							\
+	/* Exception table */						\
+	__ex_table        : AT(ADDR(__ex_table) - LOAD_OFFSET) {	\
+		__start___ex_table = .;					\
+		*(__ex_table)						\
+		__stop___ex_table = .;					\
+	}

-----------------------------------------------------------------------------
ChangeSet@1.1057, 2003-04-15 17:23:05-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITCALLS
  
  Replace the duplicated statements for the initcall sections by the
  macro INITCALLS now defined in include/asm-generic/vmlinux.lds.h

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -45,30 +45,12 @@
   __param : { *(__param) }
   __stop___param = .;
 
-  . = ALIGN(8);
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
+  INITCALLS
 
   . = ALIGN(8192);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
-
-  . = ALIGN(8);
-  .con_initcall.init : {
-	__con_initcall_start = .;
-	*(.con_initcall.init)
-	__con_initcall_end = .;
-  }
 
   . = ALIGN(64);
   __per_cpu_start = .;
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -55,28 +55,13 @@
   	__setup_start = .;
   	.setup.init : { *(.setup.init) }
   	__setup_end = .;
-  	.initcall.init : {
-		__initcall_start = .;
-		*(.initcall1.init);
-		*(.initcall2.init);
-		*(.initcall3.init);
-		*(.initcall4.init);
-		*(.initcall5.init);
-		*(.initcall6.init);
-		*(.initcall7.init);
-		__initcall_end = .;
-	}
-	.con_initcall.init : {
-		__con_initcall_start = .;
-		*(.con_initcall.init)
-		__con_initcall_end = .;
 	
-		/* We fill to the next page, so we can discard all init
-		   pages without needing to consider what payload might be
-		   appended to the kernel image.  */
-		FILL (0);
-		. = ALIGN (8192);
-	}
+	INITCALLS
+
+	/* We fill to the next page, so we can discard all init
+	   pages without needing to consider what payload might be
+	   appended to the kernel image.  */
+	. = ALIGN (8192);
 	__vmlinux_end = .;            /* last address of the physical file */
   	__init_end = .;
 
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -63,20 +63,9 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -118,22 +118,9 @@
 	  *(__param)
 	  __stop___param = .;
 	}
-  .initcall.init : AT(ADDR(.initcall.init) - PAGE_OFFSET)
-	{
-	  __initcall_start = .;
-	  *(.initcall1.init)
-	  *(.initcall2.init)
-	  *(.initcall3.init)
-	  *(.initcall4.init)
-	  *(.initcall5.init)
-	  *(.initcall6.init)
-	  *(.initcall7.init)
-	  __initcall_end = .;
-	}
-   __con_initcall_start = .;
-  .con_initcall.init : AT(ADDR(.con_initcall.init) - PAGE_OFFSET)
-	{ *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -37,20 +37,9 @@
   __setup_start = .;
   .setup.init : { *(.setup.init) }
   __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -36,20 +36,9 @@
   __setup_start = .;
   .setup.init : { *(.setup.init) }
   __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -62,20 +62,9 @@
   __start___param =.; 
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -97,21 +97,8 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
 
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+  INITCALLS
 
   __start___ftr_fixup = .;
   __ftr_fixup : { *(__ftr_fixup) }
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -88,20 +88,9 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+	
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -76,20 +76,9 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(256);
   __initramfs_start = .;
   .init.ramfs : { *(.init.initramfs) }
diff -Nru a/arch/sh/vmlinux.lds.S b/arch/sh/vmlinux.lds.S
--- a/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -53,20 +53,9 @@
   __setup_start = .;
   .setup.init : { *(.setup.init) }
   __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   __machvec_start = .;
   .machvec.init : { *(.machvec.init) }
   __machvec_end = .;
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -47,20 +47,9 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -51,20 +51,9 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(8192); 
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:18 2003
@@ -87,20 +87,9 @@
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
+
+  INITCALLS
+
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:18 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:18 2003
@@ -53,3 +53,21 @@
 		*(__ex_table)						\
 		__stop___ex_table = .;					\
 	}
+
+#define INITCALLS							\
+  	.initcall.init     : AT(ADDR(.initcall.init) - LOAD_OFFSET) {	\
+		__initcall_start = .;					\
+		*(.initcall1.init) 					\
+		*(.initcall2.init) 					\
+		*(.initcall3.init) 					\
+		*(.initcall4.init) 					\
+		*(.initcall5.init) 					\
+		*(.initcall6.init) 					\
+		*(.initcall7.init)					\
+		__initcall_end = .;					\
+	}								\
+	.con_initcall.init : AT(ADDR(.con_initcall.init)-LOAD_OFFSET) {	\
+		__con_initcall_start = .;				\
+		*(.con_initcall.init)					\
+		__con_initcall_end = .;					\
+	}

-----------------------------------------------------------------------------
ChangeSet@1.1058, 2003-04-15 17:41:59-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Move __param, .init.setup into INITCALLS macro
  
  Basically all archs have code in the linker script for the __param and
  .init.setup sections for parsing new/old-style command line parameters,
  which can be unified by putting them into the INITCALLS macro.
  
  Few archs didn't have those sections in their linker script at all,
  suggesting they rely on the linker to generate the labels for them or being
  currently broken. Doing things explicitly now should definitely not worsen
  the state, though.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -35,16 +35,6 @@
   }
   .init.data : { *(.init.data) }
 
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-
-  . = ALIGN(8);
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
-
   INITCALLS
 
   . = ALIGN(8192);
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -51,10 +51,6 @@
   	__init_begin = .;
   	.text.init : { *(.text.init) }
   	.data.init : { *(.data.init) }
-  	. = ALIGN(16);
-  	__setup_start = .;
-  	.setup.init : { *(.setup.init) }
-  	__setup_end = .;
 	
 	INITCALLS
 
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -56,14 +56,6 @@
 	_einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
-
   INITCALLS
 
   . = ALIGN(4096);
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -105,20 +105,6 @@
 	  __initramfs_end = .;
 	}
 
-   . = ALIGN(16);
-  .init.setup : AT(ADDR(.init.setup) - PAGE_OFFSET)
-        {
-	  __setup_start = .;
-	  *(.init.setup)
-	  __setup_end = .;
-	}
-  __param : AT(ADDR(__param) - PAGE_OFFSET)
-        {
-	  __start___param = .;
-	  *(__param)
-	  __stop___param = .;
-	}
-
   INITCALLS
 
   . = ALIGN(PAGE_SIZE);
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -33,10 +33,6 @@
   __init_begin = .;
   .text.init : { *(.text.init) }
   .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
 
   INITCALLS
 
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -32,10 +32,6 @@
   __init_begin = .;
   .text.init : { *(.text.init) }
   .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
 
   INITCALLS
 
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -55,13 +55,6 @@
 	_einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param =.; 
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -90,13 +90,6 @@
     *(.ptov_fixup);
     __ptov_table_end = .;
   }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -81,13 +81,6 @@
 	_einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 	
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -69,13 +69,6 @@
 	_einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 
diff -Nru a/arch/sh/vmlinux.lds.S b/arch/sh/vmlinux.lds.S
--- a/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -49,10 +49,6 @@
   __init_begin = .;
   .text.init : { *(.text.init) }
   .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
 
   INITCALLS
 
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -40,13 +40,6 @@
   }
   __init_text_end = .;
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -44,13 +44,6 @@
 	_einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:20 2003
@@ -80,13 +80,6 @@
 	_einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
 
   INITCALLS
 
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:20 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:20 2003
@@ -55,6 +55,19 @@
 	}
 
 #define INITCALLS							\
+	. = ALIGN(16);							\
+	.init.setup       : AT(ADDR(.init.setup) - LOAD_OFFSET) {	\
+		__setup_start = .;					\
+		*(.init.setup)						\
+		__setup_end = .;					\
+	}								\
+									\
+	__param           : AT(ADDR(__param) - LOAD_OFFSET) {		\
+		__start___param = .;					\
+		*(__param)						\
+		__stop___param = .;					\
+	}								\
+									\
   	.initcall.init     : AT(ADDR(.initcall.init) - LOAD_OFFSET) {	\
 		__initcall_start = .;					\
 		*(.initcall1.init) 					\
@@ -66,6 +79,7 @@
 		*(.initcall7.init)					\
 		__initcall_end = .;					\
 	}								\
+									\
 	.con_initcall.init : AT(ADDR(.con_initcall.init)-LOAD_OFFSET) {	\
 		__con_initcall_start = .;				\
 		*(.con_initcall.init)					\

-----------------------------------------------------------------------------
ChangeSet@1.1059, 2003-04-15 17:58:53-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITRAMFS macro
  
  Replace the individual initramfs statements by a new INITRAMFS macro.
  
  Note: We used to page-align the initramfs section, which however seemed
  to be for no good reason, so I removed this alignment. This sections
  contains a CPIO archive and is read byte by byte, so there should be
  no alignment whatsoever needed.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -36,11 +36,7 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
-
-  . = ALIGN(8192);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+  INITRAMFS
 
   . = ALIGN(64);
   __per_cpu_start = .;
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -57,11 +57,8 @@
   }
   .init.data : { *(.init.data) }
   INITCALLS
+  INITRAMFS
 
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -98,13 +98,7 @@
   .init.data : AT(ADDR(.init.data) - PAGE_OFFSET)
 	{ *(.init.data) }
 
-  .init.ramfs : AT(ADDR(.init.ramfs) - PAGE_OFFSET)
-	{
-	  __initramfs_start = .;
-	  *(.init.ramfs)
-	  __initramfs_end = .;
-	}
-
+  INITRAMFS
   INITCALLS
 
   . = ALIGN(PAGE_SIZE);
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -57,11 +57,8 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
+  INITRAMFS
 
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -102,10 +102,7 @@
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
 
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+  INITRAMFS
 
   . = ALIGN(4096);
   __init_end = .;
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -83,11 +83,8 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
+  INITRAMFS
 	
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -71,11 +71,8 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
+  INITRAMFS
 
-  . = ALIGN(256);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.initramfs) }
-  __initramfs_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -42,11 +42,8 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
+  INITRAMFS
 
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -46,11 +46,8 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
+  INITRAMFS
 
-  . = ALIGN(8192); 
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:22 2003
@@ -82,11 +82,8 @@
   .init.data : { *(.init.data) }
 
   INITCALLS
+  INITRAMFS
 
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;	
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:22 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:22 2003
@@ -85,3 +85,11 @@
 		*(.con_initcall.init)					\
 		__con_initcall_end = .;					\
 	}
+
+#define INITRAMFS							\
+	.init.ramfs        : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {	\
+		__initramfs_start = .;					\
+		*(.init.ramfs)						\
+		__initramfs_end = .;					\
+	}
+
diff -Nru a/include/asm-um/common.lds.S b/include/asm-um/common.lds.S
--- a/include/asm-um/common.lds.S	Fri Apr 18 09:23:22 2003
+++ b/include/asm-um/common.lds.S	Fri Apr 18 09:23:22 2003
@@ -6,25 +6,10 @@
   _sdata = .;
   PROVIDE (sdata = .);
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  EXTABLE
 
   RODATA
 
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
-  __gpl_ksymtab : { *(__gpl_ksymtab) }
-  __stop___gpl_ksymtab = .;
-
-  __start___kallsyms = .;       /* All kernel symbols */
-  __kallsyms : { *(__kallsyms) }
-  __stop___kallsyms = .;
-
   .unprotected : { *(.unprotected) }
   . = ALIGN(4096);
   PROVIDE (_unprotected_end = .);
@@ -41,31 +26,13 @@
   __uml_postsetup_start = .;
   .uml.postsetup.init : { *(.uml.postsetup.init) }
   __uml_postsetup_end = .;
-	
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
+
+  INITCALLS	
 
   . = ALIGN(32);
   __per_cpu_start = . ; 
   .data.percpu : { *(.data.percpu) }
   __per_cpu_end = . ;
-	
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
 
   __uml_initcall_start = .;
   .uml.initcall.init : { *(.uml.initcall.init) }
@@ -80,7 +47,6 @@
   .uml.exitcall : { *(.uml.exitcall.exit) }
   __uml_exitcall_end = .;
 
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+
+  INITRAMFS
+

-----------------------------------------------------------------------------
ChangeSet@1.1060, 2003-04-15 18:17:01-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITTEXT, INITDATA
  
  Introduce macros for .init.text and .init.data

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -27,14 +27,9 @@
 
   /* Will be freed after init */
   . = ALIGN(8192);				/* Init code and data */
-  __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -50,12 +50,9 @@
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
+
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -88,16 +88,9 @@
 
   . = ALIGN(PAGE_SIZE);
   __init_begin = .;
-  .init.text : AT(ADDR(.init.text) - PAGE_OFFSET)
-	{
-	  _sinittext = .;
-	  *(.init.text)
-	  _einittext = .;
-	}
-
-  .init.data : AT(ADDR(.init.data) - PAGE_OFFSET)
-	{ *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITRAMFS
   INITCALLS
 
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -49,13 +49,9 @@
 
   . = ALIGN(16384);
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -76,11 +76,9 @@
 
   . = ALIGN(4096);
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
+
+  INITTEXT
+
   .init.data : { 
     *(.init.data);
     __vtop_table_begin = .;
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -75,13 +75,9 @@
   /* will be freed after init */
   . = ALIGN(4096);
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 	
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -63,13 +63,9 @@
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -33,14 +33,10 @@
 
   . = ALIGN(4096);
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  __init_text_end = .;
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  __init_text_end = .;
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -38,13 +38,9 @@
 	
   . = ALIGN(8192);
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:25 2003
@@ -74,13 +74,9 @@
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
 
+  INITTEXT
+  INITDATA
   INITCALLS
   INITRAMFS
 
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:25 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:25 2003
@@ -54,15 +54,27 @@
 		__stop___ex_table = .;					\
 	}
 
+#define INITTEXT							\
+	.init.text	   : AT(ADDR(.init.text) - LOAD_OFFSET) { 	\
+		_sinittext = .;						\
+		*(.init.text)						\
+		_einittext = .;						\
+	}
+
+#define INITDATA							\
+	.init.data         : AT(ADDR(.init.data) - LOAD_OFFSET) {	\
+    		*(.init.data) 						\
+	}
+
 #define INITCALLS							\
 	. = ALIGN(16);							\
-	.init.setup       : AT(ADDR(.init.setup) - LOAD_OFFSET) {	\
+	.init.setup        : AT(ADDR(.init.setup) - LOAD_OFFSET) {	\
 		__setup_start = .;					\
 		*(.init.setup)						\
 		__setup_end = .;					\
 	}								\
 									\
-	__param           : AT(ADDR(__param) - LOAD_OFFSET) {		\
+	__param            : AT(ADDR(__param) - LOAD_OFFSET) {		\
 		__start___param = .;					\
 		*(__param)						\
 		__stop___param = .;					\
@@ -92,4 +104,3 @@
 		*(.init.ramfs)						\
 		__initramfs_end = .;					\
 	}
-

-----------------------------------------------------------------------------
ChangeSet@1.1061, 2003-04-15 18:31:11-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INITPERCPU
  
  Nearly all archs share the generic per_cpu implementation, so they
  can share the necessary linker magic as well.
  
  This one again has a magic alignment which I just kept, though I suspect
  it could just as well be dropped.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -32,11 +32,7 @@
   INITDATA
   INITCALLS
   INITRAMFS
-
-  . = ALIGN(64);
-  __per_cpu_start = .;
-  .data.percpu : { *(.data.percpu) }
-  __per_cpu_end = .;
+  INITPERCPU
 
   . = ALIGN(2*8192);
   __init_end = .;
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -55,11 +55,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -54,11 +54,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -95,11 +95,7 @@
   __ftr_fixup : { *(__ftr_fixup) }
   __stop___ftr_fixup = .;
 
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-
+  INITPERCPU
   INITRAMFS
 
   . = ALIGN(4096);
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -80,11 +80,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 	
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -68,11 +68,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 
-  . = ALIGN(256);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -39,11 +39,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
   . = ALIGN(32);
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -43,11 +43,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(8192);
   __init_end = .;
   __bss_start = .;
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:27 2003
@@ -79,11 +79,8 @@
   INITDATA
   INITCALLS
   INITRAMFS
+  INITPERCPU
 
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:27 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:27 2003
@@ -104,3 +104,11 @@
 		*(.init.ramfs)						\
 		__initramfs_end = .;					\
 	}
+
+#define INITPERCPU							\
+	. = ALIGN(32);							\
+	  .data.percpu     : AT(ADDR(.data.percpu) - LOAD_OFFSET) {	\
+		__per_cpu_start = .;					\
+		*(.data.percpu)						\
+		__per_cpu_end = .;					\
+	}

-----------------------------------------------------------------------------
ChangeSet@1.1062, 2003-04-15 18:58:16-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INIT_BEGIN, INIT_END
  
  and counter parts __INIT_BEGIN, __INIT_END which allow for arbitrary
  alignment, whereas the former just uses PAGE_SIZE for alignment.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -26,17 +26,13 @@
   RODATA
 
   /* Will be freed after init */
-  . = ALIGN(8192);				/* Init code and data */
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
-
-  . = ALIGN(2*8192);
-  __init_end = .;
-  /* Freed after init ends here */
+  __INIT_END(2*8192)	
 
   /* Note 2 page alignment above.  */
   .data.init_thread : { *(.data.init_thread) }
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -8,6 +8,8 @@
  * the kernel has booted. 
  */	
 
+#define PAGE_SIZE 8192
+	
 #include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
 
@@ -47,19 +49,16 @@
 	. = ALIGN(8192);              /* init_task and stack, must be aligned */
   	.data.init_task : { *(.data.init_task) }
 
-  	. = ALIGN(8192);              /* Init code and data */
-  	__init_begin = .;
-  	.text.init : { *(.text.init) }
-  	.data.init : { *(.data.init) }
-	
+  	INIT_BEGIN
+	INITTEXT
+	INITDATA
 	INITCALLS
 
 	/* We fill to the next page, so we can discard all init
 	   pages without needing to consider what payload might be
 	   appended to the kernel image.  */
-	. = ALIGN (8192);
+	INIT_END
 	__vmlinux_end = .;            /* last address of the physical file */
-  	__init_end = .;
 
 	__data_end = . ;              /* Move to _edata ? */
 	__bss_start = .;              /* BSS */
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -2,6 +2,8 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 	
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
@@ -48,18 +50,13 @@
   .data.init_task : { *(.data.init_task) }
 
   /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
-
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
+  INIT_END
 	
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -86,16 +86,12 @@
 
   /* Initialization code and data: */
 
-  . = ALIGN(PAGE_SIZE);
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITRAMFS
   INITCALLS
-
-  . = ALIGN(PAGE_SIZE);
-  __init_end = .;
+  INIT_END
 
   /* The initial task and kernel stack */
   .data.init_task : AT(ADDR(.data.init_task) - PAGE_OFFSET)
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -1,3 +1,5 @@
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_ARCH(mips)
@@ -28,16 +30,11 @@
   . = ALIGN(8192);
   .data.init_task : { *(.data.init_task) }
 
-  /* Startup code */
-  . = ALIGN(4096);
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-
+  INIT_BEGIN
+  INITTEXT
+  INITDATA
   INITCALLS
-
-  . = ALIGN(4096);	/* Align double page for init_task_union */
-  __init_end = .;
+  INIT_END
 
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -1,3 +1,5 @@
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_ARCH(mips)
@@ -27,16 +29,11 @@
   . = . + MAPPED_OFFSET; 	/* for CONFIG_MAPPED_KERNEL */
   .data.init_task : { *(.data.init_task) }
 
-  /* Startup code */
-  . = ALIGN(4096);
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-
+  INIT_BEGIN
+  INITTEXT
+  INITDATA
   INITCALLS
-
-  . = ALIGN(4096);	/* Align double page for init_task_union */
-  __init_end = .;
+  INIT_END
 
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -47,17 +47,13 @@
   .dlt : { *(.dlt) }
 #endif
 
-  . = ALIGN(16384);
-  __init_begin = .;
-
+  __INIT_BEGIN(16384)
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
-
-  . = ALIGN(4096);
-  __init_end = .;
+  __INIT_END(4096)
 
   init_task BLOCK(16384) : { *(init_task) }  /* The initial task and kernel stack */
 
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -1,3 +1,5 @@
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_ARCH(powerpc)
@@ -74,11 +76,8 @@
   . = ALIGN(8192);
   .data.init_task : { *(.data.init_task) }
 
-  . = ALIGN(4096);
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
-
   .init.data : { 
     *(.init.data);
     __vtop_table_begin = .;
@@ -88,7 +87,6 @@
     *(.ptov_fixup);
     __ptov_table_end = .;
   }
-
   INITCALLS
 
   __start___ftr_fixup = .;
@@ -97,9 +95,7 @@
 
   INITPERCPU
   INITRAMFS
-
-  . = ALIGN(4096);
-  __init_end = .;
+  INITEND
 
   . = ALIGN(4096);
   __pmac_begin = .;
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -1,3 +1,5 @@
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_ARCH(powerpc:common64)
@@ -73,18 +75,13 @@
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
   /* will be freed after init */
-  . = ALIGN(4096);
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
-	
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
+  INIT_END
 
   __toc_start = .;
   .toc : { *(.toc) }
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -2,6 +2,8 @@
  * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 #include <linux/config.h>
 
@@ -61,18 +63,13 @@
   .data.init_task : { *(.data.init_task) }
 
   /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
-
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
+  INIT_END
 
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
diff -Nru a/arch/sh/vmlinux.lds.S b/arch/sh/vmlinux.lds.S
--- a/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -2,6 +2,9 @@
  * ld script to make SuperH Linux kernel
  * Written by Niibe Yutaka
  */
+
+#define PAGE_SIZE 4096
+
 #include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
 
@@ -45,19 +48,17 @@
   /* stack */
   .stack : { stack = .;  _stack = .; }
 
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-
+  INIT_BEGIN
+  INITTEXT
+  INITDATA
   INITCALLS
 
   __machvec_start = .;
   .machvec.init : { *(.machvec.init) }
   __machvec_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
 
+  INIT_END
+	
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -1,5 +1,7 @@
 /* ld script to make SparcLinux kernel */
 
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
@@ -31,18 +33,15 @@
 
   EXTABLE
 
-  . = ALIGN(4096);
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   __init_text_end = .;
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
+  INIT_END
 
-  . = ALIGN(4096);
-  __init_end = .;
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -1,5 +1,7 @@
 /* ld script to make UltraLinux kernel */
 
+#define PAGE_SIZE 8192
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
@@ -36,17 +38,14 @@
 
   EXTABLE
 	
-  . = ALIGN(8192);
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
+  INIT_END
 
-  . = ALIGN(8192);
-  __init_end = .;
   __bss_start = .;
   .sbss      : { *(.sbss) *(.scommon) }
   .bss       :
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:29 2003
@@ -2,6 +2,8 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#define PAGE_SIZE 4096
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
@@ -72,17 +74,13 @@
   . = ALIGN(4096); 
   .data.boot_pgt : { *(.data.boot_pgt) }
 
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-
+  INIT_BEGIN
   INITTEXT
   INITDATA
   INITCALLS
   INITRAMFS
   INITPERCPU
-
-  . = ALIGN(4096);
-  __init_end = .;
+  INIT_END
 
   . = ALIGN(4096);
   __nosave_begin = .;
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:29 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:29 2003
@@ -54,6 +54,17 @@
 		__stop___ex_table = .;					\
 	}
 
+#define __INIT_BEGIN(a)							\
+	. = ALIGN(a);							\
+	__init_begin = .;
+
+#define __INIT_END(a)							\
+	. = ALIGN(a);							\
+	__init_end = .;
+
+#define INIT_BEGIN __INIT_BEGIN(PAGE_SIZE)
+#define INIT_END   __INIT_END(PAGE_SIZE)
+
 #define INITTEXT							\
 	.init.text	   : AT(ADDR(.init.text) - LOAD_OFFSET) { 	\
 		_sinittext = .;						\

-----------------------------------------------------------------------------
ChangeSet@1.1063, 2003-04-15 19:14:08-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce INIT macro
  
  archs which just use the standard .init sections can just use the
  INIT macro instead of listing the contents separately.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -1,3 +1,5 @@
+#define PAGE_SIZE 8192
+	
 #include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
 
@@ -25,14 +27,7 @@
   EXTABLE
   RODATA
 
-  /* Will be freed after init */
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  __INIT_END(2*8192)	
+  __INIT(PAGE_SIZE, 2*PAGE_SIZE)               /* Will be freed after init */
 
   /* Note 2 page alignment above.  */
   .data.init_thread : { *(.data.init_thread) }
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -49,15 +49,7 @@
 	. = ALIGN(8192);              /* init_task and stack, must be aligned */
   	.data.init_task : { *(.data.init_task) }
 
-  	INIT_BEGIN
-	INITTEXT
-	INITDATA
-	INITCALLS
-
-	/* We fill to the next page, so we can discard all init
-	   pages without needing to consider what payload might be
-	   appended to the kernel image.  */
-	INIT_END
+	INIT
 	__vmlinux_end = .;            /* last address of the physical file */
 
 	__data_end = . ;              /* Move to _edata ? */
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -49,14 +49,7 @@
   . = ALIGN(8192);		/* init_task */
   .data.init_task : { *(.data.init_task) }
 
-  /* will be freed after init */
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  INIT_END
+  INIT                          /* will be freed after init */
 	
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -30,11 +30,7 @@
   . = ALIGN(8192);
   .data.init_task : { *(.data.init_task) }
 
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INIT_END
+  INIT
 
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -29,11 +29,7 @@
   . = . + MAPPED_OFFSET; 	/* for CONFIG_MAPPED_KERNEL */
   .data.init_task : { *(.data.init_task) }
 
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INIT_END
+  INIT
 
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -47,13 +47,7 @@
   .dlt : { *(.dlt) }
 #endif
 
-  __INIT_BEGIN(16384)
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  __INIT_END(4096)
+  __INIT(16384, 4096)
 
   init_task BLOCK(16384) : { *(init_task) }  /* The initial task and kernel stack */
 
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -95,7 +95,7 @@
 
   INITPERCPU
   INITRAMFS
-  INITEND
+  INIT_END
 
   . = ALIGN(4096);
   __pmac_begin = .;
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -74,14 +74,7 @@
   . = ALIGN(128);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
-  /* will be freed after init */
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  INIT_END
+  INIT				/* will be freed after init */
 
   __toc_start = .;
   .toc : { *(.toc) }
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -62,14 +62,7 @@
   . = ALIGN(8192);		/* init_task */
   .data.init_task : { *(.data.init_task) }
 
-  /* will be freed after init */
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  INIT_END
+  INIT				/* will be freed after init */
 
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -37,14 +37,8 @@
   .fixup   : { *(.fixup) }
 
   EXTABLE
-	
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  INIT_END
+
+  INIT	
 
   __bss_start = .;
   .sbss      : { *(.sbss) *(.scommon) }
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:32 2003
@@ -74,13 +74,7 @@
   . = ALIGN(4096); 
   .data.boot_pgt : { *(.data.boot_pgt) }
 
-  INIT_BEGIN
-  INITTEXT
-  INITDATA
-  INITCALLS
-  INITRAMFS
-  INITPERCPU
-  INIT_END
+  INIT                          /* will be freed after init */
 
   . = ALIGN(4096);
   __nosave_begin = .;
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:32 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:32 2003
@@ -62,8 +62,18 @@
 	. = ALIGN(a);							\
 	__init_end = .;
 
+#define __INIT(a,b)							\
+	__INIT_BEGIN(a)							\
+	INITTEXT							\
+	INITDATA							\
+	INITCALLS							\
+	INITRAMFS							\
+	INITPERCPU							\
+	__INIT_END(b)
+
 #define INIT_BEGIN __INIT_BEGIN(PAGE_SIZE)
 #define INIT_END   __INIT_END(PAGE_SIZE)
+#define INIT       __INIT(PAGE_SIZE, PAGE_SIZE)
 
 #define INITTEXT							\
 	.init.text	   : AT(ADDR(.init.text) - LOAD_OFFSET) { 	\

-----------------------------------------------------------------------------
ChangeSet@1.1064, 2003-04-16 13:16:34-05:00, kai@tp1.ruhr-uni-bochum.de
  vmlinux.lds.h: Introduce BSS, DEBUG
  
  Introduce the macros BSS, DEBUG, containing the shared descriptions for
  .bss and the debugging sections.

  ---------------------------------------------------------------------------

diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -49,47 +49,12 @@
 
   _edata = .;					/* End of data section */
 
-  __bss_start = .;
-  .sbss : { *(.sbss) *(.scommon) }
-  .bss : { *(.bss) *(COMMON) }
-  __bss_stop = .;
+  BSS						/* BSS */	
 
   _end = .;
 
   /* Sections to be discarded */
   /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
 
-  .mdebug 0 : { *(.mdebug) }
-  .note 0 : { *(.note) }
-  .comment 0 : { *(.comment) }
-
-  /* Stabs debugging sections */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  /* DWARF 1 */
-  .debug          0 : { *(.debug) }
-  .line           0 : { *(.line) }
-  /* GNU DWARF 1 extensions */
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  /* DWARF 1.1 and DWARF 2 */
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
+  DEBUG
 }
diff -Nru a/arch/cris/vmlinux.lds.S b/arch/cris/vmlinux.lds.S
--- a/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/cris/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -53,11 +53,8 @@
 	__vmlinux_end = .;            /* last address of the physical file */
 
 	__data_end = . ;              /* Move to _edata ? */
-	__bss_start = .;              /* BSS */
-	.bss : {
-		*(COMMON)
-		*(.bss)
-	}
+
+	BSS			      /* BSS */
 
 	. =  ALIGN (0x20);
 	_end = .;
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/i386/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -50,10 +50,7 @@
   .data.init_task : { *(.data.init_task) }
 
   INIT                          /* will be freed after init */
-	
-  __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
-  __bss_stop = .; 
+  BSS				/* BSS */	
 
   _end = . ;
 
@@ -64,12 +61,5 @@
 	*(.exitcall.exit)
 	}
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+  DEBUG
 }
diff -Nru a/arch/ia64/vmlinux.lds.S b/arch/ia64/vmlinux.lds.S
--- a/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/ia64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -133,51 +133,15 @@
   .sdata : AT(ADDR(.sdata) - PAGE_OFFSET)
 	{ *(.sdata) }
   _edata  =  .;
+
   _bss = .;
-  .sbss : AT(ADDR(.sbss) - PAGE_OFFSET)
-	{ *(.sbss) *(.scommon) }
-  .bss : AT(ADDR(.bss) - PAGE_OFFSET)
-	{ *(.bss) *(COMMON) }
+  BSS
 
   _end = .;
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  /* DWARF debug sections.
-     Symbols in the DWARF debugging sections are relative to the beginning
-     of the section so we begin them at 0.  */
-  /* DWARF 1 */
-  .debug          0 : { *(.debug) }
-  .line           0 : { *(.line) }
-  /* GNU DWARF 1 extensions */
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  /* DWARF 1.1 and DWARF 2 */
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
-  /* These must appear regardless of  .  */
-  /* Discard them for now since Intel SoftSDV cannot handle them.
-  .comment 0 : { *(.comment) }
-  .note 0 : { *(.note) }
-  */
+  /* Discard them for now since Intel SoftSDV cannot handle them. */
   /DISCARD/ : { *(.comment) }
   /DISCARD/ : { *(.note) }
+
+  DEBUG
 }
diff -Nru a/arch/mips/vmlinux.lds.S b/arch/mips/vmlinux.lds.S
--- a/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/mips/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -85,19 +85,12 @@
   _edata  =  .;
   PROVIDE (edata = .);
 
-  __bss_start = .;
   _fbss = .;
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-   .  = ALIGN(4);
-  _end = . ;
+  BSS
+  .  = ALIGN(4);
+  end = . ;
   PROVIDE (end = .);
-  }
-
+  
   /* Sections to be discarded */
   /DISCARD/ :
   {
@@ -106,25 +99,7 @@
         *(.exitcall.exit)
   }
 
-  /* This is the MIPS specific mdebug section.  */
-  .mdebug : { *(.mdebug) }
-  /* These are needed for ELF backends which have not yet been
-     converted to the new style linker.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  /* DWARF debug sections.
-     Symbols in the .debug DWARF section are relative to the beginning of the
-     section so we begin .debug at 0.  It's not clear yet what needs to happen
-     for the others.   */
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
-  /* These must appear regardless of  .  */
+  DEBUG
   .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
   .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
-  .comment : { *(.comment) }
-  .note : { *(.note) }
 }
diff -Nru a/arch/mips64/vmlinux.lds.S b/arch/mips64/vmlinux.lds.S
--- a/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/mips64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -73,14 +73,8 @@
   .sdata     : { *(.sdata) }
   _edata  =  .;
 
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
+  BSS
   _end = . ;
-  }
 
   /* Sections to be discarded */
   /DISCARD/ : 
@@ -90,21 +84,7 @@
         *(.exitcall.exit)
   }
 
-  /* These are needed for ELF backends which have not yet been
-     converted to the new style linker.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  /* DWARF debug sections.
-     Symbols in the .debug DWARF section are relative to the beginning of the
-     section so we begin .debug at 0.  It's not clear yet what needs to happen
-     for the others.   */
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
-  /* These must appear regardless of  .  */
+  DEBUG
   .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
   .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
 }
diff -Nru a/arch/parisc/vmlinux.lds.S b/arch/parisc/vmlinux.lds.S
--- a/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/parisc/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -53,9 +53,7 @@
 
   _edata = .;			/* End of data section */
 
-
-  .bss : { *(.bss) *(COMMON) }		/* BSS */
-
+  BSS
 
   _end = . ;
 
diff -Nru a/arch/ppc/vmlinux.lds.S b/arch/ppc/vmlinux.lds.S
--- a/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/ppc/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -125,15 +125,7 @@
   . = ALIGN(4096);
   __openfirmware_end = .;
 
-  __bss_start = .;
-  .bss       :
-  {
-   *(.sbss) *(.scommon)
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  __bss_stop = .;
+  BSS
 
   _end = . ;
   PROVIDE (end = .);
diff -Nru a/arch/ppc64/vmlinux.lds.S b/arch/ppc64/vmlinux.lds.S
--- a/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/ppc64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -81,9 +81,7 @@
   . = ALIGN(4096);
   __toc_end = .;
 
-  __bss_start = .;
-  .bss : { *(.bss) }
-  __bss_stop = .;
+  BSS
 
   . = ALIGN(4096);
   _end = . ;
diff -Nru a/arch/s390/vmlinux.lds.S b/arch/s390/vmlinux.lds.S
--- a/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/s390/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -63,10 +63,7 @@
   .data.init_task : { *(.data.init_task) }
 
   INIT				/* will be freed after init */
-
-  __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
-  __bss_stop = .;
+  BSS				/* BSS */
 
   _end = . ;
 
@@ -78,12 +75,5 @@
 	*(.eh_frame)
 	}
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+  DEBUG
 }
diff -Nru a/arch/sh/vmlinux.lds.S b/arch/sh/vmlinux.lds.S
--- a/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/sh/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -70,10 +70,8 @@
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
   . = ALIGN(4);
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
+  BSS				/* BSS */
+
   . = ALIGN(4);
   _end = . ;
 
@@ -88,38 +86,5 @@
 	*(.exitcall.exit)
 	}
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-  /* DWARF debug sections.
-     Symbols in the DWARF debugging section are relative to the beginning
-     of the section so we begin .debug at 0.  */
-  /* DWARF 1 */
-  .debug          0 : { *(.debug) }
-  .line           0 : { *(.line) }
-  /* GNU DWARF 1 extensions */
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  /* DWARF 1.1 and DWARF 2 */
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
-  /* These must appear regardless of  .  */
+  DEBUG
 }
diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/sparc/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -45,29 +45,12 @@
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
-  __bss_start = .;
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
+  BSS
+
   _end = . ;
   PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
+
+  DEBUG
+
   /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
 }
diff -Nru a/arch/sparc64/vmlinux.lds.S b/arch/sparc64/vmlinux.lds.S
--- a/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/sparc64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -37,32 +37,12 @@
   .fixup   : { *(.fixup) }
 
   EXTABLE
-
   INIT	
+  BSS
 
-  __bss_start = .;
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
   _end = . ;
   PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
+
+  DEBUG
   /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
 }
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
+++ b/arch/x86_64/vmlinux.lds.S	Fri Apr 18 09:23:34 2003
@@ -33,11 +33,7 @@
 
   _edata = .;			/* End of data section */
 
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  __bss_end = .;
+  BSS
 
   . = ALIGN(64);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
@@ -92,20 +88,5 @@
 	*(.eh_frame)
 	}
 
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
-
-
-  .comment 0 : { *(.comment) }
+  DEBUG
 }
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:34 2003
+++ b/include/asm-generic/vmlinux.lds.h	Fri Apr 18 09:23:34 2003
@@ -133,3 +133,51 @@
 		*(.data.percpu)						\
 		__per_cpu_end = .;					\
 	}
+
+#define BSS								\
+	.sbss              : AT(ADDR(.sbss) - LOAD_OFFSET) {		\
+		__bss_start = .;					\
+		*(.sbss)						\
+		*(.scommon)						\
+	}								\
+	.bss               : AT(ADDR(.bss) - LOAD_OFFSET) {		\
+		*(.dynbss)						\
+		*(.bss)							\
+		*(COMMON)						\
+		__bss_stop = .; 					\
+	}
+
+#define DEBUG								\
+	.mdebug 0 : { *(.mdebug) }					\
+	.note 0 : { *(.note) }						\
+	.comment 0 : { *(.comment) }					\
+									\
+	/* Stabs debugging sections */					\
+	.stab 0 : { *(.stab) }						\
+	.stabstr 0 : { *(.stabstr) }					\
+	.stab.excl 0 : { *(.stab.excl) }				\
+	.stab.exclstr 0 : { *(.stab.exclstr) }				\
+	.stab.index 0 : { *(.stab.index) }				\
+	.stab.indexstr 0 : { *(.stab.indexstr) }			\
+	/* DWARF 1 */							\
+	.debug          0 : { *(.debug) }				\
+	.line           0 : { *(.line) }				\
+	/* GNU DWARF 1 extensions */					\
+	.debug_srcinfo  0 : { *(.debug_srcinfo) }			\
+	.debug_sfnames  0 : { *(.debug_sfnames) }			\
+	/* DWARF 1.1 and DWARF 2 */					\
+	.debug_aranges  0 : { *(.debug_aranges) }			\
+	.debug_pubnames 0 : { *(.debug_pubnames) }			\
+	/* DWARF 2 */							\
+	.debug_info     0 : { *(.debug_info) }				\
+	.debug_abbrev   0 : { *(.debug_abbrev) }			\
+	.debug_line     0 : { *(.debug_line) }				\
+	.debug_frame    0 : { *(.debug_frame) }				\
+	.debug_str      0 : { *(.debug_str) }				\
+	.debug_loc      0 : { *(.debug_loc) }				\
+	.debug_macinfo  0 : { *(.debug_macinfo) }			\
+	/* SGI/MIPS DWARF 2 extensions */				\
+	.debug_weaknames 0 : { *(.debug_weaknames) }			\
+	.debug_funcnames 0 : { *(.debug_funcnames) }			\
+	.debug_typenames 0 : { *(.debug_typenames) }			\
+	.debug_varnames  0 : { *(.debug_varnames) }


