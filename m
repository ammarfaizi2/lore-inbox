Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130122AbQJ2Cv4>; Sat, 28 Oct 2000 22:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130262AbQJ2Cvq>; Sat, 28 Oct 2000 22:51:46 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:8711 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130122AbQJ2Cvj>;
	Sat, 28 Oct 2000 22:51:39 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kbuild@torque.net
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch] 2.4.0-test10-pre6 fix usb initialization order
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Oct 2000 13:51:26 +1100
Message-ID: <11431.972787886@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.0-test10-pre6 implements LINK_FIRST and
LINK_LAST to fix the problem with usb initialization order.  The patch
*only* affects drivers/usb because that is the only Makefile that
specifies LINK_FIRST.  All the other Makefiles still rely on the kludge
where the link order is implicit in the order that objects are
declared.  USB is a special case[*] and the kludge is no longer enough,
it really does need LINK_FIRST.  Comments before it goes to Linus?

[*]http://www.uwsg.indiana.edu/hypermail/linux/kernel/0010.3/0661.html

Do not change any other Makefiles to use LINK_FIRST/LAST unless you can
guarantee that you know and have take care of all the side effects of
changing link order.  Given the lack of documentation on link order in
most Makefiles, that means leave link order alone until 2.5 unless
there is absolutely no other way of fixing the problem.

Index: 0-test10-pre6.1/drivers/usb/Makefile
--- 0-test10-pre6.1/drivers/usb/Makefile Tue, 24 Oct 2000 14:20:12 +1100 kaos (linux-2.4/n/b/19_Makefile 1.1.1.11 644)
+++ 0-test10-pre6.1(w)/drivers/usb/Makefile Sun, 29 Oct 2000 12:38:11 +1100 kaos (linux-2.4/n/b/19_Makefile 1.1.1.11 644)
@@ -18,6 +18,18 @@ O_OBJS		:=
 
 export-objs		:= usb.o
 
+# usb.o contains usb_init which is marked as __initcall (actually
+# module_init).  usb_init must be executed before all other usb __initcall
+# routines, otherwise the individual drivers will be initialized before the
+# hub driver is, causing the hub driver initialization sequence to
+# needlessly probe every USB driver with the root hub device.  This causes
+# a lot of unnecessary system log messages, a lot of user confusion, and
+# has been known to cause a incorrectly programmed USB device driver to
+# grab the root hub device improperly.
+#     Greg Kroah-Hartman, 27 Oct 2000
+
+LINK_FIRST := usb.o
+
 # Multipart objects.
 
 list-multi		:= usbcore.o
