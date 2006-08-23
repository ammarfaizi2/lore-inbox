Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWHWXf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWHWXf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHWXf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:35:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:7670 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965181AbWHWXf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:35:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rqC9PjKF1t2D2C8/NgEI6IiVYgyd7egdwjVQsAmCrjvE6A8WPDUWnoURKYIAERrWM0xfN5t2KcSDDTs4TkQoE2h0dKBEBsLgyBEUUNdZmr+w0h3TFlAT4GnivqaqXDbET42NF6h3lJgLhVJ7OTfKqGAW7h7Iwb/dqQCIFVOfztE=
Date: Thu, 24 Aug 2006 03:35:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, linux-kernel@vger.kernel.org,
       Karol Kozimor <sziwan@users.sourceforge.net>,
       Julien Lerouge <julien.lerouge@free.fr>
Subject: [PATCH 1/2] asus_acpi: fix error checking in /proc files
Message-ID: <20060823233522.GD5203@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darren Jenkins <darrenrjenkins@gmail.com>

ICC complains about a "Pointless comparsion of unsigned interger with
zero" @ line 760 & 808 of asus_acpi.c

parse_arg() mentioned below returns -E but it's copied into unsigned variable...

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/acpi/asus_acpi.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -555,11 +555,11 @@ static int
 write_led(const char __user * buffer, unsigned long count,
 	  char *ledname, int ledmask, int invert)
 {
-	int value;
+	int rv, value;
 	int led_out = 0;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0)
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0)
 		led_out = value ? 1 : 0;
 
 	hotk->status =
@@ -607,17 +607,17 @@ static int
 proc_write_ledd(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0) {
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0) {
 		if (!write_acpi_int
 		    (hotk->handle, hotk->methods->mt_ledd, value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: LED display write failed\n");
 		else
 			hotk->ledd_status = (u32) value;
-	} else if (count < 0)
+	} else if (rv < 0)
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 
 	return count;
@@ -761,10 +761,10 @@ static int
 proc_write_lcd(struct file *file, const char __user * buffer,
 	       unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0)
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0)
 		set_lcd_state(value);
 	return count;
 }
@@ -830,10 +830,10 @@ static int
 proc_write_brn(struct file *file, const char __user * buffer,
 	       unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0) {
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0) {
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 		/* 0 <= value <= 15 */
 		set_brightness(value);
@@ -880,12 +880,12 @@ static int
 proc_write_disp(struct file *file, const char __user * buffer,
 		unsigned long count, void *data)
 {
-	int value;
+	int rv, value;
 
-	count = parse_arg(buffer, count, &value);
-	if (count > 0)
+	rv = parse_arg(buffer, count, &value);
+	if (rv > 0)
 		set_display(value);
-	else if (count < 0)
+	else if (rv < 0)
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 
 	return count;

