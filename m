Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbTC1KtW>; Fri, 28 Mar 2003 05:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262911AbTC1KtW>; Fri, 28 Mar 2003 05:49:22 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:45071 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262905AbTC1KtN> convert rfc822-to-8bit; Fri, 28 Mar 2003 05:49:13 -0500
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Mar_28_11_00_26_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030328110026.DD4E2484CB@merlin.emma.line.org>
Date: Fri, 28 Mar 2003 12:00:26 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
* Add one address.
* Strip $0 down to POSIX portable file name character set and untaint it
  to suppress warnings with Perl 5.8.0 and --man.
* Reset $ENV{PATH} to /bin:/usr/bin:/usr/local/bin for the same reason.
* In usage information, path-strip $0 in addition to that (and store in
  $myname).
* Add --ignoremerge switch to suppress the "Merge ... into ..." log
  entries.

Matthias
##### DIFFSTAT #####
# shortlog |   43 +++++++++++++++++++++++++++++++++++--------
# 1 files changed, 35 insertions(+), 8 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.44    -> 1.45   
#	            shortlog	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/28	matthias.andree@gmx.de	1.45
# * Add one address.
# * Strip $0 down to POSIX portable file name character set and untaint it
#   to suppress warnings with Perl 5.8.0 and --man.
# * Reset $ENV{PATH} to /bin:/usr/bin:/usr/local/bin for the same reason.
# * In usage information, path-strip $0 in addition to that (and store in
#   $myname).
# * Add --ignoremerge switch to suppress the "Merge ... into ..." log
#   entries.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Mar 28 12:00:26 2003
+++ b/shortlog	Fri Mar 28 12:00:26 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.88 2003/03/26 21:12:23 emma Exp $
+# $Id: lk-changelog.pl,v 0.89 2003/03/28 10:55:39 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -561,6 +561,7 @@
 'mason@suse.com' => 'Chris Mason',
 'matt_domsch@dell.com' => 'Matt Domsch', # sent by himself
 'matthew@wil.cx' => 'Matthew Wilcox',
+'matthias.andree@gmx.de' => 'Matthias Andree', # added by himself
 'mauelshagen@sistina.com' => 'Heinz J. Mauelshagen',
 'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
 'maxk@viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
@@ -892,6 +893,7 @@
 
 sub doprint(\%@ ); # forward declaration
 
+my $myname;
 my %address_unknown;
 
 # get name associated with an "email address" formatted
@@ -977,8 +979,10 @@
 {
   my $log = shift;
   my @cur = @_;
+  my $re = qr'((http|bk|ssh)://.*|[-a-zA-Z0-9.@]+:\S+)';
   return unless @cur;
   return unless &$indexby;
+  return if $opt{ignoremerge} and $cur[0] =~ m/Merge $re into $re/;
   $log->{&$indexby} = () unless defined $log->{&$indexby};
 
   # strip trailing blank lines
@@ -1213,7 +1217,7 @@
 	and m{^[^<[:space:]]} and not m{^ChangeSet@}) {
       # if we are in multi mode, if we encounter a non-address
       # left-justified line, flush all data and print the header. The
-      # defined $address trick lets this only trigger to switch back
+      # 'defined $address' trick lets this only trigger to switch back
       # from "log entry" to "prolog" mode
       append_item(%$log, @cur); @cur = ();
       doprint(%$log, @prolog);
@@ -1313,7 +1317,7 @@
 # What options do we support?
 my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
 	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
-	    "by-surname!", "selftest");
+	    "by-surname!", "selftest", "ignoremerge!");
 #	    "bitkeeper|bk!");
 
 # How do we parse them?
@@ -1325,13 +1329,24 @@
 $opt{mode} = 'grouped';
 $opt{warn} = 1;
 
