Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSC0Xyo>; Wed, 27 Mar 2002 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310182AbSC0Xy3>; Wed, 27 Mar 2002 18:54:29 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:14086 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293725AbSC0XyE>;
	Wed, 27 Mar 2002 18:54:04 -0500
Date: Wed, 27 Mar 2002 15:54:02 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] USB Serial console support for 2.5.7
Message-ID: <20020327235402.GE5454@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 27 Feb 2002 20:50:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a patch against my most recent 2.5.7 tree (see
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101675847419296 for
the only patch you need against a clean 2.5.7 kernel) that adds USB
serial console support.

It works just like the normal serial console support, but you need to
specify a ttyUSB port instead of a ttyS port on the kernel command line.
For example, add this to the kernel command line to use the ttyUSB0 port
at 57600 baud as a console:
	console=ttyUSB0,57600

I've tested this driver out with a pl2303 device, but would not really
recommend this device.  It drops data sent to the console, as the
console subsystem doesn't care about the return value of write().  It
helps to set the baud rate very high :)  This is a fault of the driver,
not the device.  I'll be working on fixing this in the future.

I've also made some changes to the belkin and visor serial drivers so
they should work well.  Most of the other usb-serial drivers might need
some minor changes to work properly (there is no tty device assigned to
a serial console, and the usb-serial drivers used to assume that a tty
device is present at all times.)

The visor or other Palm device looks like it would make a very nice
console, if you can run a terminal program on your device (no ppp is
needed.)  I think only the HandSpring devices will work this way.

One downside is that the USB subsystem and device probing happen pretty
late in the boot process, so if you are trying to debug an oops very
early on, I would not recommend using this as a debugging aid.

Thanks to Randy Dunlap for the initial version of this patch, and for
the push to fix it up to work with all usb-serial devices.

Let me know if anyone has any problems with this patch.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/Config.help b/drivers/usb/serial/Config.help
--- a/drivers/usb/serial/Config.help	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/Config.help	Wed Mar 27 15:24:32 2002
@@ -12,6 +12,26 @@
   The module will be called usbserial.o. If you want to compile it
   as a module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_USB_SERIAL_CONSOLE
+  If you say Y here, it will be possible to use a USB to serial
+  converter port as the system console (the system console is the
+  device which receives all kernel messages and warnings and which
+  allows logins in single user mode). This could be useful if some
+  terminal or printer is connected to that serial port.
+
+  Even if you say Y here, the currently visible virtual console
+  (/dev/tty0) will still be used as the system console by default, but
+  you can alter that using a kernel command line option such as
+  "console=ttyUSB0". (Try "man bootparam" or see the documentation of
+  your boot loader (lilo or loadlin) about how to pass options to the
+  kernel at boot time.)
+
+  If you don't have a VGA card installed and you say Y here, the
+  kernel will automatically use the first USB to serial converter
+  port, /dev/ttyUSB0, as system console.
+
+  If unsure, say N.
+
 CONFIG_USB_SERIAL_GENERIC
   Say Y here if you want to use the generic USB serial driver.  Please
   read <file:Documentation/usb/usb-serial.txt> for more information on
diff -Nru a/drivers/usb/serial/Config.in b/drivers/usb/serial/Config.in
--- a/drivers/usb/serial/Config.in	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/Config.in	Wed Mar 27 15:24:32 2002
@@ -8,6 +8,7 @@
 if [ "$CONFIG_USB_SERIAL" = "y" ]; then
   dep_mbool '  USB Serial Converter verbose debug' CONFIG_USB_SERIAL_DEBUG $CONFIG_USB_SERIAL
 fi
+dep_mbool '  USB Serial Console device support (EXPERIMENTAL)' CONFIG_USB_SERIAL_CONSOLE $CONFIG_USB_SERIAL
 dep_mbool '  USB Generic Serial Driver' CONFIG_USB_SERIAL_GENERIC $CONFIG_USB_SERIAL
 dep_tristate '  USB Belkin and Peracom Single Port Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_BELKIN $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
 dep_tristate '  USB ConnectTech WhiteHEAT Serial Driver (EXPERIMENTAL)' CONFIG_USB_SERIAL_WHITEHEAT $CONFIG_USB_SERIAL $CONFIG_EXPERIMENTAL
