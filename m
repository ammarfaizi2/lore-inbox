Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTCYCCo>; Mon, 24 Mar 2003 21:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCYCCo>; Mon, 24 Mar 2003 21:02:44 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:28170 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261352AbTCYCCl>; Mon, 24 Mar 2003 21:02:41 -0500
Date: Tue, 25 Mar 2003 02:13:50 +0000
From: John Levon <levon@movementarian.org>
To: oprofile-list@lists.sourceforge.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH 2/2] Module load notification take 3
Message-ID: <20030325021350.GA96216@compsoc.man.ac.uk>
References: <20030325020316.GA95492@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325020316.GA95492@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18xdwk-000N2z-00*t3VdtKBA8yI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implement a module load notifier for the benefit of OProfile, tested
with .66 on UP.
 
This patch (2/2) hooks OProfile into the notifier. You should still be
able to use OProfile 0.5.1 or thereabouts ...

thanks,
john

diff -X dontdiff -Naur linux-linus/drivers/oprofile/buffer_sync.c linux-cvs/drivers/oprofile/buffer_sync.c
--- linux-linus/drivers/oprofile/buffer_sync.c	2003-03-25 01:38:46.000000000 +0000
+++ linux-cvs/drivers/oprofile/buffer_sync.c	2003-03-25 01:34:52.000000000 +0000
@@ -24,6 +24,7 @@
 #include <linux/notifier.h>
 #include <linux/dcookies.h>
 #include <linux/profile.h>
+#include <linux/module.h>
 #include <linux/fs.h>
  
 #include "oprofile_stats.h"
@@ -67,6 +68,19 @@
 }
 
  
+static int module_load_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	if (val != MODULE_STATE_COMING)
+		return 0;
+
+	sync_cpu_buffers();
+	down(&buffer_sem);
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(MODULE_LOADED_CODE);
+	up(&buffer_sem);
+	return 0;
+}
+
 static struct notifier_block exit_task_nb = {
 	.notifier_call	= exit_task_notify,
 };
@@ -79,6 +93,10 @@
 	.notifier_call	= mm_notify,
 };
  
+static struct notifier_block module_load_nb = {
+	.notifier_call = module_load_notify,
+};
+
  
 int sync_start(void)
 {
@@ -98,9 +116,14 @@
 	err = profile_event_register(EXEC_UNMAP, &exec_unmap_nb);
 	if (err)
 		goto out3;
+	err = register_module_notifier(&module_load_nb);
+	if (err)
+		goto out4;
 
 out:
 	return err;
+out4:
+	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
 out3:
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 out2:
@@ -113,6 +136,7 @@
 
 void sync_stop(void)
 {
+	unregister_module_notifier(&module_load_nb);
 	profile_event_unregister(EXIT_TASK, &exit_task_nb);
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
diff -X dontdiff -Naur linux-linus/drivers/oprofile/event_buffer.h linux-cvs/drivers/oprofile/event_buffer.h
--- linux-linus/drivers/oprofile/event_buffer.h	2003-03-17 21:43:41.000000000 +0000
+++ linux-cvs/drivers/oprofile/event_buffer.h	2003-03-25 01:31:43.000000000 +0000
@@ -24,12 +24,13 @@
  * then one of the following codes, then the
  * relevant data.
  */
-#define ESCAPE_CODE		~0UL
+#define ESCAPE_CODE			~0UL
 #define CTX_SWITCH_CODE 		1
 #define CPU_SWITCH_CODE 		2
 #define COOKIE_SWITCH_CODE 		3
 #define KERNEL_ENTER_SWITCH_CODE	4
 #define KERNEL_EXIT_SWITCH_CODE		5
+#define MODULE_LOADED_CODE		6
  
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
