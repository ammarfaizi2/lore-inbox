Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUJBSKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUJBSKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 14:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUJBSKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 14:10:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:46741 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267464AbUJBSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 14:10:47 -0400
Subject: Re: usb on amd-756 broken since 2.6.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gerard H. Pille" <g.h.p@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, greg@kroah.com
In-Reply-To: <415EA6FC.2080807@skynet.be>
References: <415EA6FC.2080807@skynet.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096736877.25292.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 18:08:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-02 at 14:02, Gerard H. Pille wrote: 
> The last kernel on which I could succesfully mount /proc/bus/usb and 
> "cat /proc/bus/usb/devices" is 2.6.5, since then, the cat hangs.  I am 
> not sure if the trouble starts with 2.6.6 or 2.6.7, since I can not boot 
> with 2.6.6, the boot hangs on the hdd, a cdrom.  If I could find patches 
>   to get 2.6.6 working, I might be able to further narrow it down.
> 
> In /var/log/messages, I only see this "kernel: usb 1-2: control timeout 
> on ep0in".

This is not AMD specific - the core USB code is broken in the event of
that control timeout occuring. I see the same hang on an Intel ICH6M
platform.

I've done a quick review of the semaphores and didn't see an obvious
cause although I did find a glaring error on a different unused path.
(Oh and although it isn't fixed - that isnt how busses pluralises either
)

--- drivers/usb/core/hcd.c~	2004-10-02 19:01:30.764022672 +0100
+++ drivers/usb/core/hcd.c	2004-10-02 19:01:30.784019632 +0100
@@ -708,6 +708,7 @@
 		bus->busnum = busnum;
 	} else {
 		printk (KERN_ERR "%s: too many buses\n", usbcore_name);
+		up(&usb_bus_list_lock);
 		return -E2BIG;
 	}
 

