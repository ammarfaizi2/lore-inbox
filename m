Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTEZEOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTEZEOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:14:24 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:52241 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264252AbTEZEOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:14:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10539232492885@movementarian.org>
Subject: [PATCH 2/5] OProfile update
In-Reply-To: <1053923249281@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Mon, 26 May 2003 05:27:29 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19K9a6-000Npd-1w*5jk2SYvsMPA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The code that attempts to reset last_task and in_kernel has a race
against samples appearing during the handling of the buffers, that
causes a small number of mis-attribution of samples. Closing the
window is non-obvious, and not worth it, so we just make it smaller.
Even without the patch, there seem to be few such "bad" samples
because its effects are mitigated on a switch into userspace or
a task switch.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-05-26 03:20:20.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-05-26 04:25:15.000000000 +0100
@@ -366,12 +377,26 @@
 }
  
 
-/* compute number of filled slots in cpu_buffer queue */
-static unsigned long nr_filled_slots(struct oprofile_cpu_buffer * b)
+/* "acquire" as many cpu buffer slots as we can */
+static unsigned long get_slots(struct oprofile_cpu_buffer * b)
 {
 	unsigned long head = b->head_pos;
 	unsigned long tail = b->tail_pos;
 
+	/*
+	 * Subtle. This resets the persistent last_task
+	 * and in_kernel values used for switching notes.
+	 * BUT, there is a small window between reading
+	 * head_pos, and this call, that means samples
+	 * can appear at the new head position, but not
+	 * be prefixed with the notes for switching
+	 * kernel mode or a task switch. This small hole
+	 * can lead to mis-attribution or samples where
+	 * we don't know if it's in the kernel or not,
+	 * at the start of an event buffer.
+	 */
+	cpu_buffer_reset(b);
+
 	if (head >= tail)
 		return head - tail;
 
@@ -408,9 +433,9 @@
  
 	/* Remember, only we can modify tail_pos */
 
-	unsigned long const available_elements = nr_filled_slots(cpu_buf);
+	unsigned long const available = get_slots(cpu_buf);
   
-	for (i=0; i < available_elements; ++i) {
+	for (i=0; i < available; ++i) {
 		struct op_sample * s = &cpu_buf->buffer[cpu_buf->tail_pos];
  
 		if (is_ctx_switch(s->eip)) {
@@ -435,8 +460,6 @@
 		increment_tail(cpu_buf);
 	}
 	release_mm(mm);
-
-	cpu_buffer_reset(cpu_buf);
 }
  
  

