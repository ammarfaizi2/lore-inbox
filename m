Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270849AbRIARbD>; Sat, 1 Sep 2001 13:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270862AbRIARap>; Sat, 1 Sep 2001 13:30:45 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:29189 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270849AbRIARam>; Sat, 1 Sep 2001 13:30:42 -0400
Message-ID: <3B911AFE.3E2825FC@t-online.de>
Date: Sat, 01 Sep 2001 19:29:34 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] /usr/src/linux/fs/proc/proc_misc.c, Kernel 2.4.3, 
 Uptime-overflow
Content-Type: multipart/mixed;
 boundary="------------EDAC3A70373591462C01F847"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------EDAC3A70373591462C01F847
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello...

This patch fixes the overflow-problem with /proc/uptime after 497 days,
it applies to Kernel 2.4.3, but should also fit on every following
version as this part of the code in /usr/src/linux/fs/proc/proc_misc.c
is not changed up to 2.4.9., AFAIK.

Tested this thing on my own machine (Kernel 2.4.3-SMP, RH7.1) and had no
negative effects.

I know this overflow was already discussed on the list, but this was in
1998 (at least the archive says this) and since then no fix made it in
the stable kernel, so i decided to write my own. (Could not let this
MS-guy at work talk on about "Bugs in Linux!" :-))

The fix does nothing weird, it only watches if an overflow of "jiffies"
occurs, and if, corrects the values of "uptime" and "idletime" in
/proc/uptime. It cannot do this in any case, but i think its a good
workaround for the problem.

This is my first kernel-patch...tell me what is wrong :-)

Solong..
mfg Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
--------------EDAC3A70373591462C01F847
Content-Type: text/plain; charset=us-ascii;
 name="uptime_fix_patch_2.4.3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uptime_fix_patch_2.4.3.txt"

--- /usr/src/linux-2.4.3/fs/proc/proc_misc.c	Sun Aug 26 23:14:49 2001
+++ /usr/src/linux-2.4.3-test/fs/proc/proc_misc.c	Mon Aug 27 20:21:19 2001
@@ -13,6 +13,14 @@
  * Changes:
  * Fulton Green      :  Encapsulated position metric calculations.
  *			<kernel@FultonGreen.com>
+ *
+ * Frank Schneider   :  Fixed Uptime-Bug resetting /proc/uptime
+ *                      after 497 days, 2h:27m:52.96sec to zero
+ *                      due to overflow in "jiffies".
+ *                      Tested only on i386.
+ *                      FIXME: Port this fix to non-intel.
+ *                      <spatz1@t-online.de>
+ *
  */
 
 #include <linux/types.h>
@@ -100,15 +108,68 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
 	unsigned long uptime;
 	unsigned long idle;
+
+/*
+Extra-Variables for Uptime-Overflow-Fix
+*/
+	long int test_jiffies;
+	long int test_idle;
+	static int uptime_overflow_correction=0;
+	static int idle_overflow_correction=0;
+	static unsigned long int jiffies_old;
+	static unsigned long int idle_old;
+	unsigned long int my_jiffies;
+	unsigned long int my_idle;
+	const unsigned long int max_int_value=4294967295;
 	int len;
+		
+/* If you want to test the fix, you can add e.g.
+4294937296 to "my_jiffies" and 4294931296 to "my_idle",
+then both overflows will occur 5 Minutes and 6 Minutes
+after boottime and you do not have to wait 497 days...:-)
+*/
+
+	my_jiffies = jiffies;
+	my_idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
+	
+	test_jiffies = my_jiffies;
+	test_idle = my_idle;
+	
+	uptime = my_jiffies;
+	idle = my_idle;
+
+/*
+Get values for later comparision.
+*/
+	
+	if (test_jiffies < 0 && jiffies_old == 0)
+		jiffies_old = my_jiffies;
+		
+	if (test_idle < 0 && idle_old == 0)
+		idle_old = my_idle;
+		
+/*
+Check for overflow...
+*/
 
-	uptime = jiffies;
-	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
+	if (my_jiffies < jiffies_old ) {
+		uptime_overflow_correction++;
+		jiffies_old = 0;
+		printk (KERN_NOTICE "Jiffies overflow detected, Uptime-correction enabled!\n");
+		}
+		
+	if (my_idle < idle_old ) {
+		idle_overflow_correction++;
+		idle_old = 0;
+		printk (KERN_NOTICE "Process time of Idletask: Overflow detected, Correction enabled!\n");
+		}
+		
 
 	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
 	   that would overflow about every five days at HZ == 100.
@@ -119,17 +180,27 @@
 	   calculations simplify to the version in the #else part (if the printf
 	   format is adapted to the same number of digits as zeroes in HZ.
 	 */
+
+/* 
+FIXME: Port this fix for intel to other platforms wth HZ!=100
+*/
+
 #if HZ!=100
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
 		uptime / HZ,
 		(((uptime % HZ) * 100) / HZ) % 100,
 		idle / HZ,
 		(((idle % HZ) * 100) / HZ) % 100);
+
+/* 
+Here the correction-values are added to Uptime and Idletime
+*/
+
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
+		uptime / HZ + (uptime_overflow_correction * max_int_value / HZ),
 		uptime % HZ,
-		idle / HZ,
+		idle / HZ + (idle_overflow_correction * max_int_value / HZ),
 		idle % HZ);
 #endif
 	return proc_calc_metrics(page, start, off, count, eof, len);

--------------EDAC3A70373591462C01F847
Content-Type: text/plain; charset=us-ascii;
 name="README.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.txt"

Fix of the /proc/uptime-Overflow-bug by Frank Schneider, <spatz1@t-online.de>

--------------EDAC3A70373591462C01F847--

