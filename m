Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVGGPcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVGGPcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGGL10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:27:26 -0400
Received: from coderock.org ([193.77.147.115]:23434 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261297AbVGGL0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:26:53 -0400
Message-Id: <20050707112635.804534000@homer>
References: <20050707112551.331553000@homer>
Date: Thu, 07 Jul 2005 13:25:54 +0200
From: domen@coderock.org
To: linux-kernel@vger.kernel.org
Cc: damm@opensource.se, domen@coderock.org
Subject: [patch 3/5] autoparam: extract script
Content-Disposition: inline; filename=autoparam_3-extract_script
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>


A simple perl script which extracts parameters, types and
descriptions from binary file.

Signed-off-by: Domen Puncer <domen@coderock.org>

 scripts/kernelparams.pl |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+)

Index: a/scripts/kernelparams.pl
===================================================================
--- /dev/null
+++ a/scripts/kernelparams.pl
@@ -0,0 +1,49 @@
+#!/usr/bin/perl
+use strict;
+my ($p, @params, %param_t, %param_d);
+
+while (<>) {
+	my @params = split '\0', $_;
+	foreach $p (@params) {
+		next if (!$p);
+		# module_param, "m:module.param:type"
+		if ($p =~ /^(m:.+?):(.*)/) {
+			$param_t{$1} = " ($2)";
+		}
+		# __setup, "s:"; obsolete_setup; early_param
+		elsif ($p =~ /^([soe]:.+)/) {
+			$param_t{$1} = '';
+		}
+		# description, "d:module.param:description"
+		elsif ($p =~ /^d:(.+?):(.+)/) {
+			$param_d{$1} = $2;
+		}
+		# i.e. ide uses __setup("", blah)
+		elsif ($p !~ /^[soe]:$/) {
+			print STDERR "Parameter error: \"$p\"\n";
+		}
+	}
+}
+
+# print the parameters
+foreach $p (sort(keys(%param_t))) {
+	print "$p$param_t{$p}\n";
+	my $pn = substr($p, 2);
+	if (!$param_d{$pn}) {
+		# only warn for module parameters
+		if ($p =~ "^m:") {
+			print "  No description\n";
+		}
+	} else {
+		print "  $param_d{$pn}\n";
+	}
+	print "\n";
+}
+
+# descriptions alone; typos, deprecated
+foreach $p (sort(keys(%param_d))) {
+	if (!exists $param_t{"m:".$p} && !exists $param_t{"s:".$p} &&
+			!exists $param_t{"o:".$p}) {
+		print STDERR "$p only has description (MODULE_PARM?)\n";
+	}
+}

--
