Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUA2I6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUA2I6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 03:58:14 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:22212 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263370AbUA2I6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 03:58:07 -0500
Date: Thu, 29 Jan 2004 09:57:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
Message-ID: <20040129085758.GA944@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,
> I do not undestand Alan's position, if he is for it or against it.
> Anyway, in case you want it, here's what I wrote for s390.
> I wrote some userland tests, it seems to check out. BUT I warn you,
> someone better check my assembly.
Learning to write inline assembly? Nice, but it has one small
problem, the count in %r4 is not decremented for 0x00 byte.
Try my little patch.

blue skies,
  Martin.

diff -urN linux-2.6.1/arch/s390/lib/strncpy.S linux-2.6.1-s390/arch/s390/lib/strncpy.S
--- linux-2.6.1/arch/s390/lib/strncpy.S	Fri Jan  9 07:59:45 2004
+++ linux-2.6.1-s390/arch/s390/lib/strncpy.S	Thu Jan 29 09:53:02 2004
@@ -23,8 +23,13 @@
 	LA      3,1(3)
         STC     0,0(1)
 	LA      1,1(1)
-        JZ      strncpy_exit   # ICM inserted a 0x00
+        JZ      strncpy_pad    # ICM inserted a 0x00
         BRCT    4,strncpy_loop # R4 -= 1, jump to strncpy_loop if >  0
 strncpy_exit:
         BR      14
-
+strncpy_clear:
+	STC	0,0(1)
+	LA	1,1(1)
+strncpy_pad:
+	BRCT	4,strncpy_clear
+	BR	14
diff -urN linux-2.6.1/arch/s390/lib/strncpy64.S linux-2.6.1-s390/arch/s390/lib/strncpy64.S
--- linux-2.6.1/arch/s390/lib/strncpy64.S	Fri Jan  9 07:59:10 2004
+++ linux-2.6.1-s390/arch/s390/lib/strncpy64.S	Thu Jan 29 09:53:02 2004
@@ -23,8 +23,13 @@
 	LA      3,1(3)
         STC     0,0(1)
 	LA      1,1(1)
-        JZ      strncpy_exit   # ICM inserted a 0x00
+        JZ      strncpy_pad    # ICM inserted a 0x00
         BRCTG   4,strncpy_loop # R4 -= 1, jump to strncpy_loop if > 0
 strncpy_exit:
         BR      14
-
+strncpy_clear:
+	STC	0,0(1)
+	LA	1,1(1)
+strncpy_pad:
+	BRCTG	4,strncpy_clear
+	BR	14
