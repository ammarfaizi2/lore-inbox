Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTDGUJW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTDGUJW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:09:22 -0400
Received: from galileo.bork.org ([66.11.174.148]:31495 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S263619AbTDGUJL (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:09:11 -0400
Date: Mon, 7 Apr 2003 16:13:37 -0400
From: Martin Hicks <mort@bork.org>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, wildos@sgi.com
Subject: [patch] printk subsystems
Message-ID: <20030407201337.GE28468@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

In an effort to get greater control over which printk()'s are logged
during boot and after, I've put together this patch that introduces the
concept of printk subsystems.  The problem that some are beginning to
face with larger machines is that certain subsystems are overly verbose
(SCSI, USB, cpu related messages on large NUMA or SMP machines)
and they overflow the buffer.  Making the logbuffer bigger is a stop gap
solution but I think this is a more elegant solution.

Basically, each printk is assigned to a subsystem and that subsystem has
the same set of values that the console_printk array has.  The
difference is that the console_printk loglevel decides if the message
goes to the console whereas the subsystem loglevel decides if that
message goes to the log at all.

This patch implements the core, but I haven't yet put in the facilities
to change the default values that are used at compile-time.  I'm looking
for opinions on the architecture, not the completeness.  I plan to add
configuration through sysctl.

To use the feature you simply add the subsystem identifier to the printk
call, much the same way that you add the priority tag:

printk(PRINTK_NET KERN_INFO "This is a printk from the net subsys\n");

Each subsystem has a default KERN_* priority, and if no subsystem is
given then the printk is put into the PRINTK_UNASS queue (which is setup
by default to log all messages).

The patch is against 2.5.66.

Opinions and comments welcome
mh

-- 
Martin Hicks  ||  mort@bork.org  || PGP/GnuPG: 0x4C7F2BEE
plato up 6 days,  6:33, 14 users,  load average: 0.09, 0.11, 0.09
Beer: So much more than just a breakfast drink.



diff -X /home/mort/diff-exclude -uEr linux-2.5.66.pristine/include/linux/kernel.h linux-2.5.66/include/linux/kernel.h
--- linux-2.5.66.pristine/include/linux/kernel.h	2003-03-17 16:43:37.000000000 -0500
+++ linux-2.5.66/include/linux/kernel.h	2003-04-07 14:33:05.000000000 -0400
@@ -47,6 +47,18 @@
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
+/* Printk subsystem identifiers */
+#define PRINTK_UNASS    "<A>"   /* unassigned printk subsystem          */
+#define PRINTK_CORE     "<B>"   /* from the core kernel                 */
+#define PRINTK_SCSI     "<C>"   /* from the SCSI subsystem              */
+#define PRINTK_NET      "<D>"   /* from the Net subsystem               */
+#define PRINTK_USB      "<E>"   /* from the USB subsystem               */
+
+#define FIRST_PRINTK_SUBSYS PRINTK_UNASS[1]
+#define LAST_PRINTK_SUBSYS PRINTK_USB[1]
+
+extern int printk_subsystem[5][4];
+
 struct completion;
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
@@ -102,6 +114,62 @@
 		console_loglevel = 15;
 }
 
+static inline int decode_subsys(char *subsys) 
+{
+        if (subsys[1] >= FIRST_PRINTK_SUBSYS &&
+            subsys[1] <= LAST_PRINTK_SUBSYS)
+                return subsys[1] - FIRST_PRINTK_SUBSYS;
+        return -1;
+}
+
+/* returns the log threshold for a given subsystem.  -1 on error.  */
+static inline int get_subsys_loglevel(char *subsys)
+{
+        int index;
+        if ((index = decode_subsys(subsys)) != -1)
+                return printk_subsystem[index][0];
+        return -1;
+}
+
+/* sets the log threshold for a given subsystem.  
+ * returns 0 if everything is okay, -1 if an error is encoutered. */
+static inline int set_subsys_loglevel(char *subsys, int level)
+{
+        int index;
+        if (level < 0 || level > 8)
+                return -1;
+        if ((index = decode_subsys(subsys)) != -1) {
+                if (level < printk_subsystem[index][2])
+                        level = printk_subsystem[index][3];
+                printk_subsystem[index][0] = level;
+                return 0;
+        }
+        return -1;
+}
+
+/* returns the default message level for a given subsystem.  -1 on error */
+static inline int get_subsys_msglevel(char *subsys)
+{
+        int index;
+        if ((index = decode_subsys(subsys)) != -1)
+                return printk_subsystem[index][1];
+        return -1;
+}
+
+/* sets the default message level for a given subsystem.
+ * return 0 if everything is okay, - 1 if an error is encountered */
+static inline int set_subsys_msglevel(char *subsys, int level)
+{
+        int index;
+        if (level < 0 || level > 7)
+                return -1;
+        if ((index = decode_subsys(subsys)) != -1) {
+                printk_subsystem[index][1] = level;
+                return 0;
+        }
+        return -1;
+}
+
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 
Only in linux-2.5.66.pristine/include/sound: pcm_sgbuf.h
diff -X /home/mort/diff-exclude -uEr linux-2.5.66.pristine/kernel/printk.c linux-2.5.66/kernel/printk.c
--- linux-2.5.66.pristine/kernel/printk.c	2003-03-17 16:44:50.000000000 -0500
+++ linux-2.5.66/kernel/printk.c	2003-04-07 14:54:33.356776808 -0400
@@ -42,6 +42,9 @@
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
 #define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
 
+#define MINIMUM_SUBSYS_LOGLEVEL 1
+#define DEFAULT_SUBSYS_LOGLEVEL 8
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
 int console_printk[4] = {
@@ -51,6 +54,18 @@
 	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
 };
 
+int printk_subsystem[5][4] = {  /*  [][0] == subsystem log level
+                                 *  [][1] == default message loglevel
+                                 *  [][2] == minimum subsystem loglevel
+                                 *  [][3] == default subsystem loglevel */
+        [0 ... 4] = { 
+                DEFAULT_SUBSYS_LOGLEVEL,
+                DEFAULT_MESSAGE_LOGLEVEL,
+                MINIMUM_SUBSYS_LOGLEVEL,
+                DEFAULT_SUBSYS_LOGLEVEL
+        }
+};
+
 int oops_in_progress;
 
 /*
@@ -390,10 +405,11 @@
 {
 	va_list args;
 	unsigned long flags;
-	int printed_len;
+	int printed_len, msg_log_level, msg_subsystem, i;
 	char *p;
 	static char printk_buf[1024];
-	static int log_level_unknown = 1;
+	static int begin_message = 1;
+        
 
 	if (oops_in_progress) {
 		/* If a crash is occurring, make sure we can't deadlock */
@@ -409,23 +425,44 @@
 	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
 	va_end(args);
-
+        
 	/*
-	 * Copy the output into log_buf.  If the caller didn't provide
-	 * appropriate log level tags, we insert them here
+	 * Copy the output into log_buf.
 	 */
-	for (p = printk_buf; *p; p++) {
-		if (log_level_unknown) {
-			if (p[0] != '<' || p[1] < '0' || p[1] > '7' || p[2] != '>') {
+        p = printk_buf;
+	while (*p) {
+		if (begin_message) {
+                        /* Figure out if there is zero, one or two flags */
+                        msg_log_level = -1;
+                        msg_subsystem = 0;  /* A - Unassigned */
+                        for (i = 0; i < 2; i++) {
+				if (p[0] == '<' && p[2] == '>') {
+                                	if (p[1] >= '0' && p[1] <= '7')
+                                        	msg_log_level = p[1] - '0';
+                                	if (p[1] >= 'A' && p[1] <= 'G')
+                                        	msg_subsystem = p[1] - 'A';
+				} else 
+					break;
+				p+=3;
+			}
+
+                        /* Decide if we print this message at all */
+                        if (msg_log_level == -1)
+                                msg_log_level = printk_subsystem[msg_subsystem][1];
+                                
+                        if (msg_log_level < printk_subsystem[msg_subsystem][0]) {
+                                begin_message = 0;
 				emit_log_char('<');
-				emit_log_char(default_message_loglevel + '0');
+                                emit_log_char(msg_log_level + '0');
 				emit_log_char('>');
+                        } else { // Get out of this loop.  Don't log anything.
+                                break;
 			}
-			log_level_unknown = 0;
 		}
 		emit_log_char(*p);
 		if (*p == '\n')
-			log_level_unknown = 1;
+			begin_message = 1;
+                p++;
 	}
 
 	if (!cpu_online(smp_processor_id())) {
