Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUIPXKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUIPXKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUIPXKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:10:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:55797 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268335AbUIPXGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:06:50 -0400
Date: Thu, 16 Sep 2004 18:06:47 -0500
To: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulus@samba.org, anton@samba.org
Subject: [PATCH] add syslog printing to xmon debugger.
Message-ID: <20040916230647.GN9645@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hi,

This patch 'dmesg'/printk log buffer printing to xmon.  I find this
useful because crashes are almost always preceeded by interesting 
printk's.   This patch is simple & straightforward, except for one 
possibly controversial aspect: it embeds a small snippet in 
kernel/printk.c to return the location of the syslog.  This is 
needed because kallsyms and even CONFIG_KALLSYMS_ALL is not enough 
to reveal the location of log_buf.   This code is about 90%
cut-n-paste of earlier code from Keith Owens.  

Andrew,

Please apply at least the kernel/printk.c part of the patch,
if you are feeling at all charitable.

Signed-off-by: Linas Vepstas <linas@linas.org>

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xmon-dmesg-printing.patch"

===== arch/ppc64/xmon/xmon.c 1.50 vs edited =====
--- 1.50/arch/ppc64/xmon/xmon.c	Fri Jul  2 00:23:46 2004
+++ edited/arch/ppc64/xmon/xmon.c	Thu Sep 16 16:49:23 2004
@@ -132,6 +132,7 @@
 static void bootcmds(void);
 void dump_segments(void);
 static void symbol_lookup(void);
+static void xmon_show_dmesg(void);
 static int emulate_step(struct pt_regs *regs, unsigned int instr);
 static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after);
@@ -175,6 +176,7 @@
 #endif
   "\
   C	checksum\n\
+  D	show dmesg (printk) buffer\n\
   d	dump bytes\n\
   di	dump instructions\n\
   df	dump float values\n\
@@ -911,6 +913,9 @@
 		case 'd':
 			dump();
 			break;
+		case 'D':
+			xmon_show_dmesg();
+			break;
 		case 'l':
 			symbol_lookup();
 			break;
@@ -2452,6 +2457,58 @@
 			printf(" [%s]", modname);
 	}
 	printf("%s", after);
+}
+
+extern void debugger_syslog_data(char *syslog_data[4]);
+#define SYSLOG_WRAP(p) if (p < syslog_data[0]) p = syslog_data[1]-1; \
+	else if (p >= syslog_data[1]) p = syslog_data[0];
+
+static void xmon_show_dmesg(void)
+{
+	char *syslog_data[4], *start, *end, c;
+	int logsize;
+
+	/* syslog_data[0,1] physical start, end+1.  
+	 * syslog_data[2,3] logical start, end+1. 
+	 */
+	debugger_syslog_data(syslog_data);
+	if (syslog_data[2] == syslog_data[3])
+		return;
+	logsize = syslog_data[1] - syslog_data[0];
+	start = syslog_data[0] + (syslog_data[2] - syslog_data[0]) % logsize;
+	end = syslog_data[0] + (syslog_data[3] - syslog_data[0]) % logsize;
+
+	/* Do a line at a time (max 200 chars) to reduce overhead */
+	c = '\0';
+	while(1) {
+		char *p;
+		int chars = 0;
+		if (!*start) {
+			while (!*start) {
+				++start;
+				SYSLOG_WRAP(start);
+				if (start == end)
+					break;
+			}
+			if (start == end)
+				break;
+		}
+		p = start;
+		while (*start && chars < 200) {
+			c = *start;
+			++chars;
+			++start;
+			SYSLOG_WRAP(start);
+			if (start == end || c == '\n')
+				break;
+		}
+		if (chars)
+			printf("%.*s", chars, p);
+		if (start == end)
+			break;
+	}
+	if (c != '\n')
+		printf("\n");
 }
 
 static void debug_trace(void)
===== kernel/printk.c 1.41 vs edited =====
--- 1.41/kernel/printk.c	Mon Aug 23 03:15:11 2004
+++ edited/kernel/printk.c	Thu Sep 16 15:50:59 2004
@@ -376,6 +376,21 @@
 	return do_syslog(type, buf, len);
 }
 
+#ifdef   CONFIG_DEBUG_KERNEL
+/* Its very handy to be able to view the syslog buffer during debug. 
+ * But do_syslog() uses locks so it cannot be used during debugging.  
+ * Instead, provide the start and end of the physical and logical logs.  
+ * This is equivalent to do_syslog(3).
+ */
+void debugger_syslog_data(char *syslog_data[4])
+{
+	syslog_data[0] = log_buf;
+	syslog_data[1] = log_buf + __LOG_BUF_LEN;
+	syslog_data[2] = log_buf + log_end - (logged_chars < __LOG_BUF_LEN ? logged_chars : __LOG_BUF_LEN);
+	syslog_data[3] = log_buf + log_end;
+}
+#endif   /* CONFIG_DEBUG_KERNEL */
+
 /*
  * Call the console drivers on a range of log_buf
  */

--wzJLGUyc3ArbnUjN--
