Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSGXVWD>; Wed, 24 Jul 2002 17:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSGXVWD>; Wed, 24 Jul 2002 17:22:03 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5637 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317581AbSGXVV7>;
	Wed, 24 Jul 2002 17:21:59 -0400
Date: Wed, 24 Jul 2002 23:32:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: Generate valid DocBook syntax [3/9]
Message-ID: <20020724233220.B12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.433   -> 1.434  
#	  scripts/kernel-doc	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.434
# [PATCH] kernel-doc: Generate valid DocBook syntax [3/9]
# Forward port from 2.4, originally by Alan Cox
# o Do not generate empty RefEntry's
# o Improved error reporting
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Wed Jul 24 23:25:55 2002
+++ b/scripts/kernel-doc	Wed Jul 24 23:25:55 2002
@@ -233,9 +233,17 @@
 # CAVEAT EMPTOR!  Some of the others I localised may not want to be which
 # could cause "use of undefined value" or other bugs.
 my ($function, %function_table,%parametertypes,$declaration_purpose);
-my ($type,$file,$declaration_name,$return_type);
+my ($type,$declaration_name,$return_type);
 my ($newsection,$newcontents,$prototype,$filelist, $brcount, %source_map);
 
+# Generated docbook code is inserted in a template at a point where 
+# docbook v3.1 requires a non-zero sequence of RefEntry's; see:
+# http://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
+# We keep track of number of generated entries and generate a dummy
+# if needs be to ensure the expanded template can be postprocessed
+# into html.
+my $section_counter = 0;
+
 my $lineprefix="";
 
 # states
@@ -1158,6 +1166,7 @@
 	( $function_only == 2 && !defined($function_table{$name})))
     {
         &$func(@_);
+	$section_counter++;
     }
 }
 
@@ -1168,6 +1177,7 @@
     no strict 'refs';
     my $func = "output_intro_".$output_mode;
     &$func(@_);
+    $section_counter++;
 }
 
 ##
@@ -1195,7 +1205,7 @@
 	# ignore embedded structs or unions
 	$members =~ s/{.*}//g;
 
-	create_parameterlist($members, ';');
+	create_parameterlist($members, ';', $file);
 
 	output_declaration($declaration_name,
 			   'struct',
@@ -1211,7 +1221,8 @@
 			   });
     }
     else {
-        print STDERR "Cannot parse struct or union!\n";
+        print STDERR "Error(${file}:$.): Cannot parse struct or union!\n";
+	++$errors;
     }
 }
 
@@ -1228,8 +1239,8 @@
 	    push @parameterlist, $arg;
 	    if (!$parameterdescs{$arg}) {
 	        $parameterdescs{$arg} = $undescribed;
-	        print STDERR "Warning($file:$.): Enum value '$arg' ".
-		    "described in enum '$declaration_name'\n";
+	        print STDERR "Warning(${file}:$.): Enum value '$arg' ".
+		    "not described in enum '$declaration_name'\n";
 	    }
 
 	}
@@ -1246,7 +1257,8 @@
 			   });
     }
     else {
-        print STDERR "Cannot parse enum!\n";
+        print STDERR "Error(${file}:$.): Cannot parse enum!\n";
+	++$errors;
     }
 }
 
@@ -1272,13 +1284,15 @@
 			   });
     }
     else {
-        print STDERR "Cannot parse typedef!\n";
+        print STDERR "Error(${file}:$.): Cannot parse typedef!\n";
+	++$errors;
     }
 }
 
