Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269362AbTCDKrK>; Tue, 4 Mar 2003 05:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269365AbTCDKrK>; Tue, 4 Mar 2003 05:47:10 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:59270 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S269362AbTCDKrH>; Tue, 4 Mar 2003 05:47:07 -0500
Date: Tue, 4 Mar 2003 11:57:39 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030304105739.GD6583@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030304102121.GC6583@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the checkstack patch for 2.5.63 vanilla.
Again, it works for i386 and ppc and is slow like hell.

Jörn

-- 
If System.PrivateProfileString("",
"HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Security", "Level") <>
"" Then  CommandBars("Macro").Controls("Security...").Enabled = False
-- from the Melissa-source

diff -Naur linux-2.5.63/arch/i386/Makefile linux-2.5.63-checkstack/arch/i386/Makefile
--- linux-2.5.63/arch/i386/Makefile	Mon Feb 24 20:05:15 2003
+++ linux-2.5.63-checkstack/arch/i386/Makefile	Tue Mar  4 11:51:11 2003
@@ -124,3 +124,12 @@
   echo  '		   install to $$(INSTALL_PATH) and run lilo'
 endef
 
+CLEAN_FILES +=	$(TOPDIR)/scripts/checkstack_i386.pl
+
+$(TOPDIR)/scripts/checkstack_i386.pl: $(TOPDIR)/scripts/checkstack.pl
+	(cd $(TOPDIR)/scripts/ && ln -s checkstack.pl checkstack_i386.pl)
+
+checkstack: vmlinux $(TOPDIR)/scripts/checkstack_i386.pl
+	$(OBJDUMP) -d vmlinux | \
+	grep 'sub.*$0x...,.*esp' | \
+	$(TOPDIR)/scripts/checkstack_i386.pl
diff -Naur linux-2.5.63/arch/ppc/Makefile linux-2.5.63-checkstack/arch/ppc/Makefile
--- linux-2.5.63/arch/ppc/Makefile	Mon Feb 24 20:05:06 2003
+++ linux-2.5.63-checkstack/arch/ppc/Makefile	Tue Mar  4 11:46:05 2003
@@ -108,4 +108,14 @@
 
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h.tmp \
 		include/asm-$(ARCH)/offsets.h \
-		arch/$(ARCH)/kernel/asm-offsets.s
+		arch/$(ARCH)/kernel/asm-offsets.s \
+		$(TOPDIR)/scripts/checkstack_ppc.pl
+
+$(TOPDIR)/scripts/checkstack_ppc.pl: $(TOPDIR)/scripts/checkstack.pl
+	(cd $(TOPDIR)/scripts/ && ln -s checkstack.pl checkstack_ppc.pl)
+
+checkstack: vmlinux $(TOPDIR)/scripts/checkstack_ppc.pl
+	$(OBJDUMP) -d vmlinux | \
+	grep 'stwu.*r1,-.\{3,\}(r1)' | \
+	$(TOPDIR)/scripts/checkstack_ppc.pl
+		                                                              1
diff -Naur linux-2.5.63/scripts/checkstack.pl linux-2.5.63-checkstack/scripts/checkstack.pl
--- linux-2.5.63/scripts/checkstack.pl	Thu Jan  1 01:00:00 1970
+++ linux-2.5.63-checkstack/scripts/checkstack.pl	Tue Mar  4 11:23:40 2003
@@ -0,0 +1,105 @@
+#!/usr/bin/perl
+
+#	Check the stack usage of functions
+#
+#	Copyright Joern Engel <joern@wh.fh-wedel.de>
+#	Inspired by Linus Torvalds
+#	Original idea maybe from Keith Owens
+#
+#	Usage for ppc:
+#	ln -s stackcheck.pl stackcheck_ppc.pl
+#	powerpc-linux-objdump -d vmlinux | \
+#	grep 'stwu.*r1,-.\{3,\}(r1)' | \
+#	stackcheck_ppc.pl
+
+# check for arch
+{
+	(my $arch = $0) =~ s/.*checkstack_(.+)\.pl$/\1/;
+	if ($arch =~ /^i386$/) {
+		$get_code = 'get_code_i386 "@_"';
+		$bysize = 'bysize_i386 "@_"';
+	} elsif ($arch =~ /^ppc$/) {
+		$get_code = 'get_code_ppc "@_"';
+		$bysize = 'bysize_ppc "@_"';
+	} else {
+		print "wrong or unknown architecture";
+		exit
+	}
+}
+
+# arch-independent: address and function name
+sub get_intro($) {
+	my $line = $_[0];
+
+	(my $addr = $line) =~ s/^([0-9a-f]{8}).*/0x\1/;
+	chomp($addr);
+
+	my $ksymoops = `ksymoops -v vmlinux -m System.map -K -L -O -A $addr | \
+			tail -2 | head -1`;
+	(my $func = $ksymoops) =~ s/^Adhoc [0-9a-f]{8} (<.*>)/\1/;
+	chomp($func);
+
+	my $intro = "$addr $func:";
+	my $padlen = 56 - length($intro);
+	while ($padlen > 0) {
+		$intro .= '	';
+		$padlen -= 8;
+	}
+	return $intro
+}
+
+# arch-specific: code and comparison
+
+#c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
+sub get_code_ppc {
+	(my $code = shift) =~ s/.*(stwu.*)/\1/;
+	chomp($code);
+	return $code
+}
+
+sub bysize_ppc {
+	($asize = $a) =~ s/.*r1,-([0-9]+)\(r1\)/\1/;
+	($bsize = $b) =~ s/.*r1,-([0-9]+)\(r1\)/\1/;
+	$bsize <=> $asize 
+}
+
+#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
+sub get_code_i386 {
+	(my $code = shift) =~ s/.*(sub.*)/\1/;
+	chomp($code);
+	return $code
+}
+
+sub bysize_i386 {
+	($asize = $a) =~ s/.*sub.*\$0x([0-9]+),\%esp/\1/;
+	($bsize = $b) =~ s/.*sub.*\$0x([0-9]+),\%esp/\1/;
+	$a cmp $b
+}
+
+sub get_code($) {
+	eval $get_code
+}
+
+sub bysize($) {
+	eval $bysize
+}
+
+#
+# main()
+#
+$i = 5;
+while (defined($line = <STDIN>)
+	#&& $i-- > 0
+	) {
+
+	my $intro = get_intro($line);
+	my $code = get_code($line);
+
+	$stack[@stack] = "$intro $code";
+}
+
+@sortedstack = sort bysize @stack;
+
+foreach $i (@sortedstack) {
+	print("$i\n");
+}
