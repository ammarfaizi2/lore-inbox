Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUHRETv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUHRETv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 00:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbUHRETv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 00:19:51 -0400
Received: from ozlabs.org ([203.10.76.45]:52427 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267254AbUHRETh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 00:19:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16674.55524.63713.164208@cargo.ozlabs.ibm.com>
Date: Wed, 18 Aug 2004 14:19:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nfont@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Reduce verbosity of RTAS error logs
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on pSeries systems the kernel will print out a hex dump of
any error events reported by the platform at boot time.  These can be
rather large and are practically incomprehensible to humans.  With
this patch, the kernel will by default print a 1-line summary for each
error reported with the severity, type, etc. printed as text strings.
The old behaviour is still available by using the rtasmsgs=on kernel
command line option.  The patch also renames some RTAS-specific
symbols to start with "RTAS_".

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN akpm-17aug/arch/ppc64/kernel/ras.c akpm/arch/ppc64/kernel/ras.c
--- akpm-17aug/arch/ppc64/kernel/ras.c	2004-08-03 08:07:43.000000000 +1000
+++ akpm/arch/ppc64/kernel/ras.c	2004-08-18 13:51:24.644939984 +1000
@@ -200,7 +200,7 @@
 
 	rtas_elog = (struct rtas_error_log *)ras_log_buf;
 
-	if ((status == 0) && (rtas_elog->severity >= SEVERITY_ERROR_SYNC))
+	if ((status == 0) && (rtas_elog->severity >= RTAS_SEVERITY_ERROR_SYNC))
 		fatal = 1;
 	else
 		fatal = 0;
diff -urN akpm-17aug/arch/ppc64/kernel/rtasd.c akpm/arch/ppc64/kernel/rtasd.c
--- akpm-17aug/arch/ppc64/kernel/rtasd.c	2004-08-18 12:19:08.503907560 +1000
+++ akpm/arch/ppc64/kernel/rtasd.c	2004-08-18 13:51:24.606945760 +1000
@@ -46,6 +46,8 @@
 static unsigned int rtas_error_log_max;
 static unsigned int rtas_error_log_buffer_max;
 
+static int full_rtas_msgs = 0;
+
 extern volatile int no_more_logging;
 
 volatile int error_log_cnt = 0;
@@ -59,6 +61,35 @@
 
 static int get_eventscan_parms(void);
 
+static char *rtas_type[] = {
+	"Unknown", "Retry", "TCE Error", "Internal Device Failure",
+	"Timeout", "Data Parity", "Address Parity", "Cache Parity",
+	"Address Invalid", "ECC Uncorrected", "ECC Corrupted",
+};
+
+static char *rtas_event_type(int type)
+{
+	if ((type > 0) && (type < 11))
+		return rtas_type[type];
+
+	switch (type) {
+		case RTAS_TYPE_EPOW:
+			return "EPOW";
+		case RTAS_TYPE_PLATFORM:
+			return "Platform Error";
+		case RTAS_TYPE_IO:
+			return "I/O Event";
+		case RTAS_TYPE_INFO:
+			return "Platform Information Event";
+		case RTAS_TYPE_DEALLOC:
+			return "Resource Deallocation Event";
+		case RTAS_TYPE_DUMP:
+			return "Dump Notification Event";
+	}
+
+	return rtas_type[0];
+}
+
 /* To see this info, grep RTAS /var/log/messages and each entry
  * will be collected together with obvious begin/end.
  * There will be a unique identifier on the begin and end lines.
@@ -80,33 +111,43 @@
 	char buffer[64];
 	char * str = "RTAS event";
 
-	printk(RTAS_DEBUG "%d -------- %s begin --------\n", error_log_cnt, str);
+	if (full_rtas_msgs) {
+		printk(RTAS_DEBUG "%d -------- %s begin --------\n",
+		       error_log_cnt, str);
+
+		/*
+		 * Print perline bytes on each line, each line will start
+		 * with RTAS and a changing number, so syslogd will
+		 * print lines that are otherwise the same.  Separate every
+		 * 4 bytes with a space.
+		 */
+		for (i = 0; i < len; i++) {
+			j = i % perline;
+			if (j == 0) {
+				memset(buffer, 0, sizeof(buffer));
+				n = sprintf(buffer, "RTAS %d:", i/perline);
+			}
 
-	/*
-	 * Print perline bytes on each line, each line will start
-	 * with RTAS and a changing number, so syslogd will
-	 * print lines that are otherwise the same.  Separate every
-	 * 4 bytes with a space.
-	 */
-	for (i=0; i < len; i++) {
-		j = i % perline;
-		if (j == 0) {
-			memset(buffer, 0, sizeof(buffer));
-			n = sprintf(buffer, "RTAS %d:", i/perline);
-		}
-
-		if ((i % 4) == 0)
-			n += sprintf(buffer+n, " ");
+			if ((i % 4) == 0)
+				n += sprintf(buffer+n, " ");
 
-		n += sprintf(buffer+n, "%02x", (unsigned char)buf[i]);
+			n += sprintf(buffer+n, "%02x", (unsigned char)buf[i]);
 
-		if (j == (perline-1))
+			if (j == (perline-1))
+				printk(KERN_DEBUG "%s\n", buffer);
+		}
+		if ((i % perline) != 0)
 			printk(KERN_DEBUG "%s\n", buffer);
-	}
-	if ((i % perline) != 0)
-		printk(KERN_DEBUG "%s\n", buffer);
 
-	printk(RTAS_DEBUG "%d -------- %s end ----------\n", error_log_cnt, str);
+		printk(RTAS_DEBUG "%d -------- %s end ----------\n",
+		       error_log_cnt, str);
+	} else {
+		struct rtas_error_log *errlog = (struct rtas_error_log *)buf;
+
+		printk(RTAS_DEBUG "event: %d, Type: %s, Severity: %d\n",
+		       error_log_cnt, rtas_event_type(errlog->type),
+		       errlog->severity);
+	}
 }
 
 static int log_rtas_len(char * buf)
