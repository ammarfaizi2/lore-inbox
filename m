Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTCERDc>; Wed, 5 Mar 2003 12:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTCERDc>; Wed, 5 Mar 2003 12:03:32 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17366 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267241AbTCERD3>; Wed, 5 Mar 2003 12:03:29 -0500
Date: Wed, 5 Mar 2003 18:14:01 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030305171401.GA24165@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org> <20030305145149.GA7509@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030305145149.GA7509@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another version:
- Arch dependent code is reduced to one regular expression.
- Much shorter.
- A tiny bit faster.

Still, Keith' code beats the crap out of mine, speed-wise.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 

diff -Naur linux-2.5.63/arch/i386/Makefile linux-2.5.63-csb1/arch/i386/Makefile
--- linux-2.5.63/arch/i386/Makefile	Mon Feb 24 20:05:15 2003
+++ linux-2.5.63-csb1/arch/i386/Makefile	Wed Mar  5 14:18:51 2003
@@ -124,3 +124,6 @@
   echo  '		   install to $$(INSTALL_PATH) and run lilo'
 endef
 
+checkstack: vmlinux
+	$(OBJDUMP) -d vmlinux | \
+	scripts/checkstack.pl $(ARCH)
diff -Naur linux-2.5.63/arch/ppc/Makefile linux-2.5.63-csb1/arch/ppc/Makefile
--- linux-2.5.63/arch/ppc/Makefile	Mon Feb 24 20:05:06 2003
+++ linux-2.5.63-csb1/arch/ppc/Makefile	Wed Mar  5 14:18:38 2003
@@ -109,3 +109,7 @@
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h.tmp \
 		include/asm-$(ARCH)/offsets.h \
 		arch/$(ARCH)/kernel/asm-offsets.s
+
+checkstack: vmlinux
+	$(OBJDUMP) -d vmlinux | \
+	scripts/checkstack.pl $(ARCH)
diff -Naur linux-2.5.63/scripts/checkstack.pl linux-2.5.63-csb1/scripts/checkstack.pl
--- linux-2.5.63/scripts/checkstack.pl	Thu Jan  1 01:00:00 1970
+++ linux-2.5.63-csb1/scripts/checkstack.pl	Wed Mar  5 18:04:19 2003
@@ -0,0 +1,75 @@
+#!/usr/bin/perl
+
+#	Check the stack usage of functions
+#
+#	Copyright Joern Engel <joern@wh.fh-wedel.de>
+#	Inspired by Linus Torvalds
+#	Original idea maybe from Keith Owens
+#
+#	Usage:
+#	objdump -d vmlinux | \
+#	stackcheck_ppc.pl
+#
+#	TODO :	Port to all architectures (one regex per arch)
+#		Speed this puppy up
+
+# check for arch
+# 
+# $re is used for three matches:
+# $& (whole re) matches the complete objdump line with the stack growth
+# $1 (first bracket) matches the code that will be displayed in the output
+# $2 (second bracket) matches the size of the stack growth
+#
+# use anything else and feel the pain ;)
+{
+	my $arch = shift;
+	$x = "[0-9a-f]";	# hex character
+	$X = "[0-9a-fA-F]";	# hex character
+	if ($arch =~ /^i386$/) {
+		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
+		$re = qr/^$x{8}:\t.. .. .. .. .. ..    \t(sub    \$(0x$x{3,5}),\%esp)$/o;
+	} elsif ($arch =~ /^ppc$/) {
+		#c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
+		$re = qr/.*(stwu.*r1,-($x{3,5})\(r1\))/o;
+	} else {
+		print "wrong or unknown architecture\n";
+		exit
+	}
+}
+
+sub bysize($) {
+	($asize = $a) =~ s/$re/\2/;
+	($bsize = $b) =~ s/$re/\2/;
+	$bsize <=> $asize
+}
+
+#
+# main()
+#
+while (defined($line = <STDIN>)) {
+	if ($line =~ m/$re/) {
+		(my $addr = $line) =~ s/^($x{8}).*/0x\1/o;
+		chomp($addr);
+
+		my $ksymoops = `ksymoops -v vmlinux -m System.map -K -L -O -A $addr | \
+				tail -2 | head -1`;
+		(my $func = $ksymoops) =~ s/^Adhoc [0-9a-f]{8} (<.*>)/\1/;
+		chomp($func);
+
+		my $intro = "$addr $func:";
+		my $padlen = 56 - length($intro);
+		while ($padlen > 0) {
+			$intro .= '	';
+			$padlen -= 8;
+		}
+		(my $code = $line) =~ s/$re/\1/;
+
+		$stack[@stack] = "$intro $code";
+	}
+}
+
+@sortedstack = sort bysize @stack;
+
+foreach $i (@sortedstack) {
+	print("$i");
+}