diff -Nru a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
--- a/drivers/usb/serial/belkin_sa.c	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/belkin_sa.c	Wed Mar 27 15:24:32 2002
@@ -324,12 +324,31 @@
 {
 	struct usb_serial *serial = port->serial;
 	struct belkin_sa_private *priv = (struct belkin_sa_private *)port->private;
-	unsigned int iflag = port->tty->termios->c_iflag;
-	unsigned int cflag = port->tty->termios->c_cflag;
-	unsigned int old_iflag = old_termios->c_iflag;
-	unsigned int old_cflag = old_termios->c_cflag;
+	unsigned int iflag;
+	unsigned int cflag;
+	unsigned int old_iflag = 0;
+	unsigned int old_cflag = 0;
 	__u16 urb_value = 0; /* Will hold the new flags */
 	
+	if ((!port->tty) || (!port->tty->termios)) {
+		dbg ("%s - no tty or termios structure", __FUNCTION__);
+		return;
+	}
+
+	iflag = port->tty->termios->c_iflag;
+	cflag = port->tty->termios->c_cflag;
+
+	/* check that they really want us to change something */
+	if (old_termios) {
+		if ((cflag == old_termios->c_cflag) &&
+		    (RELEVANT_IFLAG(port->tty->termios->c_iflag) == RELEVANT_IFLAG(old_termios->c_iflag))) {
+			dbg("%s - nothing to change...", __FUNCTION__);
+			return;
+		}
+		old_iflag = old_termios->c_iflag;
+		old_cflag = old_termios->c_cflag;
+	}
+
 	/* Set the baud rate */
 	if( (cflag&CBAUD) != (old_cflag&CBAUD) ) {
 		/* reassert DTR and (maybe) RTS on transition from B0 */
diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/pl2303.c	Wed Mar 27 15:24:32 2002
@@ -1,7 +1,7 @@
 /*
  * Prolific PL2303 USB to serial adaptor driver
  *
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001-2002 Greg Kroah-Hartman (greg@kroah.com)
  *
  * Original driver for 2.2.x by anonymous
  *
@@ -12,6 +12,10 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this driver
  *
+ * 2002_Mar_26 gkh
+ *	allowed driver to work properly if there is no tty assigned to a port
+ *	(this happens for serial console devices.)
+ *
  * 2001_Oct_06 gkh
  *	Added RTS and DTR line control.  Thanks to joe@bndlg.de for parts of it.
  *
@@ -173,11 +177,6 @@
 
 	dbg (__FUNCTION__ " - port %d, %d bytes", port->number, count);
 
-	if (!port->tty) {
-		err (__FUNCTION__ " - no tty???");
-		return 0;
-	}
-
 	if (port->write_urb->status == -EINPROGRESS) {
 		dbg (__FUNCTION__ " - already writing");
 		return 0;
@@ -390,10 +389,12 @@
 	SOUP (VENDOR_WRITE_REQUEST_TYPE, VENDOR_WRITE_REQUEST, 2, 4);
 
 	/* Setup termios */
-	*(port->tty->termios) = tty_std_termios;
-	port->tty->termios->c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	if (port->tty) {
+		*(port->tty->termios) = tty_std_termios;
+		port->tty->termios->c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 
-	pl2303_set_termios (port, &tmp_termios);
+		pl2303_set_termios (port, &tmp_termios);
+	}
 
 	//FIXME: need to assert RTS and DTR if CRTSCTS off
 
@@ -434,13 +435,15 @@
 	dbg (__FUNCTION__ " - port %d", port->number);
 
 	if (serial->dev) {
-		c_cflag = port->tty->termios->c_cflag;
-		if (c_cflag & HUPCL) {
-			/* drop DTR and RTS */
-			priv = port->private;
-			priv->line_control = 0;
-			set_control_lines (port->serial->dev,
-					   priv->line_control);
+		if (port->tty) {
+			c_cflag = port->tty->termios->c_cflag;
+			if (c_cflag & HUPCL) {
+				/* drop DTR and RTS */
+				priv = port->private;
+				priv->line_control = 0;
+				set_control_lines (port->serial->dev,
+						   priv->line_control);
+			}
 		}
 
 		/* shutdown our urbs */
@@ -643,7 +646,7 @@
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
 	tty = port->tty;
-	if (urb->actual_length) {
+	if (tty && urb->actual_length) {
 		for (i = 0; i < urb->actual_length; ++i) {
 			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
 				tty_flip_buffer_push(tty);
diff -Nru a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/usb-serial.h	Wed Mar 27 15:24:32 2002
@@ -1,7 +1,7 @@
 /*
  * USB Serial Converter driver
  *
- *	Copyright (C) 1999 - 2001
+ *	Copyright (C) 1999 - 2002
  *	    Greg Kroah-Hartman (greg@kroah.com)
  *
  *	This program is free software; you can redistribute it and/or modify
@@ -11,6 +11,10 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this driver
  *
+ * (03/26/2002) gkh
+ *	removed the port->tty check from port_paranoia_check() due to serial
+ *	consoles not having a tty device assigned to them.
+ *
  * (12/03/2001) gkh
  *	removed active from the port structure.
  *	added documentation to the usb_serial_device_type structure
@@ -224,10 +228,6 @@
 	}
 	if (!port->serial) {
 		dbg("%s - port->serial == NULL", function);
-		return -1;
-	}
-	if (!port->tty) {
-		dbg("%s - port->tty == NULL", function);
 		return -1;
 	}
 
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/usbserial.c	Wed Mar 27 15:24:32 2002
@@ -15,6 +15,12 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this driver
  *
+ * (03/27/2002) gkh
+ *	Got USB serial console code working properly and merged into the main
+ *	version of the tree.  Thanks to Randy Dunlap for the initial version
+ *	of this code, and for pushing me to finish it up.
+ *	The USB serial console works with any usb serial driver device.
+ *
  * (03/21/2002) gkh
  *	Moved all manipulation of port->open_count into the core.  Now the
  *	individual driver's open and close functions are called only when the
@@ -314,6 +320,14 @@
 #include <linux/smp_lock.h>
 #include <linux/usb.h>
 
+#ifdef MODULE
+#undef CONFIG_USB_SERIAL_CONSOLE
+#endif
+#ifdef CONFIG_USB_SERIAL_CONSOLE
+#include <linux/console.h>
+#include <linux/serial.h>
+#endif
+
 #ifdef CONFIG_USB_SERIAL_DEBUG
 	static int debug = 1;
 #else
@@ -402,6 +416,16 @@
 static struct usb_serial	*serial_table[SERIAL_TTY_MINORS];	/* initially all NULL */
 static LIST_HEAD(usb_serial_driver_list);
 
+#ifdef CONFIG_USB_SERIAL_CONSOLE
+struct usbcons_info {
+	int			magic;
+	int			break_flag;
+	struct usb_serial_port	*port;
+};
+
+static struct usbcons_info usbcons_info;
+static struct console usbcons;
+#endif /* CONFIG_USB_SERIAL_CONSOLE */
 
 static struct usb_serial *get_serial_by_minor (unsigned int minor)
 {
@@ -834,7 +858,8 @@
 	/* force low_latency on so that our tty_push actually forces the data through, 
 	   otherwise it is scheduled, and with high data rates (like with OHCI) data
 	   can get lost. */
-	port->tty->low_latency = 1;
+	if (port->tty)
+		port->tty->low_latency = 1;
 
 	/* if we have a bulk interrupt, start reading from it */
 	if (serial->num_bulk_in) {
@@ -986,7 +1011,7 @@
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
 	tty = port->tty;
-	if (urb->actual_length) {
+	if (tty && urb->actual_length) {
 		for (i = 0; i < urb->actual_length ; ++i) {
 			/* if we insert more than TTY_FLIPBUF_SIZE characters, we drop them. */
 			if(tty->flip.count >= TTY_FLIPBUF_SIZE) {
@@ -1311,6 +1336,26 @@
 		     type->name, serial->port[i].number, serial->port[i].number);
 	}
 
+#ifdef CONFIG_USB_SERIAL_CONSOLE
+	if (minor == 0) {
+		/* 
+		 * Call register_console() if this is the first device plugged
+		 * in.  If we call it earlier, then the callback to
+		 * console_setup() will fail, as there is not a device seen by
+		 * the USB subsystem yet.
+		 */
+		/*
+		 * Register console.
+		 * NOTES:
+		 * console_setup() is called (back) immediately (from register_console).
+		 * console_write() is called immediately from register_console iff
+		 * CON_PRINTBUFFER is set in flags.
+		 */
+		dbg ("registering the USB serial console.");
+		register_console(&usbcons);
+	}
+#endif
+
 	return serial; /* success */
 
 
@@ -1484,6 +1529,9 @@
 
 static void __exit usb_serial_exit(void)
 {
+#ifdef CONFIG_USB_SERIAL_CONSOLE
+	unregister_console(&usbcons);
+#endif
 
 #ifdef CONFIG_USB_SERIAL_GENERIC
 	/* remove our generic driver */
@@ -1533,7 +1581,7 @@
 
 
 
-/* If the usb-serial core is build into the core, the usb-serial drivers
+/* If the usb-serial core is built into the core, the usb-serial drivers
    need these symbols to load properly as modules. */
 EXPORT_SYMBOL(usb_serial_register);
 EXPORT_SYMBOL(usb_serial_deregister);
@@ -1541,6 +1589,241 @@
 	EXPORT_SYMBOL(ezusb_writememory);
 	EXPORT_SYMBOL(ezusb_set_reset);
 #endif
+
+
+#ifdef CONFIG_USB_SERIAL_CONSOLE
+/*
+ * ------------------------------------------------------------
+ * USB Serial console driver
+ *
+ * Much of the code here is copied from drivers/char/serial.c
+ * and implements a phony serial console in the same way that
+ * serial.c does so that in case some software queries it,
+ * it will get the same results.
+ *
+ * Things that are different from the way the serial port code
+ * does things, is that we call the lower level usb-serial
+ * driver code to initialize the device, and we set the initial
+ * console speeds based on the command line arguments.
+ * ------------------------------------------------------------
+ */
+
+#if 0
+static kdev_t usb_console_device(struct console *co)
+{
+	return MKDEV(SERIAL_TTY_MAJOR, co->index);	/* TBD */
+}
+#endif
+
+/*
+ * The parsing of the command line works exactly like the
+ * serial.c code, except that the specifier is "ttyUSB" instead
+ * of "ttyS".
+ */
+static int __init usb_console_setup(struct console *co, char *options)
+{
+	struct usbcons_info *info = &usbcons_info;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int doflow = 0;
+	int cflag = CREAD | HUPCL | CLOCAL;
+	char *s;
+	struct usb_serial *serial;
+	struct usb_serial_port *port;
+	int retval = 0;
+	struct tty_struct *tty;
+	struct termios *termios;
+
+	dbg ("%s", __FUNCTION__);
+
+	if (options) {
+		baud = simple_strtoul(options, NULL, 10);
+		s = options;
+		while (*s >= '0' && *s <= '9')
+			s++;
+		if (*s)	parity = *s++;
+		if (*s)	bits   = *s++ - '0';
+		if (*s)	doflow = (*s++ == 'r');
+	}
+
+	/* build a cflag setting */
+	switch (baud) {
+		case 1200:
+			cflag |= B1200;
+			break;
+		case 2400:
+			cflag |= B2400;
+			break;
+		case 4800:
+			cflag |= B4800;
+			break;
+		case 19200:
+			cflag |= B19200;
+			break;
+		case 38400:
+			cflag |= B38400;
+			break;
+		case 57600:
+			cflag |= B57600;
+			break;
+		case 115200:
+			cflag |= B115200;
+			break;
+		case 9600:
+		default:
+			cflag |= B9600;
+			/*
+			 * Set this to a sane value to prevent a divide error
+			 */
+			baud  = 9600;
+			break;
+	}
+	switch (bits) {
+		case 7:
+			cflag |= CS7;
+			break;
+		default:
+		case 8:
+			cflag |= CS8;
+			break;
+	}
+	switch (parity) {
+		case 'o': case 'O':
+			cflag |= PARODD;
+			break;
+		case 'e': case 'E':
+			cflag |= PARENB;
+			break;
+	}
+	co->cflag = cflag;
+
+	/* grab the first serial port that happens to be connected */
+	serial = get_serial_by_minor (0);
+	if (serial_paranoia_check (serial, __FUNCTION__)) {
+		/* no device is connected yet, sorry :( */
+		err ("No USB device connected to ttyUSB0");
+		return -ENODEV;
+	}
+
+	port = &serial->port[0];
+	down (&port->sem);
+	port->tty = NULL;
+
+	info->port = port;
+	 
+	++port->open_count;
+	if (port->open_count == 1) {
+		/* only call the device specific open if this 
+		 * is the first time the port is opened */
+		if (serial->type->open)
+			retval = serial->type->open(port, NULL);
+		else
+			retval = generic_open(port, NULL);
+		if (retval)
+			port->open_count = 0;
+	}
+
+	up (&port->sem);
+
+	if (retval) {
+		err ("could not open USB console port");
+		return retval;
+	}
+
+	if (serial->type->set_termios) {
+		/* build up a fake tty structure so that the open call has something
+		 * to look at to get the cflag value */
+		tty = kmalloc (sizeof (*tty), GFP_KERNEL);
+		if (!tty) {
+			err ("no more memory");
+			return -ENOMEM;
+		}
+		termios = kmalloc (sizeof (*termios), GFP_KERNEL);
+		if (!termios) {
+			err ("no more memory");
+			kfree (tty);
+			return -ENOMEM;
+		}
+		memset (tty, 0x00, sizeof(*tty));
+		memset (termios, 0x00, sizeof(*termios));
+		termios->c_cflag = cflag;
+		tty->termios = termios;
+		port->tty = tty;
+
+		/* set up the initial termios settings */
+		serial->type->set_termios(port, NULL);
+		port->tty = NULL;
+		kfree (termios);
+		kfree (tty);
+	}
+
+	return retval;
+}
+
+static void usb_console_write(struct console *co, const char *buf, unsigned count)
+{
+	static struct usbcons_info *info = &usbcons_info;
+	struct usb_serial_port *port = info->port;
+	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+	int retval = -ENODEV;
+
+	if (!serial || !port)
+		return;
+
+	if (count == 0)
+		return;
+
+	down (&port->sem);
+
+	dbg("%s - port %d, %d byte(s)", __FUNCTION__, port->number, count);
+
+	if (!port->open_count) {
+		dbg (__FUNCTION__ " - port not opened");
+		goto exit;
+	}
+
+	/* pass on to the driver specific version of this function if it is available */
+	if (serial->type->write)
+		retval = serial->type->write(port, 0, buf, count);
+	else
+		retval = generic_write(port, 0, buf, count);
+
+exit:
+	up (&port->sem);
+	dbg("%s - return value (if we had one): %d", __FUNCTION__, retval);
+}
+
+#if 0
+/*
+ * Receive character from the serial port
+ */
+static int usb_console_wait_key(struct console *co)
+{
+	static struct usbcons_info *info = &usbcons_info;
+	int c = 0;
+
+	dbg("%s", __FUNCTION__);
+
+	/* maybe use generic_read_bulk_callback ??? */
+
+	return c;
+}
+#endif
+
+static struct console usbcons = {
+	name:		"ttyUSB",			/* only [8] */
+	write:		usb_console_write,
+#if 0
+	device:		usb_console_device,		/* TBD */
+	wait_key:	usb_console_wait_key,		/* TBD */
+#endif
+	setup:		usb_console_setup,
+	flags:		CON_PRINTBUFFER,
+	index:		-1,
+};
+
+#endif /* CONFIG_USB_SERIAL_CONSOLE */
 
 
 /* Module information */
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Wed Mar 27 15:24:32 2002
+++ b/drivers/usb/serial/visor.c	Wed Mar 27 15:24:32 2002
@@ -12,6 +12,10 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this driver
  *
+ * (03/27/2002) gkh
+ *	Removed assumptions that port->tty was always valid (is not true
+ *	for usb serial console devices.)
+ *
  * (03/23/2002) gkh
  *	Added support for the Palm i705 device, thanks to Thomas Riemer
  *	<tom@netmech.com> for the information.
@@ -287,7 +291,8 @@
 	 * through, otherwise it is scheduled, and with high data rates (like
 	 * with OHCI) data can get lost.
 	 */
-	port->tty->low_latency = 1;
+	if (port->tty)
+		port->tty->low_latency = 1;
 	
 	/* Start reading from the device */
 	usb_fill_bulk_urb (port->read_urb, serial->dev,
@@ -477,7 +482,7 @@
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
 	tty = port->tty;
-	if (urb->actual_length) {
+	if (tty && urb->actual_length) {
 		for (i = 0; i < urb->actual_length ; ++i) {
 			/* if we insert more than TTY_FLIPBUF_SIZE characters, we drop them. */
 			if(tty->flip.count >= TTY_FLIPBUF_SIZE) {
@@ -487,8 +492,8 @@
 			tty_insert_flip_char(tty, data[i], 0);
 		}
 		tty_flip_buffer_push(tty);
-		bytes_in += urb->actual_length;
 	}
+	bytes_in += urb->actual_length;
 
 	/* Continue trying to always read  */
 	usb_fill_bulk_urb (port->read_urb, serial->dev,

