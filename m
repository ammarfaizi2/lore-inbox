Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVIRFvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVIRFvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIRFvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 01:51:11 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:45252 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751105AbVIRFvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 01:51:11 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.14-rc1] Make scripts/namespace.pl work with shared source and object trees
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Sep 2005 15:50:49 +1000
Message-ID: <21262.1127022649@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct scripts/namespace.pl so it finds the sources when using a
shared source and object tree for the kernel build.  Add more error
checks.  Add a couple more entries to the list of special case, single
input objects.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: linux/scripts/namespace.pl
===================================================================
--- linux.orig/scripts/namespace.pl	2005-09-18 15:07:35.825968745 +1000
+++ linux/scripts/namespace.pl	2005-09-18 15:47:31.329956062 +1000
@@ -1,6 +1,6 @@
 #!/usr/bin/perl -w
 #
-#	namespace.pl.  Mon Aug 30 2004
+#	namespace.pl.  Sun Sep 18 2005
 #
 #	Perform a name space analysis on the linux kernel.
 #
@@ -12,8 +12,7 @@
 #	Tuned for 2.1.x kernels with the new module handling, it will
 #	work with 2.0 kernels as well.
 #
-#	Last change 2.6.9-rc1, adding support for separate source and object
-#	trees.
+#	Last change 2.6.14-rc1.
 #
 #	The source must be compiled/assembled first, the object files
 #	are the primary input to this script.  Incomplete or missing
@@ -68,10 +67,24 @@ use File::Find;
 
 my $nm = "/usr/bin/nm -p";
 my $objdump = "/usr/bin/objdump -s -j .comment";
-my $srctree = "";
-my $objtree = "";
-$srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
-$objtree = "$ENV{'objtree'}/" if (exists($ENV{'objtree'}));
+my $pwd = $ENV{'PWD'};
+my $srctree = $pwd . '/';
+my $objtree = $pwd . '/';
+if (exists($ENV{'srctree'})) {
+	chdir($ENV{'srctree'}) || die("cannot chdir($ENV{'srctree'}) (srctree)");
+	$srctree = `pwd`;
+	chomp($srctree);
+	$srctree .= '/';
+	chdir($pwd) || die("cannot chdir($pwd) (original directory)");
+}
+if (exists($ENV{'objtree'})) {
+	chdir($ENV{'objtree'}) || die("cannot chdir($ENV{'objtree'}) (objtree)");
+	$objtree = `pwd`;
+	chomp($objtree);
+	$objtree .= '/';
+	die("No vmlinux in $objtree") if (! -e "vmlinux");
+}
+print("srctree=$srctree objtree=$objtree\n");
 
 if ($#ARGV != -1) {
 	print STDERR "usage: $0 takes no parameters\n";
@@ -118,6 +131,7 @@ sub linux_objects
 		|| m:arch/ia64/lib/__umodsi3.o$:
 		|| m:arch/ia64/scripts/check_gas_for_hint.o$:
 		|| m:arch/ia64/sn/kernel/xp.o$:
+		|| m:arch/ia64/kernel/mca_recovery.o$:
 		|| m:boot/bbootsect.o$:
 		|| m:boot/bsetup.o$:
 		|| m:/bootsect.o$:
@@ -127,6 +141,7 @@ sub linux_objects
 		|| m:drivers/char/drm/tdfx_drv.o$:
 		|| m:drivers/ide/ide-detect.o$:
 		|| m:drivers/ide/pci/idedriver-pci.o$:
+		|| m:drivers/pci/hotplug/pci_hotplug.o$:
 		|| m:drivers/media/media.o$:
 		|| m:drivers/scsi/sd_mod.o$:
 		|| m:drivers/video/video.o$:

