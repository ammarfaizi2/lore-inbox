Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264875AbUEQAh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbUEQAh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUEQAh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:37:27 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57040 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264875AbUEQAhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:37:14 -0400
Date: Sun, 16 May 2004 20:37:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartmann <greg@kroah.com>
Subject: [PATCH][2.6] fix usb-serial serial_open oops
Message-ID: <Pine.LNX.4.58.0405162033330.32571@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No usb serial devices, just compiled in and the system has a USB controller.

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c046a188
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c046a188>]    Not tainted VLI
EFLAGS: 00010246   (2.6.6-mm3)
EIP is at serial_open+0x38/0x170
eax: 00000000   ebx: dc883000   ecx: c0613db8   edx: 00000000
esi: 00000001   edi: 00000000   ebp: dc84cef0   esp: dc84cedc
ds: 007b   es: 007b   ss: 0068
Process serial (pid: 1073, threadinfo=dc84c000 task=ddffca50)
Stack: 00000000 de8f4f5c ffffffed 00000100 de8f4f5c dc84cf14 c035a874 090115a0
       0bc00000 dc883000 00000000 de8f4f5c 00000001 df8a2dfc dc84cf40 c0171270
       dc84c000 00000001 00000000 de8f4f5c dbc75e94 00000000 de8f4f5c dbc75e94
Call Trace:
 [<c01076c5>] show_stack+0x75/0x90
 [<c010781f>] show_registers+0x11f/0x180
 [<c01079c6>] die+0xb6/0x170
 [<c011af20>] do_page_fault+0x1e0/0x525
 [<c010732d>] error_code+0x2d/0x40
 [<c035a874>] tty_open+0x274/0x3b0
 [<c0171270>] chrdev_open+0x160/0x340
 [<c0166426>] dentry_open+0x156/0x230
 [<c01662cd>] filp_open+0x4d/0x50
 [<c0166858>] sys_open+0x38/0x70
 [<c0106199>] sysenter_past_esp+0x52/0x79

Code: de 63 c0 89 55 f0 c7 45 ec 00 00 00 00 85 f6 0f 85 31 01 00 00 c7 83
8c 09 00 00 00 00 00 00 8b 43 08 e8 3c fe ff ff 31 d2 89 c7 <8a> 50 0c 8b
43 08 29 d0 8b 74 87 18 89 b3 8c 09 00 00 89 5e 04

(gdb) list *serial_open+0x38
0xc046a188 is in serial_open (drivers/usb/serial/usb-serial.c:465).
460
461             /* get the serial object associated with this tty pointer */
462             serial = usb_serial_get_by_index(tty->index);
463
464             /* set up our port structure making the tty driver remember our port object, and us it */
465             portNumber = tty->index - serial->minor;
466             port = serial->port[portNumber];
467             tty->driver_data = port;
468
469             port->tty = tty;

Index: linux-2.6.6-mm3/drivers/usb/serial/usb-serial.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm3/drivers/usb/serial/usb-serial.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 usb-serial.c
--- linux-2.6.6-mm3/drivers/usb/serial/usb-serial.c	16 May 2004 19:18:44 -0000	1.1.1.1
+++ linux-2.6.6-mm3/drivers/usb/serial/usb-serial.c	17 May 2004 00:21:45 -0000
@@ -460,6 +460,10 @@ static int serial_open (struct tty_struc

 	/* get the serial object associated with this tty pointer */
 	serial = usb_serial_get_by_index(tty->index);
+	if (!serial) {
+		retval = -ENODEV;
+		goto bailout;
+	}

 	/* set up our port structure making the tty driver remember our port object, and us it */
 	portNumber = tty->index - serial->minor;
@@ -493,6 +497,9 @@ bailout:
 static void serial_close(struct tty_struct *tty, struct file * filp)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
+
+	if (!port)
+		return;

 	dbg("%s - port %d", __FUNCTION__, port->number);

