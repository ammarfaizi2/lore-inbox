Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWFQSiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWFQSiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWFQSiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:38:20 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:47477 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750832AbWFQSiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:38:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BnwQhAZz/FGnIuGWtDUE0nEd24KVFboHJCWjo9FB2tMMtblFRtgVyq2Z5jN0w6mAzfhwg58td9I0V4d880n+qWwIeiHnGEunWb/NRbWuSMCAjfNkCFtbjkH3T3Jfx0Cxavps2F/KLT9mrjdrA48WZZdL2QsVAOnG2hp4lGtwf3E=
Message-ID: <44944C19.7000402@gmail.com>
Date: Sat, 17 Jun 2006 12:38:17 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 17/20] chardev: GPIO for SCx200 & PC-8736x: replace spinlocks
 w mutexes
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

17/20. patch.mutexes

Replace spinlocks guarding gpio config ops with mutexes.  This is a
me-too patch, and is justifiable insofar as mutexes have stricter
semantics and better debugging support, so are preferred where they
are applicable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.mutexes
 arch/i386/kernel/scx200.c   |    8 ++++----
 drivers/char/pc8736x_gpio.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-16/arch/i386/kernel/scx200.c ax-17/arch/i386/kernel/scx200.c
--- ax-16/arch/i386/kernel/scx200.c	2006-06-17 01:36:56.000000000 -0600
+++ ax-17/arch/i386/kernel/scx200.c	2006-06-17 01:51:49.000000000 -0600
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 
 #include <linux/scx200.h>
@@ -45,7 +46,7 @@ static struct pci_driver scx200_pci_driv
 	.probe = scx200_probe,
 };
 
-static DEFINE_SPINLOCK(scx200_gpio_config_lock);
+DEFINE_MUTEX(scx200_gpio_config_lock);
 
 static void __devinit scx200_init_shadow(void)
 {
@@ -95,9 +96,8 @@ static int __devinit scx200_probe(struct
 u32 scx200_gpio_configure(unsigned index, u32 mask, u32 bits)
 {
 	u32 config, new_config;
-	unsigned long flags;
 
-	spin_lock_irqsave(&scx200_gpio_config_lock, flags);
+	mutex_lock(&scx200_gpio_config_lock);
 
 	outl(index, scx200_gpio_base + 0x20);
 	config = inl(scx200_gpio_base + 0x24);
@@ -105,7 +105,7 @@ u32 scx200_gpio_configure(unsigned index
 	new_config = (config & mask) | bits;
 	outl(new_config, scx200_gpio_base + 0x24);
 
-	spin_unlock_irqrestore(&scx200_gpio_config_lock, flags);
+	mutex_unlock(&scx200_gpio_config_lock);
 
 	return config;
 }
diff -ruNp -X dontdiff -X exclude-diffs ax-16/drivers/char/pc8736x_gpio.c ax-17/drivers/char/pc8736x_gpio.c
--- ax-16/drivers/char/pc8736x_gpio.c	2006-06-17 01:48:50.000000000 -0600
+++ ax-17/drivers/char/pc8736x_gpio.c	2006-06-17 01:51:49.000000000 -0600
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/mutex.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
@@ -31,7 +32,7 @@ static int major = 0;		/* default to dyn
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
-static DEFINE_SPINLOCK(pc8736x_gpio_config_lock);
+DEFINE_MUTEX(pc8736x_gpio_config_lock);
 static unsigned pc8736x_gpio_base;
 static u8 pc8736x_gpio_shadow[4];
 
@@ -119,9 +120,8 @@ static inline u32 pc8736x_gpio_configure
 					    u32 func_slct)
 {
 	u32 config, new_config;
-	unsigned long flags;
 
-	spin_lock_irqsave(&pc8736x_gpio_config_lock, flags);
+	mutex_lock(&pc8736x_gpio_config_lock);
 
 	device_select(SIO_GPIO_UNIT);
 	select_pin(index);
@@ -133,7 +133,7 @@ static inline u32 pc8736x_gpio_configure
 	new_config = (config & mask) | bits;
 	superio_outb(func_slct, new_config);
 
-	spin_unlock_irqrestore(&pc8736x_gpio_config_lock, flags);
+	mutex_unlock(&pc8736x_gpio_config_lock);
 
 	return config;
 }


