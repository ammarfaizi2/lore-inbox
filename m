Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264698AbTFLBwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbTFLBts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:49:48 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:62221 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264692AbTFLBsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:48:51 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553833533873@movementarian.org>
Subject: [PATCH 4/4] OProfile: fix init / exit routine
In-Reply-To: <10553833522557@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 12 Jun 2003 03:02:33 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19QHQA-000FFv-L2*KbI8Emw4Wc2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ensure that the arch exit routines are always called when needed,
previously we could end up with a nasty crash if using oprofile.timer=1,
or the FS register failed.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprof.c linux-fixes/drivers/oprofile/oprof.c
--- linux-cvs/drivers/oprofile/oprof.c	2003-05-26 05:42:45.000000000 +0100
+++ linux-fixes/drivers/oprofile/oprof.c	2003-06-12 03:07:14.000000000 +0100
@@ -131,36 +131,33 @@
 
 static int __init oprofile_init(void)
 {
-	int err = -ENODEV;
+	/* Architecture must fill in the interrupt ops and the
+	 * logical CPU type, or we can fall back to the timer
+	 * interrupt profiler.
+	 */
+	int err = oprofile_arch_init(&oprofile_ops);
 
-	if (!timer) {
-		/* Architecture must fill in the interrupt ops and the
-		 * logical CPU type, or we can fall back to the timer
-		 * interrupt profiler.
-		 */
-		err = oprofile_arch_init(&oprofile_ops);
-	}
-
-	if (err == -ENODEV) {
+	if (err == -ENODEV || timer) {
 		timer_init(&oprofile_ops);
 		err = 0;
-	}
-
-	if (err)
+	} else if (err) {
 		goto out;
+	}
 
 	if (!oprofile_ops->cpu_type) {
 		printk(KERN_ERR "oprofile: cpu_type not set !\n");
 		err = -EFAULT;
-		goto out;
+	} else {
+		err = oprofilefs_register();
 	}
-
-	err = oprofilefs_register();
-	if (err)
-		goto out;
  
+	if (err)
+		goto out_exit;
 out:
 	return err;
+out_exit:
+	oprofile_arch_exit();
+	goto out;
 }
 
 
diff -Naur -X dontdiff linux-cvs/include/linux/oprofile.h linux-fixes/include/linux/oprofile.h
--- linux-cvs/include/linux/oprofile.h	2003-04-05 05:12:09.000000000 +0100
+++ linux-fixes/include/linux/oprofile.h	2003-06-12 02:03:47.000000000 +0100
@@ -40,7 +40,9 @@
 
 /**
  * One-time initialisation. *ops must be set to a filled-in
- * operations structure.
+ * operations structure. This is called even in timer interrupt
+ * mode.
+ *
  * Return 0 on success.
  */
 int oprofile_arch_init(struct oprofile_operations ** ops);

