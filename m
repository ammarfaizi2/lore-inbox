Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267105AbRGJTP5>; Tue, 10 Jul 2001 15:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267108AbRGJTPs>; Tue, 10 Jul 2001 15:15:48 -0400
Received: from [194.213.32.142] ([194.213.32.142]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267103AbRGJTP1>;
	Tue, 10 Jul 2001 15:15:27 -0400
Message-ID: <20010710002541.A185@bug.ucw.cz>
Date: Tue, 10 Jul 2001 00:25:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>, andrew.grover@intel.com
Subject: processor/X/info implemented, added possibility of throttling CPU manually
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First, look what my old toshiba can do:

(DaveJ, do you want to try this on your vaio? Maybe you can get 750MHz
from it...)

root@bug:/proc/acpi/processor/0# echo "limit0" > status; showmhz
299.945090 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit1" > status; showmhz
263.075141 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit2" > status; showmhz
225.667442 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit3" > status; showmhz
188.283962 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit4" > status; showmhz
150.893694 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit5" > status; showmhz
113.510769 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit6" > status; showmhz
76.121494 MHz processor.
root@bug:/proc/acpi/processor/0# echo "limit7" > status; showmhz
38.731079 MHz processor.

I can select cpu speed in 38..299MHz range. Nice.

And now, here's the diff to make it possible; please apply.
								Pavel

diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/ospm/processor/pr_osl.c linux/drivers/acpi/ospm/processor/pr_osl.c
--- clean/drivers/acpi/ospm/processor/pr_osl.c	Sun Jul  8 23:26:35 2001
+++ linux/drivers/acpi/ospm/processor/pr_osl.c	Tue Jul 10 00:22:20 2001
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 #include <acpi.h>
 #include <bm.h>
 #include "pr.h"
@@ -90,6 +91,32 @@
 	return(len);
 }
 
+int
+pr_osl_proc_write_status(struct file *file, const char *buffer,
+			 unsigned long count, void *context)
+{
+	PR_CONTEXT		*processor = NULL;
+	int 			len = 0;
+	char buf[256], buf2[256];
+
+	processor = (PR_CONTEXT*)context;
+
+	if (count > 250)
+		return -EPERM;
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+	buf[count] = 0;
+	printk("pr_osl_write_status: %s...", buf);
+	if (!strncmp(buf, "limit", 5)) {
+		char *s;
+		int i = simple_strtoul(buf+5, &s, 0);
+		pr_perf_set_state(processor, i);
+	}
+		
+	return -EL3RST;
+}
+
+
 
 /****************************************************************************
  * 
@@ -108,7 +135,7 @@
 {
 	PR_CONTEXT		*processor = NULL;
 	char			*p = page;
-	int 			len = 0;
+	int 			len = 0, i;
 
 	if (!context || (off != 0)) {
 		goto end;
@@ -116,7 +143,12 @@
 
 	processor = (PR_CONTEXT*)context;
 
-	p += sprintf(p, "<TBD>\n");
+	p += sprintf(p, "Throttling states:          %d\n", processor->performance.state_count);
+	p += sprintf(p, "Power states:               %d\n", processor->power.state_count);
+	for (i=0; i<4; i++) {
+		p += sprintf(p, "  C%d valid:                %d\n", i, processor->power.state[i].is_valid);
+		p += sprintf(p, "  C%d latency:              %d us\n", i, processor->power.state[i].latency);
+	}
 
 end:
 	len = (p - page);
@@ -141,7 +173,7 @@
 	PR_CONTEXT		*processor)
 {
 	u32			i = 0;
-	struct proc_dir_entry	*proc_entry = NULL;
+	struct proc_dir_entry	*proc_entry = NULL, *proc;
 	char			processor_uid[16];
 
 	if (!processor) {
@@ -164,15 +196,19 @@
 	sprintf(processor_uid, "%d", processor->uid);
 
 	proc_entry = proc_mkdir(processor_uid, pr_proc_root);
-	if (!proc_entry) {
+	if (!proc_entry)
 		return(AE_ERROR);
-	}
 
-	create_proc_read_entry(PR_PROC_STATUS, S_IFREG | S_IRUGO, 
-		proc_entry, pr_osl_proc_read_status, (void*)processor);
+	proc = create_proc_read_entry(PR_PROC_STATUS, S_IFREG | S_IRUGO, 
+				      proc_entry, pr_osl_proc_read_status, (void*)processor);
+	if (!proc_entry)
+		return(AE_ERROR);
+	proc->write_proc = pr_osl_proc_write_status;
 
-	create_proc_read_entry(PR_PROC_INFO, S_IFREG | S_IRUGO, 
-		proc_entry, pr_osl_proc_read_info, (void*)processor);
+	proc = create_proc_read_entry(PR_PROC_INFO, S_IFREG | S_IRUGO, 
+				      proc_entry, pr_osl_proc_read_info, (void*)processor);
+	if (!proc_entry)
+		return(AE_ERROR);
 
 	return(AE_OK);
 }

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
