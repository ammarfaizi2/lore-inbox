Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933136AbWFZXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbWFZXpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbWFZXpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:45:38 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24479 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933137AbWFZWdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/16] [Suspend2] General proc entries for suspend.
Date: Tue, 27 Jun 2006 08:33:52 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223351.3832.44436.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the proc entries for Suspend2's core - debug_info,
extra_pages_allowance, ignore_rootfs, image_exists, image_size_limit,
last_result, reboot, resume2, resume_commandline, version. If PM_DEBUG is
enabled, there are also entries for testing the freezer, block io, filters
speed, for adding delays at different steps and disabling pageset2. If ACPI
is enabled, the user can select sleep states S3, S4 or S5 as powerdown
methods. Keepimage mode, since it could cause damage if used without
consideration, depends on a compile time option.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |  205 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4eabb21..429d2eb 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -691,3 +691,208 @@ static int image_exists_write(struct fil
 	return count;
 }
 
+/*
+ * Core proc entries that aren't built in.
+ *
+ * This array contains entries that are automatically registered at
+ * boot. Modules and the console code register their own entries separately.
+ */
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "debug_info",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .data = {
+		  .special = {
+			  .read_proc	= debuginfo_read_proc,
+		  }
+	  }
+	},
+	
+	{ .filename			= "extra_pages_allowance",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_LONG,
+	  .data = {
+		  .a_long = {
+			  .variable	= &extra_pd1_pages_allowance,
+			  .minimum	= 0,
+			  .maximum	= INT_MAX,
+		  }
+	  }
+	},
+	
+	{ .filename			= "ignore_rootfs",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_IGNORE_ROOTFS,
+		  }
+	  }
+	},
+	
+	{ .filename			= "image_exists",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .needs_storage_manager	= 3,
+	  .data = {
+		  .special = {
+			  .read_proc	= image_exists_read,
+			  .write_proc	= image_exists_write,
+		  }
+	  }
+	},
+
+	{ .filename			= "image_size_limit",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_LONG,
+	  .data = {
+		  .a_long = {
+			  .variable	= &image_size_limit,
+			  .minimum	= -2,
+			  .maximum	= 32767,
+		  }
+	  }
+	},
+
+	{ .filename			= "last_result",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	=  &suspend_result,
+		  }
+	  }
+	},
+	
+	{ .filename			= "reboot",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_REBOOT,
+		  }
+	  }
+	},
+	  
+	{ .filename			= "resume2",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .needs_storage_manager	= 2,
+	  .data = {
+		  .string = {
+			  .variable	= resume2_file,
+			  .max_length	= 255,
+		  }
+	  },
+	  .write_proc			= attempt_to_parse_resume_device2,
+	},
+
+	{ .filename			= "resume_commandline",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= suspend_resume_commandline,
+			  .max_length	= COMMAND_LINE_SIZE,
+		  }
+	  },
+	},
+
+	{ .filename			= "version",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= suspend_core_version,
+		  }
+	  }
+	},
+
+#ifdef CONFIG_PM_DEBUG
+	{ .filename			= "freezer_test",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_FREEZER_TEST,
+		  }
+	  }
+	},
+
+	{ .filename			= "test_bio",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_TEST_BIO,
+		  }
+	  }
+	},
+
+	{ .filename			= "test_filter_speed",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_TEST_FILTER_SPEED,
+		  }
+	  }
+	},
+
+	{ .filename			= "slow",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_SLOW,
+		  }
+	  }
+	},
+	
+	{ .filename			= "no_pageset2",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_NO_PAGESET2,
+		  }
+	  }
+	},
+	
+#endif
+	  
+#if defined(CONFIG_ACPI)
+	{ .filename			= "powerdown_method",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &suspend_powerdown_method,
+			  .minimum	= 0,
+			  .maximum	= 5,
+		  }
+	  }
+	},
+#endif
+
+#ifdef CONFIG_SUSPEND2_KEEP_IMAGE
+	{ .filename			= "keep_image",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_KEEP_IMAGE,
+		  }
+	  }
+	},
+#endif
+};
+       

--
Nigel Cunningham		nigel at suspend2 dot net
