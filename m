Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262950AbTCKP3T>; Tue, 11 Mar 2003 10:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262952AbTCKP3T>; Tue, 11 Mar 2003 10:29:19 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:65513 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262950AbTCKP3R>; Tue, 11 Mar 2003 10:29:17 -0500
Date: Tue, 11 Mar 2003 16:36:41 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030311153641.GB495@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org> <20030305145149.GA7509@wohnheim.fh-wedel.de> <20030305191516.GB1841@mars.ravnborg.org> <20030305195451.GB10871@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030305195451.GB10871@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sam already pointed out that the checkstack target should be in the
main Makefile. But I am not sure, *where* in the Makefile it should
go.

Do you know a better position than the current one? If not, I will try
to submit this to Linus.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.

diff -Naur linux-2.5.63/Makefile linux-2.5.63-checkstack/Makefile
--- linux-2.5.63/Makefile	Mon Feb 24 20:05:08 2003
+++ linux-2.5.63-checkstack/Makefile	Tue Mar 11 16:19:39 2003
@@ -908,3 +908,7 @@
 descend =$(Q)$(MAKE) -f scripts/Makefile.build obj=$(1) $(2)
 
 FORCE:
+
+checkstack: vmlinux FORCE
+	$(OBJDUMP) -d vmlinux | \
+	$(PERL) scripts/checkstack.pl $(ARCH)
diff -Naur linux-2.5.63/scripts/checkstack.pl linux-2.5.63-checkstack/scripts/checkstack.pl
--- linux-2.5.63/scripts/checkstack.pl	Thu Jan  1 01:00:00 1970
+++ linux-2.5.63-checkstack/scripts/checkstack.pl	Tue Mar 11 16:24:41 2003
@@ -0,0 +1,77 @@
+#!/usr/bin/perl
+
+#	Check the stack usage of functions
+#
+#	Copyright Joern Engel <joern@wh.fh-wedel.de>
+#	Inspired by Linus Torvalds
+#	Original idea maybe from Keith Owens
+#	s390 port and big speedup by Arnd Bergmann <arnd@bergmann-dalldorf.de>
+#
+#	Usage:
+#	objdump -d vmlinux | stackcheck_ppc.pl
+#
+#	TODO :	Port to all architectures (one regex per arch)
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
+	$x	= "[0-9a-f]";	# hex character
+	$xs	= "[0-9a-f ]";	# hex character or space
+	if ($arch =~ /^i386$/) {
+		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
+		$re = qr/^.*(sub    \$(0x$x{3,5}),\%esp)$/o;
+	} elsif ($arch =~ /^ppc$/) {
+		#c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
+		$re = qr/.*(stwu.*r1,-($x{3,5})\(r1\))/o;
+	} elsif ($arch =~ /^s390x?$/) {
+		#   11160:       a7 fb ff 60             aghi   %r15,-160
+		$re = qr/.*(ag?hi.*\%r15,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
+	} else {
+		print("wrong or unknown architecture\n");
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
+$funcre = qr/^$x* \<(.*)\>:$/;
+while ($line = <STDIN>) {
+	if ($line =~ m/$funcre/) {
+		($func = $line) =~ s/$funcre/\1/;
+		chomp($func);
+	}
+	if ($line =~ m/$re/) {
+		(my $addr = $line) =~ s/^($xs{8}).*/0x\1/o;
+		chomp($addr);
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
