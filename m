Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVDFMB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVDFMB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVDFMBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:01:55 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:62911 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262173AbVDFLrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:47:19 -0400
Message-Id: <20050406114655.527974000@faui31y>
References: <20050406114610.287064000@faui31y>
Date: Wed, 06 Apr 2005 13:46:16 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 6/6] DocBook: Use xmlto to process the DocBook files.
Content-Disposition: inline; filename=docbook-use-xmlto.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: Use xmlto to process the DocBook files.

xmlto uses standared XSLT templates to generate manpages, (x)html pages,
and XML FO files which can be processed with passivetex.
This is much faster than using jadetex for everything.
This patch also reduces the number of kernel-specific scripts that are needed
to generate documentation.

Signed-off-by: Martin Waitz <tali@admingilde.org>

 scripts/makeman                |  185 -----------------------------------------
 scripts/split-man              |  112 ------------------------
 Documentation/Changes          |    8 -
 Documentation/DocBook/Makefile |   42 ++++-----
 scripts/kernel-doc             |   32 ++++++-
 5 files changed, 53 insertions(+), 326 deletions(-)

Index: linux-docbook/Documentation/Changes
===================================================================
--- linux-docbook.orig/Documentation/Changes	2005-04-06 12:12:34.750567521 +0200
+++ linux-docbook/Documentation/Changes	2005-04-06 12:25:20.551727922 +0200
@@ -357,14 +357,14 @@ Quota-tools
 ----------
 o  <http://sourceforge.net/projects/linuxquota/>
 
-Jade
-----
-o  <ftp://ftp.jclark.com/pub/jade/jade-1.2.1.tar.gz>
-
 DocBook Stylesheets
 -------------------
 o  <http://nwalsh.com/docbook/dsssl/>
 
+XMLTO XSLT Frontend
+-------------------
+o  <http://cyberelk.net/tim/xmlto/>
+
 Intel P6 microcode
 ------------------
 o  <http://www.urbanmyth.org/microcode/>
Index: linux-docbook/Documentation/DocBook/Makefile
===================================================================
--- linux-docbook.orig/Documentation/DocBook/Makefile	2005-04-06 12:25:19.150939983 +0200
+++ linux-docbook/Documentation/DocBook/Makefile	2005-04-06 12:25:20.552727770 +0200
@@ -41,14 +41,15 @@ MAN := $(patsubst %.xml, %.9, $(BOOKS))
 mandocs: $(MAN)
 
 installmandocs: mandocs
