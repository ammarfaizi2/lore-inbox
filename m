Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUGLJGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUGLJGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266765AbUGLJGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:06:22 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:25279 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266762AbUGLJGL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:06:11 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jul_12_09_06_07_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040712090607.DFCFAC3662@merlin.emma.line.org>
Date: Mon, 12 Jul 2004 11:06:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.201, 2004-07-12 11:04:45+02:00, matthias.andree@gmx.de
  * Implement address precedence logic
  * If the LINUXKERNEL_BK_FMT_DEBUG environment variable is non-empty, enter debug mode.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |  105 ++++++++++++++++++++++++++++++-------------
# 1 files changed, 74 insertions(+), 31 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/12 11:04:45+02:00 matthias.andree@gmx.de 
#   * Implement address precedence logic
#   * If the LINUXKERNEL_BK_FMT_DEBUG environment variable is non-empty, enter debug mode.
# 
# shortlog
#   2004/07/12 11:04:44+02:00 matthias.andree@gmx.de +74 -31
#   * Implement address precedence logic ($namepref), priority:
#   2 (highest) - From:
#   1 - Signed-off-by: (the first one found in a block)
#   0 - BK information on ChangeSet author
#   * Consolidate From: and Signed-off-by: parsing into a common function, treat_address($$)
#   * Check LINUXKERNEL_BK_FMT_DEBUG environment variable, if nonzero, enter debug mode.
#   * Kill some trailing whitespace.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	2004-07-12 11:06:07 +02:00
+++ b/shortlog	2004-07-12 11:06:07 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.307 2004/07/02 08:59:44 vita Exp $
+# $Id: lk-changelog.pl,v 0.309 2004/07/12 09:00:05 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -68,6 +68,11 @@
 my $debug = 0;
 # --------------------------------------------------------------------
 
+if (defined $ENV{LINUXKERNEL_BK_FMT_DEBUG}
+	and $ENV{LINUXKERNEL_BK_FMT_DEBUG}) {
+    $debug = 1;
+}
+
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
@@ -2107,7 +2112,7 @@
 # * $author can be the email address or Joe N. Sixpack II <joe6@example.com>
 #   (ready formatted to print)
 # * $name is the name (Joe N. Sixpack II) or the mail address
-#   (<joe6@example.com>) 
+#   (<joe6@example.com>)
 
 sub get_name()   { return $name; }
 sub get_author() { return $author; }
@@ -2180,7 +2185,7 @@
   croak "do not call removedups() in scalar context" unless wantarray;
   my @u = grep (!$t{lc $_}++, @_);
   return map {
-    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_; 
+    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_;
   } @u;
 }
 
@@ -2298,7 +2303,7 @@
 		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
 		     or write_error();
       } else {
-	print join("\n", map { "$indent1$_ ($a)" } 
+	print join("\n", map { "$indent1$_ ($a)" }
 		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
 		     or write_error();
       }
@@ -2478,6 +2483,28 @@
     return $author;
 }
 
+# Treat address
+# INPUT: Tuple of Name, Address scalars
+# OUTPUT: Tuple of Name, Address, Author scalars in an array
+sub treat_address($$) {
+    my $n = shift;
+    my $a = lc shift;
+    my $au;
+    my $tmp;
+
+    if (($tmp = rmap_address($a, 0)) eq $a) {
+	if ($n =~ /\s+/) {
+	    # not found, but only add if two words or more in name.
+	    $address_found_in_from{$a} = sprintf "'%s' => '%s',",
+	    obfuscate $a, $n; # FIXME: has this any effect?
+	}
+    } else {
+	$n = $tmp;
+    }
+    $au = treat_addr_name($a, $n);
+    return ($n, $a, $au);
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -2494,8 +2521,18 @@
   my @cur = ();
   my $first = 0;
   my $firstpar = 0;
+  my $namepref = 0; # where address is from
+  # 0 - BK; 1 - Signed-off-by; 2 - From
   undef $address;
 
+  ###############################################################
+  # Linus' intended logic is:
+  # - preference is given to From: (namepref 2)
+  # - lacking From:, use the first Signed-off-by: we encounter
+  #   (namepref 1)
+  # - lacking that information, use BK user info (namepref 0)
+  ###############################################################
+
   # now go!
 
   # NOTE: the first @cur item can consist of multiple lines in the
@@ -2531,41 +2568,30 @@
       $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address, 1);
       $author = treat_addr_name($address, $name);
-      print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
+      print STDERR " BK-CHANGESET $author\n" if $debug;
+      $namepref = 0;
     } elsif (/^\s+From:?\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
-      my $tmp;
-      $name = $1;
-      $address = lc $2;
-      if (($tmp = rmap_address($address, 0)) eq $address) {
-	if ($name =~ /\s+/) {
-	  # not found, but only add if two words or more in name.
-	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	  obfuscate $address, $name;
-	}
+      my @nameauthor = treat_address($1, $2);
+      if ($namepref < 2) {
+	  ($name, $address, $author) = @nameauthor;
+	  $namepref = 2;
+	  print STDERR " FROM  $author\n" if $debug;
       } else {
-	$name = $tmp;
+	  print STDERR " SKIPPED FROM  $author\n" if $debug;
       }
-      $author = treat_addr_name($address, $name);
-      print STDERR " FROM  $author\n" if $debug;
     } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
-      my $tmp;
-      $name = $1;
-      $address = lc $2;
-      if (($tmp = rmap_address($address, 0)) eq $address) {
-	if ($name =~ /\s+/) {
-	  # not found, but only add if two words or more in name.
-	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
-	  obfuscate $address, $name;
-	}
+      my @nameauthor = treat_address($1, $2);
+      if ($namepref < 1) {
+	  ($name, $address, $author) = @nameauthor;
+	  $namepref = 1;
+	  print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
       } else {
-	$name = $tmp;
+	  print STDERR " SKIPPED SIGNED-OFF-BY  $author\n" if $debug;
       }
-      $author = treat_addr_name($address, $name);
-      print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
     } elsif ($first) {
-      # we have a "first" line after an address, take it, 
+      # we have a "first" line after an address, take it,
       # strip common redundant tags
 
       # kill "PATCH" tag
@@ -2599,7 +2625,7 @@
       # store header before a changelog
       push @prolog, $_;
     }
-  }
+  } # while more lines in file
 
   if ($fh -> error) {
     die "Error while reading from \"$fn\": $!";
@@ -2862,6 +2888,18 @@
 
 Summarizes or reformats BitKeeper ChangeLogs for Linux Kernel 2.X.
 
+Addresses of patch authors are determined with the following precedence:
+
+=over
+
+=item 1. From: line
+
+=item 2. Signed-off-by
+
+=item 3. BK user/host
+
+=back
+
 --mode options are:
 
 =over
@@ -2900,6 +2938,11 @@
 set in this variable on the command line. B<Example:> If you put
 --swap here and --noswap on your command line, --noswap takes
 precedence.
+
+=item LINUXKERNEL_BK_FMT_DEBUG
+
+If this evaluates to "true" when used as Perl expression, i. e. it is a
+nonempty string or a number other than 0, enable debugging.
 
 =back
 

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.201
## Wrapped with gzip_uu ##


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
,]M3Y"R"5FU/"#P  
 

