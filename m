Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUJaVp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUJaVp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUJaVmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:42:38 -0500
Received: from f25.mail.ru ([194.67.57.151]:5895 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S261574AbUJaVhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:37:47 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kernel-doc: support for comma-separated members in structs and unions.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.222.68.89]
Date: Mon, 01 Nov 2004 00:37:39 +0300
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1CONON-00002v-00.adobriyan-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings

$ make sgmldocs
...
Warning(include/linux/skbuff.h:283): No description found for parameter 'len,data_len,mac_len,csum'
Warning(include/linux/skbuff.h:283): No description found for parameter 'local_df,cloned,pkt_type,ip_summed'
Warning(include/linux/skbuff.h:283): No description found for parameter 'protocol,security'
...
Warning(include/linux/skbuff.h:283): No description found for
parameter 'head,*data,*tail,*end'
...

by adding support for comma-separated members in structs and unions.

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

--- a/scripts/kernel-doc	2004-11-01 05:45:19.205305432 +0000
+++ b/scripts/kernel-doc	2004-11-01 05:57:59.562713536 +0000
@@ -105,10 +105,7 @@
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
@@ -1318,22 +1315,40 @@
 	    $param = $1;
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*)$param/$1/;
+	    push_parameter($param, $type, $file);
 	} else {
 	    # evil magic to get fixed array parameters to work
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
+	    $arg =~ s/\s*:\s*/:/g;
+
+	    my @args = split('\s*,\s*', $arg);
+	    if ($args[0] =~ m/\*/) {
+		$args[0] =~ s/(\*+)\s*/ $1/;
+	    }
+	    my @first_arg = split('\s+', shift @args);
+	    unshift(@args, pop @first_arg);
+	    $type = join " ", @first_arg;
+
+	    foreach $param (@args) {
+		if ($param =~ m/^(\*+)\s*(.*)/) {
+		    push_parameter($2, "$type $1", $file);
+		}
+		elsif ($param =~ m/(.*?):(\d+)/) {
+		    push_parameter($1, "$type:$2", $file)
+		}
+		else {
+		    push_parameter($param, $type, $file);
+		}
 	    }
-	    $type = join " ", @args;
 	}
+    }
+}
+
+sub push_parameter($$$) {
+	my $param = shift;
+	my $type = shift;
+	my $file = shift;
 
 	if ($type eq "" && $param eq "...")
 	{
@@ -1362,7 +1377,6 @@
 
 	push @parameterlist, $param;
 	$parametertypes{$param} = $type;
-    }
 }
 
 ##

