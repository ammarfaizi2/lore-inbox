Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWCNTLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWCNTLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWCNTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:11:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40891 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751764AbWCNTLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:11:06 -0500
Subject: Re: 2.6.16-rc6-mm1 : Setting clocksource results in error
From: john stultz <johnstul@us.ibm.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603140935.26927@zodiac.zodiac.dnsalias.org>
References: <200603140935.26927@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 14 Mar 2006 11:11:04 -0800
Message-Id: <1142363464.8797.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 09:35 +0100, Alexander Gran wrote:
> I'm still fiddeling with my way to slow netbeans debugger. I just tried to 
> change the clocksource. That resulted in an error, but apparently worked. Is 
> that expected behaviour:
> root@t40:/sys/devices/system/clocksource/clocksource0# l
> insgesamt 0
> -rw------- 1 root root 4,0K 2006-03-14 09:31 available_clocksource
> -rw------- 1 root root    0 2006-03-14 09:31 current_clocksource
> root@t40:/sys/devices/system/clocksource/clocksource0# cat 
> available_clocksource
> acpi_pm jiffies tsc pit
> root@t40:/sys/devices/system/clocksource/clocksource0# echo acpi_pm > 
> current_clocksource
> -su: echo: write error: Das Argument ist ungültig
> root@t40:/sys/devices/system/clocksource/clocksource0# cat current_clocksource
> acpi_pm

Huh. Interesting.

Oh! I see it, we're stripping the \n from the name and returning a count
value one less then what was given.

You can verify it by noticing "echo -n tsc > current_clocksource" does
not give the error.

This small fix should resolve it.

Thanks for the bug report!
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d2ce2c3..fe22f64 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -220,6 +220,7 @@ sysfs_show_current_clocksources(struct s
 static ssize_t sysfs_override_clocksource(struct sys_device *dev,
 					  const char *buf, size_t count)
 {
+	size_t ret = count;
 	/* strings from sysfs write are not 0 terminated! */
 	if (count >= sizeof(override_name))
 		return -EINVAL;
@@ -241,7 +242,7 @@ static ssize_t sysfs_override_clocksourc
 
 	spin_unlock_irq(&clocksource_lock);
 
-	return count;
+	return ret;
 }
 
 /**



