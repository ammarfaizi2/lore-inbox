Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUDRKqu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 06:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbUDRKqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 06:46:50 -0400
Received: from f16.mail.ru ([194.67.57.46]:59919 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S264155AbUDRKqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 06:46:44 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] scripts/kernel-doc and comma separated members.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.81.172]
Date: Sun, 18 Apr 2004 14:46:42 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1BF9ow-000FFX-00.adobriyan-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch teaches scripts/kernel-doc to print descriptions
of comma separated variables correctly instead of ignoring
them.

Tested on 'make pdfdocs' and 'scripts/kernel-doc -text test.c'.

Alexey

Please, CC me when replying.

--- a/scripts/kernel-doc	2004-04-15 05:34:37.000000000 +0400
+++ b/scripts/kernel-doc	2004-04-18 14:26:55.000000000 +0400
@@ -26,6 +26,8 @@
 # Still to do:
 # 	- add perldoc documentation
 # 	- Look more closely at some of the scarier bits :)
+# 	- Clean up mess that #ifdefs and comments inside structs
+# 	  definitions leave.
 
 # 26/05/2001 - 	Support for separate source and object trees.
 #		Return error code.
@@ -36,6 +38,8 @@
 #              Small fixes (like spaces vs. \s in regex)
 # -- Tim Jansen <tim@tjansen.de>
 
+# 18/04/2004 - Comma separated members inside structs definitions are ok now.
+# -- Alexey Dobriyan <adobriyan@mail.ru>
 
 #
 # This will read a 'c' file and scan for embedded comments in the
@@ -105,10 +109,7 @@
 # enums and typedefs. Instead of the function name you must write the name 
 # of the declaration;  the struct/union/enum/typedef must always precede 
 # the name. Nesting of declarations is not supported. 
-# Use the argument mechanism to document members or constants. In 
-# structs and unions you must declare one member per declaration 
-# (comma-separated members are not allowed -  the parser does not support 
-# this).
+# Use the argument mechanism to document members or constants.
 # e.g.
 # /**
 #  * struct my_struct - short description
@@ -1316,51 +1317,62 @@
 	    $param = $1;
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*)$param/$1/;
+	    push_parameter($type, $param, $file);
 	} else {
 	    # evil magic to get fixed array parameters to work
+	    # 'char cb[48]' => 'char* cb'
 	    $arg =~ s/(.+\s+)(.+)\[.*/$1* $2/;
-	    my @args = split('\s', $arg);
-	
-	    $param = pop @args;
-	    if ($param =~ m/^(\*+)(.*)/) {
-	        $param = $2;
-		push @args, $1;
-	    } 
-	    elsif ($param =~ m/(.*?)\s*:\s*(\d+)/) {
-	        $param = $1;
-	        push @args, ":$2";
+
+	    my @args = split(',\s*', $arg);
+
+	    my @first_arg = split('\s', shift @args);
+	    unshift(@args, pop @first_arg);
+	    $type = join " ", @first_arg;
+
+	    foreach $param (@args) {
+		if ($param =~ m/^(\*+)(.*)/) {
+		   # pointer
+		   push_parameter("$type$1", $2, $file);
+		} elsif ($param =~ m/(.*?)\s*:\s*(\d+)/) {
+		   # bitfield
+		   push_parameter("$type:$2", $1, $file);
+		} else {
+		   push_parameter($type, $param, $file);
+		}
 	    }
-	    $type = join " ", @args;
 	}
+    }
+}
 
-	if ($type eq "" && $param eq "...")
-	{
-	    $type="...";
-	    $param="...";
-	    $parameterdescs{"..."} = "variable arguments";
-	}
-	elsif ($type eq "" && ($param eq "" or $param eq "void"))
-	{
-	    $type="";
-	    $param="void";
-	    $parameterdescs{void} = "no arguments";
-	}
-	if (defined $type && $type && !defined $parameterdescs{$param}) {
-	    $parameterdescs{$param} = $undescribed;
+sub push_parameter($$$) {
+    my $type = shift;
+    my $param = shift;
+    my $file = shift;
+
+    if ($type eq "" && $param eq "...")	{
+	$type="...";
+	$param="...";
+	$parameterdescs{"..."} = "variable arguments";
+    } elsif ($type eq "" && ($param eq "" or $param eq "void"))	{
+	$type="";
+	$param="void";
+	$parameterdescs{void} = "no arguments";
+    }
+    if (defined $type && $type && !defined $parameterdescs{$param}) {
+	$parameterdescs{$param} = $undescribed;
 
-	    if (($type eq 'function') || ($type eq 'enum')) {
-	        print STDERR "Warning(${file}:$.): Function parameter ".
+	if (($type eq 'function') || ($type eq 'enum')) {
+	    print STDERR "Warning(${file}:$.): Function parameter ".
 		    "or member '$param' not " .
 		    "described in '$declaration_name'\n";
-	    }
-	    print STDERR "Warning(${file}:$.):".
+	}
+	print STDERR "Warning(${file}:$.):".
 	                 " No description found for parameter '$param'\n";
-	    ++$warnings;
-        }
-
-	push @parameterlist, $param;
-	$parametertypes{$param} = $type;
+	++$warnings;
     }
+
+    push @parameterlist, $param;
+    $parametertypes{$param} = $type;
 }
 
 ##


