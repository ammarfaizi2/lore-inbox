Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265405AbUEZKJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUEZKJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265408AbUEZKJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:09:44 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:2953 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265405AbUEZKJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:09:19 -0400
Date: Wed, 26 May 2004 12:08:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, arjanv@redhat.com,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040526100854.GA13005@wohnheim.fh-wedel.de>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040517233515.GR5414@waste.org> <20040517165919.04edcc77.akpm@osdl.org> <20040526100615.GB12142@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040526100615.GB12142@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot Anton's ppc64 port in the description.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu

o Fix the misparsing on *.ko noticed by Andrew Morton.
o Slightly simplify the output format.
o Slightly simplify the code
o Added ppc64 architecture (re by Anton Blanchard)

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>

 checkstack.pl |   47 +++++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 22 deletions(-)

--- linux-2.6.6mm5/scripts/checkstack.pl~checkstack	2004-05-26 00:35:53.000000000 +0200
+++ linux-2.6.6mm5/scripts/checkstack.pl	2004-05-26 00:45:18.000000000 +0200
@@ -9,6 +9,7 @@
 #	Mips port by Juan Quintela <quintela@mandrakesoft.com>
 #	IA64 port via Andreas Dilger
 #	Arm port by Holger Schurig
+#	Random bits by Matt Mackall <mpm@selenic.com>
 #
 #	Usage:
 #	objdump -d vmlinux | stackcheck_ppc.pl [arch]
@@ -16,11 +17,10 @@
 #	TODO :	Port to all architectures (one regex per arch)
 
 # check for arch
-#
-# $re is used for three matches:
+# 
+# $re is used for two matches:
 # $& (whole re) matches the complete objdump line with the stack growth
-# $1 (first bracket) matches the code that will be displayed in the output
-# $2 (second bracket) matches the size of the stack growth
+# $1 (first bracket) matches the size of the stack growth
 #
 # use anything else and feel the pain ;)
 {
@@ -33,25 +33,28 @@
 	$xs	= "[0-9a-f ]";	# hex character or space
 	if ($arch =~ /^arm$/) {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
-		$re = qr/.*(sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2}))/o;
+		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} elsif ($arch =~ /^i[3456]86$/) {
 		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
-		$re = qr/^.*(sub    \$(0x$x{3,5}),\%esp)$/o;
+		$re = qr/^.*sub    \$(0x$x{3,5}),\%esp$/o;
 	} elsif ($arch =~ /^ia64$/) {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
-		$re = qr/.*(adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12)/o;
+		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
 	} elsif ($arch =~ /^mips64$/) {
 		#8800402c:       67bdfff0        daddiu  sp,sp,-16
-		$re = qr/.*(daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
+		$re = qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} elsif ($arch =~ /^mips$/) {
 		#88003254:       27bdffe0        addiu   sp,sp,-32
-		$re = qr/.*(addiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
+		$re = qr/.*addiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} elsif ($arch =~ /^ppc$/) {
 		#c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
-		$re = qr/.*(stwu.*r1,-($x{3,5})\(r1\))/o;
+		$re = qr/.*stwu.*r1,-($x{3,5})\(r1\)/o;
+	} elsif ($arch =~ /^ppc64$/) {
+		#XXX
+		$re = qr/.*stdu.*r1,-($x{3,5})\(r1\)/o;
 	} elsif ($arch =~ /^s390x?$/) {
 		#   11160:       a7 fb ff 60             aghi   %r15,-160
-		$re = qr/.*(ag?hi.*\%r15,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
+		$re = qr/.*ag?hi.*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})/o;
 	} else {
 		print("wrong or unknown architecture\n");
 		exit
@@ -59,10 +62,8 @@
 }
 
 sub bysize($) {
-	($asize = $a) =~ s/$re/\2/;
-	($bsize = $b) =~ s/$re/\2/;
-	$asize = hex($asize) if ($asize =~ /^0x/);
-	$bsize = hex($bsize) if ($bsize =~ /^0x/);
+	($asize = $a) =~ s/.*	+(.*)$/$1/;
+	($bsize = $b) =~ s/.*	+(.*)$/$1/;
 	$bsize <=> $asize
 }
 
@@ -72,12 +73,16 @@
 $funcre = qr/^$x* \<(.*)\>:$/;
 while ($line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
-		($func = $line) =~ s/$funcre/\1/;
-		chomp($func);
+		$func = $1;
 	}
 	if ($line =~ m/$re/) {
-		(my $addr = $line) =~ s/^($xs{8}).*/0x\1/o;
-		chomp($addr);
+		my $size = $1;
+		$size = hex($size) if ($size =~ /^0x/);
+
+		$line =~ m/^($xs*).*/;
+		my $addr = $1;
+		$addr =~ s/ /0/g;
+		$addr = "0x$addr";
 
 		my $intro = "$addr $func:";
 		my $padlen = 56 - length($intro);
@@ -85,9 +90,7 @@
 			$intro .= '	';
 			$padlen -= 8;
 		}
-		(my $code = $line) =~ s/$re/\1/;
-
-		$stack[@stack] = "$intro $code";
+		$stack[@stack] = "$intro$size\n";
 	}
 }
