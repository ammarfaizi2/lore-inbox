Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTCEOl0>; Wed, 5 Mar 2003 09:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbTCEOl0>; Wed, 5 Mar 2003 09:41:26 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:42945 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267121AbTCEOlU>; Wed, 5 Mar 2003 09:41:20 -0500
Date: Wed, 5 Mar 2003 15:51:49 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030305145149.GA7509@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il> <20030304072443.GA5503@wohnheim.fh-wedel.de> <20030304102121.GC6583@wohnheim.fh-wedel.de> <20030304105739.GD6583@wohnheim.fh-wedel.de> <20030304190854.GA1917@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030304190854.GA1917@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 March 2003 20:08:54 +0100, Sam Ravnborg wrote:
> >  
> > +CLEAN_FILES +=	$(TOPDIR)/scripts/checkstack_i386.pl
> Do not use TOPDIR.
> > +CLEAN_FILES +=	scripts/checkstack_i386.pl
> Is preferred.

ack. fixed.

> > +
> > +$(TOPDIR)/scripts/checkstack_i386.pl: $(TOPDIR)/scripts/checkstack.pl
> > +	(cd $(TOPDIR)/scripts/ && ln -s checkstack.pl checkstack_i386.pl)
> There is no need to use the symlink trick.
> Just pass the architecture as first mandatory parameter.
> Something like
> checkstack: vmlinux FORCE
> 	$(OBJDUMP) -d vmlinux | scripts/checkstack.pl $(ARCH)

ack. fixed.

> Note that I skipped grep. Perl is good at regular expressions, and
> the perl scripts already know the architecture so you can do the job there.

ack. fixed.

> Since the above is now architecture independent, better locate it in
> the top level Makefile.

But the perl script itself breaks for anything but i386 and ppc at the
moment, so I keep the changes in the arch Makefiles. Ultimately this
should support all architectures and go to the top level, though.

Thank you for the hints, looks a lot nicer now. :)

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens

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
+++ linux-2.5.63-csb1/scripts/checkstack.pl	Wed Mar  5 14:18:32 2003
@@ -0,0 +1,118 @@
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
+
+# check for arch
+{
+	my $arch = shift;
+	if ($arch =~ /^i386$/) {
+		$grep = 'grep_i386 "@_"';
+		$get_code = 'get_code_i386 "@_"';
+		$bysize = 'bysize_i386 "@_"';
+	} elsif ($arch =~ /^ppc$/) {
+		$grep = 'grep_ppc "@_"';
+		$get_code = 'get_code_ppc "@_"';
+		$bysize = 'bysize_ppc "@_"';
+	} else {
+		print "wrong or unknown architecture\n";
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
+#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
+sub grep_i386 {
+	my $line = shift;
+	$line =~ m/.*sub.*\$(0x[0-9a-f]{3,}),\%esp/
+}
+sub get_code_i386 {
+	(my $code = shift) =~ s/.*(sub.*)/\1/;
+	chomp($code);
+	return $code
+}
+sub bysize_i386 {
+	($asize = $a) =~ s/.*sub.*\$(0x[0-9a-f]{3,}),\%esp/\1/;
+	($bsize = $b) =~ s/.*sub.*\$(0x[0-9a-f]{3,}),\%esp/\1/;
+	$bsize <=> $asize
+}
+
+#c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
+sub grep_ppc {
+	my $line - shift;
+	$line =~ m/.*stwu.*r1,-([0-9a-f]{3,})\(r1\)/
+}
+sub get_code_ppc {
+	(my $code = shift) =~ s/.*(stwu.*)/\1/;
+	chomp($code);
+	return $code
+}
+sub bysize_ppc {
+	($asize = $a) =~ s/.*stwu.*r1,-([0-9a-f]{3,})\(r1\)/\1/;
+	($bsize = $b) =~ s/.*stwu.*r1,-([0-9a-f]{3,})\(r1\)/\1/;
+	$bsize <=> $asize 
+}
+
+# arch-independent again
+sub do_grep($) {
+	eval $grep
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
+$i = 5000;
+while (defined($line = <STDIN>)
+	#&& $i-- > 0
+	) {
+	if ($line =~ m/sub.*\$0x...,.*esp/) {
+
+		my $intro = get_intro($line);
+		my $code = get_code($line);
+
+		$stack[@stack] = "$intro $code";
+	}
+}
+
+@sortedstack = sort bysize @stack;
+
+foreach $i (@sortedstack) {
+	print("$i\n");
+}
