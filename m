Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268807AbTCCVGg>; Mon, 3 Mar 2003 16:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268808AbTCCVGg>; Mon, 3 Mar 2003 16:06:36 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:50361 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268807AbTCCVG0>; Mon, 3 Mar 2003 16:06:26 -0500
Date: Mon, 3 Mar 2003 22:16:47 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add checkstack Makefile target
Message-ID: <20030303211647.GA25205@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 February 2003 08:54:55 -0800, Linus Torvalds wrote:
> 
> A sorted list of bad stack users (more than 256 bytes) in my default build
> follows. Anybody can create their own with something like
> 
> 	objdump -d linux/vmlinux |
> 		grep 'sub.*$0x...,.*esp' |
> 		awk '{ print $9,$1 }' |
> 		sort > bigstack
> 
> and a script to look up the addresses.

Since Linus didn't give us the script, I had to try it myself. The
result is likely ugly and inefficient, but it works for i386 and ppc
(actually crosscompiling for ppc).

This patch is against vanilla 2.4.20, but should apply to -pre5 as
well. Shouldn't be too hard to port to 2.5.x either, but I don't need
it there yet.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare


diff -Naur foo/linux-2.4.20/arch/i386/Makefile linux-2.4.20/arch/i386/Makefile
--- foo/linux-2.4.20/arch/i386/Makefile	Fri Nov 29 00:53:09 2002
+++ linux-2.4.20/arch/i386/Makefile	Mon Mar  3 21:38:36 2003
@@ -139,9 +139,18 @@
 	@$(MAKEBOOT) BOOTIMAGE=bzImage install
 
 archclean:
+	$(RM) $(TOPDIR)/scripts/checkstack_i386.pl
 	@$(MAKEBOOT) clean
 
 archmrproper:
 
 archdep:
 	@$(MAKEBOOT) dep
+
+$(TOPDIR)/scripts/checkstack_i386.pl: $(TOPDIR)/scripts/checkstack.pl
+	(cd $(TOPDIR)/scripts/ && ln -s checkstack.pl checkstack_i386.pl)
+
+checkstack: vmlinux $(TOPDIR)/scripts/checkstack_i386.pl
+	$(OBJDUMP) -d vmlinux | \
+	grep 'sub.*$0x...,.*esp' | \
+	$(TOPDIR)/scripts/checkstack_i386.pl
diff -Naur foo/linux-2.4.20/arch/ppc/Makefile linux-2.4.20/arch/ppc/Makefile
--- foo/linux-2.4.20/arch/ppc/Makefile	Fri Nov 29 00:53:11 2002
+++ linux-2.4.20/arch/ppc/Makefile	Mon Mar  3 21:38:52 2003
@@ -108,6 +108,7 @@
 	cp -f arch/ppc/configs/$(@:config=defconfig) arch/ppc/defconfig
 
 archclean:
+	$(RM) $(TOPDIR)/scripts/checkstack_ppc.pl
 	rm -f arch/ppc/kernel/{mk_defs,ppc_defs.h,find_name,checks}
 	@$(MAKEBOOT) clean
 
@@ -115,3 +116,11 @@
 
 archdep: scripts/mkdep
 	$(MAKEBOOT) fastdep
+
+$(TOPDIR)/scripts/checkstack_ppc.pl: $(TOPDIR)/scripts/checkstack.pl
+	(cd $(TOPDIR)/scripts/ && ln -s checkstack.pl checkstack_ppc.pl)
+
+checkstack: vmlinux $(TOPDIR)/scripts/checkstack_ppc.pl
+	$(OBJDUMP) -d vmlinux | \
+	grep 'stwu.*r1,-.\{3,\}(r1)' | \
+	$(TOPDIR)/scripts/checkstack_ppc.pl
diff -Naur foo/linux-2.4.20/scripts/checkstack.pl linux-2.4.20/scripts/checkstack.pl
--- foo/linux-2.4.20/scripts/checkstack.pl	Thu Jan  1 01:00:00 1970
+++ linux-2.4.20/scripts/checkstack.pl	Mon Mar  3 20:46:52 2003
@@ -0,0 +1,92 @@
+#!/usr/bin/perl
+
+#	Check the stack usage of functions
+#
+#	Usage for ppc:
+#	powerpc-linux-objdump -d vmlinux | \
+#	grep 'stwu.*r1,-.\{3,\}(r1)' | \
+#	stackcheck_ppc.pl
+
+{
+	(my $arch = $0) =~ s/.*checkstack_(.+)\.pl$/\1/;
+	if ($arch =~ /^i386$/) {
+		$get_code = 'get_code_i386 "@_"';
+		$bysize = 'bysize_i386 "@_"';
+	} elsif ($arch =~ /^ppc$/) {
+		$get_code = 'get_code_ppc "@_"';
+		$bysize = 'bysize_ppc "@_"';
+	} else {
+		$get_code = "exit";
+		$bysize = "exit";
+	}
+}
+
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
+sub get_code_i386 {
+	(my $code = shift) =~ s/.*(sub.*)/\1/;
+	chomp($code);
+	return $code
+}
+
+sub bysize_i386 {
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
+	&& $i-- > 0
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
