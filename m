Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWAFVvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWAFVvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbWAFVvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:51:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19091 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751588AbWAFVvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:51:22 -0500
Subject: [patch 1/4]  fix some f_ops abuse in acpi
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, akpm@osdl.org
In-Reply-To: <1136583937.2940.90.camel@laptopd505.fenrus.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 22:46:57 +0100
Message-Id: <1136584017.2940.93.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

The ACPI layer writes to acpi_processor_limit_fops.write at runtime, while
it in reality is a compile time constant. Move this to the struct definition
instead.
Similar for acpi_video_bus_POST_fops.write and friends, but keep doing those 
at runtime to avoid prototype-hell.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
CC: Len Brown <len.brown@intel.com>

Index: linux-2.6.15/drivers/acpi/processor_core.c
 drivers/acpi/processor_core.c       |    2 --
 drivers/acpi/processor_perflib.c    |    2 +-
 drivers/acpi/processor_thermal.c    |    1 +
 drivers/acpi/processor_throttling.c |    1 +
 drivers/acpi/video.c                |    8 ++++----
 5 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.15/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_core.c
+++ linux-2.6.15/drivers/acpi/processor_core.c
@@ -357,7 +357,6 @@ static int acpi_processor_add_fs(struct 
 				  ACPI_PROCESSOR_FILE_THROTTLING));
 	else {
 		entry->proc_fops = &acpi_processor_throttling_fops;
-		entry->proc_fops->write = acpi_processor_write_throttling;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
@@ -372,7 +371,6 @@ static int acpi_processor_add_fs(struct 
 				  ACPI_PROCESSOR_FILE_LIMIT));
 	else {
 		entry->proc_fops = &acpi_processor_limit_fops;
-		entry->proc_fops->write = acpi_processor_write_limit;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
Index: linux-2.6.15/drivers/acpi/processor_thermal.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_thermal.c
+++ linux-2.6.15/drivers/acpi/processor_thermal.c
@@ -394,6 +394,7 @@ ssize_t acpi_processor_write_limit(struc
 struct file_operations acpi_processor_limit_fops = {
 	.open = acpi_processor_limit_open_fs,
 	.read = seq_read,
+	.write = acpi_processor_write_limit,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
Index: linux-2.6.15/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.15/drivers/acpi/processor_throttling.c
@@ -337,6 +337,7 @@ ssize_t acpi_processor_write_throttling(
 struct file_operations acpi_processor_throttling_fops = {
 	.open = acpi_processor_throttling_open_fs,
 	.read = seq_read,
+	.write = acpi_processor_write_throttling,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
Index: linux-2.6.15/drivers/acpi/video.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/video.c
+++ linux-2.6.15/drivers/acpi/video.c
@@ -920,8 +920,8 @@ static int acpi_video_device_add_fs(stru
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Unable to create 'state' fs entry\n"));
 	else {
+		acpi_video_device_state_fops.write = acpi_video_device_write_state;
 		entry->proc_fops = &acpi_video_device_state_fops;
-		entry->proc_fops->write = acpi_video_device_write_state;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
@@ -934,8 +934,8 @@ static int acpi_video_device_add_fs(stru
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Unable to create 'brightness' fs entry\n"));
 	else {
+		acpi_video_device_brightness_fops.write = acpi_video_device_write_brightness;
 		entry->proc_fops = &acpi_video_device_brightness_fops;
-		entry->proc_fops->write = acpi_video_device_write_brightness;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
@@ -1239,8 +1239,8 @@ static int acpi_video_bus_add_fs(struct 
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Unable to create 'POST' fs entry\n"));
 	else {
+		acpi_video_bus_POST_fops.write = acpi_video_bus_write_POST;
 		entry->proc_fops = &acpi_video_bus_POST_fops;
-		entry->proc_fops->write = acpi_video_bus_write_POST;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
@@ -1253,8 +1253,8 @@ static int acpi_video_bus_add_fs(struct 
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Unable to create 'DOS' fs entry\n"));
 	else {
+		acpi_video_bus_DOS_fops.write = acpi_video_bus_write_DOS;
 		entry->proc_fops = &acpi_video_bus_DOS_fops;
-		entry->proc_fops->write = acpi_video_bus_write_DOS;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
Index: linux-2.6.15/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.15/drivers/acpi/processor_perflib.c
@@ -520,8 +520,8 @@ static void acpi_cpufreq_add_file(struct
 				  "Unable to create '%s' fs entry\n",
 				  ACPI_PROCESSOR_FILE_PERFORMANCE));
 	else {
+		acpi_processor_perf_fops.write = acpi_processor_write_performance;
 		entry->proc_fops = &acpi_processor_perf_fops;
-		entry->proc_fops->write = acpi_processor_write_performance;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}


