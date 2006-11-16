Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162247AbWKPCog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162247AbWKPCog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162241AbWKPCoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:44:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10895 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162234AbWKPCnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:43:39 -0500
Message-Id: <20061116024403.692995000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:33 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       greg@kroah.com
Subject: [patch 01/30] S390: user readable uninitialised kernel memory, take 2.
Content-Disposition: inline; filename=s390-user-readable-uninitialised-kernel-memory-take-2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The previous patch to correct the copy_from_user padding is quite
broken. The execute instruction needs to be done via the register %r4,
not via %r2 and 31 bit doesn't know the instructions lgr and ahji.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/s390/lib/uaccess.S   |   10 +++++-----
 arch/s390/lib/uaccess64.S |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.18.2.orig/arch/s390/lib/uaccess64.S
+++ linux-2.6.18.2/arch/s390/lib/uaccess64.S
@@ -49,7 +49,7 @@ __copy_from_user_asm:
 	la	%r2,256(%r2)
 8:	aghi	%r5,-256
 	jnm	7b
-	ex	%r5,0(%r2)
+	ex	%r5,0(%r4)
 9:	lgr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
--- linux-2.6.18.2.orig/arch/s390/lib/uaccess.S
+++ linux-2.6.18.2/arch/s390/lib/uaccess.S
@@ -41,15 +41,15 @@ __copy_from_user_asm:
 5:	mvcp	0(%r5,%r2),0(%r4),%r0
 	slr	%r3,%r5
 	alr	%r2,%r5
-6:	lgr	%r5,%r3		# copy remaining size
+6:	lr	%r5,%r3		# copy remaining size
 	ahi	%r5,-1		# subtract 1 for xc loop
 	bras	%r4,8f
-	xc	0(1,%2),0(%2)
-7:	xc	0(256,%2),0(%2)
+	xc	0(1,%r2),0(%r2)
+7:	xc	0(256,%r2),0(%r2)
 	la	%r2,256(%r2)
-8:	ahji	%r5,-256
+8:	ahi	%r5,-256
 	jnm	7b
-	ex	%r5,0(%r2)
+	ex	%r5,0(%r4)
 9:	lr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"

--
