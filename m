Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUDAVz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUDAVvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:51:40 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:23425 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263307AbUDAVtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:49:16 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.258
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Apr__1_21_49_13_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040401214913.BA27D106E@merlin.emma.line.org>
Date: Thu,  1 Apr 2004 23:49:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.258 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://home.pages.de/~mandree/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.258
date: 2004/04/01 21:48:00;  author: emma;  state: Exp;  lines: +9 -3
If a From: header contains a known address, use the known name instead of the
name from the From: line, so as to have consistent names that can be grouped.
This fixes a report by Vita:
Maximilian Attems:
  o [NETFILTER]: Add MODULE_AUTHOR to ipchains_core.c

maximilian attems:
  o add warning to DocBook/Makefile
----------------------------
revision 0.257
date: 2004/03/30 14:04:33;  author: emma;  state: Exp;  lines: +21 -11
Bugfix: do not abbreviate last name in the presence of ()-style comments
Bugfix: Ignore ()-style comments in by-surname sort.
Bugfix: Emit unabbreviated names in could-be-added list.
Cleanup: Fix warning when abbreviate_name is called with empty input.
----------------------------
revision 0.256
date: 2004/03/30 13:45:30;  author: emma;  state: Exp;  lines: +42 -9
Feature: harvest unknown addresses from From: lines with the log and
print them at the end. Suggested by vita.
Feature: if the name is of the form Last, First (Comment), it will be
normalized to First Last (Comment); the Comment is optional.
Feature: Strip double quote marks from addresses in From: lines.
Commited patch made by vita.
----------------------------
revision 0.255
date: 2004/03/30 01:16:17;  author: emma;  state: Exp;  lines: +37 -21
Parse From: Firstname Lastname <email@address.invalid> to
credit (or blame) the right person.
Add Alain Knaff's address.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.255
diff -u -r0.255 lk-changelog.pl
--- lk-changelog.pl	30 Mar 2004 01:16:17 -0000	0.255
+++ lk-changelog.pl	1 Apr 2004 21:48:14 -0000
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.255 2004/03/30 01:16:17 emma Exp $
+# $Id: lk-changelog.pl,v 0.258 2004/04/01 21:48:00 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -1588,6 +1588,7 @@
 'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
 'vanl:megsinet.net' => 'Martin H. VanLeeuwen',
 'varenet:parisc-linux.org' => 'Thibaut Varene',
+'vatsa:in.ibm.com' => 'Srivatsa Vaddagiri',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vherva:niksula.hut.fi' => 'Ville Herva',
@@ -1686,11 +1687,14 @@
 
 my $myname;
 my %address_unknown;
+my %address_found_in_from;
 
 # get name associated with an "email address" formatted
 # BK_USER,BK_HOST tuple
