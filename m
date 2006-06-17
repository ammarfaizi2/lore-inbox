Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWFQS2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFQS2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWFQS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:28:09 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:35175 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750794AbWFQS2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:28:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lUbhuW1N8k7BKtvlI81TpBOJsbMs/wWHQ5KAOGEsnvcHWXmfCtF+pR6HZ16t09nrxR3kWq9mMwC6188KBvNIKQh07pU1ih3YFhWentffiNXmPpofrmaPGRkevRrCLnPdcYepghmKdsTjVTj1SMQfBu6ED8w2OKCfp90ytD3tPks=
Message-ID: <449449B5.8060604@gmail.com>
Date: Sat, 17 Jun 2006 12:28:05 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 06/20] chardev: GPIO for SCx200 & PC-8736x: add 'v' command
 to device-file
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6/20. patch.viewpins

Add a new driver command: 'v' which calls gpio_dump() on the pin.  The
output goes to the log, like all other INFO messages in the original
driver.  Giving the user control over the feedback they 'need' is
construed to be a user-friendly feature, and allows us (later) to dial
down many INFO messages to DEBUG log-level.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.viewpins
 arch/i386/kernel/scx200.c  |    3 +--
 drivers/char/scx200_gpio.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-5/arch/i386/kernel/scx200.c ax-6/arch/i386/kernel/scx200.c
--- ax-5/arch/i386/kernel/scx200.c	2006-06-17 01:10:02.000000000 -0600
+++ ax-6/arch/i386/kernel/scx200.c	2006-06-17 01:13:26.000000000 -0600
@@ -105,7 +105,6 @@ u32 scx200_gpio_configure(unsigned index
 	return config;
 }
 
-#if 0
 void scx200_gpio_dump(unsigned index)
 {
         u32 config = scx200_gpio_configure(index, ~0, 0);
@@ -120,7 +119,6 @@ void scx200_gpio_dump(unsigned index)
                (config & 32) ? "HI"     : "LO",		/* trigger on rising/falling edge */ 
                (config & 64) ? "DEBOUNCE" : "");	/* debounce */
 }
-#endif  /*  0  */
 
 static int __init scx200_init(void)
 {
@@ -141,4 +139,5 @@ module_exit(scx200_cleanup);
 EXPORT_SYMBOL(scx200_gpio_base);
 EXPORT_SYMBOL(scx200_gpio_shadow);
 EXPORT_SYMBOL(scx200_gpio_configure);
+EXPORT_SYMBOL(scx200_gpio_dump);
 EXPORT_SYMBOL(scx200_cb_base);
diff -ruNp -X dontdiff -X exclude-diffs ax-5/drivers/char/scx200_gpio.c ax-6/drivers/char/scx200_gpio.c
--- ax-5/drivers/char/scx200_gpio.c	2006-06-17 01:04:20.000000000 -0600
+++ ax-6/drivers/char/scx200_gpio.c	2006-06-17 01:13:26.000000000 -0600
@@ -41,6 +41,7 @@ static ssize_t scx200_gpio_write(struct 
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
 	size_t i;
+	int err = 0;
 
 	for (i = 0; i < len; ++i) {
 		char c;
@@ -77,8 +78,23 @@ static ssize_t scx200_gpio_write(struct 
 			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
 			scx200_gpio_configure(m, ~4, 0);
 			break;
+
+		case 'v':
+			/* View Current pin settings */
+			scx200_gpio_dump(m);
+			break;
+		case '\n':
+			/* end of settings string, do nothing */
+			break;
+		default:
+			printk(KERN_ERR NAME
+			       ": GPIO-%2d bad setting: chr<0x%2x>\n", m,
+			       (int)c);
+			err++;
 		}
 	}
+	if (err)
+		return -EINVAL;	/* full string handled, report error */
 
 	return len;
 }


