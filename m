Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936919AbWLDOzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936919AbWLDOzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936936AbWLDOzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:55:23 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:22456 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936919AbWLDOzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:55:15 -0500
Date: Mon, 4 Dec 2006 15:55:11 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Use diag260 for memory size detection.
Message-ID: <20061204145511.GW32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Use diag260 for memory size detection.

Avoid the tprot loop if diag260 works and reports that there are no
holes in memory. The tprot instruction can lead to a significant delay
in the ipl process if the virtual guest has a lot of memory and the
host is under memory pressure.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head64.S |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-12-04 14:50:55.000000000 +0100
@@ -70,7 +70,22 @@ startup_continue:
 	sgr	%r5,%r5 		# set src,length and pad to zero
 	mvcle	%r2,%r4,0		# clear mem
 	jo	.-4			# branch back, if not finish
+					# set program check new psw mask
+	mvc	__LC_PGM_NEW_PSW(8),.Lpcmsk-.LPG1(%r13)
+	larl	%r1,.Lslowmemdetect	# set program check address
+	stg	%r1,__LC_PGM_NEW_PSW+8
+	lghi	%r1,0xc
+	diag	%r0,%r1,0x260		# get memory size of virtual machine
+	cgr	%r0,%r1			# different? -> old detection routine
+	jne	.Lslowmemdetect
+	aghi	%r1,1			# size is one more than end
+	larl	%r2,memory_chunk
+	stg	%r1,8(%r2)		# store size of chunk
+	larl	%r2,memory_size
+	stg	%r1,0(%r2)		# set memory size
+	j	.Ldonemem
 
+.Lslowmemdetect:
 	l	%r2,.Lrcp-.LPG1(%r13)	# Read SCP forced command word
 .Lservicecall:
 	stosm	.Lpmask-.LPG1(%r13),0x01	# authorize ext interrupts
@@ -139,8 +154,6 @@ startup_continue:
 	.int	0x100000
 
 .Lfchunk:
-					# set program check new psw mask
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcmsk-.LPG1(%r13)
 
 #
 # find memory chunks.
