Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTCFBmC>; Wed, 5 Mar 2003 20:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTCFBmC>; Wed, 5 Mar 2003 20:42:02 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:33497 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267038AbTCFBmA>; Wed, 5 Mar 2003 20:42:00 -0500
Message-Id: <200303060152.h261qUiU012772@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] add checkstack Makefile target
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Date: Thu, 06 Mar 2003 02:50:22 +0100
References: <20030305172012$3eb0@gated-at.bofh.it> <20030305172012$0dea@gated-at.bofh.it> <20030305172012$0ad6@gated-at.bofh.it> <20030305172012$4a05@gated-at.bofh.it> <20030305172012$03b3@gated-at.bofh.it> <20030305172012$525f@gated-at.bofh.it> <20030305172012$698e@gated-at.bofh.it> <20030305172012$38f6@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

> Yet another version:
> - Arch dependent code is reduced to one regular expression.
> - Much shorter.
> - A tiny bit faster.
> 
> Still, Keith' code beats the crap out of mine, speed-wise.

Ok, here is another regex for s390, including a changed $line
calculation. I didn't have ksymoops around, but this change
removes the need for it and should also speed things up.

        Arnd <><

--- checkstack.pl       2003-03-06 02:28:13.000000000 +0100
+++ scripts/checkstack.pl       2003-03-06 02:25:23.000000000 +0100
@@ -31,6 +31,9 @@
        } elsif ($arch =~ /^ppc$/) {
                #c00029f4:       94 21 ff 30     stwu    r1,-208(r1)
                $re = qr/.*(stwu.*r1,-($x{3,5})\(r1\))/o;
+       } elsif ($arch =~ /^s390x?$/) {
+               #   11160:       a7 fb ff 60             aghi   %r15,-160
+               $re = qr/.*(ag?hi.*\%r15,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
        } else {
                print "wrong or unknown architecture\n";
                exit
@@ -46,16 +49,17 @@
 #
 # main()
 #
+$funcre = qr/^$x* \<(.*)\>:$/;
 while (defined($line = <STDIN>)) {
+       if ($line =~ m/$funcre/) {
+               ($func = $line) =~ s/$funcre/\1/;
+               chomp($func);
+       }
+                                       
        if ($line =~ m/$re/) {
-               (my $addr = $line) =~ s/^($x{8}).*/0x\1/o;
+               (my $addr = $line) =~ s/^([ 0-9a-z]{8}):.*/0x\1/o;
                chomp($addr);
 
-               my $ksymoops = `ksymoops -v vmlinux -m System.map -K -L -O -A $addr | \
-                               tail -2 | head -1`;
-               (my $func = $ksymoops) =~ s/^Adhoc [0-9a-f]{8} (<.*>)/\1/;
-               chomp($func);
-
                my $intro = "$addr $func:";
                my $padlen = 56 - length($intro);
                while ($padlen > 0) {
