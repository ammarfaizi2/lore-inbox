Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030690AbWKOQqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbWKOQqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030683AbWKOQqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:46:46 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:60335
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030690AbWKOQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:46:45 -0500
Message-Id: <455B52CF.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 16:47:59 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "linux-acpi" <linux-acpi@intel.com>, "Mikael Pettersson" <mikpe@it.uu.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] avoid compiler warnings
References: <455B36D2.76E4.0078.0@novell.com>
 <17755.13665.576585.82545@alkaid.it.uu.se>
In-Reply-To: <17755.13665.576585.82545@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Pointers should not be casted to u32 as this results in compiler warnings
>>on 64-bit platforms.
>
>NAK. Use "%p" for formatting pointers. No casts needed.

Indeed, how did I not see this... While at this, I saw that there were a few
more instances that needed fixing (they weren't actively generating warnings
because of the build settings).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/drivers/acpi/executer/exmutex.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-acpi-warnings/drivers/acpi/executer/exmutex.c	2006-11-15 17:22:39.000000000 +0100
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
 
--- linux-2.6.19-rc5/drivers/acpi/utilities/utmutex.c	2006-09-20 05:42:06.000000000 +0200
+++ 2.6.19-rc5-acpi-warnings/drivers/acpi/utilities/utmutex.c	2006-11-15 17:24:31.000000000 +0100
@@ -222,7 +222,7 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
 			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
 				if (i == mutex_id) {
 					ACPI_ERROR((AE_INFO,
-						    "Mutex [%s] already acquired by this thread [%X]",
+						    "Mutex [%s] already acquired by this thread [%p]",
 						    acpi_ut_get_mutex_name
 						    (mutex_id),
 						    this_thread_id));
@@ -231,7 +231,7 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
 				}
 
 				ACPI_ERROR((AE_INFO,
-					    "Invalid acquire order: Thread %X owns [%s], wants [%s]",
+					    "Invalid acquire order: Thread %p owns [%s], wants [%s]",
 					    this_thread_id,
 					    acpi_ut_get_mutex_name(i),
 					    acpi_ut_get_mutex_name(mutex_id)));
@@ -243,23 +243,23 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
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


