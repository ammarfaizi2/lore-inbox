Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbTCYNlY>; Tue, 25 Mar 2003 08:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262642AbTCYNlY>; Tue, 25 Mar 2003 08:41:24 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52365 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262639AbTCYNlV>; Tue, 25 Mar 2003 08:41:21 -0500
Date: Tue, 25 Mar 2003 14:49:08 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030325134908.GA30822@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org> <20030305145149.GA7509@wohnheim.fh-wedel.de> <20030305191516.GB1841@mars.ravnborg.org> <20030305195451.GB10871@wohnheim.fh-wedel.de> <20030323190844.GA6699@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030323190844.GA6699@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 March 2003 20:08:45 +0100, Sam Ravnborg wrote:
> 
> checkstack needs a configured and build kernel, hence the
> prerequisite vmlinux.
> So it is located at the right spot and shall not be listed in
> noconfig_targets.
> 
> Only tiny issue is that you miss:
> .PHONY: checkstack

True. Ok, hopefully this is the last missing bit. Can I bother Linus
with it?

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979

diff -Naur linux-2.5.66/Makefile linux-2.5.66-checkstack/Makefile
--- linux-2.5.66/Makefile	Tue Mar 25 13:42:32 2003
+++ linux-2.5.66-checkstack/Makefile	Tue Mar 25 14:45:38 2003
@@ -827,6 +827,11 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkincludes.pl
 
+.PHONY checkstack
+checkstack: vmlinux FORCE
+	$(OBJDUMP) -d vmlinux | \
+	$(PERL) scripts/checkstack.pl $(ARCH)
+
 else # ifneq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
 
 # We're called with both targets which do and do not need
diff -Naur linux-2.5.66/scripts/checkstack.pl linux-2.5.66-checkstack/scripts/checkstack.pl
--- linux-2.5.66/scripts/checkstack.pl	Thu Jan  1 01:00:00 1970
+++ linux-2.5.66-checkstack/scripts/checkstack.pl	Tue Mar 25 14:35:15 2003
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
