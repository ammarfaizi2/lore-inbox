Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVBHAag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVBHAag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVBHAag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:30:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:52133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261357AbVBHA35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:29:57 -0500
Date: Mon, 7 Feb 2005 16:30:05 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] convert /proc/driver/rtc to seq_file.
Message-ID: <20050207163005.1e7dab14@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/driver/rtc interface didn't have any module owner hook.
The simplest fix is to just convert this to the single version of seq_file.
Also, fix initialization of rtc_dev to use C99 form.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


diff -Nru a/drivers/char/rtc.c b/drivers/char/rtc.c
--- a/drivers/char/rtc.c	2005-02-07 16:08:10 -08:00
+++ b/drivers/char/rtc.c	2005-02-07 16:08:10 -08:00
@@ -73,6 +73,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/sysctl.h>
 #include <linux/wait.h>
@@ -151,8 +152,7 @@
 static void mask_rtc_irq_bit(unsigned char bit);
 #endif
 
-static int rtc_read_proc(char *page, char **start, off_t off,
-                         int count, int *eof, void *data);
+static int rtc_proc_open(struct inode *inode, struct file *file);
 
 /*
  *	Bits in rtc_status. (6 bits of room for future expansion)
@@ -871,11 +871,18 @@
 	.fasync		= rtc_fasync,
 };
 
-static struct miscdevice rtc_dev=
-{
-	RTC_MINOR,
-	"rtc",
-	&rtc_fops
+static struct miscdevice rtc_dev = {
+	.minor		= RTC_MINOR,
+	.name		= "rtc",
+	.fops		= &rtc_fops,
+};
+
+static struct file_operations rtc_proc_fops = {
+	.owner = THIS_MODULE,
+	.open = rtc_proc_open,
+	.read  = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
 };
 
 #if defined(RTC_IRQ) && !defined(__sparc__)
@@ -884,6 +891,7 @@
 
 static int __init rtc_init(void)
 {
+	struct proc_dir_entry *ent;
 #if defined(__alpha__) || defined(__mips__)
 	unsigned int year, ctrl;
 	unsigned long uip_watchdog;
@@ -974,7 +982,9 @@
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -ENODEV;
 	}
-	if (!create_proc_read_entry ("driver/rtc", 0, NULL, rtc_read_proc, NULL)) {
+
+	ent = create_proc_entry("driver/rtc", 0, NULL);
+	if (!ent) {
 #ifdef RTC_IRQ
 		free_irq(RTC_IRQ, NULL);
 #endif
@@ -982,6 +992,7 @@
 		misc_deregister(&rtc_dev);
 		return -ENOMEM;
 	}
+	ent->proc_fops = &rtc_proc_fops;
 
 #if defined(__alpha__) || defined(__mips__)
 	rtc_freq = HZ;
@@ -1119,11 +1130,10 @@
  *	Info exported via "/proc/driver/rtc".
  */
 
