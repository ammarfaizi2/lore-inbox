Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbTGOJmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267005AbTGOJmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:42:05 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:22797 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S266997AbTGOJl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:41:56 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Tue, 15 Jul 2003 17:34:45 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307151331.40428.mflt1@micrologica.com.hk> <20030715085622.A32119@flint.arm.linux.org.uk>
In-Reply-To: <20030715085622.A32119@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151734.46616.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 15:56, Russell King wrote:
> On Tue, Jul 15, 2003 at 01:31:37PM +0800, Michael Frank wrote:
> > problems seen:
> >
> > - yenta_probe pci_save_state saves irq as ff. Moved to end of function,
> > result same
>
> irq was 0xff at boot, so it is neither here nor there whether it remains
> 0xff after a resume.  If it works at boot with 0xff, it should work after
> a resume with 0xff.
>
> > - both swsusp and ACPI/S3 do _not_ call yenta_suspend and yenta_init,
> >   so it still wont work
>
> Please confirm whether pcmcia_socket_dev_suspend() is called from
> yenta.c with SUSPEND_SAVE_STATE and not zero.  (it should be
> SUSPEND_SAVE_STATE.)

Fixed that. Now it calls suspend and resume. It still doesn't work ;)

I believe it is not here now, we need to look elsewhere, as interrupts 
stay dead also after reloading modules (see logs).

For this test: 

$ lsmod
Module                  Size  Used by
8250_cs                 7428  0
ds                     11136  3 8250_cs
yenta_socket           11008  1
pcmcia_core            59904  3 8250_cs,ds,yenta_socket
toshiba_acpi            5268  0

swsusp

Jul 15 17:04:58 mhfl2 kernel: Stopping tasks: klogd entered refrigerator
Jul 15 17:04:58 mhfl2 kernel: =init entered refrigerator

snip

Jul 15 17:04:59 mhfl2 kernel: =kjournald entered refrigerator
Jul 15 17:04:59 mhfl2 kernel: =|
Jul 15 17:04:59 mhfl2 kernel: Freeing memory: .......| 
Jul 15 17:04:59 mhfl2 kernel: Syncing disks before copy
Jul 15 17:05:00 mhfl2 kernel: Suspending devices
Jul 15 17:05:00 mhfl2 kernel: Suspending devices
Jul 15 17:05:00 mhfl2 kernel: hda: start_power_step(step: 0)
Jul 15 17:05:00 mhfl2 kernel: hda: completing PM request, suspend
Jul 15 17:05:00 mhfl2 kernel: Suspending devices
Jul 15 17:05:00 mhfl2 kernel: Yenta: dev suspend
Jul 15 17:05:00 mhfl2 kernel: Yenta: suspend saved state ff
Jul 15 17:05:00 mhfl2 kernel: /critical section: Counting pages to copy[nosave c03e2000] (pages needed: 3426+512=3938 free: 57849)
Jul 15 17:05:00 mhfl2 kernel: Alloc pagedir
Jul 15 17:05:00 mhfl2 kernel: ....[nosave c03e2000]Enabling SEP on CPU 0
Jul 15 17:05:00 mhfl2 kernel: Freeing prev allocated pagedir

power down - resume

Jul 15 17:05:00 mhfl2 kernel: Yenta: dev resume
Jul 15 17:05:00 mhfl2 kernel: Yenta: init restored state ff
Jul 15 17:05:00 mhfl2 kernel: Trying to free nonexistent resource <000003f8-000003ff>
Jul 15 17:05:00 mhfl2 kernel: Yenta: init restored state ff
Jul 15 17:05:00 mhfl2 kernel: hda: Wakeup request inited, waiting for !BSY...
Jul 15 17:05:00 mhfl2 kernel: hda: start_power_step(step: 1000)
Jul 15 17:05:00 mhfl2 kernel: hda: completing PM request, resume
Jul 15 17:05:01 mhfl2 kernel: Devices Resumed
Jul 15 17:05:01 mhfl2 kernel: Devices Resumed
Jul 15 17:05:01 mhfl2 kernel: Yenta: dev resume
Jul 15 17:05:01 mhfl2 kernel: Fixing swap signatures... ok
Jul 15 17:05:01 mhfl2 kernel: Restarting processes...
Jul 15 17:05:01 mhfl2 kernel: Restarting tasks... done
Jul 15 17:05:01 mhfl2 kernel: init left refrigerator
Jul 15 17:05:01 mhfl2 kernel: pdflush left refrigerator
snip

