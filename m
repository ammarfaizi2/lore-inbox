Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbTCZVKX>; Wed, 26 Mar 2003 16:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262542AbTCZVKW>; Wed, 26 Mar 2003 16:10:22 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41988 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262561AbTCZVKM> convert rfc822-to-8bit; Wed, 26 Mar 2003 16:10:12 -0500
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Mar_26_21_21_21_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030326212121.DB7C458C49@merlin.emma.line.org>
Date: Wed, 26 Mar 2003 22:21:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
  Update to upstream version 0.88:
  * Add regexp support for address -> name resolution. (0.86)
  * Add selftest mode to figure addresses that can be removed because they
    are also matched by regexps (0.88).

Matthias
##### DIFFSTAT #####
# shortlog |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
# 1 files changed, 66 insertions(+), 11 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.43    -> 1.44   
#	            shortlog	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/26	matthias.andree@gmx.de	1.44
# Update to upstream version 0.88:
# * Add regexp support for address -> name resolution. (0.86)
# * Add selftest mode to figure addresses that can be removed because they
#   are also matched by regexps (0.88).
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Mar 26 22:21:21 2003
+++ b/shortlog	Wed Mar 26 22:21:21 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.85 2003/03/26 08:22:11 vita Exp $
+# $Id: lk-changelog.pl,v 0.88 2003/03/26 21:12:23 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -53,6 +53,8 @@
 use Text::Tabs;
 use Text::Wrap;
 
+sub selftest();
+
 # --------------------------------------------------------------------
 # customize the following line to change the indentation of the change
 # lines, $indent1 is used for the first line of an entry, $indent for
@@ -63,6 +65,11 @@
 my $debug = 0;
 # --------------------------------------------------------------------
 
+# Perl syntax magic here, "=>" is equivalent to ","
+my @addrregexps = (
+[ 'alan@.*\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
+[ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' => '~~~~~~~~' ]);
+
 # the key is the email address in ALL LOWER CAPS!
 # the value is the real name of the person
 #
@@ -101,8 +108,6 @@
 'akpm@digeo.com' => 'Andrew Morton',
 'akpm@zip.com.au' => 'Andrew Morton',
 'akropel1@rochester.rr.com' => 'Adam Kropelin', # lbdb
-'alan@hraefn.swansea.linux.org.uk' => 'Alan Cox',
-'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan@redhat.com' => 'Alan Cox',
 'alex@ssi.bg' => 'Alexander Atanasov',
@@ -889,12 +894,27 @@
 
 my %address_unknown;
 
-# get name associated to an email address
-sub rmap_address {
-  my @o = map {defined $addresses{$_} ? $addresses{$_} :
-		 scalar (($address_unknown{$_} = 1), $_); }
-          map { lc; } @_;
-  return wantarray ? @o : $o[0];
+# get name associated with an "email address" formatted
+# BK_USER,BK_HOST tuple
+sub rmap_address($) {
+    my $in = shift;
+    my $key = lc $in;
+    # try hash lookup first, return result if any
+    if (defined $addresses{$key}) {
+	return $addresses{$key};
+    }
+    # try matching against all regexps in listed order
+    # return result if any
+    foreach my $ar (@addrregexps) {
+	if ($in =~ m/$ar->[0]/) {
+	    return $ar->[1];
+	}
+    }
+    # when the address is unknown, return the unchanged input
+    # and mark the address as unknown (so it can be printed in --warn
+    # mode).
+    $address_unknown{$key} = 1;
+    return $in;
 }
 
 # case insensitive string comparison
@@ -1274,12 +1294,26 @@
   return print $opt{width} ? expand(wrap("", "", ($a))) : $a, "\n";
 }
 
+sub selftest() {
+    my $rc = 0;
+    foreach my $address (keys %addresses) {
+	foreach my $ar (@addrregexps) {
+	    if ($address =~ m/$ar->[0]/) {
+		print STDERR "Warning: address '$address'\n";
+		print STDERR "  shadows regexp '$ar->[0]'\n";
+		$rc = 1;
+	    }
+	}
+    }
+    return $rc;
+}
+
 # === MAIN PROGRAM ===============================================
 # Command line arguments
 # What options do we support?
 my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
 	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
-	    "by-surname!");
+	    "by-surname!", "selftest");
 #	    "bitkeeper|bk!");
 
 # How do we parse them?
@@ -1311,7 +1345,8 @@
   unless defined $table{$opt{mode}};
 pod2usage(-verbose => 0,
 	  -message => "$0: No files given, refusing to read from a TTY.")
-  if (not $opt{bitkeeper} and (@ARGV == 0) and (-t STDIN));
+  if (not $opt{selftest} and not $opt{bitkeeper}
+	  and (@ARGV == 0) and (-t STDIN));
 pod2usage(-verbose => 0,
 	  -message => "$0: Must have one or two arguments in --bitkeeper mode.")
   if ($opt{bitkeeper} && (@ARGV < 1 || @ARGV > 2));
@@ -1358,6 +1393,10 @@
   foreach (@ARGV) { print STDERR "DEBUG:   '$_'\n"; }
 }
 
+if ($opt{selftest}) {
+    exit selftest;
+}
+
 # Main program
 my @prolog;
 my %log;
@@ -1406,6 +1445,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.88  2003/03/26 21:12:23  emma
+# Add selftest mode check:
+# * check all addresses against all regexps to find addresses shadowing
+#   regular expressions.
+#
+# Revision 0.87  2003/03/26 21:02:53  emma
+# Fix broken regexp for Alan's swansea.linux.org.uk addresses. Add some comments.
+#
+# Revision 0.86  2003/03/26 20:57:49  emma
+# Support regexp queries (but try hash lookups first for efficiency).
+# Requested by Linus Torvalds.
+#
 # Revision 0.85  2003/03/26 08:22:11  vita
 # Added 6 names for new addresses.
 #
@@ -1737,6 +1788,8 @@
      --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.
                      text lines will not exceed this length.
 
+     --selftest      perform some self tests (for developers of this script)
+
 Warning: Neither --compress nor --count are currently functional with
 --mode=full.
 
@@ -1825,6 +1878,8 @@
 =head1 TODO
 
 =over
+
+=item * OBFUSCATE ADDRESSES (requested by Solar Designer)
 
 =item * --compress-me-harder
 

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.44
## Wrapped with gzip_uu ##


begin 600 bkpatch306
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
.V=VN;?P!I3`%1)P-````
`
end

