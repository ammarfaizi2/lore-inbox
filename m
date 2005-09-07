Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVIGLUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVIGLUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVIGLUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:20:00 -0400
Received: from [85.8.12.41] ([85.8.12.41]:19072 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932113AbVIGLT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:19:59 -0400
Message-ID: <431ECCE3.8080408@drzeus.cx>
Date: Wed, 07 Sep 2005 13:20:03 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: swsusp doesn't suspend devices
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem that swsusp doesn't properly suspend devices, or more
precisely it wakes them up again before suspending the machine.

The problem is in swsusp_suspend(). It is designed as if
swsusp_arch_suspend() would suspend the hardware, when in fact all it
does is prepare for a suspend. The effect is that devices are brought
back up because swsusp_suspend() believes it is resuming.

Below is a patch that uses the same system as kernel/power/disk.c to
determine if it's suspending or resuming. The patch brings up a new
problem though, disk writes generate a huge amount of "scheduling while
atomic".

---

Index: linux-wbsd/kernel/power/swsusp.c
===================================================================
--- linux-wbsd/kernel/power/swsusp.c    (revision 165)
+++ linux-wbsd/kernel/power/swsusp.c    (working copy)
@@ -84,6 +84,8 @@
 /* Local variables that should not be affected by save */
 static unsigned int nr_copy_pages __nosavedata = 0;

+static int in_suspend __nosavedata = 0;
+
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume

@@ -897,15 +899,18 @@
                return error;
        }

+       in_suspend = 1;
        save_processor_state();
        if ((error = swsusp_arch_suspend()))
                printk("Error %d suspending\n", error);
-       /* Restore control flow magically appears here */
-       restore_processor_state();
-       BUG_ON (nr_copy_pages_check != nr_copy_pages);
-       restore_highmem();
-       device_power_up();
-       local_irq_enable();
+       if (!in_suspend || error) {
+               /* Restore control flow magically appears here */
+               restore_processor_state();
+               BUG_ON (nr_copy_pages_check != nr_copy_pages);
+               restore_highmem();
+               device_power_up();
+               local_irq_enable();
+       }
        return error;
 }

