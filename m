Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422889AbWAMTxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbWAMTxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422911AbWAMTvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:60308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422889AbWAMTuf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:35 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] INPUT: add MODALIAS to the event environment
In-Reply-To: <11371818082670@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:08 -0800
Message-Id: <11371818084013@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: add MODALIAS to the event environment

input: add MODALIAS to the event environment

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bd37e5a951ad2123d3f51f59c407b5242946b6ba
tree 3a9b4875ee602d9495d4b3e1f202b20d644ae793
parent 67daf5f11f06b9b15f8320de1d237ccc2e74fe43
author Kay Sievers <kay.sievers@suse.de> Thu, 05 Jan 2006 13:19:55 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:04 -0800

 drivers/input/input.c |   55 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index fe33ff3..4fe3da3 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -528,40 +528,56 @@ INPUT_DEV_STRING_ATTR_SHOW(name);
 INPUT_DEV_STRING_ATTR_SHOW(phys);
 INPUT_DEV_STRING_ATTR_SHOW(uniq);
 
-static int print_modalias_bits(char *buf, char prefix, unsigned long *arr,
+static int print_modalias_bits(char *buf, int size, char prefix, unsigned long *arr,
 			       unsigned int min, unsigned int max)
 {
 	int len, i;
 
-	len = sprintf(buf, "%c", prefix);
+	len = snprintf(buf, size, "%c", prefix);
 	for (i = min; i < max; i++)
 		if (arr[LONG(i)] & BIT(i))
-			len += sprintf(buf+len, "%X,", i);
+			len += snprintf(buf + len, size - len, "%X,", i);
 	return len;
 }
 
-static ssize_t input_dev_show_modalias(struct class_device *dev, char *buf)
+static int print_modalias(char *buf, int size, struct input_dev *id)
 {
-	struct input_dev *id = to_input_dev(dev);
-	ssize_t len = 0;
+	int len;
 
-	len += sprintf(buf+len, "input:b%04Xv%04Xp%04Xe%04X-",
+	len = snprintf(buf, size, "input:b%04Xv%04Xp%04Xe%04X-",
 		       id->id.bustype,
 		       id->id.vendor,
 		       id->id.product,
 		       id->id.version);
 
-	len += print_modalias_bits(buf+len, 'e', id->evbit, 0, EV_MAX);
-	len += print_modalias_bits(buf+len, 'k', id->keybit,
+	len += print_modalias_bits(buf + len, size - len, 'e', id->evbit,
+				   0, EV_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'k', id->keybit,
 				   KEY_MIN_INTERESTING, KEY_MAX);
-	len += print_modalias_bits(buf+len, 'r', id->relbit, 0, REL_MAX);
-	len += print_modalias_bits(buf+len, 'a', id->absbit, 0, ABS_MAX);
-	len += print_modalias_bits(buf+len, 'm', id->mscbit, 0, MSC_MAX);
-	len += print_modalias_bits(buf+len, 'l', id->ledbit, 0, LED_MAX);
-	len += print_modalias_bits(buf+len, 's', id->sndbit, 0, SND_MAX);
-	len += print_modalias_bits(buf+len, 'f', id->ffbit, 0, FF_MAX);
-	len += print_modalias_bits(buf+len, 'w', id->swbit, 0, SW_MAX);
-	len += sprintf(buf+len, "\n");
+	len += print_modalias_bits(buf + len, size - len, 'r', id->relbit,
+				   0, REL_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'a', id->absbit,
+				   0, ABS_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'm', id->mscbit,
+				   0, MSC_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'l', id->ledbit,
+				   0, LED_MAX);
+	len += print_modalias_bits(buf + len, size - len, 's', id->sndbit,
+				   0, SND_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'f', id->ffbit,
+				   0, FF_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'w', id->swbit,
+				   0, SW_MAX);
+	return len;
+}
+
+static ssize_t input_dev_show_modalias(struct class_device *dev, char *buf)
+{
+	struct input_dev *id = to_input_dev(dev);
+	ssize_t len;
+
+	len = print_modalias(buf, PAGE_SIZE, id);
+	len += snprintf(buf + len, PAGE_SIZE-len, "\n");
 	return len;
 }
 static CLASS_DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
@@ -728,8 +744,11 @@ static int input_dev_uevent(struct class
 	if (test_bit(EV_SW, dev->evbit))
 		INPUT_ADD_HOTPLUG_BM_VAR("SW=", dev->swbit, SW_MAX);
 
-	envp[i] = NULL;
+	envp[i++] = buffer + len;
+	len += snprintf(buffer + len, buffer_size - len, "MODALIAS=");
+	len += print_modalias(buffer + len, buffer_size - len, dev) + 1;
 
+	envp[i] = NULL;
 	return 0;
 }
 

