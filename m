Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTCETox>; Wed, 5 Mar 2003 14:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTCETox>; Wed, 5 Mar 2003 14:44:53 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:1000 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261295AbTCEToY>; Wed, 5 Mar 2003 14:44:24 -0500
Date: Wed, 5 Mar 2003 20:54:51 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030305195451.GB10871@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org> <20030305145149.GA7509@wohnheim.fh-wedel.de> <20030305191516.GB1841@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030305191516.GB1841@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 March 2003 20:15:16 +0100, Sam Ravnborg wrote:
> On Wed, Mar 05, 2003 at 03:51:49PM +0100, J??rn Engel wrote:
> 
> > But the perl script itself breaks for anything but i386 and ppc at the
> > moment, so I keep the changes in the arch Makefiles. Ultimately this
> > should support all architectures and go to the top level, though.
> 
> There is no reason to put this in the arch specific makefiles.
> You error out in a nice way in checkstack.pl anyway.
> And architecture specific requirements shall be kept on a minimum.
> Realise that the changes get even smaller, and only one file needs
> to be touched to support a new architecture.

Ok, you convinced me.

> > +checkstack: vmlinux ***FORCE***
> > +	$(OBJDUMP) -d vmlinux | \
> > +	$(PERL) scripts/checkstack.pl $(ARCH)
> 
> You need FORCE to make sure the rule is actually executed.

Doh! Missed that one in your last mail. fixed.

> And we have a variable that points to perl, use that one.

ack. fixed.

I wonder if checkstack should be added to noconfig_targets. In fact, I
wonder if I put checkstack in the right spot at all. Sam?

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius

diff -Naur linux-2.5.63/Makefile linux-2.5.63-csb1/Makefile
--- linux-2.5.63/Makefile	Mon Feb 24 20:05:08 2003
+++ linux-2.5.63-csb1/Makefile	Wed Mar  5 20:33:22 2003
@@ -823,6 +823,10 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkincludes.pl
 
+checkstack: vmlinux FORCE
+	$(OBJDUMP) -d vmlinux | \
+	$(PERL) scripts/checkstack.pl $(ARCH)
+
 else # ifneq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
 
 # We're called with both targets which do and do not need
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
