Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132263AbQK3AG3>; Wed, 29 Nov 2000 19:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132286AbQK3AGT>; Wed, 29 Nov 2000 19:06:19 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:63749 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S132263AbQK3AGJ>; Wed, 29 Nov 2000 19:06:09 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 30 Nov 2000 10:35:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14885.37565.611695.816426@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: PATCH  - kbuild documentation.
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 I thought I would document what I had learnt about Makefiles in
 making the initialisation of drivers/md work better.

 This patch (minus a few typos that I have since found and corrected)
 was blessed by Michael Chastain on linux-kbuild.

 Ofcourse, running "make vmlinux" doesn't convert documentation
 patches into changes in a running kernel like it does for code
 patches, so:

Linux Developers:
 Please apply this patch to your brain.  It works for me, bit if you
 get a cerebral Oops, or a live-lock (hopefully no deadlock!!), please
 send me a brain-dump and I will try to fix the problem :-)

NeilBrown




--- ./Documentation/kbuild/makefiles.txt	2000/11/29 20:44:19	1.1
+++ ./Documentation/kbuild/makefiles.txt	2000/11/29 23:27:10	1.2
@@ -32,6 +32,8 @@
      7.6  Compilation flags
      7.7  Miscellaneous variables
   8  New-style variables
+     8.1  New variables
+     8.2  Converting to old-style
   9  Compatibility with Linux Kernel 2.2
  10  Credits
 
@@ -521,6 +523,8 @@
 old-style variables.  This is because Rules.make processes only the
 old-style variables.
 
+See section 8.2 ("Converting to old-style") for examples.
+
 
 
 --- 6.4 Rules.make section
@@ -679,6 +683,25 @@
 	options still control whether or not its $(O_TARGET) goes into
 	vmlinux.  See the $(M_OBJS) example below.
 
+	Sometimes the ordering of all $(OX_OBJS) files before all
+	$(O_OBJS) files can be a problem, particularly if both
+	$(O_OBJS) files and $(OX_OBJS) files contain __initcall
+	declarations where order is important.   To avoid this imposed
+	ordering, the use of $(OX_OBJS) can be dropped altogether and
+	$(MIX_OBJS) used instead.
+
+	If this approach is used, then:
+	 - All objects to be linked into vmlinux should be listed in
+	   $(O_OBJS) in the desired order.
+	 - All objects to be created as modules should be listed in
+	   $(M_OBJS)
+	 - All objects that export symbols should also be listed in
+	   $(MIX_OBJS).
+
+	This has the same effect as maintaining the
+	exported/non-exported split, except that there is more control
+	over the ordering of object files in vmlinux.
+	
 
 
 --- 7.3 Library file goals
@@ -865,6 +888,14 @@
 			$(LD) -r -o $@ $(sb-objs)
 
 
+	As is mentioned in section 7.2 ("Object file goals"),
+	$(MIX_OBJS) can also be used simply to list all objects that
+	export any symbols.  If this approach is taken, then
+	$(O_OBJS), $(L_OBJS), $(M_OBJS) and $(MI_OBJS) should simply
+	lists all of the vmlinux object files, library object files,
+	module object files and intermediate module files
+	respectively.  Duplication between $(MI_OBJS) and $(MIX_OBJS)
+	is not a problem.
 
 --- 7.6 Compilation flags
 
@@ -993,6 +1024,8 @@
 people define most variables using "new style" but then fall back to
 "old style" for a few lines.
 
+--- 8.1 New variables
+
     obj-y obj-m obj-n obj-
 
 	These variables replace $(O_OBJS), $(OX_OBJS), $(M_OBJS),
@@ -1184,6 +1217,41 @@
 	This means nls should be added to (subdir-y) and $(subdir-m) if
 	CONFIG_NFS = y.
 
+--- 8.2 Converting to old-style
+
+	The following example is taken from ./drivers/usb/Makefile.
+	Note that this uses MIX_OBJS to avoid the need for OX_OBJS and
+	MX_OBJS and thus to maintain the ordering of objects in $(obj-y)
+
+		# Translate to Rules.make lists.
+		multi-used	:= $(filter $(list-multi), $(obj-y) $(obj-m))
+		multi-objs	:= $(foreach m, $(multi-used), $($(basename $(m))-objs))
+		active-objs	:= $(sort $(multi-objs) $(obj-y) $(obj-m))
+
+		O_OBJS		:= $(obj-y)
+		M_OBJS		:= $(obj-m)
+		MIX_OBJS	:= $(filter $(export-objs), $(active-objs))
+
+	An example for libraries from drivers/acorn/scsi/Makefile:
+
+		# Translate to Rules.make lists.
+
+		L_OBJS		:= $(filter-out $(export-objs), $(obj-y))
+		LX_OBJS		:= $(filter     $(export-objs), $(obj-y))
+		M_OBJS		:= $(sort $(filter-out $(export-objs), $(obj-m)))
+		MX_OBJS		:= $(sort $(filter     $(export-objs), $(obj-m)))
+
+	As ordering is not so important in libraries, this still uses
+	LX_OBJS and MX_OBJS, though (presumably) it could be changed to
+	use MIX_OBJS as follows:
+
+		active-objs	:= $(sort $(obj-y) $(obj-m))
+		L_OBJS		:= $(obj-y)
+		M_OBJS		:= $(obj-m)
+		MIX_OBJS	:= $(filter $(export-objs), $(active-objs))
+		
+
+	which is clearly shorted and arguably clearer.
 
 === 9 Compatibility with Linux Kernel 2.2
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