-sub create_parameterlist($$) {
+sub create_parameterlist($$$) {
     my $args = shift;
     my $splitter = shift;
+    my $file = shift;
     my $type;
     my $param;
 
@@ -1332,7 +1346,7 @@
 	    $parameterdescs{$param} = $undescribed;
 
 	    if (($type eq 'function') || ($type eq 'enum')) {
-	        print STDERR "Warning($file:$.): Function parameter ".
+	        print STDERR "Warning(${file}:$.): Function parameter ".
 		    "or member '$param' not " .
 		    "described in '$declaration_name'\n";
 	    }
@@ -1392,9 +1406,9 @@
 	$declaration_name = $2;
 	my $args = $3;
 
-	create_parameterlist($args, ',');
+	create_parameterlist($args, ',', $file);
     } else {
-	print STDERR "Error($.): cannot understand prototype: '$prototype'\n";
+	print STDERR "Error(${file}:$.): cannot understand prototype: '$prototype'\n";
 	++$errors;
 	return;
     }
@@ -1456,8 +1470,9 @@
     $state = 0;
 }
 
-sub process_state3_function($) { 
+sub process_state3_function($$) { 
     my $x = shift;
+    my $file = shift;
 
     if ($x =~ m#\s*/\*\s+MACDOC\s*#io) {
 	# do nothing
@@ -1474,8 +1489,9 @@
     }
 }
 
-sub process_state3_type($) { 
+sub process_state3_type($$) { 
     my $x = shift;
+    my $file = shift;
 
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     $x =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
@@ -1504,6 +1520,7 @@
     my ($file) = @_;
     my $identifier;
     my $func;
+    my $initial_section_counter = $section_counter;
 
     if (defined($source_map{$file})) {
 	$file = $source_map{$file};
@@ -1515,6 +1532,7 @@
 	return;
     }
 
+    $section_counter = 0;
     while (<IN>) {
 	if ($state == 0) {
 	    if (/$doc_start/o) {
@@ -1555,10 +1573,10 @@
 		}
 
 		if ($verbose) {
-		    print STDERR "Info($.): Scanning doc for $identifier\n";
+		    print STDERR "Info(${file}:$.): Scanning doc for $identifier\n";
 		}
 	    } else {
-		print STDERR "WARN($.): Cannot understand $_ on line $.",
+		print STDERR "Warning(${file}:$.): Cannot understand $_ on line $.",
 		" - I thought it was a doc line\n";
 		++$errors;
 		$state = 0;
@@ -1612,14 +1630,14 @@
 		}
 	    } else {
 		# i dont know - bad line?  ignore.
-		print STDERR "WARNING($.): bad line: $_"; 
+		print STDERR "Warning(${file}:$.): bad line: $_"; 
 		++$errors;
 	    }
 	} elsif ($state == 3) {	# scanning for function { (end of prototype)
 	    if ($decl_type eq 'function') {
-	        process_state3_function($_);
+	        process_state3_function($_, $file);
 	    } else {
-	        process_state3_type($_);
+	        process_state3_type($_, $file);
 	    }
 	} elsif ($state == 4) {
 		# Documentation block
@@ -1671,5 +1689,35 @@
         	}
           }
     }
+    if ($initial_section_counter == $section_counter) {
+	print STDERR "Warning(${file}): no structured comments found\n";
+	if ($output_mode eq "sgml") {
+	    # The template wants at least one RefEntry here; make one.
+	    print "<refentry>\n";
+	    print " <refnamediv>\n";
+	    print "  <refname>\n";
+	    print "   ${file}\n";
+	    print "  </refname>\n";
+	    print "  <refpurpose>\n";
+	    print "   Document generation inconsistency\n";
+	    print "  </refpurpose>\n";
+	    print " </refnamediv>\n";
+	    print " <refsect1>\n";
+	    print "  <title>\n";
+	    print "   Oops\n";
+	    print "  </title>\n";
+	    print "  <warning>\n";
+	    print "   <para>\n";
+	    print "    The template for this document tried to insert\n";
+	    print "    the structured comment from the file\n";
+	    print "    <filename>${file}</filename> at this point,\n";
+	    print "    but none was found.\n";
+	    print "    This dummy section is inserted to allow\n";
+	    print "    generation to continue.\n";
+	    print "   </para>\n";
+	    print "  </warning>\n";
+	    print " </refsect1>\n";
+	    print "</refentry>\n";
+	}
+    }
 }
-
