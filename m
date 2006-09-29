Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWI2ViK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWI2ViK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWI2ViK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:38:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41345 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964851AbWI2ViG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:38:06 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=QURIjE+NcsYJZveOBZwzn0P0BaYQ3Sa20m0xq1iIJFpIO/mEyo4e9NSIyFogjDKbT
	g6kfXJ1ufjtvtqwksL5rA==
Message-ID: <451D9236.6040902@google.com>
Date: Fri, 29 Sep 2006 14:37:58 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] Fix up a multitude of ACPI compiler warnings on x86_64
Content-Type: multipart/mixed;
 boundary="------------040401070608060604030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401070608060604030407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

32bit vs 64 bit issues. sizeof(sizeof) and sizeof(pointer) is variable,
but we're trying to shove it into unsigned int or u32.

Signed-off-by: Martin J. Bligh <mbligh@google.com>

--------------040401070608060604030407
Content-Type: text/plain;
 name="2.6.18-acpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-acpi"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/acpi/executer/exmutex.c 2.6.18-acpi/drivers/acpi/executer/exmutex.c
--- linux-2.6.18/drivers/acpi/executer/exmutex.c	2006-09-20 12:24:30.000000000 -0700
+++ 2.6.18-acpi/drivers/acpi/executer/exmutex.c	2006-09-29 14:34:44.000000000 -0700
@@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
 	     walk_state->thread->thread_id)
 	    && (obj_desc->mutex.os_mutex != ACPI_GLOBAL_LOCK)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    (u32) walk_state->thread->thread_id,
+			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
+			    (unsigned long)walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (u32) obj_desc->mutex.owner_thread->thread_id));
+			    (unsigned long)obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/acpi/tables/tbget.c 2.6.18-acpi/drivers/acpi/tables/tbget.c
--- linux-2.6.18/drivers/acpi/tables/tbget.c	2006-09-20 12:24:30.000000000 -0700
+++ 2.6.18-acpi/drivers/acpi/tables/tbget.c	2006-09-29 14:34:44.000000000 -0700
@@ -324,8 +324,8 @@ acpi_tb_get_this_table(struct acpi_point
 
 	if (header->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "Table length (%X) is smaller than minimum (%X)",
-			    header->length, sizeof(struct acpi_table_header)));
+			    "Table length (%X) is smaller than minimum (%lX)",
+			    header->length, (unsigned long) sizeof(struct acpi_table_header)));
 
 		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
 	}
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/acpi/tables/tbrsdt.c 2.6.18-acpi/drivers/acpi/tables/tbrsdt.c
--- linux-2.6.18/drivers/acpi/tables/tbrsdt.c	2006-09-20 12:24:30.000000000 -0700
+++ 2.6.18-acpi/drivers/acpi/tables/tbrsdt.c	2006-09-29 14:34:44.000000000 -0700
@@ -187,9 +187,9 @@ acpi_status acpi_tb_validate_rsdt(struct
 
 	if (table_ptr->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
+			    "RSDT/XSDT length (%X) is smaller than minimum (%lX)",
 			    table_ptr->length,
-			    sizeof(struct acpi_table_header)));
+			    (unsigned long) sizeof(struct acpi_table_header)));
 
 		return (AE_INVALID_TABLE_LENGTH);
 	}
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/acpi/utilities/utdebug.c 2.6.18-acpi/drivers/acpi/utilities/utdebug.c
--- linux-2.6.18/drivers/acpi/utilities/utdebug.c	2006-09-20 12:24:30.000000000 -0700
+++ 2.6.18-acpi/drivers/acpi/utilities/utdebug.c	2006-09-29 14:34:44.000000000 -0700
@@ -180,8 +180,9 @@ acpi_ut_debug_print(u32 requested_debug_
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     (u32) acpi_gbl_prev_thread_id, (u32) thread_id);
+			    ("\n**** Context Switch from TID %lX to TID %lX ****\n\n",
+			     (unsigned long) acpi_gbl_prev_thread_id,
+			     (unsigned long) thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/acpi/utilities/utmutex.c 2.6.18-acpi/drivers/acpi/utilities/utmutex.c
--- linux-2.6.18/drivers/acpi/utilities/utmutex.c	2006-09-20 12:24:30.000000000 -0700
+++ 2.6.18-acpi/drivers/acpi/utilities/utmutex.c	2006-09-29 14:34:44.000000000 -0700
@@ -243,23 +243,24 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X attempting to acquire Mutex [%s]\n",
-			  (u32) this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
+			  "Thread %lX attempting to acquire Mutex [%s]\n",
+			  (unsigned long) this_thread_id, 
+			  acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %X acquired Mutex [%s]\n",
-				  (u32) this_thread_id,
+				  "Thread %lX acquired Mutex [%s]\n",
+				  (unsigned long) this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %X could not acquire Mutex [%X]",
-				(u32) this_thread_id, mutex_id));
+				"Thread %lX could not acquire Mutex [%X]",
+				(unsigned long) this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -285,7 +286,8 @@ acpi_status acpi_ut_release_mutex(acpi_m
 
 	this_thread_id = acpi_os_get_thread_id();
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X releasing Mutex [%s]\n", (u32) this_thread_id,
+			  "Thread %lX releasing Mutex [%s]\n",
+			  (unsigned long) this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {

--------------040401070608060604030407--
