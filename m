Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUJBD7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUJBD7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 23:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUJBD7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 23:59:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:29355 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267263AbUJBD7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 23:59:13 -0400
Date: Fri, 1 Oct 2004 20:56:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: sebek64@post.cz (Marcel Sebek)
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.9-rc3-bk1] Sleeping function called from invalid context
Message-Id: <20041001205658.7c2b8ecf.akpm@osdl.org>
In-Reply-To: <20041001203505.GA4480@penguin.localdomain>
References: <20041001203505.GA4480@penguin.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sebek64@post.cz (Marcel Sebek) wrote:
>
> I upgraded from 2.6.8-rc2-bk10.
>  When I run pppd, a lot of debug messages are typed out.
>  pppd uses /dev/ttyUSB0 as serial device (driver ftdi_sio).
> 
>  My .config is at http://wremcont.mysteria.cz/config-2.6.9-rc3-bk1
>  Kernel debug output is at http://wremcont.mysteria.cz/messages-2.6.9-rc3-bk1

OK, we have a problem.

Debug: sleeping function called from invalid context at mm/slab.c:2052
in_atomic():1, irqs_disabled():1
[__might_sleep+180/224] __might_sleep+0xb4/0xe0
[pg0+273102006/1069224960] hcd_submit_urb+0x106/0x190 [usbcore]
[kmem_cache_alloc+91/96] kmem_cache_alloc+0x5b/0x60
[pg0+273105606/1069224960] usb_control_msg+0x36/0xa0 [usbcore]
[pg0+272960692/1069224960] ftdi_set_termios+0x144/0x5f0 [ftdi_sio]
[pg0+273029492/1069224960] serial_set_termios+0x44/0xa0 [usbserial]
[tty_wait_until_sent+215/240] tty_wait_until_sent+0xd7/0xf0
[change_termios+480/528] change_termios+0x1e0/0x210
[set_termios+227/288] set_termios+0xe3/0x120
[tty_ioctl+1025/1248] tty_ioctl+0x401/0x4e0
[sys_ioctl+233/608] sys_ioctl+0xe9/0x260
[sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!

In rc3 change_termios() was altered so that it calls
(*tty->driver->set_termios)() under spin_lock_irqsave(tty_termios_lock).

But ftdi_set_termios() wants to perform USB I/O, which involves sleeping
allocations all over the place.

There may be other ->set_termios() implementations which want to sleep, too.
