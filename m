Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVCWIdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVCWIdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVCWIdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:33:45 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:12756 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262874AbVCWIcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:32:05 -0500
Date: Wed, 23 Mar 2005 09:29:52 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH RFC] DocBook: use xmlto to process the DocBook files.
Message-ID: <20050323082952.GV8617@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s3kX86/NvBhlc9Gj"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s3kX86/NvBhlc9Gj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use xmlto to process the DocBook files.

xmlto uses standared XSLT templates to generate manpages, (x)html pages,
and XML FO files which can be processed with passivetex.
This is much faster than using jadetex for everything.
This patch also reduces the number of kernel-specific scripts that are need=
ed
to generate documentation.

---

The patch still needs some testing to ensure that everything is build
correctly. So please have a look at the documentation output.
I'll send patches for inclusion when I got some time for better testing
after my easter holidays.

 b/Documentation/Changes          |    8 -
 b/Documentation/DocBook/Makefile |   42 ++++----
 b/scripts/kernel-doc             |   47 ++++++++-
 scripts/makeman                  |  185 ----------------------------------=
-----
 scripts/split-man                |  112 -----------------------
 5 files changed, 63 insertions(+), 331 deletions(-)

diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	2005-03-18 11:51:17 +01:00
+++ b/Documentation/Changes	2005-03-18 11:51:17 +01:00
@@ -357,13 +357,13 @@
 ----------
 o  <http://sourceforge.net/projects/linuxquota/>
=20
-Jade
-----
-o  <ftp://ftp.jclark.com/pub/jade/jade-1.2.1.tar.gz>
-
 DocBook Stylesheets
 -------------------
 o  <http://nwalsh.com/docbook/dsssl/>
+
+XMLTO XSLT Frontend
+-------------------
+o  <http://cyberelk.net/tim/xmlto/>
=20
 Intel P6 microcode
 ------------------
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	2005-03-18 11:51:17 +01:00
+++ b/Documentation/DocBook/Makefile	2005-03-18 11:51:17 +01:00
@@ -42,14 +41,15 @@
 mandocs: $(MAN)
=20
 installmandocs: mandocs
