Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVBOHVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVBOHVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 02:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVBOHVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 02:21:07 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:28804 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261644AbVBOHUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 02:20:52 -0500
Date: Tue, 15 Feb 2005 08:21:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Prarit Bhargava <prarit@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Message-ID: <20050215072124.GA1543@ucw.cz>
References: <41F11C66.5000707@sgi.com> <d120d500050121074313788f99@mail.gmail.com> <20050121163540.GC4795@ucw.cz> <200501210847.04654.jbarnes@engr.sgi.com> <41F13924.50602@sgi.com> <4210D29E.9000808@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4210D29E.9000808@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 11:32:30AM -0500, Prarit Bhargava wrote:

> I didn't see a final ACK on this patch -- just checking for one :)

The patch was redone - we now check for error from the 'flush' command
before sending CTL_TEST.

> P.
> 
> Prarit Bhargava wrote:
> 
> >I've taken into account Dmitry's comments (thanks Dmitry!) and 
> >generated a new patch.
> >
> >Thanks,
> >
> >P.
> >Jesse Barnes wrote:
> >
> >>On Friday, January 21, 2005 8:35 am, Vojtech Pavlik wrote:
> >> 
> >>
> >>>No. But vacant ports usually return 0xff. The problem here is that 0xff
> >>>is a valid value for the status register, too. Fortunately this patch
> >>>checks for 0xff only after the timeout failed.
> >>>  
> >>
> >>
> >>On PCs you'll get all 1s, but on some ia64 platforms and others, 
> >>you'll take a hard machine check exception if you try to access 
> >>non-existent memory (mmio, port space, or otherwise).
> >>
> >>Jesse
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe 
> >>linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >> 
> >>
> >------------------------------------------------------------------------
> >
> >===== i8042.c 1.71 vs edited =====
> >--- 1.71/drivers/input/serio/i8042.c	2005-01-03 08:11:49 -05:00
> >+++ edited/i8042.c	2005-01-21 11:50:11 -05:00
> >@@ -696,7 +696,10 @@
> >		unsigned char param;
> >
> >		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> >-			printk(KERN_ERR "i8042.c: i8042 controller self test 
> >timeout.\n");
> >+			if (i8042_read_status() != 0xFF)
> >+				printk(KERN_ERR "i8042.c: i8042 controller 
> >self test timeout.\n");
> >+			else
> >+				printk(KERN_ERR "i8042.c: no i8042 
> >controller found.\n");
> >			return -1;
> >		}
> >
> >@@ -1016,16 +1019,22 @@
> >	i8042_aux_values.irq = I8042_AUX_IRQ;
> >	i8042_kbd_values.irq = I8042_KBD_IRQ;
> >
> >-	if (i8042_controller_init())
> >+	if (i8042_controller_init()) {
> >+		i8042_platform_exit();
> >		return -ENODEV;
> >+	}
> >
> >	err = driver_register(&i8042_driver);
> >-	if (err)
> >+	if (err) {
> >+		i8042_platform_exit();
> >		return err;
> >+	}
> >
> >	i8042_platform_device = platform_device_register_simple("i8042", -1, 
> >	NULL, 0);
> >	if (IS_ERR(i8042_platform_device)) {
> >		driver_unregister(&i8042_driver);
> >+		i8042_platform_exit();
> >+		del_timer_sync(&i8042_timer);
> >		return PTR_ERR(i8042_platform_device);
> >	}
> >
> > 
> >
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