+# set up proper environment
+$ENV{PATH} = '/bin:/usr/bin:/usr/local/bin';
+$0 =~ tr|-a-zA-Z0-9_./||cd;
+# untaint $0
+$0 =~ m/(.*)/;
+$0 = $1;
+# get a path-stripped version of $0 in $myname
+$0 =~ m/^(.*\/)?([^\/]+)$/;
+$myname = $2;
+$myname =~ tr/a-zA-Z0-9_.-//cd;
+
 # Parse from environment, temporarily storing the original @ARGV.
 if (defined $ENV{LINUXKERNEL_BK_FMT}) {
   my @savedargs = @ARGV;
   @ARGV = parse_line('\s+', 0, $ENV{LINUXKERNEL_BK_FMT});
   GetOptions(\%opt, @opts)
     or pod2usage(-verbose => 0,
-		 -message => $0 . ': error in $LINUXKERNEL_BK_FMT');
+		 -message => $myname . ': error in $LINUXKERNEL_BK_FMT');
   push @ARGV, @savedargs;
 }
 
@@ -1340,18 +1355,18 @@
 pod2usage(-verbose => 1) if $opt{help};
 pod2usage(-verbose => 2) if $opt{man};
 pod2usage(-verbose => 0,
-	  -message => ("$0: Unknown mode specified.\nValid modes are:\n    "
+	  -message => ("$myname: Unknown mode specified.\nValid modes are:\n    "
 		       . join(" ", sort keys %table) . "\n"))
   unless defined $table{$opt{mode}};
 pod2usage(-verbose => 0,
-	  -message => "$0: No files given, refusing to read from a TTY.")
+	  -message => "$myname: No files given, refusing to read from a TTY.")
   if (not $opt{selftest} and not $opt{bitkeeper}
 	  and (@ARGV == 0) and (-t STDIN));
 pod2usage(-verbose => 0,
-	  -message => "$0: Must have one or two arguments in --bitkeeper mode.")
+	  -message => "$myname: Must have one or two arguments in --bitkeeper mode.")
   if ($opt{bitkeeper} && (@ARGV < 1 || @ARGV > 2));
 pod2usage(-verbose => 0,
-	  -message => "$0: You cannot use --merge and --multi at the same time.")
+	  -message => "$myname: You cannot use --merge and --multi at the same time.")
   if ($opt{merge} and $opt{multi});
 
 # Shortcut for programmer convenience :-)
@@ -1445,6 +1460,16 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.89  2003/03/28 10:55:39  emma
+# * Add one address.
+# * Strip $0 down to POSIX portable file name character set and untaint it
+#   to suppress warnings with Perl 5.8.0 and --man.
+# * Reset $ENV{PATH} to /bin:/usr/bin:/usr/local/bin for the same reason.
+# * In usage information, path-strip $0 in addition to that (and store in
+#   $myname).
+# * Add --ignoremerge switch to suppress the "Merge ... into ..." log
+#   entries.
+#
 # Revision 0.88  2003/03/26 21:12:23  emma
 # Add selftest mode check:
 # * check all addresses against all regexps to find addresses shadowing
@@ -1783,6 +1808,8 @@
                      abbreviate all but the last name
      --[no]by-surname
                      sort entries by surname
+     --[no]ignoremerge
+                     suppress "Merge bk://..." changelogs.
 
      --mode=MODE     specify the output format (use --man to find out more)
      --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.45
## Wrapped with gzip_uu ##


