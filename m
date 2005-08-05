Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVHEGMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVHEGMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVHEGJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:09:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262867AbVHEGJ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:09:27 -0400
Date: Thu, 4 Aug 2005 23:08:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kristian =?ISO-8859-1?B?R3L4bmZlbGR0IFP4cmVuc2Vu?= 
	<kriller@vkr.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when shutting down laptop
Message-Id: <20050804230818.7d4df88a.akpm@osdl.org>
In-Reply-To: <1123186901.8831.42.camel@localhost.localdomain>
References: <1123186901.8831.42.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Grønfeldt Sørensen <kriller@vkr.dk> wrote:
>
> My laptop oops'es in the final phase of shutdown. It started this
>  Monday. I don't remember having done anything particular with respect to
>  the kernel around that time. It only happens when going to runlevel 0 -
>  a reboot does not result in an oops.
> 
>  Until yesterday i used kernel 2.6.13-rc3, but i have now compiled
>  2.6.13-rc5 with some debugging support. However the problem persists.
> 
>  Since the oops happens so late in the shutdown-sequence, that all
>  filesystems has been unmounted, i am unable to capture the oops on the
>  disc, but a picture of the oops is available at
>  http://www.vkr.dk/~kriller/oops.jpg . (Sorry for not writing the oops in
>  this mail).
> 
>  I tried to remove all modules except speedstep_centrino, freqtable,
>  processor and ipv6 (reported as being in use),  before calling poweroff,
>  but with no change.

We've been busily reverting new power management patches and it's likely
that we fixed this one in the past day or so.  So please test 2.6.13-rc6
when it comes out, or 2.6.13-rc5-git3 which is about three hours away,
thanks.

If it still happens please add the below patch so we can work out the
offending device.  Or apply it anyway - we may have a buggy driver which
will just bite us again later.

Thanks.

--- devel/drivers/base/power/suspend.c~a	2005-08-04 23:06:27.000000000 -0700
+++ devel-akpm/drivers/base/power/suspend.c	2005-08-04 23:08:06.000000000 -0700
@@ -92,6 +92,8 @@ int device_suspend(pm_message_t state)
 		get_device(dev);
 		up(&dpm_list_sem);
 
+		printk("Suspending device %s\n", kobject_name(&dev->kobj));
+
 		error = suspend_device(dev, state);
 
 		down(&dpm_list_sem);
_

