Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUENLsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUENLsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUENLsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:48:14 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:26297 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265263AbUENLsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:48:03 -0400
Date: Fri, 14 May 2004 13:47:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040514114746.GB23863@wohnheim.fh-wedel.de>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040514094923.GB29106@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 11:49:23 +0200, Arjan van de Ven wrote:
> On Fri, May 14, 2004 at 11:47:39AM +0200, Andrew Morton wrote:
> > There's a `make buildcheck' target in -mm (from Arjan) into which we could
> > integrate such a tool.  Although probably it should be a different make
> > target.
> 
> I added it to buildcheck for now, based on Keith Owens' check-stack.sh
> script. I added a tiny bit of perl (shudder) to it to 
> 1) Make it print in decimal not hex
> 2) Filter the stack users to users of 400 bytes and higher
> 
> I arbitrarily used 400; that surely is debatable.

Keith' script has the major disadvantage of not working on anything
but i386.  Here is my old script that works on a few more.

I have another more intrusive one that also follows down all call
paths and sums up the stack consumption.  Lawyers pevent me from
publishing it, though.  A real pain. :(

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu

--- linux-2.6.0-test5/Makefile~checkstack	2003-10-02 10:35:27.000000000 +0200
+++ linux-2.6.0-test5/Makefile	2003-10-18 18:27:23.000000000 +0200
@@ -849,6 +849,11 @@
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
+.PHONY: checkstack
+checkstack: vmlinux FORCE
+	$(OBJDUMP) -d vmlinux | \
+	$(PERL) scripts/checkstack.pl $(ARCH)
+
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test5/scripts/checkstack.pl	2003-10-21 15:31:33.000000000 +0200
@@ -0,0 +1,98 @@
+#!/usr/bin/perl
+
+#	Check the stack usage of functions
+#
+#	Copyright Joern Engel <joern@wh.fh-wedel.de>
+#	Inspired by Linus Torvalds
+#	Original idea maybe from Keith Owens
+#	s390 port and big speedup by Arnd Bergmann <arnd@bergmann-dalldorf.de>
+#	Mips port by Juan Quintela <quintela@mandrakesoft.com>
+#	IA64 port via Andreas Dilger
+#	Arm port by Holger Schurig
+#
+#	Usage:
+#	objdump -d vmlinux | stackcheck_ppc.pl [arch]
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
+	if ($arch eq "") {
+		$arch = `uname -m`;
+	}
+
+	$x	= "[0-9a-f]";	# hex character
+	$xs	= "[0-9a-f ]";	# hex character or space
+	if ($arch =~ /^arm$/) {
+		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
+		$re = qr/.*(sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2}))/o;
+	} elsif ($arch =~ /^i[3456]86$/) {
+		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
+		$re = qr/^.*(sub    \$(0x$x{3,5}),\%esp)$/o;
+	} elsif ($arch =~ /^ia64$/) {
+		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
+		$re = qr/.*(adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12)/o;
+	} elsif ($arch =~ /^mips64$/) {
+		#8800402c:       67bdfff0        daddiu  sp,sp,-16
+		$re = qr/.*(daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
+	} elsif ($arch =~ /^mips$/) {
+		#88003254:       27bdffe0        addiu   sp,sp,-32
+		$re = qr/.*(addiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
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
+	$asize = hex($asize) if ($asize =~ /^0x/);
+	$bsize = hex($bsize) if ($bsize =~ /^0x/);
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
