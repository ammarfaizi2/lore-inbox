Return-Path: <linux-kernel-owner+w=401wt.eu-S932606AbXAJFnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbXAJFnH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXAJFnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:43:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:38254 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbXAJFnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:43:05 -0500
Date: Tue, 9 Jan 2007 21:41:14 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: fix some odd spacing issues
Message-Id: <20070109214114.d480fac2.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

- in man and text mode output, if the function return type is
  empty (like it is for macros), don't print the return type
  and a following space; this fixes an output malalignment;

- in the function short description, strip leading, trailing,
  and multiple embedded spaces (to one space); this makes
  function name/description output spacing consistent;

- fix a comment typo;

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 scripts/kernel-doc |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- linux-2620-rc4.orig/scripts/kernel-doc
+++ linux-2620-rc4/scripts/kernel-doc
@@ -365,7 +365,7 @@ sub dump_section {
 #  parameterlist => @list of parameters
 #  parameterdescs => %parameter descriptions
 #  sectionlist => @list of sections
-#  sections => %descriont descriptions
+#  sections => %section descriptions
 #
 
 sub output_highlight {
@@ -953,7 +953,11 @@ sub output_function_man(%) {
     print $args{'function'}." \\- ".$args{'purpose'}."\n";
 
     print ".SH SYNOPSIS\n";
-    print ".B \"".$args{'functiontype'}."\" ".$args{'function'}."\n";
+    if ($args{'functiontype'} ne "") {
+	print ".B \"".$args{'functiontype'}."\" ".$args{'function'}."\n";
+    } else {
+	print ".B \"".$args{'function'}."\n";
+    }
     $count = 0;
     my $parenth = "(";
     my $post = ",";
@@ -1118,13 +1122,19 @@ sub output_intro_man(%) {
 sub output_function_text(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
+    my $start;
 
     print "Name:\n\n";
     print $args{'function'}." - ".$args{'purpose'}."\n";
 
     print "\nSynopsis:\n\n";
-    my $start=$args{'functiontype'}." ".$args{'function'}." (";
+    if ($args{'functiontype'} ne "") {
+	$start = $args{'functiontype'}." ".$args{'function'}." (";
+    } else {
+	$start = $args{'function'}." (";
+    }
     print $start;
+
     my $count = 0;
     foreach my $parameter (@{$args{'parameterlist'}}) {
 	$type = $args{'parametertypes'}{$parameter};
@@ -1710,6 +1720,7 @@ sub process_file($) {
     my $file;
     my $identifier;
     my $func;
+    my $descr;
     my $initial_section_counter = $section_counter;
 
     if (defined($ENV{'SRCTREE'})) {
@@ -1753,7 +1764,12 @@ sub process_file($) {
 
 		$state = 2;
 		if (/-(.*)/) {
-		    $declaration_purpose = xml_escape($1);
+		    # strip leading/trailing/multiple spaces #RDD:T:
+		    $descr= $1;
+		    $descr =~ s/^\s*//;
+		    $descr =~ s/\s*$//;
+		    $descr =~ s/\s+/ /;
+		    $declaration_purpose = xml_escape($descr);
 		} else {
 		    $declaration_purpose = "";
 		}


---
