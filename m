Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbUC3OG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbUC3OG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:06:59 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:32711 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263667AbUC3OFj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:05:39 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Mar_30_14_05_34_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040330140534.02804A9330@merlin.emma.line.org>
Date: Tue, 30 Mar 2004 16:05:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.147, 2004-03-30 16:04:52+02:00, matthias.andree@gmx.de
  Bugfix: do not abbreviate last name in the presence of ()-style comments
  Bugfix: Ignore ()-style comments in by-surname sort.
  Bugfix: Emit unabbreviated names in could-be-added list.
  Cleanup: Fix warning when abbreviate_name is called with empty input.

ChangeSet@1.146, 2004-03-30 15:45:31+02:00, matthias.andree@gmx.de
  Feature: harvest unknown addresses from From: lines with the log and
  print them at the end. Suggested by vita.
  Feature: if the name is of the form Last, First (Comment), it will be
  normalized to First Last (Comment); the Comment is optional.
  Feature: Strip double quote marks from addresses in From: lines.
  Commited patch made by vita.
(1.146 is missing from the patch below)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   32 +++++++++++++++++++++-----------
# 1 files changed, 21 insertions(+), 11 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/30 16:04:52+02:00 matthias.andree@gmx.de 
#   Bugfix: do not abbreviate last name in the presence of ()-style comments
#   Bugfix: Ignore ()-style comments in by-surname sort.
#   Bugfix: Emit unabbreviated names in could-be-added list.
#   Cleanup: Fix warning when abbreviate_name is called with empty input.
# 
# shortlog
#   2004/03/30 16:04:52+02:00 matthias.andree@gmx.de +21 -11
#   Bugfix: do not abbreviate last name in the presence of ()-style comments
#   Bugfix: Ignore ()-style comments in by-surname sort.
#   Bugfix: Emit unabbreviated names in could-be-added list.
#   Cleanup: Fix warning when abbreviate_name is called with empty input.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Mar 30 16:05:34 2004
+++ b/shortlog	Tue Mar 30 16:05:34 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.256 2004/03/30 13:45:30 emma Exp $
+# $Id: lk-changelog.pl,v 0.257 2004/03/30 14:04:33 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -1728,8 +1728,8 @@
 sub caseicmpbysurname {
   my $alast = "";
   my $blast = "";
-  if ($a =~ m/(\S+)\s*(\s\<|$)/) { $alast = $1; }
-  if ($b =~ m/(\S+)\s*(\s\<|$)/) { $blast = $1; }
+  if ($a =~ m/(\S+)\s*(\(.*\))?(\s\<|$)/) { $alast = $1; }
+  if ($b =~ m/(\S+)\s*(\(.*\))?(\s\<|$)/) { $blast = $1; }
   return uc($alast . $a) cmp uc($blast . $b);
 }
 