@@ -98,6 +110,10 @@ int-m		:= $(sort $(foreach m, $(multi-m)
 
 obj-m		:= $(filter-out $(obj-y), $(obj-m))
 int-m		:= $(filter-out $(int-y), $(int-m))
+
+# Take multi-part drivers out of obj-y and put components in.
+
+obj-y		:= $(filter-out $(list-multi), $(obj-y)) $(int-y)
 
 # Translate to Rules.make lists.
 
Index: 0-test10-pre6.1/Rules.make
--- 0-test10-pre6.1/Rules.make Tue, 19 Sep 2000 10:36:07 +1100 kaos (linux-2.4/B/c/24_Rules.make 1.2.1.4 644)
+++ 0-test10-pre6.1(w)/Rules.make Sun, 29 Oct 2000 12:04:05 +1100 kaos (linux-2.4/B/c/24_Rules.make 1.2.1.4 644)
@@ -31,6 +31,9 @@ unexport LX_OBJS
 unexport MX_OBJS
 unexport MIX_OBJS
 unexport SYMTAB_OBJS
+# Control link order, added 29 Oct 200 Keith Owens <kaos@ocs.com.au>
+unexport LINK_FIRST
+unexport LINK_LAST
 
 #
 # Get things started.
@@ -84,8 +87,19 @@ all_targets: $(O_TARGET) $(L_TARGET)
 #
 # Rule to compile a set of .o files into one .o file
 #
+# Note: if LINK_FIRST or LINK_LAST are specified, the rest of the
+# object files are sorted to remove duplicates.  Thus, if you use
+# LINK_FIRST/LAST, make sure they specify all ordering requirements.
+#
 ifdef O_TARGET
-ALL_O = $(OX_OBJS) $(O_OBJS)
+  ALL_O = $(OX_OBJS) $(O_OBJS)
+  ifneq ($(strip $(LINK_FIRST)$(LINK_LAST)),)
+    ALL_O := $(sort $(ALL_O))
+    ALL_O := \
+      $(filter $(ALL_O), $(LINK_FIRST)) \
+      $(filter-out $(LINK_FIRST) $(LINK_LAST), $(ALL_O)) \
+      $(filter $(ALL_O), $(LINK_LAST))
+  endif
 $(O_TARGET): $(ALL_O)
 	rm -f $@
     ifneq "$(strip $(ALL_O))" ""
Index: 0-test10-pre6.1/Documentation/kbuild/makefiles.txt
--- 0-test10-pre6.1/Documentation/kbuild/makefiles.txt Mon, 02 Oct 2000 15:28:44 +1100 kaos (linux-2.4/b/d/12_makefiles. 1.3 644)
+++ 0-test10-pre6.1(w)/Documentation/kbuild/makefiles.txt Sun, 29 Oct 2000 13:39:06 +1100 kaos (linux-2.4/b/d/12_makefiles. 1.3 644)
@@ -1,6 +1,8 @@
 Linux Kernel Makefiles
 2000-September-14
 Michael Elizabeth Chastain, <mec@shout.net>
+2000-October-29
+LINK_FIRST/LAST Keith Owens <kaos@ocs.com.au>
 
 
 
@@ -656,7 +658,12 @@ The public interface of Rules.make consi
 	with the name $(O_TARGET).  This $(O_TARGET) name also appears
 	in the top Makefile.
 
-	The order of files in $(O_OBJS) and $(OX_OBJS) is significant.
+	Even if a subdirectory Makefile has an $(O_TARGET), the .config
+	options still control whether or not its $(O_TARGET) goes into
+	vmlinux.  See the $(M_OBJS) example below.
+
+	If neither of LINK_FIRST nor LINK_LAST are defined then the
+	order of files in $(O_OBJS) and $(OX_OBJS) is significant.
 	All $(OX_OBJS) files come first, in the order listed, followed by
 	all $(O_OBJS) files, in the order listed.  Duplicates in the lists
 	are allowed: the first instance will be linked into $(O_TARGET)
@@ -680,9 +687,53 @@ The public interface of Rules.make consi
 		O_OBJS   += pci.o pci_iommu.o
 		endif
 
-	Even if a subdirectory Makefile has an $(O_TARGET), the .config
-	options still control whether or not its $(O_TARGET) goes into
-	vmlinux.  See the $(M_OBJS) example below.
+	If either of LINK_FIRST or LINK_LAST are defined then the order of
+	files in $(O_OBJS) and $(OX_OBJS) is ignored.  Instead the files
+	are linked in the order $(LINK_FIRST), the rest, $(LINK_LAST).  The
+	order of entries in LINK_FIRST and LINK_LAST is preserved exactly
+	as specified.  The order of the rest of the files is undefined,
+	currently it is alphabetical but you must not rely on any order for
+	the rest of the files.  When either LINK_FIRST or LINK_LAST are
+	defined, they must define the complete link order for all files, do
+	not rely on manual ordering of the rest of the filenames in the
+	Makefile.
+
+	The only justification for LINK_FIRST and LINK_LAST is to control
+	the order of initialization routines.  Routines which are defined
+	as __initcall or module_init and are linked into the kernel will be
+	executed during kernel startup in the order they were linked.  So
+	moving objects to the start of their O_TARGET via LINK_FIRST
+	defines which initialization routines in O_TARGET are executed
+	first.
+
+	Use LINK_FIRST for routines which must be executed before all
+	others.  For example, usb_init in usb_init must be executed before
+	all other usb initialization routines so drivers/usb/Makefile has
+	LINK_FIRST := usb.o.
+
+	Use LINK_LAST where you have multiple drivers that can recognise a
+	piece of hardware and you want the older drivers to be tried last.
+	For example, SCSI card foo can be controlled by drivers bar.o and
+	baz.o but you only want to try bar.o if all else fails.
+	LINK_LAST := bar.o
+	will ensure that the initialization routines in bar.o are tried
+	last.
+
+	LINK_FIRST and LINK_LAST must not contain any duplicate object
+	names.  There is no need to make any entries in LINK_FIRST/LAST
+	conditional on CONFIG_xxx options, the ordering lists are only
+	effective if the specified objects are actually compiled.  In other
+	words, when you use LINK_FIRST/LAST, specify all the objects in one
+	assignment, do not create LINK_FIRST/LAST from multiple
+	assignments.
+
+	All uses of LINK_FIRST and LINK_LAST must be justified and fully
+	documented in the Makefile.  Historically entries in Makefile were
+	manually ordered with no documentation, now we do not know if an
+	order is coincidence or it is required and, if it is required, why
+	the order matters.  This lack of critical information is
+	unacceptable.  See drivers/usb/Makefile for an example of the level
+	of detail required.
 
 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
