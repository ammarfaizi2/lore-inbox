Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVGZUz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVGZUz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVGZUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:55:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261929AbVGZUzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:55:53 -0400
Date: Tue, 26 Jul 2005 13:57:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 16/23] swpsuspend:  Have suspend to disk use factors of
 sys_reboot
Message-Id: <20050726135749.14bf26df.akpm@osdl.org>
In-Reply-To: <m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
	<m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
	<m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> 
> The suspend to disk code was a poor copy of the code in
> sys_reboot now that we have kernel_power_off, kernel_restart
> and kernel_halt use them instead of poorly duplicating them inline.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
>  kernel/power/disk.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> 78a2f83d732e327874fe73728d5667875dfeea46
> diff --git a/kernel/power/disk.c b/kernel/power/disk.c
> --- a/kernel/power/disk.c
> +++ b/kernel/power/disk.c
> @@ -59,16 +59,13 @@ static void power_down(suspend_disk_meth
>  		error = pm_ops->enter(PM_SUSPEND_DISK);
>  		break;
>  	case PM_DISK_SHUTDOWN:
> -		printk("Powering off system\n");
> -		device_shutdown();
> -		machine_power_off();
> +		kernel_power_off();
>  		break;
>  	case PM_DISK_REBOOT:
> -		device_shutdown();
> -		machine_restart(NULL);
> +		kernel_restart(NULL);
>  		break;
>  	}
> -	machine_halt();
> +	kernel_halt();
>  	/* Valid image is on the disk, if we continue we risk serious data corruption
>  	   after resume. */
>  	printk(KERN_CRIT "Please power me down manually\n");

This one conflicts in both implementation and intent with the below, from Pavel.  I'll
drop Pavel's patch.


From: Pavel Machek <pavel@ucw.cz>

Do not call device_shutdown with interrupts disabled.  It is wrong and
produces ugly warnings.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/power/disk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN kernel/power/disk.c~call-device_shutdown-with-interrupts-enabled kernel/power/disk.c
--- devel/kernel/power/disk.c~call-device_shutdown-with-interrupts-enabled	2005-07-08 23:11:23.000000000 -0700
+++ devel-akpm/kernel/power/disk.c	2005-07-08 23:11:23.000000000 -0700
@@ -52,19 +52,21 @@ static void power_down(suspend_disk_meth
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
+		device_shutdown();
+		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
 		device_shutdown();
+		local_irq_save(flags);
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
 		device_shutdown();
+		local_irq_save(flags);
 		machine_restart(NULL);
 		break;
 	}
_
