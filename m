Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWCaKFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWCaKFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWCaKFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:11 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:17965 "EHLO
	linux") by vger.kernel.org with ESMTP id S932077AbWCaKEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:45 -0500
Message-Id: <20060331100424.067229000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:28 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org, Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 05/10] RTC subsystem, fix proc output 
Content-Disposition: inline; filename=rtc-subsys-fix-proc-24hr.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Moved the "24hr: yes" proc output from drivers to rtc
 proc code. This is required because the time value
 in the proc output is always in 24hr mode regardless
 of the driver.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>

---
 drivers/rtc/rtc-ep93xx.c  |    1 -
 drivers/rtc/rtc-m48t86.c  |    3 ---
 drivers/rtc/rtc-pcf8563.c |    7 -------
 drivers/rtc/rtc-proc.c    |    2 ++
 drivers/rtc/rtc-rs5c372.c |    5 ++---
 drivers/rtc/rtc-test.c    |    1 -
 drivers/rtc/rtc-x1205.c   |    2 --
 7 files changed, 4 insertions(+), 17 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-ep93xx.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-ep93xx.c	2006-03-29 02:40:12.000000000 +0200
@@ -67,7 +67,6 @@ static int ep93xx_rtc_proc(struct device
 
 	ep93xx_get_swcomp(dev, &preload, &delete);
 
-	seq_printf(seq, "24hr\t\t: yes\n");
 	seq_printf(seq, "preload\t\t: %d\n", preload);
 	seq_printf(seq, "delete\t\t: %d\n", delete);
 
--- linux-rtc.orig/drivers/rtc/rtc-pcf8563.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-pcf8563.c	2006-03-29 02:40:27.000000000 +0200
@@ -227,14 +227,7 @@ static int pcf8563_rtc_set_time(struct d
 	return pcf8563_set_datetime(to_i2c_client(dev), tm);
 }
 
-static int pcf8563_rtc_proc(struct device *dev, struct seq_file *seq)
-{
-	seq_printf(seq, "24hr\t\t: yes\n");
-	return 0;
-}
-
 static struct rtc_class_ops pcf8563_rtc_ops = {
-	.proc		= pcf8563_rtc_proc,
 	.read_time	= pcf8563_rtc_read_time,
 	.set_time	= pcf8563_rtc_set_time,
 };
--- linux-rtc.orig/drivers/rtc/rtc-proc.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-proc.c	2006-03-29 02:39:56.000000000 +0200
@@ -71,6 +71,8 @@ static int rtc_proc_show(struct seq_file
 				alrm.pending ? "yes" : "no");
 	}
 
+	seq_printf(seq, "24hr\t\t: yes\n");
+
 	if (ops->proc)
 		ops->proc(class_dev->dev, seq);
 
--- linux-rtc.orig/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:46:57.000000000 +0200
@@ -151,9 +151,8 @@ static int rs5c372_rtc_proc(struct devic
 {
 	int err, osc, trim;
 
-	seq_printf(seq, "24hr\t\t: yes\n");
-
-	if ((err = rs5c372_get_trim(to_i2c_client(dev), &osc, &trim)) == 0) {
+	err = rs5c372_get_trim(to_i2c_client(dev), &osc, &trim);
+	if (err == 0) {
 		seq_printf(seq, "%d.%03d KHz\n", osc / 1000, osc % 1000);
 		seq_printf(seq, "trim\t: %d\n", trim);
 	}
--- linux-rtc.orig/drivers/rtc/rtc-x1205.c	2006-03-29 02:38:39.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-x1205.c	2006-03-29 02:39:46.000000000 +0200
@@ -451,8 +451,6 @@ static int x1205_rtc_proc(struct device 
 {
 	int err, dtrim, atrim;
 
-	seq_printf(seq, "24hr\t\t: yes\n");
-
 	if ((err = x1205_get_dtrim(to_i2c_client(dev), &dtrim)) == 0)
 		seq_printf(seq, "digital_trim\t: %d ppm\n", dtrim);
 
--- linux-rtc.orig/drivers/rtc/rtc-m48t86.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-m48t86.c	2006-03-29 02:42:37.000000000 +0200
@@ -127,9 +127,6 @@ static int m48t86_rtc_proc(struct device
 
 	reg = ops->readb(M48T86_REG_B);
 
-	seq_printf(seq, "24hr\t\t: %s\n",
-		 (reg & M48T86_REG_B_H24) ? "yes" : "no");
-
 	seq_printf(seq, "mode\t\t: %s\n",
 		 (reg & M48T86_REG_B_DM) ? "binary" : "bcd");
 
--- linux-rtc.orig/drivers/rtc/rtc-test.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-test.c	2006-03-29 02:42:54.000000000 +0200
@@ -49,7 +49,6 @@ static int test_rtc_proc(struct device *
 {
 	struct platform_device *plat_dev = to_platform_device(dev);
 
-	seq_printf(seq, "24hr\t\t: yes\n");
 	seq_printf(seq, "test\t\t: yes\n");
 	seq_printf(seq, "id\t\t: %d\n", plat_dev->id);
 

--