@@ -1981,13 +1981,16 @@
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
@@ -2081,6 +2084,13 @@
 	    $$name = "$2 $1";
 	    if (defined $3) { $$name .= " " . $3; }
 	}
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
@@ -2158,13 +2168,13 @@
     } elsif (/^\s+From:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
       $name = $1;
       $address = lc $2;
-      $author = treat_addr_name($address, $name);
-      print STDERR " FROM  $author\n" if $debug;
       if (rmap_address($address, 0) eq $address and $name =~ /\s+/) {
 	  # not found, but only add if two words or more in name.
 	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
 	    obfuscate $address, $name;
       }
+      $author = treat_addr_name($address, $name);
+      print STDERR " FROM  $author\n" if $debug;
     } elsif ($first) {
       # we have a "first" line after an address, take it, 
       # strip common redundant tags
@@ -2397,7 +2407,7 @@
       my $havebanner = 0;
     foreach (sort caseicmp keys %address_found_in_from) {
       if ($address_unknown{$_}) {
-	  print STDERR "Notice: these address mappings should be added:\n" unless $havebanner++;
+	  print STDERR "Notice: these address mappings should be added after clean-up:\n" unless $havebanner++;
 	  print STDERR $address_found_in_from{$_}, "\n" or write_error();
 	  delete $address_unknown{$_};
 	  delete $address_found_in_from{$_};
@@ -2405,7 +2415,7 @@
     }
   }
   if (scalar keys %address_found_in_from) {
-    print STDERR "Info: these address mappings could be added:\n";
+    print STDERR "Info: these address mappings could be added after clean-up:\n";
     foreach (sort caseicmp keys %address_found_in_from) {
       print STDERR $address_found_in_from{$_}, "\n" or write_error();
       delete $address_unknown{$_};

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.147
## Wrapped with gzip_uu ##


M'XL( *Y^:4   ^U6:V_;-A3];/V*BT0!Y+B223W\2KVE>70SVJZ%LP[#XB2@
M)=H6(E&&2"4.YNZW[Y)RW@NV[O%MEF!*Y+WGW,<A[6WX+'DY:.1,J47*I,=$
M4G)N;</WA52#QCQ?>8E^'1<%OK9E)7G[DI>"9^V#=WB[]8NKBB*3%AI^8BI>
MP!4OY:!!O>!N1MTL^: Q/O[N\_LW8\L:#N%PP<2<GW %PZ&EBO**98G<7W(Q
MKU+AJ9()F7/%O+C(UW>V:Y\0'R_J!Z03]==^OQ-%:^[S*(I#RJ;=7I?'OO4D
MG_TZC\<P(0D"0H,P"N@:\2BQCH!Z-.P""=LD: <$:&= PD'DMX@_( 3^&!5:
M%%QB'<"_G,.A%<-!-9^EJP$D!8A" 9M.2WZ5,L4A8U*!8#F'5(!:<%B67'(1
M<RAFX#1=J6XR#LB;<Z'D ZC17!0E?VZB<:8WKJQ*@RJ+4GD/W([S5$$E[B-(
M#+MQBXLJ2]PI=UF2X'R62N-ZF'$FJN4 WJ8KN&:E2,4<KA=</,CCHDY!0LRR
M#'VO4[4 GB_5#0(O*\1Y!Y3V ^O3O5XL]RL_ED48L;ZY;]"BR/F3[L@%)IP5
M\[HY$>V1;MBEO75 N_UH/>-]-HN[I,\(3]@T>4$*CU!J?84DC/PUZ>"C4?VM
MQ2/1_^-X7A+\\WAJO8>=?N37>O?)5^O=1\%3^K_B_S/%&[5\!+>\7NG;7:'\
M;UOY-]1_1"E0:V2^M\$>)0/(+MW8= <1O67VZ@J(YT==T#JY%4.HQ1 $&%S.
MX'BU!!N1N@$%'[&Z@8\C0(JUMQD,?X.\[4Q.6LV)W'4FCK<[:3:_=29R\GIM
M-]M-^!5L9CHX!)ONP9=;U^E?<IT^<AW1?B_ 7 !*KK![V%IL5,:E!&?_ @#E
M"O;%*3EK[F'$_5X' N/3,S[;D*2J@%E1WHL%K?K$U$B/$5KI92>_ 3M%6K*G
MQ]=@;S/]U&IA4&BCL53)F<*?QYP)$%7.2Y9)8+)6ZY*52JM3M]S8F]FZ9*=V
M>J9S;Y^?CG[Z^?WAAZ.SEMW&B&O<Y_J_"_8Y4(MNH":.1ACY!.O3M1K&P#:"
MT\O.Z1OWES-=YY9S>HX5/MM]5'-=:ZNAX3%QQZY>@3UK8OJ.[>,C1>0'BYE>
MR6*P_<TT3FD6V3[WVNW;N0TYR&69"C6#K1W7HW)'PH[<0DQ-466:9^.@(T[X
M+!6X,^S ]+Z&\(:PA9>'LUH"C2_6D4\[1HLX=HT6#2.K%.X4I#2=N< -6IHM
MAY7"1]0(LNGW3:4!3&1P\N/1\7B,#&_''S_<P4S$E@[)3OBTFJ.8_) 8F6S&
MQE/O'PJ5QGR@CR?)84.(Y^ARB2>!U'L8SPV8FB7,D,T41Q7J4\/%8T.S;71L
M+]@5GS(A>-EJU<2]#7&MXJ?,(S$K7N2-_XQV[_ZO6[S@\:6L\F$OHCR9^8GU
).Y9/+-(E"@  
 

