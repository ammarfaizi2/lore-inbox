Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVCJIKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVCJIKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVCJIKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:10:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:58558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261433AbVCJIJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:09:59 -0500
Date: Thu, 10 Mar 2005 00:09:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11-mm2
Message-Id: <20050310000921.0d0bd597.akpm@osdl.org>
In-Reply-To: <422FFDEF.2060706@gts.it>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<422FFDEF.2060706@gts.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/
> 
> Hi Andrew
> 
> With 2.6.11-mm series, "acpi_poweroff called" problem is back again (it 
> disappeared in 2.6.11-rc-mm and actually never happend in Linus' tree). 
> So when you shutdown, you have to unplug power cord or so to switch off 
> because the system hangs after that message is displayed.
> 

Does the below fix it?

If so, sorry, this patch was dropped because it just does everything the
wrong way, and the acpi guys are cooking up some scheme to fix it for real.



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


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/acpi/sleep/poweroff.c |   23 +++++++++++++++++++++--
 25-akpm/drivers/base/power/shutdown.c |    7 +++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/sleep/poweroff.c~acpi_power_off-bug-fix drivers/acpi/sleep/poweroff.c
--- 25/drivers/acpi/sleep/poweroff.c~acpi_power_off-bug-fix	2005-02-23 01:48:08.000000000 -0800
+++ 25-akpm/drivers/acpi/sleep/poweroff.c	2005-02-23 01:48:08.000000000 -0800
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
--- 25/drivers/base/power/shutdown.c~acpi_power_off-bug-fix	2005-02-23 01:48:08.000000000 -0800
+++ 25-akpm/drivers/base/power/shutdown.c	2005-02-23 01:48:08.000000000 -0800
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

