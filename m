Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbTCFKl2>; Thu, 6 Mar 2003 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268009AbTCFKl2>; Thu, 6 Mar 2003 05:41:28 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:45226 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268001AbTCFKlZ>; Thu, 6 Mar 2003 05:41:25 -0500
Date: Thu, 6 Mar 2003 11:51:56 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030306105156.GA6783@wohnheim.fh-wedel.de>
References: <20030305172012$3eb0@gated-at.bofh.it> <20030305172012$0dea@gated-at.bofh.it> <20030305172012$0ad6@gated-at.bofh.it> <20030305172012$4a05@gated-at.bofh.it> <20030305172012$03b3@gated-at.bofh.it> <20030305172012$525f@gated-at.bofh.it> <20030305172012$698e@gated-at.bofh.it> <20030305172012$38f6@gated-at.bofh.it> <200303060152.h261qUiU012772@post.webmailer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303060152.h261qUiU012772@post.webmailer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, 6 March 2003 02:50:22 +0100, Arnd Bergmann wrote:
> 
> Ok, here is another regex for s390, including a changed $line
> calculation. I didn't have ksymoops around, but this change
> removes the need for it and should also speed things up.

Time for allnoconfig went down from 13s to 4s.
Time for allyesconfig went down from 44m to 59s.
Great!

The output is slightly less verbose, but that information wasn't too
useful anyway. Thanks a lot!

BTW: Your mailer did something horrible to the patch, and I had to fix
it manually. Hope it didn't break anything (i386 looks fine).

And mine appears to do the same. Better send it as an attachment until
I fix the cause. :(

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="checkstack.c1.2.5.63.patch"

diff -Naur linux-2.5.63/Makefile linux-2.5.63-csb1/Makefile
--- linux-2.5.63/Makefile	Mon Feb 24 20:05:08 2003
+++ linux-2.5.63-csb1/Makefile	Wed Mar  5 20:33:22 2003
@@ -908,3 +908,7 @@
 descend =$(Q)$(MAKE) -f scripts/Makefile.build obj=$(1) $(2)
 
 FORCE:
+
+checkstack: #vmlinux FORCE
+	$(OBJDUMP) -d vmlinux | \
+	$(PERL) scripts/checkstack.pl $(ARCH)
diff -Naur linux-2.5.63/scripts/checkstack.pl linux-2.5.63-csb1/scripts/checkstack.pl
--- linux-2.5.63/scripts/checkstack.pl	Thu Jan  1 01:00:00 1970
+++ linux-2.5.63-csb1/scripts/checkstack.pl	Wed Mar  5 18:04:19 2003
@@ -0,0 +1,80 @@
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
+#		Get rid of ksymoops
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
+
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

--M9NhX3UHpAaciwkO--
