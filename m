Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTECXdC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTECXcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:32:35 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:53768 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263481AbTECXbr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:47 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052005448795@movementarian.org>
Subject: [PATCH 8/8] OProfile update
In-Reply-To: <10520054473121@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:08 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.4 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fp-0009tv-5u*7ldV6UC71Ps*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Schedule work away on an unmap, instead of calling it directly. Should result
in less lost samples, and it fixes a lock ordering problem buffer_sem <-> mmap_sem

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-04-05 18:44:49.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-05-03 20:10:44.000000000 +0100
@@ -58,8 +58,8 @@
  * must concern ourselves with. First, when a task is about to
  * exit (exit_mmap()), we should process the buffer to deal with
  * any samples in the CPU buffer, before we lose the ->mmap information
- * we need. Second, a task may unmap (part of) an executable mmap,
- * so we want to process samples before that happens too
+ * we need. It is vital to get this case correct, otherwise we can
+ * end up trying to access a freed task_struct.
  */
 static int mm_notify(struct notifier_block * self, unsigned long val, void * data)
 {
@@ -67,6 +67,29 @@
 	return 0;
 }
 
+
+/* Second, a task may unmap (part of) an executable mmap,
+ * so we want to process samples before that happens too. This is merely
+ * a QOI issue not a correctness one.
+ */
+static int munmap_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	/* Note that we cannot sync the buffers directly, because we might end up
+	 * taking the the mmap_sem that we hold now inside of event_buffer_read()
+	 * on a page fault, whilst holding buffer_sem - deadlock.
+	 *
+	 * This would mean a threaded reader of the event buffer, but we should
+	 * prevent it anyway.
+	 *
+	 * Delaying the work in a context that doesn't hold the mmap_sem means
+	 * that we won't lose samples from other mappings that current() may
+	 * have. Note that either way, we lose any pending samples for what is
+	 * being unmapped.
+	 */
+	schedule_work(&sync_wq);
+	return 0;
+}
+
  
 /* We need to be told about new modules so we don't attribute to a previously
  * loaded module, or drop the samples on the floor.
@@ -92,7 +115,7 @@
 };
 
 static struct notifier_block exec_unmap_nb = {
-	.notifier_call	= mm_notify,
+	.notifier_call	= munmap_notify,
 };
 
 static struct notifier_block exit_mmap_nb = {

