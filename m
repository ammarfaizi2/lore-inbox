Return-Path: <linux-kernel-owner+w=401wt.eu-S932735AbWLTUmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWLTUmN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWLTUmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:42:13 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:46876 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbWLTUmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:42:12 -0500
From: Oliver Neukum <oliver@neukum.org>
To: J <jhnlmn@yahoo.com>, linux-usb-devel@lists.sourceforge.net
Subject: Re: Possible race condition in usb-serial.c
Date: Wed, 20 Dec 2006 21:43:54 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20061220193231.39261.qmail@web32911.mail.mud.yahoo.com>
In-Reply-To: <20061220193231.39261.qmail@web32911.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LCaiFMay9PjAzFu"
Message-Id: <200612202143.55778.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LCaiFMay9PjAzFu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch, 20. Dezember 2006 20:32 schrieb J:

> I am currently trying to fix a legacy 2.4 based USB
> driver and I am having various races, 
> serial_open/usb_serial_disconnect is the most lively.
> I am not asking your help in fixing this old 2.4 junk
> (in fact I already fixed it using a global semaphore
> to protect serial_table).

Please send in a patch for 2.4. It's very important to have a
very reliable ultraconservative tested kernel available.

> But I still want to understand how the latest and
> greatest 2.6 driver is supposed to work so I can
> adopt some of the changes. At first I thought that
> the ref-counting will help, but then found that 
> it does not fix much! The race is as lively 
> as ever.

I suppose the last time I looked at that code, khubd still took
BKL. Or I overlooked the race. I have no serial devices since
the cell phone broke.

> Also I found that BKL/lock_kernel is compiled out in
> my configuration because it is not an SMP build.
> 
> I see that in 2.6 BKL/lock_kernel are also optional
> for non-SMP builds. Is it true?
> If yes, then again, how this is supposed to work
> and avoid races?

Look closer. If you build with preemption, taking BKL disables preemption.
BKL is effective only until you schedule. On UP, without preemption
ordinary kernel code will not reenter. You need no lock that doesn't guard
against interrupts unless you schedule under these narrow conditions.

Could you test the attached patch against 2.6?

	Regards
		Oliver

--Boundary-00=_LCaiFMay9PjAzFu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="usbserialtablerace.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbserialtablerace.diff"

--- drivers/usb/serial/usb-serial.c.alt	2006-12-17 14:57:40.000000000 +0100
+++ drivers/usb/serial/usb-serial.c	2006-12-20 18:22:41.000000000 +0100
@@ -59,6 +59,7 @@
 
 static int debug;
 static struct usb_serial *serial_table[SERIAL_TTY_MINORS];	/* initially all NULL */
+static DECLARE_MUTEX(table_lock); /* lock for serial_table */
 static LIST_HEAD(usb_serial_driver_list);
 
 struct usb_serial *usb_serial_get_by_index(unsigned index)
@@ -176,7 +177,9 @@
 	dbg("%s", __FUNCTION__);
 
 	/* get the serial object associated with this tty pointer */
+	mutex_lock(&table_lock);
 	serial = usb_serial_get_by_index(tty->index);
+	mutex_unlock(&table_lock);
 	if (!serial) {
 		tty->driver_data = NULL;
 		return -ENODEV;
@@ -265,7 +268,9 @@
 	}
 
 	mutex_unlock(&port->mutex);
+	mutex_lock(&table_lock);
 	usb_serial_put(port->serial);
+	mutex_unlock(&table_lock);
 }
 
 static int serial_write (struct tty_struct * tty, const unsigned char *buf, int count)
@@ -771,7 +776,9 @@
 			num_ports = type->num_ports;
 	}
 
+	mutex_lock(&table_lock);
 	if (get_free_serial (serial, num_ports, &minor) == NULL) {
+		mutex_unlock(&table_lock);
 		dev_err(&interface->dev, "No more free serial devices\n");
 		kfree (serial);
 		return -ENOMEM;
@@ -921,6 +928,7 @@
 		if (retval > 0) {
 			/* quietly accept this device, but don't bind to a serial port
 			 * as it's about to disappear */
+			mutex_unlock(&table_lock);
 			goto exit;
 		}
 	}
@@ -941,6 +949,7 @@
 				"continuing\n");
 	}
 
+	mutex_unlock(&table_lock);
 	usb_serial_console_init (debug, minor);
 
 exit:
@@ -980,6 +989,7 @@
 
 	/* return the minor range that this device had */
 	return_serial (serial);
+	mutex_unlock(&table_lock);
 
 	/* free up any memory that we allocated */
 	for (i = 0; i < serial->num_port_pointers; ++i)
@@ -999,6 +1009,7 @@
 	dbg ("%s", __FUNCTION__);
 
 	usb_set_intfdata (interface, NULL);
+	mutex_lock(&table_lock);
 	if (serial) {
 		for (i = 0; i < serial->num_ports; ++i) {
 			port = serial->port[i];
@@ -1009,6 +1020,7 @@
 		 * cause it to be cleaned up */
 		usb_serial_put(serial);
 	}
+	mutex_unlock(&table_lock);
 	dev_info(dev, "device disconnected\n");
 }
 
@@ -1060,6 +1072,7 @@
 	usb_serial_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	usb_serial_tty_driver->init_termios = tty_std_termios;
 	usb_serial_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	init_MUTEX(&table_lock);
 	tty_set_operations(usb_serial_tty_driver, &serial_ops);
 	result = tty_register_driver(usb_serial_tty_driver);
 	if (result) {

--Boundary-00=_LCaiFMay9PjAzFu--
