Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVBNXjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVBNXjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBNXjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:39:17 -0500
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:31413 "EHLO
	mail8.fw-sd.sony.com") by vger.kernel.org with ESMTP
	id S261347AbVBNXdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:33:42 -0500
Message-ID: <42113551.5050102@am.sony.com>
Date: Mon, 14 Feb 2005 15:33:37 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] add timing information to printk messages
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a little patch which is useful for showing timing information for
kernel bootup activities.

This patch adds a new Kconfig option under "Kernel Hacking" and a new
option for the kernel command line.  It also provides a script for
showing delta information.

Note that the timing data may not be correct on some platforms until
after time_init() is called.

Recently (as of about 2.6.10) I found that the message log produced by
dmesg is truncated when I use this feature.  That is, the first few printk
messages of the boot sequence are not in the dmesg output, although
they are printed to console during startup.  This is a new behavior -
dmesg output was fine as of 2.6.9.  Increasing CONFIG_LOG_BUF_SHIFT
had no effect on the truncation.

Has something changed with printk recently?

For more information on this patch, see:
http://tree.celinuxforum.org/CelfPubWiki/InstrumentedPrintk

Here's some sample output:
...
[4294667.296000] Kernel command line: ro root=/dev/nfs ip=dhcp hdc=ide-scsi console=vga console=ttyS0,115200
[4294667.296000] ide_setup: hdc=ide-scsi
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 512 (order: 9, 8192 bytes)
[    0.000000] Detected 1995.620 MHz processor.
[   21.397369] Using tsc for high-res timesource
[   21.399820] Console: colour VGA+ 80x25
[   21.537244] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[   21.544547] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[   21.555066] Memory: 125076k/130240k available (2002k kernel code, 4556k reserved, 1006k data, 140k init, 0k highmem)
[   21.565775] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   21.574089] Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
[   21.596511] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[   21.603263] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.603276] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.603287] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   21.608884] CPU: L2 cache: 128K
...


Output from diffinfo:
 Documentation/kernel-parameters.txt |    2+     0- (1 hunk)
 kernel/printk.c                     |   54+     4- (2 hunks)
 lib/Kconfig.debug                   |    9+     0- (1 hunk)
 scripts/show_delta                  N  129+     0- (1 hunk)
 4 files changed, 194 insertions(+), 4 deletions(-), 5 hunks

And now the patch...

Signed-off-by: Tim Bird <tim.bird (at) am.sony.com>

----------------------------
diff -pruN linux-2.6.11-rc4.orig/Documentation/kernel-parameters.txt linux-2.6.11-rc4/Documentation/kernel-parameters.txt
--- linux-2.6.11-rc4.orig/Documentation/kernel-parameters.txt	2005-02-14 11:46:47.000000000 -0800
+++ linux-2.6.11-rc4/Documentation/kernel-parameters.txt	2005-02-14 13:14:13.000000000 -0800
@@ -1356,6 +1356,8 @@ running once the system is up.
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection

+	time		Show timing data prefixed to each printk message line
+
 	tipar.timeout=	[HW,PPT]
 			Set communications timeout in tenths of a second
 			(default 15).
diff -pruN linux-2.6.11-rc4.orig/kernel/printk.c linux-2.6.11-rc4/kernel/printk.c
--- linux-2.6.11-rc4.orig/kernel/printk.c	2005-02-14 11:46:50.000000000 -0800
+++ linux-2.6.11-rc4/kernel/printk.c	2005-02-14 13:12:50.000000000 -0800
@@ -499,6 +499,22 @@ static void zap_locks(void)
 	init_MUTEX(&console_sem);
 }