-	$(MAKEMAN) install Documentation/DocBook/man
+	mkdir -p /usr/local/man/man9/
+	install Documentation/DocBook/man/*.9.gz /usr/local/man/man9/
=20
 ###
 #External programs used
 KERNELDOC =3D scripts/kernel-doc
 DOCPROC   =3D scripts/basic/docproc
-SPLITMAN  =3D $(PERL) $(srctree)/scripts/split-man
-MAKEMAN   =3D $(PERL) $(srctree)/scripts/makeman
+
+#XMLTOFLAGS =3D --skip-validation
=20
 ###
 # DOCPROC is used for two purposes:
@@ -96,29 +96,29 @@
 # Rules to generate postscript, PDF and HTML
 # db2html creates a directory. Generate a html file used for timestamp
=20
-quiet_cmd_db2ps =3D DB2PS   $@
-      cmd_db2ps =3D db2ps -o $(dir $@) $<
+quiet_cmd_db2ps =3D XMLTO    $@
+      cmd_db2ps =3D xmlto ps $(XMLTOFLAGS) -o $(dir $@) $<
 %.ps : %.xml
-	@(which db2ps > /dev/null 2>&1) || \
+	@(which xmlto > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	$(call cmd,db2ps)
=20
-quiet_cmd_db2pdf =3D DB2PDF  $@
-      cmd_db2pdf =3D db2pdf -o $(dir $@) $<
+quiet_cmd_db2pdf =3D XMLTO   $@
+      cmd_db2pdf =3D xmlto pdf $(XMLTOFLAGS) -o $(dir $@) $<
 %.pdf : %.xml
-	@(which db2pdf > /dev/null 2>&1) || \
+	@(which xmlto > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	$(call cmd,db2pdf)
=20
-quiet_cmd_db2html =3D DB2HTML $@
-      cmd_db2html =3D db2html -o $(patsubst %.html,%,$@) $< &&		      \
+quiet_cmd_db2html =3D XMLTO  $@
+      cmd_db2html =3D xmlto xhtml $(XMLTOFLAGS) -o $(patsubst %.html,%,$@)=
 $< && \
 		echo '<a HREF=3D"$(patsubst %.html,%,$(notdir $@))/book1.html"> \
          Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
=20
 %.html:	%.xml
-	@(which db2html > /dev/null 2>&1) || \
+	@(which xmlto > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	@rm -rf $@ $(patsubst %.html,%,$@)
@@ -126,15 +126,14 @@
 	@if [ ! -z "$(PNG-$(basename $(notdir $@)))" ]; then \
             cp $(PNG-$(basename $(notdir $@))) $(patsubst %.html,%,$@); fi
=20
-###
-# Rule to generate man files - output is placed in the man subdirectory
-
-%.9:	%.xml
-ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p $(objtree)/Documentation/DocBook/man
-endif
-	$(SPLITMAN) $< $(objtree)/Documentation/DocBook/man "$(VERSION).$(PATCHLE=
VEL).$(SUBLEVEL)"
-	$(MAKEMAN) convert $(objtree)/Documentation/DocBook/man $<
+quiet_cmd_db2man =3D XMLTO   $@
+      cmd_db2man =3D if grep -q refentry $<; then xmlto man $(XMLTOFLAGS) =
-o $(obj)/man $< ; gzip -f $(obj)/man/*.9; fi
+%.9 : %.xml
+	@(which xmlto > /dev/null 2>&1) || \
+	 (echo "*** You need to install DocBook stylesheets ***"; \
+	  exit 1)
+	$(call cmd,db2man)
+	@touch $@
=20
 ###
 # Rules to generate postscripts and PNG imgages from .fig format files
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	2005-03-18 11:51:17 +01:00
+++ b/scripts/kernel-doc	2005-03-18 11:51:17 +01:00
@@ -576,8 +581,14 @@
     $id =3D~ s/[^A-Za-z0-9]/-/g;
=20
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=3D\"$id\">".$args{'function'}."</phra=
se></refentrytitle>\n";
+    print " <refentrytitle><phrase id=3D\"$id\">".$args{'function'}."</phr=
ase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>".$args{'function'}."</refname>\n";
@@ -607,7 +618,7 @@
 	    }
 	}
     } else {
-	print "  <void>\n";
+	print "  <void/>\n";
     }
     print "  </funcprototype></funcsynopsis>\n";
     print "</refsynopsisdiv>\n";
@@ -646,8 +657,14 @@
     $id =3D~ s/[^A-Za-z0-9]/-/g;
=20
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=3D\"$id\">".$args{'type'}." ".$args{'=
struct'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=3D\"$id\">".$args{'type'}." ".$args{=
'struct'}."</phrase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>".$args{'type'}." ".$args{'struct'}."</refname>\n";
@@ -724,8 +741,14 @@
     $id =3D~ s/[^A-Za-z0-9]/-/g;
=20
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=3D\"$id\">enum ".$args{'enum'}."</phr=
ase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=3D\"$id\">enum ".$args{'enum'}."</ph=
rase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>enum ".$args{'enum'}."</refname>\n";
@@ -784,8 +807,14 @@
     $id =3D~ s/[^A-Za-z0-9]/-/g;
=20
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=3D\"$id\">typedef ".$args{'typedef'}.=
"</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=3D\"$id\">typedef ".$args{'typedef'}=
=2E"</phrase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>typedef ".$args{'typedef'}."</refname>\n";
diff -Nru a/scripts/makeman b/scripts/makeman
--- a/scripts/makeman	2005-03-18 11:51:17 +01:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,185 +0,0 @@
-#!/usr/bin/perl
-
-use strict;
-
-## Copyright (C) Michael Still (mikal@stillhq.com)
-## Released under the terms of the GNU GPL
-##
-## A script to make or install the manpages extracted by split-man
-##
-## Arguements: $1 -- the word "convert" or "install"
-##             $2 -- the directory containing the SGML files for the manpa=
ges
-##             $3 -- the filename which contained the sgmldoc output
-##                     (I need this so I know which manpages to convert)
-
-my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename, $tmpdi=
r);
-
-if($ARGV[0] eq ""){
-  die "Usage: makeman [convert | install] <dir> <file>\n";
-}
-
-if( ! -d "$ARGV[1]" ){
-  die "Output directory \"$ARGV[1]\" does not exist\n";
-}
-
-if($ENV{"TMPDIR"} ne ""){
-  $tmpdir =3D $ENV{"TMPDIR"};
-}
-else{
-  $tmpdir =3D "/tmp";
-}
-
-if($ARGV[0] eq "convert"){
-  open LISTING, "grep \"<refentrytitle>\" $ARGV[2] |";
-  while(<LISTING>){
-    s/<\/.*$//;
-    s/^.*>//;
-    s/\.sgml//;
-    s/struct //;
-    s/typedef //;
-
-    chomp;
-    $filename =3D $_;
-    print "Processing $filename\n";
-
-    # Open the input file to extract the front matter, generate the man pa=
ge,
-    # and open it, and the rearrange everything until it is happy
-    open INPUT, "< $ARGV[1]/$filename.sgml";
-    $front =3D "";
-    $mode =3D 0;
-
-    # The modes used here are:
-    #                                                         mode =3D 0
-    # <!-- BEGINFRONTTAG -->
-    # <!-- <bookinfo>                                         mode =3D 1
-    # <!--   <legalnotice>                                    mode =3D 2
-    # <!--     ...GPL or whatever...
-    # <!--   </legalnotice>                                   mode =3D 4
-    # <!-- </bookinfo>                                        mode =3D 3
-    # <!-- ENDFRONTTAG -->
-    #
-    # ...doco...
-
-    # I know that some of the if statements in this while loop are in a fu=
nny
-    # order, but that is deliberate...
-    while(<INPUT>){
-      if($mode > 0){
-	s/<!-- //;
-	s/ -->//;
-	s/<docinfo>//i;
-	s<\/docinfo>//i;
-	s/^[ \t]*//i;
-      }
-
-      if($mode =3D=3D 2){
-	if(/<para>/i){
-	}
-	elsif(/<\/para>/i){
-	  $front =3D "$front.\\\" \n";
-	}
-	elsif(/<\/legalnotice>/i){
-	  $mode =3D 4;
-	}
-	elsif(/^[ \t]*$/){
-	}
-	else{
-	  $front =3D "$front.\\\"     $_";
-	}
-      }
-
-      if($mode =3D=3D 1){
-	if(/<title>(.*)<\/title>/i){
-	  $front =3D "$front.\\\" This documentation was generated from the book =
titled \"$1\", which is part of the Linux kernel source.\n.\\\" \n";
-	}
-	elsif(/<legalnotice>/i){
-	  $front =3D "$front.\\\" This documentation comes with the following leg=
al notice:\n.\\\" \n";
-	  $mode =3D 2;
-	}
-
-	elsif(/<author>/i){
-	  $front =3D "$front.\\\" Documentation by: ";
-	}
-	elsif(/<firstname>(.*)<\/firstname>/i){
-	  $front =3D "$front$1 ";
-	}
-	elsif(/<surname>(.*)<\/surname>/i){
-	  $front =3D "$front$1 ";
-	}
-	elsif(/<email>(.*)<\/email>/i){
-	  $front =3D "$front($1)";
-	}
-	elsif(/\/author>/i){
-	  $front =3D "$front\n";
-	}
-
-	elsif(/<copyright>/i){
-	  $front =3D "$front.\\\" Documentation copyright: ";
-	}
-	elsif(/<holder>(.*)<\/holder>/i){
-	  $front =3D "$front$1 ";
-	}
-	elsif(/<year>(.*)<\/year>/i){
-	  $front =3D "$front$1 ";
-	}
-	elsif(/\/copyright>/i){
-	  $front =3D "$front\n";
-	}
-
-	elsif(/^[ \t]*$/
-	      || /<affiliation>/i
-	      || /<\/affiliation>/i
-	      || /<address>/i
-	      || /<\/address>/i
-	      || /<authorgroup>/i
-	      || /<\/authorgroup>/i
-	      || /<\/legalnotice>/i
-              || /<date>/i
-              || /<\/date>/i
-              || /<edition>/i
-              || /<\/edition>/i
-	      || /<pubdate>/i
-	      || /<\/pubdate>/i){
-	}
-	else{
-	  print "Unknown tag in manpage conversion: $_";
-	  }
-      }
-
-      if($mode =3D=3D 0){
-	if(/<bookinfo>/i){
-	  $mode =3D 1;
-	}
-      }
-
-      if($mode =3D=3D 4){
-	if(/<\/bookinfo>/i){
-	  $mode =3D 3;
-	}
-      }
-    }
-    close INPUT;
-
-    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 $tmpdi=
r/$$.9\n");
-    open GENERATED, "< $tmpdir/$$.9";
-    open OUTPUT, "> $ARGV[1]/$filename.9";
-
-    print OUTPUT "$front";
-    print OUTPUT ".\\\" For comments on the formatting of this manpage, pl=
ease contact Michael Still <mikal\@stillhq.com>\n\n";
-    while(<GENERATED>){
-      print OUTPUT "$_";
-    }
-    close OUTPUT;
-    close GENERATED;
-
-    system("gzip -f $ARGV[1]/$filename.9\n");
-    unlink("$tmpdir/$$.9");
-  }
-}
-elsif($ARGV[0] eq "install"){
-  system("mkdir -p /usr/local/man/man9/; install $ARGV[1]/*.9.gz /usr/loca=
l/man/man9/");
-}
-else{
-  die "Usage: makeman [convert | install] <dir> <file>\n";
-}
-
-print "Done\n";
diff -Nru a/scripts/split-man b/scripts/split-man
--- a/scripts/split-man	2005-03-18 11:51:17 +01:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,112 +0,0 @@
-#!/usr/bin/perl
-
-use strict;
-
-## Copyright (C) Michael Still (mikal@stillhq.com)
-## Released under the terms of the GNU GPL
-##
-## Hoon through the specified DocBook SGML file, and split out the
-## man pages. These can then be processed into groff format, and
-## installed if desired...
-##
-## Arguements: $1 -- the name of the sgml file
-##             $2 -- the directory to put the generated SGML files in
-##             $3 -- kernel version
-
-my($SGML, $REF, $front, $refdata, $mode, $filename);
-
-if(($ARGV[0] eq "") || ($ARGV[1] eq "") || ($ARGV[2] eq "")){
-  die "Usage: split-man <sgml file> <output dir> <kernel version>\n";
-}
-
-open SGML, "< $ARGV[0]" or die "Could not open input file \"$ARGV[0]\"\n";
-if( ! -d "$ARGV[1]" ){
-  die "Output directory \"$ARGV[1]\" does not exist\n";
-}
-
-# Possible modes:
-#   0: Looking for input I care about
-#   1: Inside book front matter
-#   2: Inside a refentry
-#   3: Inside a refentry, and we know the filename
-
-$mode =3D 0;
-$refdata =3D "";
-$front =3D "";
-while(<SGML>){
-  # Starting modes
-  if(/<bookinfo>/ || /<docinfo>/){
-    $mode =3D 1;
-  }
-  elsif(/<refentry>/){
-    $mode =3D 2;
-  }
-  elsif(/<refentrytitle><phrase[^>]*>([^<]*)<.*$/){
-    $mode =3D 3;
-    $filename =3D $1;
-
-    $filename =3D~ s/struct //;
-    $filename =3D~ s/typedef //;
-
-    print "Found manpage for $filename\n";
-    open REF, "> $ARGV[1]/$filename.sgml" or
-      die "Couldn't open output file \"$ARGV[1]/$filename.sgml\": $!\n";
-    print REF <<EOF;
-<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook V4.1//EN">
-
-<!-- BEGINFRONTTAG: The following is front matter for the parent book -->
-$front
-<!-- ENDFRONTTAG: End front matter -->
-
-$refdata
-EOF
-    $refdata =3D "";
-  }
-
-  # Extraction
-  if($mode =3D=3D 1){
-    chomp $_;
-    $front =3D "$front<!-- $_ -->\n";
-  }
-  elsif($mode =3D=3D 2){
-    $refdata =3D "$refdata$_";
-  }
-  elsif($mode =3D=3D 3){
-    # There are some fixups which need to be applied
-    if(/<\/refmeta>/){
-      print REF "<manvolnum>9</manvolnum>\n";
-    }
-    if(/<\/refentry>/){
-      print REF <<EOF;
-<refsect1><title>About this document</title>
-<para>
-This documentation was generated with kernel version $ARGV[2].
-</para>
-</refsect1>
-EOF
-    }
-
-    # For some reason, we title the synopsis twice in the main DocBook
-    if(! /<title>Synopsis<\/title>/){
-      if(/<refentrytitle>/){
-	s/struct //;
-	s/typedef //;
-      }
-
-      print REF "$_";
-    }
-  }
-
-  # Ending modes
-  if(/<\/bookinfo>/ || /<\/docinfo>/){
-    $mode =3D 0;
-  }
-  elsif(/<\/refentry>/){
-    $mode =3D 0;
-    close REF;
-  }
-}
-
-# And make sure we don't process this unnessesarily
-$ARGV[0] =3D~ s/\.sgml/.9/;
-`touch $ARGV[0]`;

--=20
Martin Waitz

--s3kX86/NvBhlc9Gj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCQSj/j/Eaxd/oD7IRApmcAJkBcF0Y5BCtSzY1zehlqcktdE2iqQCaA65S
gWxwmgd13GGmMHO7r6KcDI8=
=ccx2
-----END PGP SIGNATURE-----

--s3kX86/NvBhlc9Gj--
