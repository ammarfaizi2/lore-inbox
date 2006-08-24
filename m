Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWHXVml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWHXVml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWHXVml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:42:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:39428 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422701AbWHXVmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:42:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ua/heACWCYlHN6CHxp6c1rtiFVTGqYcyK2SCJIvLzMqVpTFdFrftinre5kN5thzTyGry0gR0Q/M+OrgJzWgPgrqBdp+ckMDnMbubWUpJ4M1WOF9tiXqj7WvFW7UeotjCf4EObWb+siQVue1SjQZMOmsrofDdaNxtzMw/KQ94+AY=
Date: Fri, 25 Aug 2006 01:42:33 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: [PATCH 1/2] asus_acpi: fix proc files parsing
Message-ID: <20060824214233.GA5204@martell.zuzino.mipt.ru>
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

 drivers/acpi/asus_acpi.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

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
@@ -572,7 +572,7 @@ write_led(const char __user * buffer, un
 		printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
 		       ledname);
 
-	return count;
+	return rv;
 }
 
 /*
@@ -607,20 +607,20 @@ static int
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
 
-	return count;
+	return rv;
 }
 
 /*
@@ -761,12 +761,12 @@ static int
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
-	return count;
+	return rv;
 }
 
 static int read_brightness(void)
@@ -830,18 +830,18 @@ static int
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
-	} else if (count < 0) {
+	} else if (rv < 0) {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
 
-	return count;
+	return rv;
 }
 
 static void set_display(int value)
@@ -880,15 +880,15 @@ static int
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
 
-	return count;
+	return rv;
 }
 
 typedef int (proc_readfunc) (char *page, char **start, off_t off, int count,

