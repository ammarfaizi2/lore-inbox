Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQJ3ViB>; Mon, 30 Oct 2000 16:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQJ3Vho>; Mon, 30 Oct 2000 16:37:44 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:19982 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129130AbQJ3Vhb>;
	Mon, 30 Oct 2000 16:37:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 11:32:33 -0800."
             <Pine.LNX.4.10.10010301128380.5551-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 08:37:23 +1100
Message-ID: <10135.972941843@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 11:32:33 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
> - pre7:
>    - Randy Dunlap, USB: printer.c, usb-storage, usb identification and
>      memory leak fixes

USB still gets unresolved symbols when part is in kernel, part is in
modules and modversions are set.  Patch against 2.4.0-test10-pre7, only
affects drivers/usb/Makefile.

Index: 0-test10-pre7.1/drivers/usb/Makefile
--- 0-test10-pre7.1/drivers/usb/Makefile Tue, 24 Oct 2000 14:20:12 +1100 kaos (linux-2.4/n/b/19_Makefile 1.1.1.11 644)
+++ 0-test10-pre7.1(w)/drivers/usb/Makefile Tue, 31 Oct 2000 08:33:46 +1100 kaos (linux-2.4/n/b/19_Makefile 1.1.1.11 644)
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
 
Index: 0-test10-pre7.1/Rules.make
--- 0-test10-pre7.1/Rules.make Tue, 19 Sep 2000 10:36:07 +1100 kaos (linux-2.4/B/c/24_Rules.make 1.2.1.4 644)
+++ 0-test10-pre7.1(w)/Rules.make Tue, 31 Oct 2000 08:33:46 +1100 kaos (linux-2.4/B/c/24_Rules.make 1.2.1.4 644)
@@ -31,6 +31,9 @@ unexport LX_OBJS
 unexport MX_OBJS
 unexport MIX_OBJS
 unexport SYMTAB_OBJS
+# Control link order, added 29 Oct 2000 Keith Owens <kaos@ocs.com.au>
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
Index: 0-test10-pre7.1/Documentation/kbuild/makefiles.txt
--- 0-test10-pre7.1/Documentation/kbuild/makefiles.txt Tue, 31 Oct 2000 08:28:16 +1100 kaos (linux-2.4/b/d/12_makefiles. 1.4 644)
+++ 0-test10-pre7.1(w)/Documentation/kbuild/makefiles.txt Tue, 31 Oct 2000 08:33:46 +1100 kaos (linux-2.4/b/d/12_makefiles. 1.4 644)
@@ -1,6 +1,9 @@
 Linux Kernel Makefiles
 2000-September-14
 Michael Elizabeth Chastain, <mec@shout.net>
+2000-October-29
+LINK_FIRST/LAST Keith Owens <kaos@ocs.com.au>,
+		Peter Samuelson <peter@cadcamlab.org>
 
 
 
@@ -319,7 +322,7 @@ architecture-specific values.
 		# arch/alpha/Makefile
 
 		SUBDIRS := $(SUBDIRS) arch/alpha/kernel arch/alpha/mm \
-		           arch/alpha/lib arch/alpha/math-emu
+			   arch/alpha/lib arch/alpha/math-emu
 
 	This list may depend on the configuration:
 
@@ -645,12 +648,17 @@ The public interface of Rules.make consi
 	with the name $(O_TARGET).  This $(O_TARGET) name also appears
 	in the top Makefile.
 
