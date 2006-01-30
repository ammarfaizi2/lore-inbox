Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWA3JEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWA3JEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWA3JEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:04:48 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40132
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932139AbWA3JEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:04:47 -0500
Message-Id: <43DDE4D5.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 10:05:09 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix mkmakefile
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartF5D766D5.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartF5D766D5.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Jan Beulich <jbeulich@novell.com>

With the current way of generating the Makefile in the output directory
for builds outside of the source tree, specifying real targets (rather
than phony ones) doesn't work in an already (partially) built tree, as
the stub Makefile doesn't have any dependency information available.
Thus, all targets where files may actually exist must be listed
explicitly and, due to what I'd call a make misbehavior, directory
targets must then also be special cased.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>



--=__PartF5D766D5.1__=
Content-Type: text/plain; name="linux-2.6.16-rc1-mkmakefile.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc1-mkmakefile.patch"

From: Jan Beulich <jbeulich@novell.com>

With the current way of generating the Makefile in the output directory
for builds outside of the source tree, specifying real targets (rather
than phony ones) doesn't work in an already (partially) built tree, as
the stub Makefile doesn't have any dependency information available.
Thus, all targets where files may actually exist must be listed
explicitly and, due to what I'd call a make misbehavior, directory
targets must then also be special cased.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/mkmakefile 2.6.16-rc1-mkmakefile/scripts/mkmakefile
--- /home/jbeulich/tmp/linux-2.6.16-rc1/scripts/mkmakefile	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc1-mkmakefile/scripts/mkmakefile	2006-01-25 09:55:53.000000000 +0100
@@ -20,12 +20,15 @@ KERNELSRC    := $1
 KERNELOUTPUT := $2
 
 MAKEFLAGS += --no-print-directory
+MAKEARGS  := -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
+
+.PHONY: all \$(MAKECMDGOALS)
 
 all:
-	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
+	\$(MAKE) \$(MAKEARGS)
 
-%::
-	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
+Makefile:;
 
+\$(filter-out all Makefile,\$(MAKECMDGOALS)) %/:
+	\$(MAKE) \$(MAKEARGS) \$@
 EOF
-

--=__PartF5D766D5.1__=--
