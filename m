Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFGHwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFGHwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:52:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:49421 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262742AbTFGHvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:51:35 -0400
Date: Sat, 7 Jun 2003 10:05:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Docbook update
Message-ID: <20030607080509.GD8943@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030607080226.GA8943@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607080226.GA8943@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1316.1.2 -> 1.1316.1.3
#	   scripts/docproc.c	1.3     -> 1.4    
#	  scripts/kernel-doc	1.11    -> 1.12   
#	Documentation/DocBook/Makefile	1.40    -> 1.41   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/07	sam@mars.ravnborg.org	1.1316.1.3
# docbook: Warn about missing parameter definitions
# 
# Previously kernel-doc silently ignored missing parameter descriptions
# but sometimes 'make sgmldocs' failed with exit code > 0.
# When kernel-doc encounter parameters where the description is missing
# it now prints a warning.
# docproc corrected so previously exit code are recorded.
# docbook makefile cleaned up a bit
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Sat Jun  7 09:53:42 2003
+++ b/Documentation/DocBook/Makefile	Sat Jun  7 09:53:42 2003
@@ -39,8 +39,8 @@
 
 ###
 #External programs used
-KERNELDOC=$(objtree)/scripts/kernel-doc
-DOCPROC=$(objtree)/scripts/docproc
+KERNELDOC = scripts/kernel-doc
+DOCPROC   = scripts/docproc
 
 ###
 # DOCPROC is used for two purposes:
@@ -50,14 +50,14 @@
 # The following rules are used to generate the .sgml documentation
 # required to generate the final targets. (ps, pdf, html).
 quiet_cmd_docproc = DOCPROC $@
-cmd_docproc = $(DOCPROC) doc $< >$@
+      cmd_docproc = $(DOCPROC) doc $< >$@
 define rule_docproc
-	set -e
-        $(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) 
-        $(cmd_$(1)); \
-        ( \
-          echo 'cmd_$@ := $(cmd_$(1))'; \
-          echo $@: `$(DOCPROC) depend $<`; \
+	set -e;								\
+        $(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) 	\
+        $(cmd_$(1)); 							\
+        ( 								\
+          echo 'cmd_$@ := $(cmd_$(1))'; 				\
+          echo $@: `$(DOCPROC) depend $<`; 				\
         ) > $(dir $@).$(notdir $@).cmd
 endef
 
@@ -96,41 +96,55 @@
 ###
 # Rules to generate postscript, PDF and HTML
 # db2html creates a directory. Generate a html file used for timestamp
+
+quiet_cmd_db2ps = DB2PS   $@
+      cmd_db2ps = db2ps -o $(dir $@) $<
 %.ps : %.sgml
 	@(which db2ps > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
-	$(call do_cmd,DB2PS   $@,db2ps -o $(dir $@) $<)
+	$(call cmd,db2ps)
 
+quiet_cmd_db2pdf = DB2PDF  $@
+      cmd_db2pdf = db2pdf -o $(dir $@) $<
 %.pdf : %.sgml
 	@(which db2pdf > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
-	$(call do_cmd,DB2PDF  $@,db2pdf -o $(dir $@) $<)
+	$(call cmd,db2pdf)
+
+quiet_cmd_db2html = DB2HTML $@
+      cmd_db2html = db2html -o $(patsubst %.html,%,$@) $< &&		      \
+		echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html"> \
+         Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
 
 %.html:	%.sgml
 	@(which db2html > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	@rm -rf $@ $(patsubst %.html,%,$@)
-	$(call do_cmd,DB2HTML $@,db2html -o $(patsubst %.html,%,$@) $< && \
-         echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html">\
-         Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@)
+	$(call cmd,db2html)
 	@if [ ! -z "$(PNG-$(basename $(notdir $@)))" ]; then \
             cp $(PNG-$(basename $(notdir $@))) $(patsubst %.html,%,$@); fi
 
 ###
 # Rules to generate postscripts and PNG imgages from .fig format files
+quiet_cmd_fig2eps = FIG2EPS $@
+      cmd_fig2eps = fig2dev -Leps $< $@
+
 %.eps: %.fig
-	$(call do_cmd,FIG2DEV -Leps $@,fig2dev -Leps $< $@)
+	$(call cmd,fig2eps)
+
+quiet_cmd_fig2png = FIG2PNG $@
+      cmd_fig2png = fig2dev -Lpng $< $@
 
 %.png: %.fig
-	$(call do_cmd,FIG2DEV -Lpng $@,fig2dev -Lpng $< $@)
+	$(call cmd,fig2png)
 
 ###
 # Rule to convert a .c file to inline SGML documentation
 %.sgml: %.c
-	@echo '  Generating $@'
+	@echo '  GEN     $@'
 	@(                            \
 	   echo "<programlisting>";   \
 	   expand --tabs=8 < $< |     \
diff -Nru a/scripts/docproc.c b/scripts/docproc.c
--- a/scripts/docproc.c	Sat Jun  7 09:53:42 2003
+++ b/scripts/docproc.c	Sat Jun  7 09:53:42 2003
@@ -93,7 +93,7 @@
 			waitpid(pid, &ret ,0);
 	}
 	if (WIFEXITED(ret))
-		exitstatus = WEXITSTATUS(ret);
+		exitstatus |= WEXITSTATUS(ret);
 	else
 		exitstatus = 0xff;
 }
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Sat Jun  7 09:53:42 2003
+++ b/scripts/kernel-doc	Sat Jun  7 09:53:42 2003
@@ -154,6 +154,7 @@
 # '%CONST' - name of a constant.
 
 my $errors = 0;
+my $warnings = 0;
 
 # match expressions used to find embedded type information
 my $type_constant = '\%([-_\w]+)';
@@ -1352,7 +1353,9 @@
 		    "or member '$param' not " .
 		    "described in '$declaration_name'\n";
 	    }
-	    ++$errors;
+	    print STDERR "Warning(${file}:$.):".
+	                 " No description found for parameter '$param'\n";
+	    ++$warnings;
         }
 
 	push @parameterlist, $param;
@@ -1456,6 +1459,12 @@
     chomp;
     process_file($_);
 }
+if ($verbose && $errors) {
+  print STDERR "$errors errors\n";
+}
+if ($verbose && $warnings) {
+  print STDERR "$warnings warnings\n";
+}
 
 exit($errors);
 
@@ -1580,7 +1589,7 @@
 	    } else {
 		print STDERR "Warning(${file}:$.): Cannot understand $_ on line $.",
 		" - I thought it was a doc line\n";
-		++$errors;
+		++$warnings;
 		$state = 0;
 	    }
 	} elsif ($state == 2) {	# look for head: lines, and include content
@@ -1633,7 +1642,7 @@
 	    } else {
 		# i dont know - bad line?  ignore.
 		print STDERR "Warning(${file}:$.): bad line: $_"; 
-		++$errors;
+		++$warnings;
 	    }
 	} elsif ($state == 3) {	# scanning for function { (end of prototype)
 	    if ($decl_type eq 'function') {