-static int rtc_proc_output (char *buf)
+static int rtc_proc_show(struct seq_file *seq, void *v)
 {
 #define YN(bit) ((ctrl & bit) ? "yes" : "no")
 #define NY(bit) ((ctrl & bit) ? "no" : "yes")
-	char *p;
 	struct rtc_time tm;
 	unsigned char batt, ctrl;
 	unsigned long freq;
@@ -1134,7 +1144,6 @@
 	freq = rtc_freq;
 	spin_unlock_irq(&rtc_lock);
 
-	p = buf;
 
 	rtc_get_rtc_time(&tm);
 
@@ -1142,12 +1151,12 @@
 	 * There is no way to tell if the luser has the RTC set for local
 	 * time or for Universal Standard Time (GMT). Probably local though.
 	 */
-	p += sprintf(p,
-		     "rtc_time\t: %02d:%02d:%02d\n"
-		     "rtc_date\t: %04d-%02d-%02d\n"
-	 	     "rtc_epoch\t: %04lu\n",
-		     tm.tm_hour, tm.tm_min, tm.tm_sec,
-		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, epoch);
+	seq_printf(seq, 
+		   "rtc_time\t: %02d:%02d:%02d\n"
+		   "rtc_date\t: %04d-%02d-%02d\n"
+		   "rtc_epoch\t: %04lu\n",
+		   tm.tm_hour, tm.tm_min, tm.tm_sec,
+		   tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, epoch);
 
 	get_rtc_alm_time(&tm);
 
@@ -1156,57 +1165,50 @@
 	 * match any value for that particular field. Values that are
 	 * greater than a valid time, but less than 0xc0 shouldn't appear.
 	 */
-	p += sprintf(p, "alarm\t\t: ");
+	seq_puts(seq, "alarm\t\t: ");
 	if (tm.tm_hour <= 24)
-		p += sprintf(p, "%02d:", tm.tm_hour);
+		seq_printf(seq, "%02d:", tm.tm_hour);
 	else
-		p += sprintf(p, "**:");
+		seq_puts(seq, "**:");
 
 	if (tm.tm_min <= 59)
-		p += sprintf(p, "%02d:", tm.tm_min);
+		seq_printf(seq, "%02d:", tm.tm_min);
 	else
-		p += sprintf(p, "**:");
+		seq_puts(seq, "**:");
 
 	if (tm.tm_sec <= 59)
-		p += sprintf(p, "%02d\n", tm.tm_sec);
+		seq_printf(seq, "%02d\n", tm.tm_sec);
 	else
-		p += sprintf(p, "**\n");
+		seq_puts(seq, "**\n");
 
-	p += sprintf(p,
-		     "DST_enable\t: %s\n"
-		     "BCD\t\t: %s\n"
-		     "24hr\t\t: %s\n"
-		     "square_wave\t: %s\n"
-		     "alarm_IRQ\t: %s\n"
-		     "update_IRQ\t: %s\n"
-		     "periodic_IRQ\t: %s\n"
-		     "periodic_freq\t: %ld\n"
-		     "batt_status\t: %s\n",
-		     YN(RTC_DST_EN),
-		     NY(RTC_DM_BINARY),
-		     YN(RTC_24H),
-		     YN(RTC_SQWE),
-		     YN(RTC_AIE),
-		     YN(RTC_UIE),
-		     YN(RTC_PIE),
-		     freq,
-		     batt ? "okay" : "dead");
+	seq_printf(seq,
+		   "DST_enable\t: %s\n"
+		   "BCD\t\t: %s\n"
+		   "24hr\t\t: %s\n"
+		   "square_wave\t: %s\n"
+		   "alarm_IRQ\t: %s\n"
+		   "update_IRQ\t: %s\n"
+		   "periodic_IRQ\t: %s\n"
+		   "periodic_freq\t: %ld\n"
+		   "batt_status\t: %s\n",
+		   YN(RTC_DST_EN),
+		   NY(RTC_DM_BINARY),
+		   YN(RTC_24H),
+		   YN(RTC_SQWE),
+		   YN(RTC_AIE),
+		   YN(RTC_UIE),
+		   YN(RTC_PIE),
+		   freq,
+		   batt ? "okay" : "dead");
 
-	return  p - buf;
+	return  0;
 #undef YN
 #undef NY
 }
 
-static int rtc_read_proc(char *page, char **start, off_t off,
-                         int count, int *eof, void *data)
+static int rtc_proc_open(struct inode *inode, struct file *file)
 {
-        int len = rtc_proc_output (page);
-        if (len <= off+count) *eof = 1;
-        *start = page + off;
-        len -= off;
-        if (len>count) len = count;
-        if (len<0) len = 0;
-        return len;
+	return single_open(file, rtc_proc_show, NULL);
 }
 
 void rtc_get_rtc_time(struct rtc_time *rtc_tm)
