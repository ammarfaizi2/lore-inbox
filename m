Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbUKITk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUKITk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKITk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:40:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:14215 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261642AbUKITkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:40:17 -0500
Date: Tue, 9 Nov 2004 11:39:47 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /sys/devices/system/timer registered twice
Message-ID: <20041109193947.GA5758@kroah.com>
References: <20041109193043.GA8767@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109193043.GA8767@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 08:30:43PM +0100, Kay Sievers wrote:
> Hi,
> I got this on a Centrino box with the latest bk:
> 
>   [kay@pim linux.kay]$ ls -l /sys/devices/system/
>   total 0
>   drwxr-xr-x  7 root root 0 Nov  8 15:12 .
>   drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
>   drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
>   drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
>   drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
>   drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
>   ?---------  ? ?    ?    ?            ? timer
> 
> 
> It is caused by registering two devices with the name "timer" from:
> 
>   arch/i386/kernel/time.c
>   arch/i386/kernel/timers/timer_pit.c
> 
> If I change one of the names, I get two correct looking sysfs entries.
> 
> Greg, shouldn't the driver core prevent the corruption of the first
> device if another one tries to register with the same name?

Yes, we should handle this.  Can you try the patch below?  I just sent
it to Linus, as it fixes a bug that was recently introduced.

The second registration should fail, and this patch will make it fail,
and recover properly.

thanks,

greg k-h

--- a/lib/kobject.c	2004-11-05 10:06:33 -08:00
+++ b/lib/kobject.c	2004-11-08 23:58:02 -08:00
@@ -181,10 +181,10 @@ int kobject_add(struct kobject * kobj)
 
 	error = create_dir(kobj);
 	if (error) {
+		/* Does the kobject_put() for us */
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
-		kobject_put(kobj);
 	} else {
 		kobject_hotplug(kobj, KOBJ_ADD);
 	}
