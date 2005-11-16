Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbVKPRQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVKPRQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVKPRQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:16:37 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:36509 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751485AbVKPRQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:16:36 -0500
Date: Wed, 16 Nov 2005 15:16:34 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] - Fixes NULL pointer deference in usb-serial driver.
Message-Id: <20051116151634.20661b0f.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

 If I run several instances of this program in parallel: 

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[])
{
	int ret, fd;
	char *port;
	struct termios tio, original;

	port = argv[1];
	if (!port)
		port = "/dev/ttyUSB0";

	fd = open(port, O_RDWR | O_NONBLOCK | O_NOCTTY);
	if (fd < 0) {
		perror("open()");
		exit(1);
	}

	usleep(100);
	ret = tcgetattr(fd, &original);
	if (ret < 0) {
		perror("tcgetattr()");
		exit(1);
	}

	ret = close(fd);
	if (ret) {
		perror("close()");
		exit(1);
	}

	return 0;
}

 with a Siemens CX65 mobile (which uses the pl2303 driver), I get the
following NULL pointer deference:

Nov 15 12:32:19 tirion kernel: [  147.009410] Unable to handle kernel NULL pointer dereference at virtual address 000000a4
Nov 15 12:32:19 tirion kernel: [  147.009430]  printing eip:
Nov 15 12:32:19 tirion kernel: [  147.009436] d0a1f888
Nov 15 12:32:19 tirion kernel: [  147.009441] *pde = 00000000
Nov 15 12:32:19 tirion kernel: [  147.009449] Oops: 0000 [#1]
Nov 15 12:32:19 tirion kernel: [  147.009454] DEBUG_PAGEALLOC
Nov 15 12:32:19 tirion kernel: [  147.009461] Modules linked in: pl2303 usbserial ide_cd cdrom e100 mii uhci_hcd ehci_hcd usbcore quota_v2 snd_cs46xx snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc
Nov 15 12:32:19 tirion kernel: [  147.009504] CPU:    0
Nov 15 12:32:19 tirion kernel: [  147.009507] EIP:    0060:[pg0+275417224/1070101504]    Not tainted VLI
Nov 15 12:32:19 tirion kernel: [  147.009512] EFLAGS: 00210246   (2.6.15-rc1y-gee90f62b) 
Nov 15 12:32:19 tirion kernel: [  147.009548] EIP is at serial_ioctl+0x28/0xd0 [usbserial]
Nov 15 12:32:19 tirion kernel: [  147.009558] eax: 00000000   ebx: 00000000   ecx: 00005401   edx: c99c4f58
Nov 15 12:32:19 tirion kernel: [  147.009569] esi: ffffffed   edi: 00005401   ebp: c94c3f3c   esp: c94c3f18
Nov 15 12:32:19 tirion kernel: [  147.009578] ds: 007b   es: 007b   ss: 0068
Nov 15 12:32:19 tirion kernel: [  147.009588] Process termios_set (pid: 3091, threadinfo=c94c2000 task=c9ba6ad0)
Nov 15 12:32:19 tirion kernel: [  147.009595] Stack: 00000000 c95c1b7c b7f014e0 c94c3f5c c0144ed6 c99c4f58 cb0eedf8 d0a1f860 
Nov 15 12:32:19 tirion kernel: [  147.009618]        c9bd6000 c94c3f60 c01f5c23 bfc7c010 c9bd6000 00005401 c99c4f58 c02eda60 
Nov 15 12:32:19 tirion kernel: [  147.009640]        c99c4f58 c01f5970 c94c3f78 c0164ac8 bfc7c010 c99c4f58 00000000 00000003 
Nov 15 12:32:19 tirion kernel: [  147.009662] Call Trace:
Nov 15 12:32:19 tirion kernel: [  147.009668]  [show_stack+122/144] show_stack+0x7a/0x90
Nov 15 12:32:19 tirion kernel: [  147.009689]  [show_registers+330/432] show_registers+0x14a/0x1b0
Nov 15 12:32:19 tirion kernel: [  147.009702]  [die+220/352] die+0xdc/0x160
Nov 15 12:32:19 tirion kernel: [  147.009714]  [do_page_fault+724/1461] do_page_fault+0x2d4/0x5b5
Nov 15 12:32:19 tirion kernel: [  147.009738]  [error_code+79/84] error_code+0x4f/0x54
Nov 15 12:32:19 tirion kernel: [  147.009750]  [tty_ioctl+691/944] tty_ioctl+0x2b3/0x3b0
Nov 15 12:32:19 tirion kernel: [  147.009768]  [do_ioctl+72/112] do_ioctl+0x48/0x70
Nov 15 12:32:19 tirion kernel: [  147.009786]  [vfs_ioctl+95/416] vfs_ioctl+0x5f/0x1a0
Nov 15 12:32:19 tirion kernel: [  147.009798]  [sys_ioctl+57/96] sys_ioctl+0x39/0x60
Nov 15 12:32:19 tirion kernel: [  147.009809]  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 15 12:32:19 tirion kernel: [  147.009820] Code: ef eb 88 55 89 e5 83 ec 24 89 75 f8 be ed ff ff ff 89 7d fc 89 cf 89 5d f4 89 55 f0 8b 98 b4 09 00 00 a1 04 59 a2 d0 85 c0 75 78 <8b> 83 a4 00 00 00 85 c0 74 3e 8b 03 8b 70 04 8b 86 fc 00 00 00 

 The deference is at drivers/usb/serial/usb-serial.c:352. The first fix I
thought was just to check if 'port' is NULL, and to return '-ENODEV' if so.
I did that, but it brought up another problem: when the bug is triggered
(ie, 'port' is NULL) the serial port in use becomes invalid, and I have to
replug the device's cable. This will force the device to take the next free
port.

 We cannot live with this of course, because the numbers of ports is
limited.

 My guess is: 

1. Process A calls open() and tcgetattr(). When it calls close(), the specific
driver function put it to sleep at usb_serial.c:242 (I'm using pl2303 driver)

2. Process B calls open() and before the call to tcgetattr() it is put to
sleep.

3. Process A wakes up and finish the close procedure (which resets
'port->tty->driver_data')

4. Process B wakes up, executes serial_ioctl() and gets a NULL pointer in
'port->tty->driver_data'.

 So, based on my guess the right fix _seems_ to be serialize the construction
and destruction of 'port'. The following patch does that, I can run hundreds
instances of the test-case (and use minicom in parallel) without any
problem.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.c |   15 ++++++++++++++-
 drivers/usb/serial/usb-serial.h |    2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
 #include "pl2303.h"
@@ -188,6 +189,9 @@ static int serial_open (struct tty_struc
 
 	portNumber = tty->index - serial->minor;
 	port = serial->port[portNumber];
+
+	if (down_interruptible(&port->sem))
+		return -ERESTARTSYS;
 	 
 	++port->open_count;
 
@@ -213,6 +217,7 @@ static int serial_open (struct tty_struc
 			goto bailout_module_put;
 	}
 
+	up(&port->sem);
 	return 0;
 
 bailout_module_put:
@@ -220,6 +225,7 @@ bailout_module_put:
 bailout_kref_put:
 	kref_put(&serial->kref, destroy_serial);
 	port->open_count = 0;
+	up(&port->sem);
 	return retval;
 }
 
@@ -232,9 +238,12 @@ static void serial_close(struct tty_stru
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	if (port->open_count == 0)
+	if (down_interruptible(&port->sem))
 		return;
 
+	if (port->open_count == 0)
+		goto out;
+
 	--port->open_count;
 	if (port->open_count == 0) {
 		/* only call the device specific close if this 
@@ -251,6 +260,9 @@ static void serial_close(struct tty_stru
 	}
 
 	kref_put(&port->serial->kref, destroy_serial);
+
+out:
+	up(&port->sem);
 }
 
 static int serial_write (struct tty_struct * tty, const unsigned char *buf, int count)
@@ -742,6 +754,7 @@ int usb_serial_probe(struct usb_interfac
 		port->number = i + serial->minor;
 		port->serial = serial;
 		spin_lock_init(&port->lock);
+		sema_init(&port->sem, 1);
 		INIT_WORK(&port->work, usb_serial_port_softint, port);
 		serial->port[i] = port;
 	}
diff --git a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h
+++ b/drivers/usb/serial/usb-serial.h
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 #include <linux/kref.h>
+#include <asm/semaphore.h>
 
 #define SERIAL_TTY_MAJOR	188	/* Nice legal number now */
 #define SERIAL_TTY_MINORS	255	/* loads of devices :) */
@@ -60,6 +61,7 @@ struct usb_serial_port {
 	struct usb_serial *	serial;
 	struct tty_struct *	tty;
 	spinlock_t		lock;
+	struct semaphore        sem;
 	unsigned char		number;
 
 	unsigned char *		interrupt_in_buffer;


-- 
Luiz Fernando N. Capitulino
