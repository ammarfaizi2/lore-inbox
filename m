Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752177AbWFMDX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWFMDX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbWFMDX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:23:27 -0400
Received: from xenotime.net ([66.160.160.81]:28875 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752177AbWFMDX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:23:27 -0400
Date: Mon, 12 Jun 2006 20:26:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tali@admingilde.org
Subject: [PATCH] kernel-doc: warn on malformed function docs.
Message-Id: <20060612202612.4901b6cb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

When the verbose (-v) option is used with scripts/kernel-doc,
this option reports when the kernel-doc format is malformed
and apparently contains function description lines before
function parameters.  In these cases, the kernel-doc script
will print something like:
Warning(filemap.c:335): contents before sections

I have fixed the problems in mm/filemap.c and added lots
of kernel-doc to that file (posted to the linux-mm
mailing list Mon. 2006-June-12).

The real goal (as requested by Andrew Morton) is to allow
the short function description to be more than one line long.
This patch is both a kernel-doc checker and a tool en route
to that goal.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2617-rc6.orig/scripts/kernel-doc
+++ linux-2617-rc6/scripts/kernel-doc
@@ -253,6 +253,7 @@ my $lineprefix="";
 # 3 - scanning prototype.
 # 4 - documentation block
 my $state;
+my $in_doc_sect;
 
 #declaration types: can be
 # 'function', 'struct', 'union', 'enum', 'typedef'
@@ -1706,6 +1707,7 @@ sub process_file($) {
 	if ($state == 0) {
 	    if (/$doc_start/o) {
 		$state = 1;		# next line is always the function name
+		$in_doc_sect = 0;
 	    }
 	} elsif ($state == 1) {	# this line is the function name (always)
 	    if (/$doc_block/o) {
@@ -1756,10 +1758,15 @@ sub process_file($) {
 		$newcontents = $2;
 
 		if ($contents ne "") {
+		    if (!$in_doc_sect && $verbose) {
+			print STDERR "Warning(${file}:$.): contents before sections\n";
+			++$warnings;
+		    }
 		    dump_section($section, xml_escape($contents));
 		    $section = $section_default;
 		}
 
+		$in_doc_sect = 1;
 		$contents = $newcontents;
 		if ($contents ne "") {
 		    $contents .= "\n";


---
