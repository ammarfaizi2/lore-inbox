Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272074AbTHNBYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 21:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272127AbTHNBYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 21:24:04 -0400
Received: from mta07ps.bigpond.com ([144.135.25.132]:40425 "EHLO
	mta07ps.bigpond.com") by vger.kernel.org with ESMTP id S272074AbTHNBX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 21:23:57 -0400
Date: Thu, 14 Aug 2003 11:23:18 +1000
From: Michael Still <mikal@stillhq.com>
Subject: [PATCH] Docbook: Make mandocs output more terse
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linus@osdl.org
Message-id: <Pine.LNX.4.44.0308140950260.17489-100000@diskbox.stillhq.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

This patch takes into account requests from various LKML members for the 
mandocs output to be more terse. Information about the copyright, and 
formatting of the man page is moved into a comment at the start of the 
groff output.

Sample output can be found at:
  http://www.stillhq.com/linux/mandocs/2.6.0-test3-bk1/

Here's the patch:

diff -Nur linux-2.6.0-test3-bk1/scripts/makeman linux-2.6.0-test3-bk1-terseman-001/scripts/makeman
--- linux-2.6.0-test3-bk1/scripts/makeman	2003-08-12 14:35:41.000000000 +1000
+++ linux-2.6.0-test3-bk1-terseman-001/scripts/makeman	2003-08-13 10:24:10.000000000 +1000
@@ -12,7 +12,7 @@
 ##             $3 -- the filename which contained the sgmldoc output
 ##                     (I need this so I know which manpages to convert)
 
-my($LISTING);
+my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename);
 
 if($ARGV[0] eq ""){
   die "Usage: makeman [convert | install] <dir> <file>\n";
@@ -32,8 +32,121 @@
     s/typedef //;
 
     chomp;
-    print "Processing $_\n";
-    system("cd $ARGV[1]; docbook2man $_.sgml; gzip -f $_.9\n");
+    $filename = $_;
+    print "Processing $filename\n";
+
+    # Open the input file to extract the front matter, generate the man page,
+    # and open it, and the rearrange everything until it is happy
+    open INPUT, "< $ARGV[1]/$filename.sgml";
+    $front = "";
+    $mode = 0;
+    while(<INPUT>){
+      if(/.*ENDFRONTTAG.*/){
+	$mode = 0;
+      }
+
+      if($mode > 0){
+	s/<!-- //;
+	s/ -->//;
+	s/<bookinfo>//;
+	s/<\/bookinfo>//;
+	s/<docinfo>//;
+	s<\/docinfo>//;
+	s/^[ \t]*//;
+      }
+
+      if($mode == 2){
+	if(/<para>/){
+	}
+	elsif(/<\/para>/){
+	  $front = "$front.\\\" \n";
+	}
+	elsif(/<\/legalnotice>/){
+	  $mode = 1;
+	}
+	elsif(/^[ \t]*$/){
+	}
+	else{
+	  $front = "$front.\\\"     $_";
+	}
+      }
+
+      if($mode == 1){
+	if(/<title>(.*)<\/title>/){
+	  $front = "$front.\\\" This documentation was generated from the book titled \"$1\", which is part of the Linux kernel source.\n.\\\" \n";
+	}
+	elsif(/<legalnotice>/){
+	  $front = "$front.\\\" This documentation comes with the following legal notice:\n.\\\" \n";
+	  $mode = 2;
+	}
+
+	elsif(/<author>/){
+	  $front = "$front.\\\" Documentation by: ";
+	}
+	elsif(/<firstname>(.*)<\/firstname>/){
+	  $front = "$front$1 ";
+	}
+	elsif(/<surname>(.*)<\/surname>/){
+	  $front = "$front$1 ";
+	}
+	elsif(/<email>(.*)<\/email>/){
+	  $front = "$front($1)";
+	}
+	elsif(/\/author>/){
+	  $front = "$front\n";
+	}
+
+	elsif(/<copyright>/){
+	  $front = "$front.\\\" Documentation copyright: ";
+	}
+	elsif(/<holder>(.*)<\/holder>/){
+	  $front = "$front$1 ";
+	}
+	elsif(/<year>(.*)<\/year>/){
+	  $front = "$front$1 ";
+	}
+	elsif(/\/copyright>/){
+	  $front = "$front\n";
+	}
+
+	elsif(/^[ \t]*$/
+	      || /<affiliation>/
+	      || /<\/affiliation>/
+	      || /<address>/
+	      || /<\/address>/
+	      || /<authorgroup>/
+	      || /<\/authorgroup>/
+	      || /<\/legalnotice>/
+              || /<date>/
+              || /<\/date>/
+              || /<edition>/
+              || /<\/edition>/){
+	}
+	else{
+	  print "Unknown tag in manpage conversion: $_";
+	  }
+      }
+
+      if(/.*BEGINFRONTTAG.*/){
+	$mode = 1;
+      }
+    }
+    close INPUT;
+
+    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 /tmp/$$.9\n");
+    open GENERATED, "< /tmp/$$.9";
+    open OUTPUT, "> $ARGV[1]/$filename.9";
+
+    print OUTPUT "$front";
+    print OUTPUT ".\\\" For comments on the formatting of this manpage, please contact Michael Still <mikal\@stillhq.com>\n\n";
+    while(<GENERATED>){
+      print OUTPUT "$_";
+    }
+    close OUTPUT;
+    close GENERATED;
+
+    system("gzip -f $ARGV[1]/$filename.9\n");
+    unlink("/tmp/$filename.9");
   }
 }
 elsif($ARGV[0] eq "install"){
diff -Nur linux-2.6.0-test3-bk1/scripts/split-man linux-2.6.0-test3-bk1-terseman-001/scripts/split-man
--- linux-2.6.0-test3-bk1/scripts/split-man	2003-08-12 14:35:41.000000000 +1000
+++ linux-2.6.0-test3-bk1-terseman-001/scripts/split-man	2003-08-13 10:24:16.000000000 +1000
@@ -35,7 +35,7 @@
 $front = "";
 while(<SGML>){
   # Starting modes
-  if(/<legalnotice>/){
+  if(/<bookinfo>/ || /<docinfo>/){
     $mode = 1;
   }
   elsif(/<refentry>/){
@@ -49,16 +49,24 @@
     $filename =~ s/typedef //;
 
     print "Found manpage for $filename\n";
-    open REF, "> $ARGV[1]/$filename.sgml" or
+    open REF, "> $ARGV[1]/$filename.sgml" or 
       die "Couldn't open output file \"$ARGV[1]/$filename.sgml\": $!\n";
-    print REF "<!DOCTYPE refentry PUBLIC \"-//Davenport//DTD DocBook V3.0//EN\">\n\n";
-    print REF "$refdata";
+    print REF <<EOF;
+<!DOCTYPE refentry PUBLIC "-//Davenport//DTD DocBook V3.0//EN">
+
+<!-- BEGINFRONTTAG: The following is front matter for the parent book -->
+$front
+<!-- ENDFRONTTAG: End front matter -->
+
+$refdata
+EOF
     $refdata = "";
   }
 
   # Extraction
   if($mode == 1){
-    $front = "$front$_";
+    chomp $_;
+    $front = "$front<!-- $_ -->\n";
   }
   elsif($mode == 2){
     $refdata = "$refdata$_";
@@ -69,16 +77,8 @@
       print REF "<manvolnum>9</manvolnum>\n";
     }
     if(/<\/refentry>/){
-      $front =~ s/<legalnotice>//;
-      $front =~ s/<\/legalnotice>//;
       print REF <<EOF;
 <refsect1><title>About this document</title>
-$front
-<para>
-If you have comments on the formatting of this manpage, then please contact
-Michael Still (mikal\@stillhq.com).
-</para>
-
 <para>
 This documentation was generated with kernel version $ARGV[2].
 </para>
@@ -98,13 +98,13 @@
   }
 
   # Ending modes
-  if(/<\/legalnotice>/){
+  if(/<\/bookinfo>/ || /<\/docinfo>/){
     $mode = 0;
   }
   elsif(/<\/refentry>/){
     $mode = 0;
     close REF;
-  }
+  }	
 }
 
 # And make sure we don't process this unnessesarily



