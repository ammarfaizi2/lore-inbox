Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUH3Tlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUH3Tlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268847AbUH3Tlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:41:40 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:56629 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268753AbUH3TlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:41:01 -0400
Date: Mon, 30 Aug 2004 21:42:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Updates to namespacecheck
Message-ID: <20040830194246.GC18518@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040830193915.GA18518@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830193915.GA18518@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/30 20:51:06+02:00 sam@mars.ravnborg.org 
#   kbuild: Updates to namespacecheck.pl
#   
#   From: Keith Owens <kaos@ocs.com.au>
#   
#   This now supports the absolute symbols from modversions, handles
#   recent binutils changes and supports O=.
#   
#   Signed-off-by: Keith Owens <kaos@ocs.com.au>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/namespace.pl
#   2004/08/30 20:50:49+02:00 sam@mars.ravnborg.org +86 -53
#   This now supports the absolute symbols from modversions, handles
#   recent binutils changes and supports O=.
# 
diff -Nru a/scripts/namespace.pl b/scripts/namespace.pl
--- a/scripts/namespace.pl	2004-08-30 21:26:04 +02:00
+++ b/scripts/namespace.pl	2004-08-30 21:26:04 +02:00
@@ -1,6 +1,6 @@
 #!/usr/bin/perl -w
 #
-#	namespace.pl.  Sun Aug 29 2004
+#	namespace.pl.  Mon Aug 30 2004
 #
 #	Perform a name space analysis on the linux kernel.
 #
@@ -10,7 +10,10 @@
 #	tree then namespace.pl, no parameters.
 #
 #	Tuned for 2.1.x kernels with the new module handling, it will
-#	work with 2.0 kernels as well.  Last change 2.6.9-rc1.
+#	work with 2.0 kernels as well.
+#
+#	Last change 2.6.9-rc1, adding support for separate source and object
+#	trees.
 #
 #	The source must be compiled/assembled first, the object files
 #	are the primary input to this script.  Incomplete or missing
@@ -31,6 +34,33 @@
 #	so the symbols are defined as static unless a particular
 #	CONFIG_... requires it to be external.
 #
+#	A symbol that is suffixed with '(export only)' has these properties
+#
+#	* It is global.
+#	* It is marked EXPORT_SYMBOL or EXPORT_SYMBOL_GPL, either in the same
+#	  source file or a different source file.
+#	* Given the current .config, nothing uses the symbol.
+#
+#	The symbol is a candidate for conversion to static, plus removal of the
+#	export.  But be careful that a different .config might use the symbol.
+#
+#
+#	Name space analysis and cleanup is an iterative process.  You cannot
+#	expect to find all the problems in a single pass.
+#
+#	* Identify possibly unnecessary global declarations, verify that they
+#	  really are unnecessary and change them to static.
+#	* Compile and fix up gcc warnings about static, removing dead symbols
+#	  as necessary.
+#	* make clean and rebuild with different configs (especially
+#	  CONFIG_MODULES=n) to see which symbols are being defined when the
+#	  config does not require them.  These symbols bloat the kernel object
+#	  for no good reason, which is frustrating for embedded systems.
+#	* Wrap config sensitive symbols in #ifdef CONFIG_foo, as long as the
+#	  code does not get too ugly.
+#	* Repeat the name space analysis until you can live with with the
+#	  result.
+#
 
 require 5;	# at least perl 5
 use strict;
@@ -38,6 +68,10 @@
 
 my $nm = "/usr/bin/nm -p";
 my $objdump = "/usr/bin/objdump -s -j .comment";