begin 600 bkpatch6467
M'XL(`$HKA#X``^U7;5/;1A#^C'[%QO:,<4#ODE_$.`U):.,A$(:73%(@F;-T
MMC263JKN9*!1^MN[)]G&$&BG*9\Z%1K?Z73W[-[N\^R))IQQFGL;"1$BC`C7
M"`MR2I4FO$VY\#:FR;46R,?C-,5'G1><ZC.:,QKKK_;Q5NL'5:1IS!6<>$2$
M'\*<YMS;,#5[-2)N,NIM'._]<O9N]UA1AD-X'1(VI2=4P'"HB#2?DSC@+S/*
MID7$-)$3QA,JB.:G2;F:6UJ&8>&?:=E&UQV4UJ#KNB6UJ.OZCDG&O7Z/^I9R
M;S\OZWW<A;$-V^I:ICEP[-)U$5)Y`Z;FN&#8.MY6'TS+,PS/<+<,$SOP,"AL
MF:`:RBMXXBV\5GQX#KM!`"FC0`(TR;E6#9Z(/,J@94"07C&T"T?O3T8?(4MS
M0<8QA4F$/XPD%/R0Y,07-`>.<4:_H6""1$Q`)!`*Y&)>9)G$ABN2LXA-L1.)
M$(YH'H.K]36C6J>J"6&U^6,JP5I[AQ^^'NV>OOTF0?1QQ#R]X/EM)TY]$LM'
MF*0YB)`"ER[EE/!T@31B4'`RI1`QG(/QC5*V#1D1H<J7>\3UN/E(OI*&1$@$
M;$J/.`9<KJSVT4INY(8[VBIJJAI-&<Y(:(X&..Y)LG!MN]*CQD'U5M,T!,*7
MV&E`G$XK3,K0!XHQWP?7-?M]Y>B6LXKZ#R]%,8BAO+AE29@F]!Y%>(@91.LU
M0]"DT7-Z9K^TS=[`+2=T0"9^SQ@0@P9D'#S"QSLHDN-]TS0,PRD=Q^FZE?*6
M,^X([U_[\YCH[OM3:\XJK7[7[E::L\SO-.?\C>9L%]3^_Z+[3XNN)NQ[4/.K
M:WFKUZC`)9M^0(!O3!-,953]-J$U"CR(9ZI?4001M2S>GH.A]0<@F;KDH^&Y
MKF</@"8)@;UK#(\R<KLV8K0?)F<;AB^@?;!X![O5N_8V-&5(:0#C&PBCA--X
MHHSZ`P>!DIME*'>4T:`WP"$`.8BA'L)O>7MS,Q0B*\>SDO.PX^FZ]KP\5XGZ
M^Z[ZJZ$.M)>76][%R5:G+=?WS6I]3D61,X@FT$HS\74M+]\J;K7\(C\W+F'X
M!R1ZG9%6E5K,"';T'8R797:KB-4M5%<3V@&=1`QWTEH(I`V8,W\&,14RPQ%'
M]<0W<G`Z117(_-=,&!-_AK#V`K9N-R1J8WRC<O078_"LL0T-&1Y!N9#]-=>?
M-3H[<J'5`U,F46JBR"#+TPP-43:/\I0ER"%E32E#:/^54C!HR'@,@\C+VYA^
MT?2R](,=-+)4;\M83$ST3>UY1Z_70<N4DZ92ZFLJRC`^\BM(*BB=+#2UR/(*
MYC/B7.B=GS;//U_HEUN=EL2LYTA@:^U)NJ>O>:?JNO3N0H;3=NIP5NW&!J@)
M)D4J'(FX!-"@[0'-<ZP*TI%WH\.SC_M[QX=[[[Z\VO_R\\%INR,S;CMVC56U
MF)IUK,W&`LV#,S9CL@XF*59CGE$_FD0TT"[8!Q)'037,@>34NV!5>BOHW@*Z
M]SWT+?)A6I52#M-H3K$PY712<*R0DD98Q@*8Y&F"H3X]_:0U.A+7K65=MX_B
M'A1<0$CFM"KMLCA>I>CAM)!TX3(HJCJ.Q(Q2226Y@27\(KI5^RC\I[0`GS"6
M(B$YE96[DM2BBA>QB`!KZ*H@BRBI\$>F(\-AR$]L.H\JNE0EZ,$:5!4AG/K`
M$=5\NB.J^0-'5//)CJCFDQU1S3M'5/-)CJCF^A'5Q/3U^BY8=6E4U7.67JZA
M+RKFO6ME:&%D/),%71I8'46(O?K'R0^I/^-%,K0#Q\(/*%_Y$S;^F[^U#0``
`
end

