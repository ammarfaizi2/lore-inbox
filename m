Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTCZVDO>; Wed, 26 Mar 2003 16:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTCZVDO>; Wed, 26 Mar 2003 16:03:14 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:38404 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262492AbTCZVDF>; Wed, 26 Mar 2003 16:03:05 -0500
Date: Wed, 26 Mar 2003 22:14:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       samel@mail.cz, ma@dt.e-technik.uni-dortmund.de
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030326211414.GA32316@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, samel@mail.cz
References: <20030326103036.064147C8DD@merlin.emma.line.org> <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Linus Torvalds wrote:

> I don't know whether you can force perl to do something like this, but if 
> somebody were to try...

How about this (search for 'Alan Cox' to see the syntax):

Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.85
retrieving revision 0.88
diff -u -r0.85 -r0.88
--- lk-changelog.pl	26 Mar 2003 08:22:11 -0000	0.85
+++ lk-changelog.pl	26 Mar 2003 21:12:23 -0000	0.88
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
 

-- 
Matthias Andree
