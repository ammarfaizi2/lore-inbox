Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbTCIPiP>; Sun, 9 Mar 2003 10:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbTCIPiP>; Sun, 9 Mar 2003 10:38:15 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:20494 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262525AbTCIPiN>; Sun, 9 Mar 2003 10:38:13 -0500
Date: Sun, 9 Mar 2003 15:48:42 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       oprofile-list@lists.sf.net
Subject: [PATCH] fix oprofile on x86 > 1 counter
Message-ID: <20030309154841.GA19585@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18s32Y-000JGE-00*TJZxKzeGu9E*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See the comment below, without this we have a choice between
dropping lots of counter events for counters > 0, or getting dazed and
confused. This brings it inline with the 2.4 module code. Tested on my 2-way.

Also fix a typo from Steven Cole, and remove some unnecessary code

please apply,
john


diff -Naur -X dontdiff linux-linus/arch/alpha/oprofile/op_model_ev4.c linux/arch/alpha/oprofile/op_model_ev4.c
--- linux-linus/arch/alpha/oprofile/op_model_ev4.c	2003-02-25 13:53:47.000000000 +0000
+++ linux/arch/alpha/oprofile/op_model_ev4.c	2003-03-08 04:31:28.000000000 +0000
@@ -34,7 +34,7 @@
 	   for these "disabled" counter overflows are ignored by the
 	   interrupt handler.
 
-	   This is most irritating, becuase the hardware *can* enable and
+	   This is most irritating, because the hardware *can* enable and
 	   disable the interrupts for these counters independently, but the
 	   wrperfmon interface doesn't allow it.  */
 
diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/op_model_athlon.c linux/arch/i386/oprofile/op_model_athlon.c
--- linux-linus/arch/i386/oprofile/op_model_athlon.c	2003-02-15 18:10:37.000000000 +0000
+++ linux/arch/i386/oprofile/op_model_athlon.c	2003-03-09 13:09:00.000000000 +0000
@@ -104,10 +104,11 @@
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(eip, is_kernel, i, cpu);
 			CTR_WRITE(reset_value[i], msrs, i);
-			return 1;
 		}
 	}
-	return 0;
+
+	/* See op_model_ppro.c */
+	return 1;
 }
 
  
diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/op_model_p4.c linux/arch/i386/oprofile/op_model_p4.c
--- linux-linus/arch/i386/oprofile/op_model_p4.c	2003-03-06 16:18:50.000000000 +0000
+++ linux/arch/i386/oprofile/op_model_p4.c	2003-03-09 13:08:41.000000000 +0000
@@ -608,13 +608,14 @@
  			CTR_WRITE(reset_value[i], real);
 			/* P4 quirk: you have to re-unmask the apic vector */
 			apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
-			return 1;
 		}
 	}
 
 	/* P4 quirk: you have to re-unmask the apic vector */
 	apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
-	return 0;
+
+	/* See op_model_ppro.c */
+	return 1;
 }
 
 
diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/op_model_ppro.c linux/arch/i386/oprofile/op_model_ppro.c
--- linux-linus/arch/i386/oprofile/op_model_ppro.c	2003-02-15 18:10:37.000000000 +0000
+++ linux/arch/i386/oprofile/op_model_ppro.c	2003-03-09 14:15:07.000000000 +0000
@@ -98,10 +98,17 @@
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(eip, is_kernel, i, cpu);
 			CTR_WRITE(reset_value[i], msrs, i);
-			return 1;
 		}
 	}
-	return 0;
+
+	/* We can't work out if we really handled an interrupt. We
+	 * might have caught a *second* counter just after overflowing
+	 * the interrupt for this counter then arrives
+	 * and we don't find a counter that's overflowed, so we
+	 * would return 0 and get dazed + confused. Instead we always
+	 * assume we found an overflow. This sucks.
+	 */
+	return 1;
 }
 
  
diff -Naur -X dontdiff linux-linus/drivers/oprofile/cpu_buffer.c linux/drivers/oprofile/cpu_buffer.c
--- linux-linus/drivers/oprofile/cpu_buffer.c	2003-03-06 16:18:50.000000000 +0000
+++ linux/drivers/oprofile/cpu_buffer.c	2003-03-06 16:24:34.000000000 +0000
@@ -85,9 +85,6 @@
 	unsigned long head = b->head_pos;
 	unsigned long tail = b->tail_pos;
 
-	if (tail == head)
-		return b->buffer_size;
-
 	if (tail > head)
 		return tail - head;
 
