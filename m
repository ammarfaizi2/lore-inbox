Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbUC3BSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUC3BSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:18:15 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:33472 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263385AbUC3BSD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:18:03 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Mar_30_01_17_59_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040330011759.9713BA3783@merlin.emma.line.org>
Date: Tue, 30 Mar 2004 03:17:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

THIS IS AN IMPORTANT UPDATE FOR SHORTLOG!

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:

ChangeSet@1.145, 2004-03-30 03:16:56+02:00, matthias.andree@gmx.de
  Parse From: Firstname Lastname <email@address.invalid> to credit (or
  blame) the right person.

  Add Alain Knaff's address.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   58 +++++++++++++++++++++++++++----------------
# 1 files changed, 37 insertions(+), 21 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/30 03:16:56+02:00 matthias.andree@gmx.de 
#   Parse From: Firstname Lastname <email@address.invalid> to credit (or
#   blame) the right person.
#   Add Alain Knaff's address.
# 
# shortlog
#   2004/03/30 03:16:56+02:00 matthias.andree@gmx.de +37 -21
#   Parse From: Firstname Lastname <email@address.invalid> to credit (or
#   blame) the right person.
#   Add Alain Knaff's address.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Mar 30 03:17:59 2004
+++ b/shortlog	Tue Mar 30 03:17:59 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.254 2004/03/27 13:47:02 vita Exp $
+# $Id: lk-changelog.pl,v 0.255 2004/03/30 01:16:17 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -192,6 +192,7 @@
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'alain:linux.lu' => 'Alain Knaff',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
@@ -2061,6 +2062,34 @@
   return ();
 }
 
+sub treat_addr_name(\$\$) {
+    my ($address, $name) = @_;
+    my $havename = $$name ne $$address;
+    my $author;
+
+    if ($opt{'obfuscate'}) {
+	$$address = obfuscate $$address;
+    }
+
+    if ($havename) {
+	if ($opt{'abbreviate-names'}) {
+	    $$name = abbreviate_name($$name);
+	}
+	if ($opt{'omitaddresses'}) {
+	    $author = $$name;
+	} else {
+	    $author = $$name . ' <' . $$address . '>';
+	}
+    } else { # $havename
+	# must obfuscate name since it contains an address still
+	if ($opt{obfuscate}) {
+	    $$name = obfuscate $$name;
+	}
+	$author = '<' . $$address . '>';
+    }
+    return $author;
+}
+
 # Read a file and parse it into the %log hash.
 sub parse_file(\%$$ ) {
 # arguments: %log hash
@@ -2113,28 +2142,15 @@
       $address = lc($1);
       $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address);
-      my $havename = $name ne $address;
-      if ($opt{'obfuscate'}) {
-	$address = obfuscate $address;
-      }
-      if ($havename) {
-	if ($opt{'abbreviate-names'}) {
-	  $name = abbreviate_name($name);
-	}
-	if ($opt{'omitaddresses'}) {
-	  $author = $name;
-	} else {
-	  $author = $name . ' <' . $address . '>';
-	}
-      } else { # $havename
-	# must obfuscate name since it contains an address still
-	if ($opt{obfuscate}) {
-	    $name = obfuscate $name;
-	}
-	$author = '<' . $address . '>';
-      }
+      $author = treat_addr_name($address, $name);
+      print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
+    } elsif (/^\s+From:\s*(.*)\s+\<(.*)\>\s*$/) {
+      $name = $1;
+      $address = lc $2;
+      $author = treat_addr_name($address, $name);
+      print STDERR " FROM  $author\n" if $debug;
     } elsif ($first) {
       # we have a "first" line after an address, take it, 
       # strip common redundant tags

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.145
## Wrapped with gzip_uu ##


M'XL( ,?*:$   ]U676_:2!1]9G[%5;'DI EFQI]@0I2T2;91NDI%FS>TT6 /
M8,4>HYDQ2U7RWW=LL"$H>>C'TQK+S,>]9^XY]\AR&QXD$V$KHTK-$RHMRF/!
M&&K#IURJL#7+5E9<3D=YKJ==64C6?6*"L[3[X4[?G<VDH_(\E4@'?J$JFL.2
M"1FVB.4T*^K[@H6MT?5?#Y\O1P@-A_!Q3OF,?64*AD.D<K&D:2PO%HS/BH1;
M2E N,Z:H%>79NHE=VQC;^D=L!_M>?VWW?<];,YMY7N02.@EZ 8ML=,#G8L/C
M)8R+';N'L>.ZWEKCX0!= ;&(ZP%VN]CI.ABP$Q(_]/P3;(<8P^NH<$*@@]$'
M^,,</J)(:R<D@QN19R'<)$(J3C,&G^EV<,8RFJ07--;E2&DE7)^?Q.>Z$H@$
MBQ,%1[G0,)-41Q^#FC,0R6RN8*'[DW-+;UW&,5RF-.%PQ^ET:DJHT= =:%5Z
MZ,NN4ZCSDQ="F&)TOI-FGF?L0!<YSX5*\]E&%H_T<. &I+=V2-#WUE/6I],H
MP'V*64PG\1M->(&B.^M@3(CO^6OB![Y=^:V.>&&WWZ[G+:L=U+-UFKOV<&"[
M&Z>1WD\[S0F@8Y/_I]>J1MU#1_R[*N_.2CNO5O$7C'=%"!!T6SW;8-S&(:1/
MG:@21B-:B_1T"=BR/0_*%M5](&4?2  LRRA<KQ9@:(R^JT%,6I8>I@DO5E9:
MF# \!W.?SBFZM;'O@-U#LIB $HRJQY+A8RG@T=@8&\?P X&^LN]P9&S)GX+!
M*\F&</$XJ+>-.5VR2O@A&%4 <*9'VZ1='"V4%FF QM5*,M7 ^4+],//)M) 1
M5<Q\+D]M-:D:L-D[!'S>AZDKJ-)WP'0R$6R9Z.Q.N2NW^&7:MM A[&(VW#<;
MQP/4>MZ'RK-$;<]_B;,AU5 O\X"EVIYO!( %)IR9^F]'4R^=F]6)%;-M/K1W
MTJ)6&[)"JCT]*C"9\(B!=G24<Z7[JWW*:ZN"5$F:[I%H<E^185_GFH?N1%.\
M^7K)FTZ43\%4(?BNR65_KFS]9M.>U6XCCC9O%;@OR:'Q#HTVV&8L1,(5?/UV
M=3T:P;O+AV^?[D<US)B_*TU@Q&Q2S ;540%X.R5+^MU_QO*D>E^,Y?LCZ_VQ
MGH[/JL&Y7C&ZM=L!:D$,,FC*;=R81F#8@S]$ VY&]W_#&S2:KY%HSJ(G661#
0[/EQ;Q+YZ#_ZILOW"@D     
 