@@ -484,5 +525,15 @@
 	return 1;
 }
 
+static int __init rtasmsgs_setup(char *str)
+{
+	if (strcmp(str, "on") == 0)
+		full_rtas_msgs = 1;
+	else if (strcmp(str, "off") == 0)
+		full_rtas_msgs = 0;
+
+	return 1;
+}
 __initcall(rtas_init);
 __setup("surveillance=", surveillance_setup);
+__setup("rtasmsgs=", rtasmsgs_setup);
diff -urN akpm-17aug/arch/ppc64/kernel/traps.c akpm/arch/ppc64/kernel/traps.c
--- akpm-17aug/arch/ppc64/kernel/traps.c	2004-08-18 11:45:11.000000000 +1000
+++ akpm/arch/ppc64/kernel/traps.c	2004-08-18 14:09:19.825974768 +1000
@@ -219,15 +219,15 @@
  */
 static int recover_mce(struct pt_regs *regs, struct rtas_error_log err)
 {
-	if (err.disposition == DISP_FULLY_RECOVERED) {
+	if (err.disposition == RTAS_DISP_FULLY_RECOVERED) {
 		/* Platform corrected itself */
 		return 1;
 	} else if ((regs->msr & MSR_RI) &&
 		   user_mode(regs) &&
-		   err.severity == SEVERITY_ERROR_SYNC &&
-		   err.disposition == DISP_NOT_RECOVERED &&
-		   err.target == TARGET_MEMORY &&
-		   err.type == TYPE_ECC_UNCORR &&
+		   err.severity == RTAS_SEVERITY_ERROR_SYNC &&
+		   err.disposition == RTAS_DISP_NOT_RECOVERED &&
+		   err.target == RTAS_TARGET_MEMORY &&
+		   err.type == RTAS_TYPE_ECC_UNCORR &&
 		   !(current->pid == 0 || current->pid == 1)) {
 		/* Kill off a user process with an ECC error */
 		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
diff -urN akpm-17aug/include/asm-ppc64/rtas.h akpm/include/asm-ppc64/rtas.h
--- akpm-17aug/include/asm-ppc64/rtas.h	2004-07-05 11:49:20.000000000 +1000
+++ akpm/include/asm-ppc64/rtas.h	2004-08-18 13:57:09.957897856 +1000
@@ -65,67 +65,78 @@
 	struct device_node *dev;	/* virtual address pointer */
 };
 
-/* Event classes */
+/* RTAS event classes */
 #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
 #define RTAS_POWERMGM_EVENTS		0x20000000 /* set bit 2 */
 #define RTAS_HOTPLUG_EVENTS		0x10000000 /* set bit 3 */
 #define RTAS_EVENT_SCAN_ALL_EVENTS	0xf0000000
 
-/* event-scan returns */
-#define SEVERITY_FATAL		0x5
-#define SEVERITY_ERROR		0x4
-#define SEVERITY_ERROR_SYNC	0x3
-#define SEVERITY_WARNING	0x2
-#define SEVERITY_EVENT		0x1
-#define SEVERITY_NO_ERROR	0x0
-#define DISP_FULLY_RECOVERED	0x0
-#define DISP_LIMITED_RECOVERY	0x1
-#define DISP_NOT_RECOVERED	0x2
-#define PART_PRESENT		0x0
-#define PART_NOT_PRESENT	0x1
-#define INITIATOR_UNKNOWN	0x0
-#define INITIATOR_CPU		0x1
-#define INITIATOR_PCI		0x2
-#define INITIATOR_ISA		0x3
-#define INITIATOR_MEMORY	0x4
-#define INITIATOR_POWERMGM	0x5
-#define TARGET_UNKNOWN		0x0
-#define TARGET_CPU		0x1
-#define TARGET_PCI		0x2
-#define TARGET_ISA		0x3
-#define TARGET_MEMORY		0x4
-#define TARGET_POWERMGM		0x5
-#define TYPE_RETRY		0x01
-#define TYPE_TCE_ERR		0x02
-#define TYPE_INTERN_DEV_FAIL	0x03
-#define TYPE_TIMEOUT		0x04
-#define TYPE_DATA_PARITY	0x05
-#define TYPE_ADDR_PARITY	0x06
-#define TYPE_CACHE_PARITY	0x07
-#define TYPE_ADDR_INVALID	0x08
-#define TYPE_ECC_UNCORR		0x09
-#define TYPE_ECC_CORR		0x0a
-#define TYPE_EPOW		0x40
+/* RTAS event severity */
+#define RTAS_SEVERITY_FATAL		0x5
+#define RTAS_SEVERITY_ERROR		0x4
+#define RTAS_SEVERITY_ERROR_SYNC	0x3
+#define RTAS_SEVERITY_WARNING		0x2
+#define RTAS_SEVERITY_EVENT		0x1
+#define RTAS_SEVERITY_NO_ERROR		0x0
+
+/* RTAS event disposition */
+#define RTAS_DISP_FULLY_RECOVERED	0x0
+#define RTAS_DISP_LIMITED_RECOVERY	0x1
+#define RTAS_DISP_NOT_RECOVERED		0x2
+
+/* RTAS event initiator */
+#define RTAS_INITIATOR_UNKNOWN		0x0
+#define RTAS_INITIATOR_CPU		0x1
+#define RTAS_INITIATOR_PCI		0x2
+#define RTAS_INITIATOR_ISA		0x3
+#define RTAS_INITIATOR_MEMORY		0x4
+#define RTAS_INITIATOR_POWERMGM		0x5
+
+/* RTAS event target */
+#define RTAS_TARGET_UNKNOWN		0x0
+#define RTAS_TARGET_CPU			0x1
+#define RTAS_TARGET_PCI			0x2
+#define RTAS_TARGET_ISA			0x3
+#define RTAS_TARGET_MEMORY		0x4
+#define RTAS_TARGET_POWERMGM		0x5
+
+/* RTAS event type */
+#define RTAS_TYPE_RETRY			0x01
+#define RTAS_TYPE_TCE_ERR		0x02
+#define RTAS_TYPE_INTERN_DEV_FAIL	0x03
+#define RTAS_TYPE_TIMEOUT		0x04
+#define RTAS_TYPE_DATA_PARITY		0x05
+#define RTAS_TYPE_ADDR_PARITY		0x06
+#define RTAS_TYPE_CACHE_PARITY		0x07
+#define RTAS_TYPE_ADDR_INVALID		0x08
+#define RTAS_TYPE_ECC_UNCORR		0x09
+#define RTAS_TYPE_ECC_CORR		0x0a
+#define RTAS_TYPE_EPOW			0x40
+#define RTAS_TYPE_PLATFORM		0xE0
+#define RTAS_TYPE_IO			0xE1
+#define RTAS_TYPE_INFO			0xE2
+#define RTAS_TYPE_DEALLOC		0xE3
+#define RTAS_TYPE_DUMP			0xE4
 /* I don't add PowerMGM events right now, this is a different topic */ 
-#define TYPE_PMGM_POWER_SW_ON	0x60
-#define TYPE_PMGM_POWER_SW_OFF	0x61
-#define TYPE_PMGM_LID_OPEN	0x62
-#define TYPE_PMGM_LID_CLOSE	0x63
-#define TYPE_PMGM_SLEEP_BTN	0x64
-#define TYPE_PMGM_WAKE_BTN	0x65
-#define TYPE_PMGM_BATTERY_WARN	0x66
-#define TYPE_PMGM_BATTERY_CRIT	0x67
-#define TYPE_PMGM_SWITCH_TO_BAT	0x68
-#define TYPE_PMGM_SWITCH_TO_AC	0x69
-#define TYPE_PMGM_KBD_OR_MOUSE	0x6a
-#define TYPE_PMGM_ENCLOS_OPEN	0x6b
-#define TYPE_PMGM_ENCLOS_CLOSED	0x6c
-#define TYPE_PMGM_RING_INDICATE	0x6d
-#define TYPE_PMGM_LAN_ATTENTION	0x6e
-#define TYPE_PMGM_TIME_ALARM	0x6f
-#define TYPE_PMGM_CONFIG_CHANGE	0x70
-#define TYPE_PMGM_SERVICE_PROC	0x71
+#define RTAS_TYPE_PMGM_POWER_SW_ON	0x60
+#define RTAS_TYPE_PMGM_POWER_SW_OFF	0x61
+#define RTAS_TYPE_PMGM_LID_OPEN		0x62
+#define RTAS_TYPE_PMGM_LID_CLOSE	0x63
+#define RTAS_TYPE_PMGM_SLEEP_BTN	0x64
+#define RTAS_TYPE_PMGM_WAKE_BTN		0x65
+#define RTAS_TYPE_PMGM_BATTERY_WARN	0x66
+#define RTAS_TYPE_PMGM_BATTERY_CRIT	0x67
+#define RTAS_TYPE_PMGM_SWITCH_TO_BAT	0x68
+#define RTAS_TYPE_PMGM_SWITCH_TO_AC	0x69
+#define RTAS_TYPE_PMGM_KBD_OR_MOUSE	0x6a
+#define RTAS_TYPE_PMGM_ENCLOS_OPEN	0x6b
+#define RTAS_TYPE_PMGM_ENCLOS_CLOSED	0x6c
+#define RTAS_TYPE_PMGM_RING_INDICATE	0x6d
+#define RTAS_TYPE_PMGM_LAN_ATTENTION	0x6e
+#define RTAS_TYPE_PMGM_TIME_ALARM	0x6f
+#define RTAS_TYPE_PMGM_CONFIG_CHANGE	0x70
+#define RTAS_TYPE_PMGM_SERVICE_PROC	0x71
 
 struct rtas_error_log {
 	unsigned long version:8;		/* Architectural version */
