Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUJDXkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUJDXkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUJDXkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:40:14 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:18910 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S268704AbUJDXkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:40:00 -0400
Date: Mon, 4 Oct 2004 16:39:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2.6.9-rc3] Fix 'htmldocs' and friends with O=
Message-ID: <20041004233958.GD32692@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following patch fixes up 'htmldocs' and related to work when
trees are being built with O=.  I fixed it all up by passing the srctree
as an env-var to docproc (and thus what it calls) and then pull that out
when needed.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.9-rc3.orig/Documentation/DocBook/Makefile
+++ linux-2.6.9-rc3/Documentation/DocBook/Makefile
@@ -58,14 +58,14 @@ MAKEMAN   = $(PERL) $(srctree)/scripts/m
 # The following rules are used to generate the .sgml documentation
 # required to generate the final targets. (ps, pdf, html).
 quiet_cmd_docproc = DOCPROC $@
-      cmd_docproc = $(DOCPROC) doc $< >$@
+      cmd_docproc = SRCTREE=$(srctree)/ $(DOCPROC) doc $< >$@
 define rule_docproc
 	set -e;								\
         $(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) 	\
         $(cmd_$(1)); 							\
         ( 								\
           echo 'cmd_$@ := $(cmd_$(1))'; 				\
-          echo $@: `$(DOCPROC) depend $<`; 				\
+          echo $@: `SRCTREE=$(srctree) $(DOCPROC) depend $<`; 		\
         ) > $(dir $@).$(notdir $@).cmd
 endef
 
@@ -129,6 +129,9 @@ quiet_cmd_db2html = DB2HTML $@
 # Rule to generate man files - output is placed in the man subdirectory
 
 %.9:	%.sgml
+ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p $(objtree)/Documentation/DocBook/man
+endif
 	$(SPLITMAN) $< $(objtree)/Documentation/DocBook/man "$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)"
 	$(MAKEMAN) convert $(objtree)/Documentation/DocBook/man $<
 
--- linux-2.6.9-rc3.orig/scripts/kernel-doc
+++ linux-2.6.9-rc3/scripts/kernel-doc
@@ -1531,7 +1531,7 @@ sub process_state3_type($$) { 
 }
 
 sub process_file($) {
-    my ($file) = @_;
+    my ($file) = "$ENV{'SRCTREE'}@_";
     my $identifier;
     my $func;
     my $initial_section_counter = $section_counter;
--- linux-2.6.9-rc3.orig/scripts/basic/docproc.c
+++ linux-2.6.9-rc3/scripts/basic/docproc.c
@@ -79,6 +79,7 @@ void exec_kernel_doc(char **svec)
 {
 	pid_t pid;
 	int ret;
+	char real_filename[PATH_MAX + 1];
 	/* Make sure output generated so far are flushed */
 	fflush(stdout);
 	switch(pid=fork()) {
@@ -86,8 +87,13 @@ void exec_kernel_doc(char **svec)
 			perror("fork");
 			exit(1);
 		case  0:
-			execvp(KERNELDOCPATH KERNELDOC, svec);
-			perror("exec " KERNELDOCPATH KERNELDOC);
+			memset(real_filename, 0, sizeof(real_filename));
+			strncat(real_filename, getenv("SRCTREE"), PATH_MAX);
+			strncat(real_filename, KERNELDOCPATH KERNELDOC,
+					PATH_MAX - strlen(real_filename));
+			execvp(real_filename, svec);
+			fprintf(stderr, "exec ");
+			perror(real_filename);
 			exit(1);
 		default:
 			waitpid(pid, &ret ,0);
@@ -160,12 +166,17 @@ void find_export_symbols(char * filename
 	struct symfile *sym;
 	char line[MAXLINESZ];
 	if (filename_exist(filename) == NULL) {
+		char real_filename[PATH_MAX + 1];
+		memset(real_filename, 0, sizeof(real_filename));
+		strncat(real_filename, getenv("SRCTREE"), PATH_MAX);
+		strncat(real_filename, filename,
+				PATH_MAX - strlen(real_filename));
 		sym = add_new_file(filename);
-		fp = fopen(filename, "r");
+		fp = fopen(real_filename, "r");
 		if (fp == NULL)
 		{
 			fprintf(stderr, "docproc: ");
-			perror(filename);
+			perror(real_filename);
 		}
 		while(fgets(line, MAXLINESZ, fp)) {
 			char *p;

-- 
Tom Rini
http://gate.crashing.org/~trini/
