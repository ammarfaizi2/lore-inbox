Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313325AbSDGN4U>; Sun, 7 Apr 2002 09:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313326AbSDGN4T>; Sun, 7 Apr 2002 09:56:19 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:38919 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313325AbSDGN4R>; Sun, 7 Apr 2002 09:56:17 -0400
Message-Id: <200204071356.g37DuF2V023124@smtpzilla3.xs4all.nl>
Content-Type: text/plain; charset=US-ASCII
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
Reply-To: ekonijn@xs4all.nl
Subject: [PATCH] kernel-doc generates malformed SGML
Date: Sun, 7 Apr 2002 15:56:15 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: Linux Kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running 'make htmldocs' will fail if a template tries to include structured
comment from a source file, and that source file does not have such comment;
see for an example the treatment of kernel/sched.c in kernel-api.tmpl
in the vanilla 2.5.7 kernel.

This is because the absence of output from scripts/kernel-doc leaves an
empty spot in the generated SGML where that's syntactically not allowed
by db2html.

The attached patch to scripts/kernel-doc helps as follows:
- provide filename in error messages.
- warn on processed source files that do not contain any structured comment.
- generate warning in docbook format for source files without structured
  comment to avoid the empty spot in generated SGML.

The nett effect is that HTML generation is more robust if changes in
documentation templates and source code do not get accepted at the
same time.

This seems to work on 2.5.8-pre1 and 2.4.19-pre6, with doc-tools from
RedHat skipjack-beta1.  Note however that I have not fed any malformed
source code to kernel-doc to exercise the error handling.

Comments and suggestions are welcome; please Cc me as I'm not on the list.

Regards,
Erik


diff -ur linux-2.5.7-base/scripts/kernel-doc linux-2.5.7-work/scripts/kernel-doc
--- linux-2.5.7-base/scripts/kernel-doc	Mon Mar 18 21:37:14 2002
+++ linux-2.5.7-work/scripts/kernel-doc	Mon Apr  1 22:12:39 2002
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