+#if defined(CONFIG_PRINTK_TIME)
+static int printk_time = 1;
+#else
+static int printk_time = 0;
+#endif
+
+static int __init printk_time_setup(char *str)
+{
+	if (*str)
+		return 0;
+	printk_time = 1;
+	return 1;
+}
+
+__setup("time", printk_time_setup);
+
 /*
  * This is printk.  It can be called from any context.  We want it to work.
  *
@@ -547,10 +563,44 @@ asmlinkage int vprintk(const char *fmt,
 	 */
 	for (p = printk_buf; *p; p++) {
 		if (log_level_unknown) {
-			if (p[0] != '<' || p[1] < '0' || p[1] > '7' || p[2] != '>') {
-				emit_log_char('<');
-				emit_log_char(default_message_loglevel + '0');
-				emit_log_char('>');
+                        /* log_level_unknown signals the start of a new line */
+			if (printk_time) {
+				int loglev_char;
+				char tbuf[50], *tp;
+				unsigned tlen;
+				unsigned long long t;
+				unsigned long nanosec_rem;
+				
+				/*
+				 * force the log level token to be
+				 * before the time output.
+				 */
+				if (p[0] == '<' && p[1] >='0' &&
+				   p[1] <= '7' && p[2] == '>') {
+					loglev_char = p[1];
+					p += 3;
+				} else {
+					loglev_char = default_message_loglevel
+						+ '0';
+				}
+				t = sched_clock();
+				nanosec_rem = do_div(t, 1000000000);
+				tlen = sprintf(tbuf,
+						"<%c>[%5lu.%06lu] ",
+						loglev_char,
+						(unsigned long)t,
+						nanosec_rem/1000);
+
+				for (tp = tbuf; tp< tbuf + tlen; tp++)
+					emit_log_char (*tp);
+			} else {
+				if (p[0] != '<' || p[1] < '0' ||
+				   p[1] > '7' || p[2] != '>') {
+					emit_log_char('<');
+					emit_log_char(default_message_loglevel
+						+ '0');
+					emit_log_char('>');
+				}
 			}
 			log_level_unknown = 0;
 		}
diff -pruN linux-2.6.11-rc4.orig/lib/Kconfig.debug linux-2.6.11-rc4/lib/Kconfig.debug
--- linux-2.6.11-rc4.orig/lib/Kconfig.debug	2005-02-14 11:46:50.000000000 -0800
+++ linux-2.6.11-rc4/lib/Kconfig.debug	2005-02-14 13:12:50.000000000 -0800
@@ -27,6 +27,15 @@ config MAGIC_SYSRQ
 	  Enables console device to interpret special characters as
 	  commands to dump state information.

+config PRINTK_TIME
+	bool "Show timing information on printks"
+	help
+	  Selecting this option causes timing information to be
+	  included in printk output.  This allows you to measure
+	  the interval between kernel operations, including bootup
+	  operations.  This is useful for identifying long delays
+	  in kernel startup.
+
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
 	depends on DEBUG_KERNEL && PROC_FS
diff -pruN linux-2.6.11-rc4.orig/scripts/show_delta linux-2.6.11-rc4/scripts/show_delta
--- linux-2.6.11-rc4.orig/scripts/show_delta	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc4/scripts/show_delta	2005-02-14 13:12:50.000000000 -0800
@@ -0,0 +1,129 @@
+#!/usr/bin/env python
+#
+# show_deltas: Read list of printk messages instrumented with
+# time data, and format with time deltas.
+#
+# Also, you can show the times relative to a fixed point.
+#
+# Copyright 2003 Sony Corporation
+#
+# GPL 2.0 applies.
+
+import sys
+import string
+
+def usage():
+	print """usage: show_delta [<options>] <filename>
+
+This program parses the output from a set of printk message lines which
+have time data prefixed because the CONFIG_PRINTK_TIME option is set, or
+the kernel command line option "time" is specified. When run with no
+options, the time information is converted to show the time delta between
+each printk line and the next.  When run with the '-b' option, all times
+are relative to a single (base) point in time.
+
+Options:
+  -h            Show this usage help.
+  -b <base>	Specify a base for time references.
+		<base> can be a number or a string.
+		If it is a string, the first message line
+		which matches (at the beginning of the
+		line) is used as the time reference.
+
+ex: $ dmesg >timefile
+    $ show_delta -b NET4 timefile
+
+will show times relative to the line in the kernel output
+starting with "NET4".
+"""
+	sys.exit(1)
+
+# returns a tuple containing the seconds and text for each message line
+# seconds is returned as a float
+# raise an exception if no timing data was found
+def get_time(line):
+	if line[0]!="[":
+		raise ValueError
+
+	# split on closing bracket
+	(time_str, rest) = string.split(line[1:],']',1)
+	time = string.atof(time_str)
+
+	#print "time=", time
+	return (time, rest)
+
+
+# average line looks like:
+# [    0.084282] VFS: Mounted root (romfs filesystem) readonly
+# time data is expressed in seconds.useconds,
+# convert_line adds a delta for each line
+last_time = 0.0
+def convert_line(line, base_time):
+	global last_time
+
+	try:
+		(time, rest) = get_time(line)
+	except:
+		# if any problem parsing time, don't convert anything
+		return line
+
+	if base_time:
+		# show time from base
+		delta = time - base_time
+	else:
+		# just show time from last line
+		delta = time - last_time
+		last_time = time
+
+	return ("[%5.6f < %5.6f >]" % (time, delta)) + rest
+
+def main():
+	base_str = ""
+	filein = ""
+	for arg in sys.argv[1:]:
+		if arg=="-b":
+			base_str = sys.argv[sys.argv.index("-b")+1]
+		elif arg=="-h":
+			usage()
+		else:
+			filein = arg
+
+	if not filein:
+		usage()
+
+	try:
+		lines = open(filein,"r").readlines()
+	except:
+		print "Problem opening file: %s" % filein
+		sys.exit(1)
+
+	if base_str:
+		print 'base= "%s"' % base_str
+		# assume a numeric base.  If that fails, try searching
+		# for a matching line.
+		try:
+			base_time = float(base_str)
+		except:
+			# search for line matching <base> string
+			found = 0
+			for line in lines:
+				try:
+					(time, rest) = get_time(line)
+				except:
+					continue
+				if string.find(rest, base_str)==1:
+					base_time = time
+					found = 1
+					# stop at first match
+					break
+			if not found:
+				print 'Couldn\'t find line matching base pattern "%s"' % base_str
+				sys.exit(1)
+	else:
+		base_time = 0.0
+
+	for line in lines:
+		print convert_line(line, base_time),
+
+main()
+
