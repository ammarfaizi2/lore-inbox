Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbUKHHmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUKHHmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKHHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:42:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:2524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261773AbUKHHmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:42:33 -0500
Date: Sun, 7 Nov 2004 23:42:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: diffie@gmail.com, linux-kernel@vger.kernel.org, diffie@blazebox.homeip.net,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-rc1-mm3
Message-Id: <20041107234225.02c2f9b6.akpm@osdl.org>
In-Reply-To: <20041108075934.GA4602@elte.hu>
References: <9dda349204110611043e093bca@mail.gmail.com>
	<20041107024841.402c16ed.akpm@osdl.org>
	<20041108075934.GA4602@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > Weird.  Can you send me the .config?
> 
>  reproducible here too with Paul's .config.

Me too.  The problem starts out at tty_register_driver():

	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
		for(i = 0; i < driver->num; i++)
		    tty_register_device(driver, i, NULL);

That NULL for the struct device* propagates all the way down to
class_hotplug_name() and bang.  This bug is present in Linus's tree.


0xc026d8ce in class_hotplug_name (kset=0xc03ccf80, kobj=0xc17b3614) at drivers/base/class.c:278
278             return class_dev->class->name;
(gdb) bt
#0  0xc026d8ce in class_hotplug_name (kset=0xc03ccf80, kobj=0xc17b3614) at drivers/base/class.c:278
#1  0xc02164eb in kobject_hotplug (kobj=0xc17b3614, action=0) at lib/kobject_uevent.c:243
#2  0xc0215f3a in kobject_add (kobj=0xc17b3614) at lib/kobject.c:188
#3  0xc026db46 in class_device_add (class_dev=0xc17b360c) at drivers/base/class.c:401
#4  0xc026dc0d in class_device_register (class_dev=0xc17b360c) at drivers/base/class.c:427
#5  0xc026e09f in class_simple_device_add (cs=0xcffa3d80, dev=0, device=0x0, fmt=0x0)
    at drivers/base/class_simple.c:153
#6  0xc0254b8d in tty_register_device (driver=0xc1781c00, index=0, device=0x0) at drivers/char/tty_io.c:2708
#7  0xc0254ed0 in tty_register_driver (driver=0xc1781c00) at drivers/char/tty_io.c:2845
#8  0xc0577a1b in legacy_pty_init () at drivers/char/pty.c:299
#9  0xc0577be9 in pty_init () at drivers/char/pty.c:406
#10 0xc05647da in do_initcalls () at init/main.c:625
#11 0xc056484e in do_basic_setup () at init/main.c:668
#12 0xc0100410 in init (unused=0x80) at init/main.c:736
#13 0xc0104255 in kernel_thread_helper () at arch/i386/kernel/process.c:293

I assume that tty_register_driver is at fault, but will call in Greg for
adjudication. 
