Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWHWLtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWHWLtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWHWLtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:49:19 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:34790 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S932419AbWHWLtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:49:18 -0400
Subject: [PATCH] Translate asm version of ELFNOTE macro into preprocessor
	macro
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 12:49:21 +0100
Message-Id: <1156333761.12949.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2006 11:51:05.0984 (UTC) FILETIME=[6A7B4000:01C6C6AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've come across some problems with the assembly version of the ELFNOTE
macro currently in -mm. (in
x86-put-note-sections-into-a-pt_note-segment-in-vmlinux.patch)

The first is that older gas does not support :varargs in .macro
definitions (in my testing 2.17 does while 2.15 does not, I don't know
when it became supported). The Changes file says binutils >= 2.12 so I
think we need to avoid using it. There are no other uses in mainline or
-mm. Old gas appears to just ignore it so you get "too many arguments"
type errors.

Secondly it seems that passing strings as arguments to assembler macros
is broken without varargs. It looks like they get unquoted or each
character is treated as a separate argument or something and this causes
all manner of grief. I think this is because of the use of -traditional
when compiling assembly files.

Therefore I have translated the assembler macro into a pre-processor
macro.

I added the desctype as a separate argument instead of including it with
the descdata as the previous version did since -traditional means the
ELFNOTE definition after the #else needs to have the same number of
arguments (I think so anyway, the -traditional CPP semantics are pretty
fscking strange!).

With this patch I am able to define elfnotes in assembly like this with
both old and new assemblers.

	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz, "linux")	
	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz, "2.6")
	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz, "xen-3.0")
	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      .long,  __PAGE_OFFSET)

Which seems reasonable enough.

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -r 4b7cd997c08f include/linux/elfnote.h
--- a/include/linux/elfnote.h	Wed Aug 23 11:48:46 2006 +0100
+++ b/include/linux/elfnote.h	Wed Aug 23 12:44:27 2006 +0100
@@ -31,22 +31,24 @@
 /*
  * Generate a structure with the same shape as Elf{32,64}_Nhdr (which
  * turn out to be the same size and shape), followed by the name and
- * desc data with appropriate padding.  The 'desc' argument includes
- * the assembler pseudo op defining the type of the data: .asciz
- * "hello, world"
+ * desc data with appropriate padding.  The 'desctype' argument is the
+ * assembler pseudo op defining the type of the data e.g. .asciz while
+ * 'descdata' is the data itself e.g.  "hello, world".
+ *
+ * e.g. ELFNOTE(XYZCo, 42, .asciz, "forty-two")
+ *      ELFNOTE(XYZCo, 12, .long, 0xdeadbeef)
  */
-.macro ELFNOTE name type desc:vararg
-.pushsection ".note.\name"
-  .align 4
-  .long 2f - 1f			/* namesz */
-  .long 4f - 3f			/* descsz */
-  .long \type
-1:.asciz "\name"
-2:.align 4
-3:\desc
-4:.align 4
-.popsection
-.endm
+#define ELFNOTE(name, type, desctype, descdata)	\
+.pushsection .note.name			;	\
+  .align 4				;	\
+  .long 2f - 1f		/* namesz */	;	\
+  .long 4f - 3f		/* descsz */	;	\
+  .long type				;	\
+1:.asciz "name"				;	\
+2:.align 4				;	\
+3:desctype descdata			;	\
+4:.align 4				;	\
+.popsection				;
 #else	/* !__ASSEMBLER__ */
 #include <linux/elf.h>
 /*