-	The order of files in $(O_OBJS) and $(OX_OBJS) is significant.
-	All $(OX_OBJS) files come first, in the order listed, followed by
-	all $(O_OBJS) files, in the order listed.  Duplicates in the lists
-	are allowed: the first instance will be linked into $(O_TARGET)
-	and succeeding instances will be ignored.  (Note: Rules.make may
-	emit warning messages for duplicates, but this is harmless).
+	Even if a subdirectory Makefile has an $(O_TARGET), the .config
+	options still control whether or not its $(O_TARGET) goes into
+	vmlinux.  See the $(M_OBJS) example below.
+
+	If neither $(LINK_FIRST) nor $(LINK_LAST) are defined, the order of
+	files in $(O_OBJS) and $(OX_OBJS) is significant.  All $(OX_OBJS)
+	files come first, in the order listed, followed by all $(O_OBJS)
+	files, in the order listed.  Duplicates in the lists are allowed:
+	the first instance will be linked into $(O_TARGET) and succeeding
+	instances will be ignored.  (Note: Rules.make may emit warning
+	messages for duplicates, but this is harmless).
 
 	Example:
 
@@ -669,9 +677,61 @@ The public interface of Rules.make consi
 		O_OBJS   += pci.o pci_iommu.o
 		endif
 
-	Even if a subdirectory Makefile has an $(O_TARGET), the .config
-	options still control whether or not its $(O_TARGET) goes into
-	vmlinux.  See the $(M_OBJS) example below.
+	If either $(LINK_FIRST) or $(LINK_LAST) are defined, the order of
+	files in $(O_OBJS) and $(OX_OBJS) is ignored.  Instead the files are
+	linked in the order $(LINK_FIRST), the rest, $(LINK_LAST).  The
+	order of entries in $(LINK_FIRST) and $(LINK_LAST) is preserved
+	exactly as specified.  The order of the rest of the files is
+	undefined; currently it is alphabetical, but you must not rely on
+	this.  When either $(LINK_FIRST) or $(LINK_LAST) are defined, they
+	must satisfy all possible ordering requirements for the
+	corresponding $(O_TARGET).
+
+	The only justification for $(LINK_FIRST) and $(LINK_LAST) is to
+	control the order of initialization routines.  Routines which are
+	defined as __initcall or module_init and are linked into the kernel
+	will be executed during kernel startup in the order they were
+	linked.
+
+	Use $(LINK_FIRST) to ensure that certain routines, if present, are
+	executed before all others in the current directory.  For example,
+	usb_init() in usb.c must be executed before all other usb
+	initialization routines:
+
+		# drivers/usb/Makefile
+		LINK_FIRST := usb.o
+
+	Use $(LINK_LAST) to ensure that initialization routines, if present,
+	are executed after all other such routines in the current directory.
+	Typically this is needed where you have multiple drivers that can
+	recognise a piece of hardware and you want the older drivers to be
+	tried last.  For example, SCSI card `foo' can be controlled by
+	drivers bar.o and baz.o but baz.o is preferred, if present.
+	``LINK_LAST := bar.o'' will ensure that the initialization routines
+	in bar.o are tried last.
+
+	[Note that the only way to control the kernel link order *between*
+	directories is by manipulating variables such as $(DRIVERS-y) in the
+	toplevel Makefile.  This has directory-level granularity; if
+	finer-grained control is needed, you must use a workaround.  Such
+	cases should be rare, if they exist at all.]
+
+	$(LINK_FIRST) and $(LINK_LAST) must not contain any duplicate object
+	names.  For this reason, you should define them unconditionally,
+	i.e. they should not depend on the kernel configuration.  They do
+	not need to, because they only affect the link order, not the actual
+	list of objects linked to $(O_TARGET).  In other words, if an object
+	appears in $(LINK_FIRST) or $(LINK_LAST) but does not appear in
+	$(O_OBJS) or $(OX_OBJS), it is ignored.
+
+	All uses of $(LINK_FIRST) and $(LINK_LAST) must be justified and
+	fully documented in the Makefile.  Historically, entries in
+	Makefiles were manually ordered with no documentation.  This is
+	unfortunate because now, in some cases, we cannot be sure whether a
+	particular ordering is by chance or by necessity -- or, if by
+	necessity, what the reason was.  This lack of critical information
+	is unacceptable.  See drivers/usb/Makefile for an example of the
+	level of detail required.
 
 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
