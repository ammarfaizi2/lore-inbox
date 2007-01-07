Return-Path: <linux-kernel-owner+w=401wt.eu-S932474AbXAGKnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbXAGKnI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbXAGKnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:43:08 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:58459 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474AbXAGKnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:43:05 -0500
Date: Sun, 7 Jan 2007 11:43:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, hongjie@us.ibm.com
Subject: [S390] memory detection misses 128k.
Message-ID: <20070107104302.GA14724@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongjie Yang <hongjie@us.ibm.com>

[S390] memory detection misses 128k.

Fix a memory leak problem in the memory detection routines.  A memory leak
of 128k occurs when we have a contiguous memory with mixed access-mode
(read or write) ranges.

Signed-off-by: Hongjie Yang <hongjie@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S |   12 +++++++++++-
 arch/s390/kernel/head64.S |   12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2007-01-06 15:20:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2007-01-06 15:20:27.000000000 +0100
@@ -164,11 +164,14 @@ startup_continue:
 	srl	%r7,28
 	clr	%r6,%r7			# compare cc with last access code
 	be	.Lsame-.LPG1(%r13)
-	b	.Lchkmem-.LPG1(%r13)
+	lhi	%r8,0			# no program checks
+	b	.Lsavchk-.LPG1(%r13)
 .Lsame:
 	ar	%r5,%r1			# add 128KB to end of chunk
 	bno	.Lloop-.LPG1(%r13)	# r1 < 0x80000000 -> loop
 .Lchkmem:				# > 2GB or tprot got a program check
+	lhi	%r8,1			# set program check flag
+.Lsavchk:
 	clr	%r4,%r5			# chunk size > 0?
 	be	.Lchkloop-.LPG1(%r13)
 	st	%r4,0(%r3)		# store start address of chunk
@@ -190,8 +193,15 @@ startup_continue:
 	je	.Ldonemem		# if not, leave
 	chi	%r10,0			# do we have chunks left?
 	je	.Ldonemem
+	chi	%r8,1			# program check ?
+	je	.Lpgmchk
+	lr	%r4,%r5			# potential new chunk
+	alr	%r5,%r1			# add 128KB to end of chunk
+	j	.Llpcnt
+.Lpgmchk:
 	alr	%r5,%r1			# add 128KB to end of chunk
 	lr	%r4,%r5			# potential new chunk
+.Llpcnt:
 	clr	%r5,%r9			# should we go on?
 	jl	.Lloop
 .Ldonemem:
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2007-01-06 15:20:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2007-01-06 15:20:27.000000000 +0100
@@ -172,12 +172,15 @@ startup_continue:
 	srl	%r7,28
 	clr	%r6,%r7			# compare cc with last access code
 	je	.Lsame
-	j	.Lchkmem
+	lghi	%r8,0			# no program checks
+	j	.Lsavchk
 .Lsame:
 	algr	%r5,%r1			# add 128KB to end of chunk
 					# no need to check here,
 	brc	12,.Lloop		# this is the same chunk
 .Lchkmem:				# > 16EB or tprot got a program check
+	lghi	%r8,1			# set program check flag
+.Lsavchk:
 	clgr	%r4,%r5			# chunk size > 0?
 	je	.Lchkloop
 	stg	%r4,0(%r3)		# store start address of chunk
@@ -204,8 +207,15 @@ startup_continue:
 	chi	%r10, 0			# do we have chunks left?
 	je	.Ldonemem
 .Lhsaskip:
+	chi	%r8,1			# program check ?
+	je	.Lpgmchk
+	lgr	%r4,%r5			# potential new chunk
+	algr	%r5,%r1			# add 128KB to end of chunk
+	j	.Llpcnt
+.Lpgmchk:
 	algr	%r5,%r1			# add 128KB to end of chunk
 	lgr	%r4,%r5			# potential new chunk
+.Llpcnt:
 	clgr	%r5,%r9			# should we go on?
 	jl	.Lloop
 .Ldonemem:
