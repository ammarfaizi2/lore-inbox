Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVBJENh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVBJENh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVBJEMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:12:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:5095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262014AbVBJEM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:12:28 -0500
Date: Wed, 9 Feb 2005 20:12:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.11-rc3-mm1
Message-Id: <20050209201207.54c1f99a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt>
References: <20050204103350.241a907a.akpm@osdl.org>
	<Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
>
>  Please add to -mm the patch in attachment, since it solves the old
>  acpi_power_off bug...
> 
> ...
>  diff -Nru -p1 linux-2.6.11-rc2-mm1/drivers/base/power/shutdown.c linux-2.6.11-rc2-mm1-mbn1/drivers/base/power/shutdown.c
>  --- linux-2.6.11-rc2-mm1/drivers/base/power/shutdown.c	2004-12-24 22:35:01.000000000 +0100
>  +++ linux-2.6.11-rc2-mm1-mbn1/drivers/base/power/shutdown.c	2005-01-26 00:26:54.000000000 +0100
>  @@ -64,2 +64,9 @@ void device_shutdown(void)
>   
>  +#if 1
>  +	{
>  +		extern void do_acpi_power_off_prepare(void);
>  +		do_acpi_power_off_prepare();
>  +	}
>  +#endif
>  +

This of course doesn't compile if CONFIG_ACPI=n.  I fixed that up.

Also, having acpi stuff in drivers/base/power/shutdown.c is quite
inappropriate.

Also, extern declarations should also not be placed in .c files - they
should go into header files which are shared by the definition and all
users of the symbol.

(I understand that it's only a "proof of concept" patch, but I thought I'd
bitch anyway ;))

So.  I'll keep the patch as-is in -mm for now.  I've Cc'ed linux-acpi. 
Perhaps the people there can absorb this and fix it up for real, please?


From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>

From: "Barry K. Nathan" <barryn@pobox.com>

On Tue, Feb 08, 2005 at 08:54:06PM -0800, Andrew Morton wrote:
> "Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:
> >
> > Please add to -mm the patch in attachment, since it solves the old
> >  acpi_power_off bug...
> 
> What acpi_power_off bug?  And how does it solve it?

Here's the observed bug that the patch is trying to fix:
http://bugme.osdl.org/show_bug.cgi?id=4041

What Marcos posted is a typo-corrected version of Eric Biederman's
patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110665542929525&w=2

In Eric's own words, the patch "needs some work before it goes into a
mainline kernel". AFAICT it's more of a proof-of-concept, just to see if
Eric's on the right track...

This is the motivation behind the patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110665405402747&w=2


--- 25-alpha/drivers/acpi/sleep/poweroff.c~acpi_power_off-bug-fix	2005-02-09 19:55:05.000000000 -0800
+++ 25-alpha-akpm/drivers/acpi/sleep/poweroff.c	2005-02-09 19:55:05.000000000 -0800
@@ -7,18 +7,37 @@
 
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <acpi/acpi_bus.h>
 #include <linux/sched.h>
 #include "sleep.h"
 
 static void
+acpi_power_off_prepare(void)
+{
+       if (system_state == SYSTEM_POWER_OFF) {
+               acpi_wakeup_gpe_poweroff_prepare();
+               acpi_enter_sleep_state_prep(ACPI_STATE_S5);
+       }
+}
+
+void
+do_acpi_power_off_prepare(void)
+{
+       if (!acpi_disabled) {
+               acpi_power_off_prepare();
+       }
+}
+
+
+static void
 acpi_power_off (void)
 {
 	printk("%s called\n",__FUNCTION__);
+#if 0	/* This should be made redundant by other patches.. */
 	/* Some SMP machines only can poweroff in boot CPU */
 	set_cpus_allowed(current, cpumask_of_cpu(0));
-	acpi_wakeup_gpe_poweroff_prepare();
-	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
+#endif
 	ACPI_DISABLE_IRQS();
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
diff -puN drivers/base/power/shutdown.c~acpi_power_off-bug-fix drivers/base/power/shutdown.c
--- 25-alpha/drivers/base/power/shutdown.c~acpi_power_off-bug-fix	2005-02-09 19:55:05.000000000 -0800
+++ 25-alpha-akpm/drivers/base/power/shutdown.c	2005-02-09 20:10:21.000000000 -0800
@@ -62,6 +62,13 @@ void device_shutdown(void)
 	}
 	up_write(&devices_subsys.rwsem);
 
+#ifdef CONFIG_ACPI
+	{
+		extern void do_acpi_power_off_prepare(void);
+		do_acpi_power_off_prepare();
+	}
+#endif
+
 	sysdev_shutdown();
 }
 
_