Resumed: no interrupts

stop pcmcia

Jul 15 17:05:02 mhfl2 cardmgr[774]: executing: './serial stop ttyS0'

removing all pcmcia modules

Jul 15 17:05:40 mhfl2 su(pam_unix)[855]: session opened for user root by mhf(uid=500)
Jul 15 17:05:50 mhfl2 cardmgr[774]: exiting
Jul 15 17:06:28 mhfl2 kernel: unloading Kernel Card Services

start pcmcia again

Jul 15 17:06:42 mhfl2 kernel: Linux Kernel Card Services 3.1.22
Jul 15 17:06:42 mhfl2 kernel:   options:  [pci] [cardbus] [pm]
Jul 15 17:06:43 mhfl2 kernel: Intel PCIC probe: not found.
Jul 15 17:06:43 mhfl2 kernel: Yenta IRQ list 0000, PCI irq5
Jul 15 17:06:43 mhfl2 kernel: Socket status: ffffffff
Jul 15 17:06:43 mhfl2 kernel: Yenta: probe saved state ff
Jul 15 17:06:43 mhfl2 kernel: Yenta: init restored state ff
Jul 15 17:06:43 mhfl2 cardmgr[996]: watching 1 sockets
Jul 15 17:06:43 mhfl2 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 15 17:06:43 mhfl2 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jul 15 17:06:43 mhfl2 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x1e0-0x1e7 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Jul 15 17:06:43 mhfl2 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 15 17:06:43 mhfl2 cardmgr[997]: starting, version is 3.2.4

interrupts still dead, now it is something else!

reboot (need to use modem for this email ;)

Jul 15 17:07:53 mhfl2 shutdown: shutting down for system reboot

diff -uN drivers/pcmcia/yenta_socket.c.orig drivers/pcmcia/yenta_socket.c
--- drivers/pcmcia/yenta_socket.c.orig  2003-07-15 12:39:52.000000000 +0800
+++ drivers/pcmcia/yenta_socket.c       2003-07-15 17:19:11.000000000 +0800
@@ -577,7 +577,9 @@
        struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);

        pci_set_power_state(socket->dev, 0);
-       pci_restore_state(socket->dev, socket->saved_state);
+
+	pci_restore_state(socket->dev, socket->saved_state);
+	printk("Yenta: init restored state %x\n",(u8)socket->saved_state[0xf]);

        yenta_config_init(socket);
        yenta_clear_maps(socket);
@@ -597,6 +599,7 @@
        cb_writel(socket, CB_SOCKET_MASK, 0x0);

        pci_save_state(socket->dev, socket->saved_state);
+	printk("Yenta: suspend saved state %x\n",(u8)socket->saved_state[0xf]);

        /*
         * This does not work currently. The controller
@@ -867,8 +870,6 @@
        /* Set up the bridge regions.. */
        yenta_allocate_resources(socket);

-       pci_save_state(dev, socket->saved_state);
-
        socket->cb_irq = dev->irq;

        /* Do we have special options for the device? */
@@ -897,6 +898,10 @@
        /* Figure out what the dang thing can do for the PCMCIA layer... */
        yenta_get_socket_capabilities(socket, isa_interrupts);
        printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
+	pci_save_state(dev, socket->saved_state);
+	printk("Yenta: probe saved state %x\n",(u8)socket->saved_state[0xf]);
+	//(u8)socket->saved_state[0xf] = socket->cb_irq;
+	//printk("Yenta: probe saved state irq fixed %x\n",(u8)socket->saved_state[0xf]);

        /* Register it with the pcmcia layer.. */
        return pcmcia_register_socket(&socket->socket);
@@ -905,12 +910,14 @@

 static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
 {
-       return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
+  	printk("Yenta: dev suspend\n");
+	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
 }


 static int yenta_dev_resume (struct pci_dev *dev)
 {
+	printk("Yenta: dev resume\n");
        return pcmcia_socket_dev_resume(&dev->dev, RESUME_RESTORE_STATE);
 }

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

