Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWJANMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWJANMb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWJANMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:12:31 -0400
Received: from havoc.gtf.org ([69.61.125.42]:34279 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932166AbWJANMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:12:30 -0400
Date: Sun, 1 Oct 2006 09:12:29 -0400
From: Jeff Garzik <jeff@garzik.org>
To: len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] acpi: fix 64-bit pointer truncation bugs
Message-ID: <20061001131229.GA30997@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The compiler complains because a pointer is being truncated to a
32-bit integer on all platforms:

drivers/acpi/executer/exmutex.c: In function ‘acpi_ex_release_mutex’:
drivers/acpi/executer/exmutex.c:268: warning: cast from pointer to integer of different size
drivers/acpi/executer/exmutex.c:268: warning: cast from pointer to integer of different size

drivers/acpi/utilities/utdebug.c: In function ‘acpi_ut_debug_print’:
drivers/acpi/utilities/utdebug.c:184: warning: cast from pointer to integer of different size
drivers/acpi/utilities/utdebug.c:184: warning: cast from pointer to integer of different size

drivers/acpi/utilities/utmutex.c: In function ‘acpi_ut_acquire_mutex’:
drivers/acpi/utilities/utmutex.c:245: warning: cast from pointer to integer of different size
drivers/acpi/utilities/utmutex.c:252: warning: cast from pointer to integer of different size
drivers/acpi/utilities/utmutex.c:260: warning: cast from pointer to integer of different size
drivers/acpi/utilities/utmutex.c: In function ‘acpi_ut_release_mutex’:
drivers/acpi/utilities/utmutex.c:287: warning: cast from pointer to integer of different size

Use the standard "%p" specifier when printing pointers directly,
and eliminate the need for casts.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index 3a39c2e..c2b6043 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
 	     walk_state->thread->thread_id)
 	    && (obj_desc->mutex.os_mutex != ACPI_GLOBAL_LOCK)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    (u32) walk_state->thread->thread_id,
+			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
+			    walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (u32) obj_desc->mutex.owner_thread->thread_id));
+			    obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index bb1eaf9..09e03d0 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -180,8 +180,8 @@ acpi_ut_debug_print(u32 requested_debug_
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     (u32) acpi_gbl_prev_thread_id, (u32) thread_id);
+			    ("\n**** Context Switch from TID %p to TID %p ****\n\n",
+			     acpi_gbl_prev_thread_id, thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
diff --git a/drivers/acpi/utilities/utmutex.c b/drivers/acpi/utilities/utmutex.c
index c39062a..3d2ed2b 100644
--- a/drivers/acpi/utilities/utmutex.c
+++ b/drivers/acpi/utilities/utmutex.c
@@ -243,23 +243,23 @@ #ifdef ACPI_MUTEX_DEBUG
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X attempting to acquire Mutex [%s]\n",
-			  (u32) this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
+			  "Thread %p attempting to acquire Mutex [%s]\n",
+			  this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %X acquired Mutex [%s]\n",
-				  (u32) this_thread_id,
+				  "Thread %p acquired Mutex [%s]\n",
+				  this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %X could not acquire Mutex [%X]",
-				(u32) this_thread_id, mutex_id));
+				"Thread %p could not acquire Mutex [%X]",
+				this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -285,7 +285,7 @@ acpi_status acpi_ut_release_mutex(acpi_m
 
 	this_thread_id = acpi_os_get_thread_id();
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X releasing Mutex [%s]\n", (u32) this_thread_id,
+			  "Thread %p releasing Mutex [%s]\n", this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
