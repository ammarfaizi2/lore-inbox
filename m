Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWFGSuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWFGSuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFGSuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:50:12 -0400
Received: from xenotime.net ([66.160.160.81]:42213 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751253AbWFGSuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:50:11 -0400
Date: Wed, 7 Jun 2006 11:52:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, joern@wohnheim.fh-wedel.de
Subject: [PATCH] checkstack: pirnt module names
Message-Id: <20060607115258.ff8f337c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Finding "init_module" high stack usage problems is challenging
when there are over 1600 "init_module" functions in the kernel tree,
so make checkstack.pl print out the filename where the stack usage
occurs.  This is useful for code built as loadable modules.

For built-in code, it just prints the kernel image file name,
like "vmlinux".  Examples:

(before patch:)
0x0000000d callback:					1928
0xffffffff81678c09 huft_build:				1560
0x0018 init_module:					1512

(after patch:)
0x0000000d callback [divacapi]:				1928
0xffffffff81678c09 huft_build [vmlinux]:		1560
0x0018 init_module [hdaps]:				1512

Also change one if-series to use elsif to cut down on
unneeded tests.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/checkstack.pl |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

--- linux-2617-rc5mm3.orig/scripts/checkstack.pl
+++ linux-2617-rc5mm3/scripts/checkstack.pl
@@ -89,11 +89,21 @@ sub bysize($) {
 #
 my $funcre = qr/^$x* <(.*)>:$/;
 my $func;
+my $file, $lastslash;
+
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
 	}
-	if ($line =~ m/$re/) {
+	elsif ($line =~ m/(.*):\s*file format/) {
+		$file = $1;
+		$file =~ s/\.ko//;
+		$lastslash = rindex($file, "/");
+		if ($lastslash != -1) {
+			$file = substr($file, $lastslash + 1);
+		}
+	}
+	elsif ($line =~ m/$re/) {
 		my $size = $1;
 		$size = hex($size) if ($size =~ /^0x/);
 
@@ -109,7 +119,7 @@ while (my $line = <STDIN>) {
 		$addr =~ s/ /0/g;
 		$addr = "0x$addr";
 
-		my $intro = "$addr $func:";
+		my $intro = "$addr $func [$file]:";
 		my $padlen = 56 - length($intro);
 		while ($padlen > 0) {
 			$intro .= '	';


---
