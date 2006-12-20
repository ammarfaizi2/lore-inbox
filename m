Return-Path: <linux-kernel-owner+w=401wt.eu-S964901AbWLTHKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWLTHKX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 02:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWLTHKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 02:10:23 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:38340 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901AbWLTHKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 02:10:21 -0500
Date: Tue, 19 Dec 2006 23:10:19 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tali <tali@admingilde.org>, davem@davemloft.net
Subject: [PATCH] kernel-doc: allow unnamed structs/unions
Message-Id: <20061219231019.6df16e1c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Make kernel-doc support unnamed (anonymous) structs and unions.
There is one (union) in include/linux/skbuff.h (inside struct sk_buff)
that is currently generating a kernel-doc warning, so this
fixes that warning.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 scripts/kernel-doc |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- linux-2.6.20-rc1-git7.orig/scripts/kernel-doc
+++ linux-2.6.20-rc1-git7/scripts/kernel-doc
@@ -1469,6 +1469,7 @@ sub push_parameter($$$) {
 	my $param = shift;
 	my $type = shift;
 	my $file = shift;
+	my $anon = 0;
 
 	my $param_name = $param;
 	$param_name =~ s/\[.*//;
@@ -1484,9 +1485,20 @@ sub push_parameter($$$) {
 	    $param="void";
 	    $parameterdescs{void} = "no arguments";
 	}
+	elsif ($type eq "" && ($param eq "struct" or $param eq "union"))
+	# handle unnamed (anonymous) union or struct:
+	{
+		$type = $param;
+		$param = "{unnamed_" . $param. "}";
+		$parameterdescs{$param} = "anonymous\n";
+		$anon = 1;
+	}
+
 	# warn if parameter has no description
-	# (but ignore ones starting with # as these are no parameters
-	# but inline preprocessor statements
+	# (but ignore ones starting with # as these are not parameters
+	# but inline preprocessor statements);
+	# also ignore unnamed structs/unions;
+	if (!$anon) {
 	if (!defined $parameterdescs{$param_name} && $param_name !~ /^#/) {
 
 	    $parameterdescs{$param_name} = $undescribed;
@@ -1500,6 +1512,7 @@ sub push_parameter($$$) {
 	                 " No description found for parameter '$param'\n";
 	    ++$warnings;
         }
+        }
 
 	push @parameterlist, $param;
 	$parametertypes{$param} = $type;


---
