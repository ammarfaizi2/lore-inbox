Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTBNUji>; Fri, 14 Feb 2003 15:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbTBNUji>; Fri, 14 Feb 2003 15:39:38 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267421AbTBNUit>;
	Fri, 14 Feb 2003 15:38:49 -0500
Date: Thu, 13 Feb 2003 23:39:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Cc: Patrick Mochel <mochel@osdl.org>
Subject: More seq-file fixes for /proc/acpi
Message-ID: <20030213223900.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

More seq-file fixes. [This is not a dup ;-)] Toshiba maintainer,
please fix your stuff yourself. This should fix all /proc write
problems in acpi I know... Please apply,

							Pavel

--- clean/drivers/acpi/processor.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-02-13 23:16:28.000000000 +0100
@@ -1356,7 +1356,8 @@
         loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			state_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_processor_write_throttling");
@@ -1418,7 +1419,8 @@
 	loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			limit_string[25] = {'\0'};
 	int			px = 0;
 	int			tx = 0;
--- clean/drivers/acpi/thermal.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2003-02-13 23:17:37.000000000 +0100
@@ -946,11 +948,12 @@
 acpi_thermal_write_cooling_mode (
 	struct file		*file,
 	const char		*buffer,
-	size_t			count,
-	loff_t			*data)
+	unsigned long		count,
+	loff_t			*ppos)
 {
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			mode_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_cooling_mode");
@@ -1006,11 +1009,12 @@
 acpi_thermal_write_polling (
 	struct file		*file,
 	const char		*buffer,
-	size_t			count,
-	loff_t			*data)
+	unsigned long		count,
+	loff_t			*ppos)
 {
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			polling_string[12] = {'\0'};
 	int			seconds = 0;
 
--- clean/drivers/acpi/toshiba_acpi.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/toshiba_acpi.c	2003-02-13 23:17:16.000000000 +0100
@@ -519,6 +519,7 @@
 	if (proc) {
 		proc->proc_fops = &toshiba_lcd_fops;
 		proc->proc_fops->write = proc_write_lcd;
+#warning You need to fix up after converting to seq_file; see thermal.c for examples.
 	}
 
 	proc = create_proc_entry(PROC_VIDEO, S_IFREG | S_IRUGO | S_IWUSR,

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