+my $srctree = "";
+my $objtree = "";
+$srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
+$objtree = "$ENV{'objtree'}/" if (exists($ENV{'objtree'}));
 
 if ($#ARGV != -1) {
 	print STDERR "usage: $0 takes no parameters\n";
@@ -71,58 +105,49 @@
 	if (/.*\.o$/ &&
 		! (
 		m:/built-in.o$:
-		|| m:/piggy.o$: || m:/bootsect.o$:
-		|| m:/boot/setup.o$: || m:^modules/: || m:^scripts/:
-		|| m:/compressed/: || m:/vmlinux-obj.o$:
-		|| m:boot/bbootsect.o$: || m:boot/bsetup.o$:
-		|| m:arch/ia64/scripts/check_gas_for_hint.o$:
+		|| m:arch/i386/kernel/vsyscall-syms.o$:
+		|| m:arch/ia64/ia32/ia32.o$:
+		|| m:arch/ia64/kernel/gate-syms.o$:
+		|| m:arch/ia64/lib/__divdi3.o$:
 		|| m:arch/ia64/lib/__divsi3.o$:
-		|| m:arch/ia64/lib/__udivsi3.o$:
+		|| m:arch/ia64/lib/__moddi3.o$:
 		|| m:arch/ia64/lib/__modsi3.o$:
-		|| m:arch/ia64/lib/__umodsi3.o$:
-		|| m:arch/ia64/lib/__divdi3.o$:
 		|| m:arch/ia64/lib/__udivdi3.o$:
-		|| m:arch/ia64/lib/__moddi3.o$:
+		|| m:arch/ia64/lib/__udivsi3.o$:
 		|| m:arch/ia64/lib/__umoddi3.o$:
-		|| m:arch/ia64/ia32/ia32.o$:
-		|| m:net/sched/sched.o$:
-		|| m:fs/romfs/romfs.o$:
-		|| m:fs/ramfs/ramfs.o$:
-		|| m:fs/nls/nls.o$:
-		|| m:drivers/video/video.o$:
-		|| m:drivers/scsi/sd_mod.o$:
-		|| m:drivers/media/media.o$:
+		|| m:arch/ia64/lib/__umodsi3.o$:
+		|| m:arch/ia64/scripts/check_gas_for_hint.o$:
+		|| m:arch/ia64/sn/kernel/xp.o$:
+		|| m:boot/bbootsect.o$:
+		|| m:boot/bsetup.o$:
+		|| m:/bootsect.o$:
+		|| m:/boot/setup.o$:
+		|| m:/compressed/:
+		|| m:drivers/cdrom/driver.o$:
+		|| m:drivers/char/drm/tdfx_drv.o$:
 		|| m:drivers/ide/ide-detect.o$:
 		|| m:drivers/ide/pci/idedriver-pci.o$:
-		|| m:drivers/cdrom/driver.o$:
-		|| m:net/netlink/netlink.o$:
-		|| m:fs/vfat/vfat.o$:
-		|| m:fs/hugetlbfs/hugetlbfs.o$:
-		|| m:fs/exportfs/exportfs.o$:
+		|| m:drivers/media/media.o$:
+		|| m:drivers/scsi/sd_mod.o$:
+		|| m:drivers/video/video.o$:
 		|| m:fs/devpts/devpts.o$:
-		|| m:arch/ia64/sn/kernel/xp.o$:
-		|| m:arch/ia64/kernel/gate-syms.o$:
-		|| m:^\.tmp_:
-		|| m:^.*/\.tmp_:
-		|| m:sound/pci/snd-intel8x0.o$:
-		|| m:sound/drivers/mpu401/snd-mpu401-uart.o$:
-		|| m:sound/core/snd-timer.o$:
-		|| m:sound/core/snd-rawmidi.o$:
-		|| m:sound/core/seq/snd-seq-device.o$:
-		|| m:sound/core/seq/snd-seq-midi-event.o$:
-		|| m:sound/core/seq/snd-seq-midi.o$:
-		|| m:sound/core/oss/snd-mixer-oss.o$:
-		|| m:sound/core/snd-rtctimer.o$:
-		|| m:sound/core/seq/snd-seq-dummy.o$:
-		|| m:sound/core/seq/snd-seq-virmidi.o$:
-		|| m:sound/drivers/snd-dummy.o$:
-		|| m:sound/drivers/snd-virmidi.o$:
-		|| m:sound/drivers/snd-serial-u16550.o$:
-		|| m:sound/drivers/snd-mtpav.o$:
-		|| m:sound/drivers/mpu401/snd-mpu401.o$:
-		|| m:init/mounts.o$:
+		|| m:fs/exportfs/exportfs.o$:
+		|| m:fs/hugetlbfs/hugetlbfs.o$:
 		|| m:fs/msdos/msdos.o$:
-		|| m:arch/i386/kernel/vsyscall-syms.o$:
+		|| m:fs/nls/nls.o$:
+		|| m:fs/ramfs/ramfs.o$:
+		|| m:fs/romfs/romfs.o$:
+		|| m:fs/vfat/vfat.o$:
+		|| m:init/mounts.o$:
+		|| m:^modules/:
+		|| m:net/netlink/netlink.o$:
+		|| m:net/sched/sched.o$:
+		|| m:/piggy.o$:
+		|| m:^scripts/:
+		|| m:sound/.*/snd-:
+		|| m:^.*/\.tmp_:
+		|| m:^\.tmp_:
+		|| m:/vmlinux-obj.o$:
 		)
 	) {
 		do_nm($basename, $_);
@@ -142,8 +167,12 @@
 		printf STDERR "$fullname is not an object file\n";
 		return;
 	}
-	$source = $basename;
-	$source =~ s/\.o$//;
+	($source = $fullname) =~ s/\.o$//;
+	if (-e "$objtree$source.c" || -e "$objtree$source.S") {
+		$source = "$objtree$source";
+	} else {
+		$source = "$srctree$source";
+	}
 	if (! -e "$source.c" && ! -e "$source.S") {
 		# No obvious source, exclude the object if it is conglomerate
 		if (! open(OBJDUMPDATA, "$objdump $basename|")) {
@@ -176,6 +205,7 @@
 		chop;
 		($type, $name) = (split(/ +/, $_, 3))[1..2];
 		# Expected types
+		# A absolute symbol
 		# B weak external reference to data that has been resolved
 		# C global variable, uninitialised
 		# D global variable, initialised
@@ -194,7 +224,7 @@
 		# t static label/procedures
 		# w weak external reference to text that has not been resolved
 		# ? undefined type, used a lot by modules
-		if ($type !~ /^[BCDGRSTUWabdgrstw?]$/) {
+		if ($type !~ /^[ABCDGRSTUWabdgrstw?]$/) {
 			printf STDERR "nm output for $fullname contains unknown type '$_'\n";
 		}
 		elsif ($name =~ /\./) {
@@ -202,8 +232,10 @@
 		}
 		else {
 			$type = 'R' if ($type eq '?');	# binutils replaced ? with R at one point
+			# binutils keeps changing the type for exported symbols, force it to R
+			$type = 'R' if ($name =~ /^__ksymtab/ || $name =~ /^__kstrtab/);
 			$name =~ s/_R[a-f0-9]{8}$//;	# module versions adds this
-			if ($type =~ /[BCDGRSTW]/ &&
+			if ($type =~ /[ABCDGRSTW]/ &&
 				$name ne 'init_module' &&
 				$name ne 'cleanup_module' &&
 				$name ne 'Using_Versions' &&
@@ -211,12 +243,14 @@
 				$name !~ /^__parm_/ &&
 				$name !~ /^__kstrtab/ &&
 				$name !~ /^__ksymtab/ &&
+				$name !~ /^__kcrctab_/ &&
 				$name !~ /^__exitcall_/ &&
 				$name !~ /^__initcall_/ &&
 				$name !~ /^__kdb_initcall_/ &&
 				$name !~ /^__kdb_exitcall_/ &&
 				$name !~ /^__module_/ &&
 				$name !~ /^__mod_/ &&
+				$name !~ /^__crc_/ &&
 				$name ne '__this_module' &&
 				$name ne 'kernel_version') {
 				if (!exists($def{$name})) {
@@ -252,6 +286,7 @@
 			&& $fullname ne "security/capability.o"
 			&& $fullname ne "sound/core/wrappers.o"
 			&& $fullname ne "fs/ntfs/sysctl.o"
+			&& $fullname ne "fs/jfs/jfs_debug.o"
 		) {
 			printf "No nm data for $fullname\n";
 		}
@@ -354,8 +389,6 @@
 					&& $name ne "__gp"
 					&& $name ne "ia64_unw_start"
 					&& $name ne "ia64_unw_end"
-					&& $name ne "__setup_start"
-					&& $name ne "__setup_end"
 					&& $name ne "__init_begin"
 					&& $name ne "__init_end"
 					&& $name ne "__bss_stop"
@@ -372,8 +405,8 @@
 					&& $name !~ /^__.*per_cpu_start/
 					&& $name !~ /^__.*per_cpu_end/
 					&& $name !~ /^__alt_instructions/
+					&& $name !~ /^__setup_/
 				) {
-
 					printf "Cannot resolve ";
 					printf "weak " if ($type eq "w");
 					printf "reference to $name from $object\n";