-sub rmap_address($) {
+sub rmap_address($$) {
     my $in = shift;
+    my $markunknown = shift;
+
     confess "empty string passed to rmap_address" unless $in;
     my $key = lc $in;
     # try hash lookup first, return result if any
@@ -1707,7 +1711,9 @@
     # when the address is unknown, return the unchanged input
     # and mark the address as unknown (so it can be printed in --warn
     # mode).
-    $address_unknown{$key} = 1;
+    if ($markunknown) {
+	$address_unknown{$key} = 1;
+    }
     return $in;
 }
 
@@ -1723,8 +1729,8 @@
 sub caseicmpbysurname {
   my $alast = "";
   my $blast = "";
-  if ($a =~ m/(\S+)\s*(\s\<|$)/) { $alast = $1; }
-  if ($b =~ m/(\S+)\s*(\s\<|$)/) { $blast = $1; }
+  if ($a =~ m/(\S+)\s*(\(.*\))?(\s\<|$)/) { $alast = $1; }
+  if ($b =~ m/(\S+)\s*(\(.*\))?(\s\<|$)/) { $blast = $1; }
   return uc($alast . $a) cmp uc($blast . $b);
 }
 
@@ -1976,13 +1982,16 @@
 # Roman numerals form the last component, leave that and the previous
 # component alone.
 sub abbreviate_name($ ) {
+  return () unless (@_  and $_[0]);
   my @a = split /\s+/, $_[0];
 
-  # treat Roman numerals as last part of name
-  my $off = 0;
-  $off = 1 if ($a[$#a] =~ /^[IVXLCMD]+$/);
+  # dito for comments
 
-  for (my $i = 0; $i < $#a - $off; $i++) {
+  for (my $i = 0; $i < $#a; $i++) {
+    # treat Roman numerals as last part of name
+    last if ($a[$i] =~ /^[IVXLCMD]+$/);
+    # do not abbreviate comments
+    last if ($a[$i+1] =~ /^\(/);
     $a[$i] =~ s/^(.).*/$1./;
   }
   return join(" ", @a);
@@ -2004,7 +2013,7 @@
     if (/^<($nre)>:$/) {
       my $a = $1;
       if ($a =~ /:/) { $a = unveil($a); }
-      my $name = rmap_address($a);
+      my $name = rmap_address($a, 1);
       if ($name ne $a) { # found name
 	print "$name:\n";
       } else {
@@ -2016,7 +2025,7 @@
     if (/\s+\(($nre)\)$/) {
       my $a = $1;
       if ($a =~ /:/) { $a = unveil($a); }
-      my $name = rmap_address($a);
+      my $name = rmap_address($a, 1);
       if ($name ne $a) { # found name
 	s/\($nre\)$/$name/;
       }
@@ -2027,7 +2036,7 @@
     if (/^$indent1($nre): /) {
       my $a = $1;
       if ($a =~ /:/) { $a = unveil($a); }
-      my $name = rmap_address($a);
+      my $name = rmap_address($a, 1);
       if ($name ne $a) { # found name
 	s/^$indent1$nre:/$indent1$name:/;
       }
@@ -2053,7 +2062,7 @@
   while ($_ = $fh -> getline) {
       chomp;
       if (/($mre)/) {
-	  my $r = rmap_address($1);
+	  my $r = rmap_address($1, 1);
 	  s/$mre/$r/;
       }
       print "$_\n";
@@ -2072,6 +2081,17 @@
     }
 
     if ($havename) {
+	if ($$name =~ /([^,]+),\s*([^(\s]*)\s*(\(.*\))?/) {
+	    $$name = "$2 $1";
+	    if (defined $3) { $$name .= " " . $3; }
+	}
+	if ($$name =~ /([A-Z]+)\s+([^(\s]*)\s*(\(.*\))?/) {
+	    my ($u, $f) = ($2, $1);
+	    my ($ul) = lc $2;
+	    $ul =~ s/^.//;
+	    $$name = sprintf "%-.1s%s %s", $u, $ul, $f;
+	    if (defined $3) { $$name .= " " . $3; }
+	}
 	if ($opt{'abbreviate-names'}) {
 	    $$name = abbreviate_name($$name);
 	}
@@ -2141,14 +2161,24 @@
       append_item(%$log, @cur); @cur = ();
       $address = lc($1);
       $address =~ s/\[[^]]+\]$//;
-      $name = rmap_address($address);
+      $name = rmap_address($address, 1);
       $author = treat_addr_name($address, $name);
       print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
-    } elsif (/^\s+From:\s*(.*)\s+\<(.*)\>\s*$/) {
+    } elsif (/^\s+From:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
+      my $tmp;
       $name = $1;
       $address = lc $2;
+      if (($tmp = rmap_address($address, 0)) eq $address) {
+	if ($name =~ /\s+/) {
+	  # not found, but only add if two words or more in name.
+	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
+	  obfuscate $address, $name;
+	}
+      } else {
+	$name = $tmp;
+      }
       $author = treat_addr_name($address, $name);
       print STDERR " FROM  $author\n" if $debug;
     } elsif ($first) {
@@ -2379,6 +2409,25 @@
 
 # Warn about unknown addresses
 if ($opt{warn}) {
+  if (scalar keys %address_found_in_from) {
+      my $havebanner = 0;
+    foreach (sort caseicmp keys %address_found_in_from) {
+      if ($address_unknown{$_}) {
+	  print STDERR "Notice: these address mappings should be added after clean-up:\n" unless $havebanner++;
+	  print STDERR $address_found_in_from{$_}, "\n" or write_error();
+	  delete $address_unknown{$_};
+	  delete $address_found_in_from{$_};
+      }
+    }
+  }
+  if (scalar keys %address_found_in_from) {
+    print STDERR "Info: these address mappings could be added after clean-up:\n";
+    foreach (sort caseicmp keys %address_found_in_from) {
+      print STDERR $address_found_in_from{$_}, "\n" or write_error();
+      delete $address_unknown{$_};
+      delete $address_found_in_from{$_};
+    }
+  }
   foreach (sort caseicmp keys %address_unknown) {
     print STDERR "Warning: unknown address \"$_\"\n" or write_error();
   }

