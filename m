Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752019AbWCGHUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbWCGHUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbWCGHUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:20:33 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:37380 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752019AbWCGHUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:20:32 -0500
Date: Tue, 7 Mar 2006 08:20:14 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Gerald Schaefer <geraldsc@de.ibm.com>,
       David Howells <dhowells@redhat.com>
Subject: [patch 1/3] s390: fix strnlen_user return value
Message-ID: <20060307072014.GA9329@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

strnlen_user is supposed to return then length count + 1 if no
terminating \0 is found, and it should return 0 on exception.
Found by David Howells <dhowells@redhat.com>.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/lib/uaccess.S   |    6 +++---
 arch/s390/lib/uaccess64.S |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/uaccess64.S linux-2.6-patched/arch/s390/lib/uaccess64.S
--- linux-2.6/arch/s390/lib/uaccess64.S	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess64.S	2006-03-07 07:59:22.000000000 +0100
@@ -194,12 +194,12 @@ __strnlen_user_asm:
 0:	srst	%r2,%r1
 	jo	0b
 	sacf	0
-	jh	1f		# \0 found in string ?
 	aghi	%r2,1		# strnlen_user result includes the \0
-1:	slgr	%r2,%r3
+				# or return count+1 if \0 not found
+	slgr	%r2,%r3
 	br	%r14
 2:	sacf	0
-	lghi	%r2,-EFAULT
+	slgr	%r2,%r2		# return 0 on exception
 	br	%r14
 	.section __ex_table,"a"
 	.quad	0b,2b
diff -urpN linux-2.6/arch/s390/lib/uaccess.S linux-2.6-patched/arch/s390/lib/uaccess.S
--- linux-2.6/arch/s390/lib/uaccess.S	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess.S	2006-03-07 07:59:22.000000000 +0100
@@ -198,12 +198,12 @@ __strnlen_user_asm:
 0:	srst	%r2,%r1
 	jo	0b
 	sacf	0
-	jh	1f		# \0 found in string ?
 	ahi	%r2,1		# strnlen_user result includes the \0
-1:	slr	%r2,%r3
+				# or return count+1 if \0 not found
+	slr	%r2,%r3
 	br	%r14
 2:	sacf	0
-	lhi	%r2,-EFAULT
+	slr	%r2,%r2		# return 0 on exception
 	br	%r14
 	.section __ex_table,"a"
 	.long	0b,2b
