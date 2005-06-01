Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVFASIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVFASIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVFASIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:08:41 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48772 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261539AbVFASEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:04:39 -0400
Date: Wed, 1 Jun 2005 20:04:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 10/11] s390: memory detection > 32GB.
Message-ID: <20050601180433.GJ6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 10/11] s390: memory detection > 32GB.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The kernel takes a very long time to boot if the memory size is bigger
then 32767 MB. The memory size is contained in a structure created by
an sclp call. The kernel accesses the field with a LH instrution which
performs a sign extension of a 16 bit word. In the case of a memory size
with bit 2^15 set this results in a very large value and the memory
detection just loops for a long time. In addition if more then 64 GB
are used on a 64 bit system the memory size is read from an incorrect
storage location.
Use zero-extention to read the 16 bit memory size and the correct offset
to read the 4 byte memory size on 64 bit.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S   |    8 ++++----
 arch/s390/kernel/head64.S |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-06-01 19:43:21.000000000 +0200
@@ -518,9 +518,9 @@ startup:basr  %r13,0                    
 	l     %r2,.Lrcp2-.LPG1(%r13)	# try with Read SCP
 	b     .Lservicecall-.LPG1(%r13)
 .Lprocsccb:
-	lh    %r1,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
-	chi   %r1,0x00
-	jne   .Lscnd
+	lghi  %r1,0
+	icm   %r1,3,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
+	jnz   .Lscnd
 	lg    %r1,.Lscpincr2-PARMAREA(%r4) # otherwise use this one
 .Lscnd:
 	xr    %r3,%r3			# same logic
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-03-02 08:37:51.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-06-01 19:43:21.000000000 +0200
@@ -517,10 +517,10 @@ startup:basr  %r13,0                    
 	l     %r2, .Lrcp2-.LPG1(%r13)	# try with Read SCP
 	b     .Lservicecall-.LPG1(%r13)
 .Lprocsccb:
-	lh    %r1,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
-	chi   %r1,0x00
-	jne   .Lscnd
-	l     %r1,.Lscpincr2-PARMAREA(%r4) # otherwise use this one
+	lhi   %r1,0
+	icm   %r1,3,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
+	jnz   .Lscnd
+	l     %r1,.Lscpincr2-PARMAREA+4(%r4) # otherwise use this one
 .Lscnd:
 	xr    %r3,%r3			# same logic
 	ic    %r3,.Lscpa1-PARMAREA(%r4)
