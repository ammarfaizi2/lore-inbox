Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUKCAO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUKCAO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUKCAO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:14:26 -0500
Received: from f30.mail.ru ([194.67.57.23]:13830 "EHLO f30.mail.ru")
	by vger.kernel.org with ESMTP id S262777AbUKCAJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:09:23 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: Print preprocessor directives correctly.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.158.216.191]
Date: Wed, 03 Nov 2004 03:09:21 +0300
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1CP8iH-000D2z-00.adobriyan-mail-ru@f30.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against http://linux-sam.bkbits.net:8080/kbuild/

Print preprocessor directives (usually "#ifdef CONFIG_SOMETHING" and "#endif")
in structs definitions correctly (-text, -html, sgmldocs, htmldocs, pdfdocs,
mandocs).

Correctly means:
 - on the separate line
 - starting from column 0
 - not glued to the type of the next member
 - not breeding if members are separated by comma
 - not imitating pointers to functions ("#if defined(CONFIG_X)...")
 - not giving bogus warnings because of this imitation

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

--- a/scripts/kernel-doc	2004-11-02 00:31:13.000000000 +0000
+++ b/scripts/kernel-doc	2004-11-03 01:00:38.627241464 +0000
@@ -452,6 +452,10 @@ sub output_struct_html(%) {
     print "<h2>".$args{'type'}." ".$args{'struct'}."</h2>\n";
     print "<b>".$args{'type'}." ".$args{'struct'}."</b> {<br>\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	if ($parameter =~ /^#/) {
+		print "$parameter<br>\n";
+		next;
+	}
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
@@ -471,6 +475,8 @@ sub output_struct_html(%) {
     print "<h3>Members</h3>\n";
     print "<dl>\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	($parameter =~ /^#/) && next;
+
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
@@ -656,6 +662,11 @@ sub output_struct_sgml(%) {
     print "  <programlisting>\n";
     print $args{'type'}." ".$args{'struct'}." {\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	if ($parameter =~ /^#/) {
+	    print "$parameter\n";
+	    next;
+	}
+
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
@@ -680,6 +691,8 @@ sub output_struct_sgml(%) {
 
     print "  <variablelist>\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+      ($parameter =~ /^#/) && next;
+
       my $parameter_name = $parameter;
       $parameter_name =~ s/\[.*//;
 
@@ -995,14 +1008,17 @@ sub output_struct_man(%) {
     print $args{'type'}." ".$args{'struct'}." \\- ".$args{'purpose'}."\n";
 
     print ".SH SYNOPSIS\n";
-    print $args{'type'}." ".$args{'struct'}." {\n";
+    print $args{'type'}." ".$args{'struct'}." {\n.br\n";
 
     foreach my $parameter (@{$args{'parameterlist'}}) {
+	if ($parameter =~ /^#/) {
+	    print ".BI \"$parameter\"\n.br\n";
+	    next;
+	}
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
         ($args{'parameterdescs'}{$parameter_name} ne $undescribed) || next;
-	print "\n.br\n";
 	$type = $args{'parametertypes'}{$parameter};
 	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
 	    # pointer-to-function
@@ -1019,6 +1035,8 @@ sub output_struct_man(%) {
 
     print ".SH Arguments\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	($parameter =~ /^#/) && next;
+
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
@@ -1159,6 +1177,11 @@ sub output_struct_text(%) {
     print $args{'type'}." ".$args{'struct'}.":\n\n";
     print $args{'type'}." ".$args{'struct'}." {\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	if ($parameter =~ /^#/) {
+	    print "$parameter\n";
+	    next;
+	}
+
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
@@ -1177,6 +1200,8 @@ sub output_struct_text(%) {
 
     print "Members:\n\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	($parameter =~ /^#/) && next;
+
 	my $parameter_name = $parameter;
 	$parameter_name =~ s/\[.*//;
 
@@ -1353,7 +1378,12 @@ sub create_parameterlist($$$) {
 	$arg =~ s/\s*$//;
 	$arg =~ s/\s+/ /;
 
-	if ($arg =~ m/\(/) {
+	if ($arg =~ /^#/) {
+	    # Treat preprocessor directive as a typeless variable just to fill
+	    # corresponding data structures "correctly". Catch it later in
+	    # output_* subs.
+	    push_parameter($arg, "", $file);
+	} elsif ($arg =~ m/\(/) {
 	    # pointer-to-function
 	    $arg =~ tr/#/,/;
 	    $arg =~ m/[^\(]+\(\*([^\)]+)\)/;
@@ -1571,6 +1601,10 @@ sub process_state3_type($$) { 
     $x =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
     $x =~ s@^\s+@@gos; # strip leading spaces
     $x =~ s@\s+$@@gos; # strip trailing spaces
+    if ($x =~ /^#/) {
+	# To distinguish preprocessor directive from regular declaration later.
+	$x .= ";";
+    }
 
     while (1) {
         if ( $x =~ /([^{};]*)([{};])(.*)/ ) {

