Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263954AbSJ3EFC>; Tue, 29 Oct 2002 23:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263958AbSJ3EFC>; Tue, 29 Oct 2002 23:05:02 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:11271 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S263954AbSJ3EE7>; Tue, 29 Oct 2002 23:04:59 -0500
Date: Wed, 30 Oct 2002 04:11:21 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix oprofile multiple counters
Message-ID: <20021030041121.GA7272@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, the below ensures we deal properly with multiple perfctr overflow
interrupts under high load.

Please apply

thanks
john


diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/op_model_athlon.c linux/arch/i386/oprofile/op_model_athlon.c
--- linux-linus/arch/i386/oprofile/op_model_athlon.c	Wed Oct 16 19:08:39 2002
+++ linux/arch/i386/oprofile/op_model_athlon.c	Thu Oct 24 02:10:26 2002
@@ -95,17 +95,16 @@
 			      struct pt_regs * const regs)
 {
 	unsigned int low, high;
-	int handled = 0;
 	int i;
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(regs->eip, i, cpu);
 			CTR_WRITE(reset_value[i], msrs, i);
-			handled = 1;
+			return 1;
 		}
 	}
-	return handled;
+	return 0;
 }
 
  
diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/op_model_ppro.c linux/arch/i386/oprofile/op_model_ppro.c
--- linux-linus/arch/i386/oprofile/op_model_ppro.c	Wed Oct 16 19:08:39 2002
+++ linux/arch/i386/oprofile/op_model_ppro.c	Thu Oct 24 02:10:42 2002
@@ -90,17 +90,16 @@
 {
 	unsigned int low, high;
 	int i;
-	int handled = 0;
  
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(regs->eip, i, cpu);
 			CTR_WRITE(reset_value[i], msrs, i);
-			handled = 1;
+			return 1;
 		}
 	}
-	return handled;
+	return 0;
 }
 
  