-	$(MAKEMAN) install Documentation/DocBook/man
+	mkdir -p /usr/local/man/man9/
+	install Documentation/DocBook/man/*.9.gz /usr/local/man/man9/
 
 ###
 #External programs used
 KERNELDOC = scripts/kernel-doc
 DOCPROC   = scripts/basic/docproc
-SPLITMAN  = $(PERL) $(srctree)/scripts/split-man
-MAKEMAN   = $(PERL) $(srctree)/scripts/makeman
+
+#XMLTOFLAGS = --skip-validation
 
 ###
 # DOCPROC is used for two purposes:
@@ -95,29 +96,29 @@ $(obj)/procfs-guide.xml: $(C-procfs-exam
 # Rules to generate postscript, PDF and HTML
 # db2html creates a directory. Generate a html file used for timestamp
 
-quiet_cmd_db2ps = DB2PS   $@
-      cmd_db2ps = db2ps -o $(dir $@) $<
+quiet_cmd_db2ps = XMLTO    $@
+      cmd_db2ps = xmlto ps $(XMLTOFLAGS) -o $(dir $@) $<
 %.ps : %.xml
-	@(which db2ps > /dev/null 2>&1) || \
+	@(which xmlto > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	$(call cmd,db2ps)
 
-quiet_cmd_db2pdf = DB2PDF  $@
-      cmd_db2pdf = db2pdf -o $(dir $@) $<
+quiet_cmd_db2pdf = XMLTO   $@
+      cmd_db2pdf = xmlto pdf $(XMLTOFLAGS) -o $(dir $@) $<
 %.pdf : %.xml
-	@(which db2pdf > /dev/null 2>&1) || \
+	@(which xmlto > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	$(call cmd,db2pdf)
 
-quiet_cmd_db2html = DB2HTML $@
-      cmd_db2html = db2html -o $(patsubst %.html,%,$@) $< &&		      \
+quiet_cmd_db2html = XMLTO  $@
+      cmd_db2html = xmlto xhtml $(XMLTOFLAGS) -o $(patsubst %.html,%,$@) $< && \
 		echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html"> \
          Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
 
 %.html:	%.xml
-	@(which db2html > /dev/null 2>&1) || \
+	@(which xmlto > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	@rm -rf $@ $(patsubst %.html,%,$@)
@@ -125,15 +126,14 @@ quiet_cmd_db2html = DB2HTML $@
 	@if [ ! -z "$(PNG-$(basename $(notdir $@)))" ]; then \
             cp $(PNG-$(basename $(notdir $@))) $(patsubst %.html,%,$@); fi
 
-###
-# Rule to generate man files - output is placed in the man subdirectory
-
-%.9:	%.xml
-ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p $(objtree)/Documentation/DocBook/man
-endif
-	$(SPLITMAN) $< $(objtree)/Documentation/DocBook/man "$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)"
-	$(MAKEMAN) convert $(objtree)/Documentation/DocBook/man $<
+quiet_cmd_db2man = XMLTO   $@
+      cmd_db2man = if grep -q refentry $<; then xmlto man $(XMLTOFLAGS) -o $(obj)/man $< ; gzip -f $(obj)/man/*.9; fi
+%.9 : %.xml
+	@(which xmlto > /dev/null 2>&1) || \
+	 (echo "*** You need to install DocBook stylesheets ***"; \
+	  exit 1)
+	$(call cmd,db2man)
+	@touch $@
 
 ###
 # Rules to generate postscripts and PNG imgages from .fig format files
Index: linux-docbook/scripts/kernel-doc
===================================================================
--- linux-docbook.orig/scripts/kernel-doc	2005-04-06 12:25:17.867134335 +0200
+++ linux-docbook/scripts/kernel-doc	2005-04-06 12:25:20.555727316 +0200
@@ -581,8 +581,14 @@ sub output_function_xml(%) {
     $id =~ s/[^A-Za-z0-9]/-/g;
 
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=\"$id\">".$args{'function'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=\"$id\">".$args{'function'}."</phrase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>".$args{'function'}."</refname>\n";
@@ -651,8 +657,14 @@ sub output_struct_xml(%) {
     $id =~ s/[^A-Za-z0-9]/-/g;
 
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=\"$id\">".$args{'type'}." ".$args{'struct'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=\"$id\">".$args{'type'}." ".$args{'struct'}."</phrase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>".$args{'type'}." ".$args{'struct'}."</refname>\n";
@@ -729,8 +741,14 @@ sub output_enum_xml(%) {
     $id =~ s/[^A-Za-z0-9]/-/g;
 
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=\"$id\">enum ".$args{'enum'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=\"$id\">enum ".$args{'enum'}."</phrase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>enum ".$args{'enum'}."</refname>\n";
@@ -789,8 +807,14 @@ sub output_typedef_xml(%) {
     $id =~ s/[^A-Za-z0-9]/-/g;
 
     print "<refentry>\n";
+    print "<refentryinfo>\n";
+    print " <title>LINUX</title>\n";
+    print " <productname>Kernel Hackers Manual</productname>\n";
+    print " <date>$man_date</date>\n";
+    print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print "<refentrytitle><phrase id=\"$id\">typedef ".$args{'typedef'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase id=\"$id\">typedef ".$args{'typedef'}."</phrase></refentrytitle>\n";
+    print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
     print " <refname>typedef ".$args{'typedef'}."</refname>\n";
Index: linux-docbook/scripts/makeman
===================================================================
--- linux-docbook.orig/scripts/makeman	2005-04-06 12:12:34.753567067 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
-##             $2 -- the directory containing the SGML files for the manpages
-##             $3 -- the filename which contained the sgmldoc output
-##                     (I need this so I know which manpages to convert)
-
-my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename, $tmpdir);
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
-  $tmpdir = $ENV{"TMPDIR"};
-}
-else{
-  $tmpdir = "/tmp";
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
-    $filename = $_;
-    print "Processing $filename\n";
-
-    # Open the input file to extract the front matter, generate the man page,
-    # and open it, and the rearrange everything until it is happy
-    open INPUT, "< $ARGV[1]/$filename.sgml";
-    $front = "";
-    $mode = 0;
-
-    # The modes used here are:
-    #                                                         mode = 0
-    # <!-- BEGINFRONTTAG -->
-    # <!-- <bookinfo>                                         mode = 1
-    # <!--   <legalnotice>                                    mode = 2
-    # <!--     ...GPL or whatever...
-    # <!--   </legalnotice>                                   mode = 4
-    # <!-- </bookinfo>                                        mode = 3
-    # <!-- ENDFRONTTAG -->
-    #
-    # ...doco...
-
-    # I know that some of the if statements in this while loop are in a funny
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
-      if($mode == 2){
-	if(/<para>/i){
-	}
-	elsif(/<\/para>/i){
-	  $front = "$front.\\\" \n";
-	}
-	elsif(/<\/legalnotice>/i){
-	  $mode = 4;
-	}
-	elsif(/^[ \t]*$/){
-	}
-	else{
-	  $front = "$front.\\\"     $_";
-	}
-      }
-
-      if($mode == 1){
-	if(/<title>(.*)<\/title>/i){
-	  $front = "$front.\\\" This documentation was generated from the book titled \"$1\", which is part of the Linux kernel source.\n.\\\" \n";
-	}
-	elsif(/<legalnotice>/i){
-	  $front = "$front.\\\" This documentation comes with the following legal notice:\n.\\\" \n";
-	  $mode = 2;
-	}
-
-	elsif(/<author>/i){
-	  $front = "$front.\\\" Documentation by: ";
-	}
-	elsif(/<firstname>(.*)<\/firstname>/i){
-	  $front = "$front$1 ";
-	}
-	elsif(/<surname>(.*)<\/surname>/i){
-	  $front = "$front$1 ";
-	}
-	elsif(/<email>(.*)<\/email>/i){
-	  $front = "$front($1)";
-	}
-	elsif(/\/author>/i){
-	  $front = "$front\n";
-	}
-
-	elsif(/<copyright>/i){
-	  $front = "$front.\\\" Documentation copyright: ";
-	}
-	elsif(/<holder>(.*)<\/holder>/i){
-	  $front = "$front$1 ";
-	}
-	elsif(/<year>(.*)<\/year>/i){
-	  $front = "$front$1 ";
-	}
-	elsif(/\/copyright>/i){
-	  $front = "$front\n";
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
-      if($mode == 0){
-	if(/<bookinfo>/i){
-	  $mode = 1;
-	}
-      }
-
-      if($mode == 4){
-	if(/<\/bookinfo>/i){
-	  $mode = 3;
-	}
-      }
-    }
-    close INPUT;
-
-    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 $tmpdir/$$.9\n");
-    open GENERATED, "< $tmpdir/$$.9";
-    open OUTPUT, "> $ARGV[1]/$filename.9";
-
-    print OUTPUT "$front";
-    print OUTPUT ".\\\" For comments on the formatting of this manpage, please contact Michael Still <mikal\@stillhq.com>\n\n";
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
-  system("mkdir -p /usr/local/man/man9/; install $ARGV[1]/*.9.gz /usr/local/man/man9/");
-}
-else{
-  die "Usage: makeman [convert | install] <dir> <file>\n";
-}
-
-print "Done\n";
Index: linux-docbook/scripts/split-man
===================================================================
--- linux-docbook.orig/scripts/split-man	2005-04-06 12:12:34.753567067 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
-$mode = 0;
-$refdata = "";
-$front = "";
-while(<SGML>){
-  # Starting modes
-  if(/<bookinfo>/ || /<docinfo>/){
-    $mode = 1;
-  }
-  elsif(/<refentry>/){
-    $mode = 2;
-  }
-  elsif(/<refentrytitle><phrase[^>]*>([^<]*)<.*$/){
-    $mode = 3;
-    $filename = $1;
-
-    $filename =~ s/struct //;
-    $filename =~ s/typedef //;
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
-    $refdata = "";
-  }
-
-  # Extraction
-  if($mode == 1){
-    chomp $_;
-    $front = "$front<!-- $_ -->\n";
-  }
-  elsif($mode == 2){
-    $refdata = "$refdata$_";
-  }
-  elsif($mode == 3){
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
-    $mode = 0;
-  }
-  elsif(/<\/refentry>/){
-    $mode = 0;
-    close REF;
-  }
-}
-
-# And make sure we don't process this unnessesarily
-$ARGV[0] =~ s/\.sgml/.9/;
-`touch $ARGV[0]`;

--
Martin Waitz
