Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131042AbQKIUQV>; Thu, 9 Nov 2000 15:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131120AbQKIUQL>; Thu, 9 Nov 2000 15:16:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:26643 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131042AbQKIUQD>;
	Thu, 9 Nov 2000 15:16:03 -0500
Date: Thu, 9 Nov 2000 21:15:25 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] generate man pages from inline documentation
Message-ID: <20001109211524.A2926@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch adds some infrastructure and modifies scripts/kernel-doc to
support generating man pages from the inline documentation.

Please apply (for all the poeple that prefer man pages over sgml)

	Christoph

P.S. it does also removed an older stub for this that slipped in some
time ago.

-- 
Always remember that you are unique.  Just like everyone else.


diff -uNr --exclude-from=dontdiff linux-2.4.0t11p1/Documentation/DocBook/Makefile linux/Documentation/DocBook/Makefile
--- linux-2.4.0t11p1/Documentation/DocBook/Makefile	Thu Oct 19 13:21:14 2000
+++ linux/Documentation/DocBook/Makefile	Thu Nov  9 21:50:26 2000
@@ -82,11 +82,6 @@
 	$(TOPDIR)/scripts/docgen $(APISOURCES) \
 		<kernel-api.tmpl >kernel-api.sgml
 
-kernel-api-man: $(APISOURCES)
-	@rm -rf $(TOPDIR)/Documentation/man
-	$(TOPDIR)/scripts/kernel-doc -man $^ | \
-		$(PERL) $(TOPDIR)/scripts/split-man $(TOPDIR)/Documentation/man
-
 parportbook: $(JPG-parportbook)
 parportbook.ps: $(EPS-parportbook)
 parportbook.sgml: parportbook.tmpl $(TOPDIR)/drivers/parport/init.c
diff -uNr --exclude-from=dontdiff linux-2.4.0t11p1/Makefile linux/Makefile
--- linux-2.4.0t11p1/Makefile	Thu Nov  9 15:50:14 2000
+++ linux/Makefile	Thu Nov  9 21:50:26 2000
@@ -82,6 +82,13 @@
 export MODLIB
 
 #
+# MANPATH specifies where to install the manpages created from
+# inline documentation
+#
+
+MANDIR	:= /usr/share/man
+
+#
 # standard CFLAGS
 #
 
@@ -371,6 +378,7 @@
 	rm -f net/khttpd/times.h
 	rm -f submenu*
 	rm -rf modules
+	rm -rf Documentation/man
 	$(MAKE) -C Documentation/DocBook clean
 
 mrproper: clean archmrproper
@@ -421,6 +429,25 @@
 
 htmldocs: sgmldocs
 	$(MAKE) -C Documentation/DocBook html
+
+mandocs:
+	@rm -rf $(TOPDIR)/Documentation/man
+	chmod 755 $(TOPDIR)/scripts/kernel-doc
+	chmod 755 $(TOPDIR)/scripts/split-man
+	( \
+		find include/asm-$(ARCH) -name '*.h' -print; \
+		find $(SUBDIRS) init -name '*.c' -print; \
+		find include -type d \( -name "asm-*" -o -name config \) \
+			-prune -o -name '*.h' -print \
+	) | xargs $(TOPDIR)/scripts/kernel-doc | \
+		$(TOPDIR)/scripts/split-man \
+		$(TOPDIR)/Documentation/man
+
+install-man: mandocs
+	test -d $(MANDIR)/man9 || mkdir -p $(MANDIR)/man9
+	cp $(TOPDIR)/Documentation/man/*.9 $(MANDIR)/man9
+
+	
 
 sums:
 	find . -type f -print | sort | xargs sum > .SUMS
diff -uNr --exclude-from=dontdiff linux-2.4.0t11p1/scripts/kernel-doc linux/scripts/kernel-doc
--- linux-2.4.0t11p1/scripts/kernel-doc	Wed Oct 18 15:54:06 2000
+++ linux/scripts/kernel-doc	Thu Nov  9 22:04:55 2000
@@ -537,7 +537,7 @@
     my ($parameter, $section);
     my $count;
 
-    print ".TH \"$args{'module'}\" 4 \"$args{'function'}\" \"25 May 1998\" \"API Manual\" LINUX\n";
+    print ".TH \"$args{'function'}\" 9 \"$args{'function'}\" \"25 May 1998\" LINUX\n";
 
     print ".SH NAME\n";
     print $args{'function'}." \\- ".$args{'purpose'}."\n";
@@ -563,13 +563,13 @@
 	$parenth = "";
     }
 
-    print ".SH Arguments\n";
+    print ".SH ARGUMENTS\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
 	print ".IP \"".$parameter."\" 12\n";
 	output_highlight($args{'parameters'}{$parameter});
     }
     foreach $section (@{$args{'sectionlist'}}) {
-	print ".SH \"$section\"\n";
+	print ".SH \"", uc $section, "\"\n";
 	output_highlight($args{'sections'}{$section});
     }
 }
diff -uNr --exclude-from=dontdiff linux-2.4.0t11p1/scripts/split-man linux/scripts/split-man
--- linux-2.4.0t11p1/scripts/split-man	Thu Jan  1 01:00:00 1970
+++ linux/scripts/split-man	Thu Nov  9 21:50:26 2000
@@ -0,0 +1,33 @@
+#!/usr/bin/perl
+#
+#	split-man: create man pages from kernel-doc -man output 
+#
+# Author:	Tim Waugh <twaugh@redhat.com>
+# Modified by:	Christoph Hellwig <hch@caldera.de>
+#
+
+use strict;
+
+die "$0: where do I put the results?\n" unless ($#ARGV >= 0);
+die "$0: can't create $ARGV[0]: $!\n" unless mkdir $ARGV[0], 0777;
+
+my $state = 0;
+
+while (<STDIN>) {
+	s/&amp;(\w+)/\\fB\1\\fP/g; # fix smgl uglinesses
+	s/\$(\w+)/\\fI\1\\fP/g;
+	if (/^\.TH \"[^\"]*\" 9 \"([^\"]*)\"/) {
+		close OUT unless ($state++ == 0);
+		my $fn = "$ARGV[0]/$1.9";
+		if (open OUT, ">$fn") {
+			print STDERR "creating $fn\n";
+		} else {
+			die "can't open $fn: $!\n";
+		}
+		print OUT $_;
+	} elsif ($state != 0) {
+		print OUT $_;
+	}
+}
+
+close OUT; 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
