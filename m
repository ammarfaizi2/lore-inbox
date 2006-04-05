Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDEJWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDEJWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDEJWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:22:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751183AbWDEJWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:22:12 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] Improve data-dependency memory barrier example in documentation
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 05 Apr 2006 10:22:03 +0100
Message-ID: <29899.1144228923@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the memory barrier document, improve the example of the data dependency
barrier situation by:

 (1) showing the initial values of the variables involved; and

 (2) repeating the instruction sequence description, this time with the data
     dependency barrier actually shown to make it clear what the revised
     sequence actually is.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/mb.diff 
 Documentation/memory-barriers.txt |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index f855031..822fc45 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -610,6 +610,7 @@ loads.  Consider the following sequence 
 
 	CPU 1			CPU 2
 	=======================	=======================
+		{ B = 7; X = 9; Y = 8; C = &Y }
 	STORE A = 1
 	STORE B = 2
 	<write barrier>
@@ -651,7 +652,20 @@ In the above example, CPU 2 perceives th
 (which would be B) coming after the the LOAD of C.
 
 If, however, a data dependency barrier were to be placed between the load of C
-and the load of *C (ie: B) on CPU 2, then the following will occur:
+and the load of *C (ie: B) on CPU 2:
+
+	CPU 1			CPU 2
+	=======================	=======================
+		{ B = 7; X = 9; Y = 8; C = &Y }
+	STORE A = 1
+	STORE B = 2
+	<write barrier>
+	STORE C = &B		LOAD X
+	STORE D = 4		LOAD C (gets &B)
+				<data dependency barrier>
+				LOAD *C (reads B)
+
+then the following will occur:
 
 	+-------+       :      :                :       :
 	|       |       +------+                +-------+
