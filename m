Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130895AbQK3IfF>; Thu, 30 Nov 2000 03:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131448AbQK3Ie4>; Thu, 30 Nov 2000 03:34:56 -0500
Received: from 13dyn240.delft.casema.net ([212.64.76.240]:24077 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S130895AbQK3Iew>; Thu, 30 Nov 2000 03:34:52 -0500
Date: Thu, 30 Nov 2000 09:04:03 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] New user space serial port driver
Message-ID: <Pine.LNX.4.21.0011300903470.11226-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider including this user space serial driver. It was writen for
the Pele 833 RAS Server but is also usable for other serial device drivers
in user space.

	Patrick   


diff -u -r --new-file linux-2.4.0-test7.clean/Documentation/Configure.help linux-2.4.0-test7.rio/Documentation/Configure.help
--- linux-2.4.0-test7.clean/Documentation/Configure.help	Thu Aug 24 08:54:59 2000
+++ linux-2.4.0-test7.rio/Documentation/Configure.help	Mon Aug 28 11:01:57 2000
@@ -12075,6 +12075,19 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called sx.o. If you want to do that, say M here.
 
+User space serial port support (perle RAS server)
+CONFIG_USSP
+  This is a driver that allows a userspace deamon to handle the 
+  internals of a serial port. This is an especially good way to
+  handle things if for instance the serial port is "remote" on 
+  a network. Select this if for instance you want to use the 
+  Perle 833 RAS server. 
+
+  For now, this driver can only be built as a module ( = code which
+  can be inserted in and removed from the running kernel whenever you 
+  want).  The module will be called ussp.o. If you want to do that, 
+  say M here.
+
 Hayes ESP serial port support
 CONFIG_ESPSERIAL
   This is a driver which supports Hayes ESP serial ports. Both single
diff -u -r --new-file linux-2.4.0-test7.clean/Documentation/ussp.txt linux-2.4.0-test7.rio/Documentation/ussp.txt
--- linux-2.4.0-test7.clean/Documentation/ussp.txt	Thu Jan  1 01:00:00 1970
+++ linux-2.4.0-test7.rio/Documentation/ussp.txt	Mon Aug 28 11:01:57 2000
@@ -0,0 +1,80 @@
+
+
+ussp.txt: Userspace serial ports. 
+
+Introduction
+------------
+
+This driver allows serial port drivers to be written in userspace.
+This will probably incur a bit over overhead, but I don't expect it to
+be unusable. In fact, intelligent cards like "sx" already hold up
+characters upto 20 ms before reporting them to the OS. It must be very
+well possible to handle things faster than that.
+
+This driver was written to allow access to the perle 833 RAS
+server. It can easily be driven using a userspace deamon, while
+interfacing with the kernel internals on the network level would be
+harder.
+
+
+Technical details
+-----------------
+
+The deamon opens the ussp_master device. It then uses the
+USSP_SET_PORT ioctl to associate the filedescriptor with a port.  From
+that moment onward, the device is a "pipe" that transfers data between
+the serial port and the kernel driver.
+
+
+struct operation {
+	enum op;
+	unsigned long len;	
+	unsigned long arg;
+	unsigned char data[];
+	};
+
+
+Write: (kernel -> Userspace)
+	op  = USSP_WRITE;
+	len = length of data.
+	data[]  holds the data. 
+
+Read: (Userspace -> kernel)
+	op  = USSP_READ;
+	len = length of data.
+	data[]  holds the data. 
+
+set_termios: (kernel -> userspace)
+	op  = USSP_SET_TERMIOS;
+	len = size of termios structure. 
+               (userspace can return error on unsupported sizes).
+	data[] Termios structure. 
+
+modem_signal_change: (bidirectional)
+	/* Either side ignores the bits that are not setable */
+	op = USSP_MSC;
+	len = 0;
+	arg = the logical OR of:
+              DCD 0x01 
+              RI  0x02
+              RTS 0x04
+              CTS 0x08
+              DTR 0x10
+              DSR 0x20
+
+open: (kernel -> userspace)
+	op = USSP_OPEN;
+	len = 0;
+	arg = open flags;
+
+open_ok: (userspace -> kernel)
+	op = USSP_OPEN_RESULT;
+	len = 0l
+	arg = result code (0 = OK, other = Errno);
+
+close: (kernel -> userspace)
+	op = USSP_CLOSE;
+	len = 0;
+
+
+
diff -u -r --new-file linux-2.4.0-test7.clean/drivers/char/Config.in linux-2.4.0-test7.rio/drivers/char/Config.in
--- linux-2.4.0-test7.clean/drivers/char/Config.in	Thu Aug 24 08:55:05 2000
+++ linux-2.4.0-test7.rio/drivers/char/Config.in	Mon Aug 28 11:01:57 2000
@@ -50,6 +50,7 @@
       bool '  Specialix DTR/RTS pin is RTS' CONFIG_SPECIALIX_RTSCTS
    fi 
    tristate '  Specialix SX (and SI) card support' CONFIG_SX
+   tristate '  User Space Serial Ports (for Perle dialout)' CONFIG_USSP
    tristate '  Specialix RIO system support' CONFIG_RIO
    if [ "$CONFIG_RIO" != "n" ]; then
      bool '    Support really old RIO/PCI cards' CONFIG_RIO_OLDPCI
diff -u -r --new-file linux-2.4.0-test7.clean/drivers/char/Makefile linux-2.4.0-test7.rio/drivers/char/Makefile
--- linux-2.4.0-test7.clean/drivers/char/Makefile	Thu Aug 24 08:55:05 2000
+++ linux-2.4.0-test7.rio/drivers/char/Makefile	Mon Aug 28 11:01:57 2000
@@ -118,6 +118,7 @@
 obj-$(CONFIG_CYCLADES) += cyclades.o
 obj-$(CONFIG_STALLION) += stallion.o
 obj-$(CONFIG_ISTALLION) += istallion.o
+obj-$(CONFIG_USSP) += ussp.o
 obj-$(CONFIG_COMPUTONE) += ip2.o ip2main.o
 obj-$(CONFIG_RISCOM8) += riscom8.o
 obj-$(CONFIG_ISI) += isicom.o
diff -u -r --new-file linux-2.4.0-test7.clean/drivers/char/ussp.c linux-2.4.0-test7.rio/drivers/char/ussp.c
--- linux-2.4.0-test7.clean/drivers/char/ussp.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.0-test7.rio/drivers/char/ussp.c	Mon Aug 28 14:31:25 2000
@@ -0,0 +1,1000 @@
+/* -linux-c; c-basic-offset 8; */
+/* ussp.c -- driver to allow a userspace daemon to handle a serial port.
+
+ *
+ *  This driver was written to allow Linux to communicate with the 
+ *  Perle 833 RAS server. 
+ *
+ *
+ *   (C) 2000  R.E.Wolff@BitWizard.nl, patrick@BitWizard.nl
+ *
+ * Perle/Specialix paid for the development of this driver. If you are
+ * using this driver in conjunction with a perle product, please DO
+ * contact support@perle.com if you require support. But please read
+ * the documentation (ussp.txt) first.
+ *
+ *
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License as
+ *      published by the Free Software Foundation; either version 2 of
+ *      the License, or (at your option) any later version.
+ *
+ *      This program is distributed in the hope that it will be
+ *      useful, but WITHOUT ANY WARRANTY; without even the implied
+ *      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ *      PURPOSE.  See the GNU General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public
+ *      License along with this program; if not, write to the Free
+ *      Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
+ *      USA.
+ *
+ * Revision history:
+ *
+ * */
+
+
+#define RCS_ID "$Id: $"
+#define RCS_REV "$Revision: $"
+
+
+#include <linux/module.h>
+#include <linux/config.h> 
+#include <linux/kdev_t.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/mm.h>
+#include <linux/serial.h>
+#include <linux/fcntl.h>
+#include <linux/major.h>
+#include <linux/delay.h>
+#include <linux/tqueue.h>
+#include <linux/version.h>
+#include <linux/pci.h>
+#include <linux/malloc.h>
+#include <linux/miscdevice.h>
+#include <linux/tty_ldisc.h>
+
+#include <linux/compatmac.h>
+#include <linux/poll.h>
+#include <asm/smplock.h>
+
+#include <linux/ussp.h>
+
+
+/* During development this is -1, to reduce nkeystrokes. Later this
+   should be 0. Beta testers: Remind me to set this to 0 before
+   release -- REW */
+int ussp_debug = -1;
+
+/* This parameter makes this driver set "lowlatency". For nomal serial ports
+   the handling of serial characters is aggregated for a lower CPU overhead.
+   In this driver however, that won't buy you anything, as the deamon will
+   already packetize and aggregate the data. Clear this if you feel that 
+   this is not true. -- REW
+ */
+int ussp_set_lowlatency = 1;
+
+
+/* I don't think that this driver can handle more than 256 ports on
+   one machine. -- REW */
+
+
+/* Configurable options: 
+   (Don't be too sure that it'll work if you toggle them) */
+
+
+#ifdef MODULE
+MODULE_PARM(ussp_debug, "i");
+MODULE_PARM(ussp_set_lowlatency, "i");
+#endif
+
+static int ussp_ctl_ioctl (struct inode *inode, struct file *filp,
+			   unsigned int cmd, unsigned long arg);
+static int ussp_ctl_open(struct inode *inode, struct file *filp);
+static ssize_t ussp_ctl_read(struct file * filp, char * buf,
+			     size_t count, loff_t *ppos);
+static ssize_t ussp_ctl_write(struct file * filp, const char * buf,
+			      size_t count, loff_t *ppos);
+static int ussp_ctl_close(struct inode *, struct file *);
+static unsigned int ussp_ctl_poll (struct file *, poll_table *);
+
+static struct file_operations ussp_ctl_fops = {
+        owner:          THIS_MODULE,
+	read: ussp_ctl_read,
+	write: ussp_ctl_write,
+	poll: ussp_ctl_poll,
+	ioctl: ussp_ctl_ioctl,
+	open: ussp_ctl_open,
+	release: ussp_ctl_close
+};
+
+
+struct miscdevice ussp_ctl_device = {
+	USSPCTL_MISC_MINOR, "ussp_ctl", &ussp_ctl_fops
+};
+
+
+#define DEBUG_FLOW         0x0001
+#define DEBUG_WRITE_TO_CTL 0x0002
+#define DEBUG_CLOSE        0x0004
+#define DEBUG_IOCTL        0x0008
+#define DEBUG_CIB          0x0010
+#define DEBUG_OPEN         0x0020
+#define DEBUG_BUFFERS      0x0040
+#define DEBUG_READ_CTL     0x0080
+#define DEBUG_INFO         0x0100
+
+#define DEBUG
+
+#ifdef DEBUG
+#define ussp_dprintk(f, str...) if (ussp_debug & f) printk (str)
+#else
+#define ussp_dprintk(f, str...) klasjdhflksjdhflkdjshfslakh/* nothing */
+#endif
+
+
+#define func_enter() ussp_dprintk (DEBUG_FLOW, "ussp: enter " __FUNCTION__ "\n")
+#define func_exit()  ussp_dprintk (DEBUG_FLOW, "ussp: exit  " __FUNCTION__ "\n")
+
+
+
+/*
+ * TTY callbacks
+ */
+
+static ssize_t ussp_tty_write       (struct tty_struct * tty, int from_user, 
+                                     const unsigned char *buf, int count);
+static int ussp_tty_ioctl           (struct tty_struct *, struct file *, unsigned int,
+			             unsigned long);
+static int ussp_tty_open            (struct tty_struct *, struct file * filp);
+static void ussp_tty_close          (struct tty_struct *, struct file *);
+static int ussp_tty_write_room      (struct tty_struct * );
+static int ussp_tty_chars_in_buffer (struct tty_struct * );
+static void ussp_tty_put_char       (struct tty_struct *, unsigned char); 
+
+void ussp_tty_flush_buffer          (struct tty_struct *tty);
+void ussp_tty_flush_chars           (struct tty_struct *tty);
+void ussp_tty_stop                  (struct tty_struct *tty);
+void ussp_tty_start                 (struct tty_struct *tty);
+void ussp_tty_set_termios           (struct tty_struct * tty, 
+                                     struct termios * old_termios);
+void ussp_tty_hangup                (struct tty_struct *tty);
+
+struct ussp_port ussp_ports[USSP_MAX_PORTS];
+int ussp_nports = USSP_MAX_PORTS;
+int ussp_refcount;
+
+static struct tty_driver   ussp_driver;
+static struct tty_struct * ussp_table[USSP_MAX_PORTS] = { NULL, };
+static struct termios    * ussp_termios[USSP_MAX_PORTS];
+static struct termios    * ussp_termios_locked[USSP_MAX_PORTS];
+
+#define D_DATA_AVAILABLE(port) ((port->daemon_head - port->daemon_tail) & (PAGE_SIZE-1))
+#define TTY_DATA_AVAILABLE(port) ((port->tty_head - port->tty_tail) & (PAGE_SIZE-1))
+
+#define SPACE_IN_BUFFER(head, tail, bufsz) \
+                    ((((tail) - (head)) <= 0)?(tail) - (head) - 1 + (bufsz):((tail)-(head) - 1))
+
+
+void ussp_tty_hangup (struct tty_struct *tty)
+{ 
+	func_enter();
+	
+	/* nothing special for us to do? Oh well. -- REW */
+
+	func_exit();
+}
+
+
+void ussp_tty_flush_buffer (struct tty_struct *tty)
+{
+	struct ussp_port *port = tty->driver_data;
+
+	func_enter ();
+	/* Clear the (output) buffer. But the buffer may contain interesting
+	   data (e.g. a baud rate change.). For now just let things be... 
+	   -- REW
+	*/
+
+	if (port && port->tty) {
+		if (port->tty->stopped || port->tty->hw_stopped ||
+		    !port->tty_buffer) {
+	  		func_exit ();
+			return;
+		}
+		wake_up_interruptible (&port->tty_wait);
+	}
+	func_exit();
+}
+
+
+void ussp_tty_flush_chars (struct tty_struct *tty)
+{
+	func_enter();
+	func_exit();
+}
+
+
+void ussp_tty_stop (struct tty_struct *tty)
+{
+	func_enter();
+	func_exit();
+}
+
+
+void ussp_tty_start (struct tty_struct *tty)
+{
+	func_enter();
+	func_exit();
+}
+
+
+static void ussp_dummy(struct tty_struct *tty)
+{
+	func_enter();
+	func_exit();
+
+	return;
+}
+
+#ifdef MODULE
+#define ussp_init init_module
+#endif
+
+static int ussp_init (void)
+{
+	int status;
+
+	func_enter();
+
+	ussp_dprintk (DEBUG_INFO, "USSP: " __DATE__ "/" __TIME__ " version 0.01\n");
+
+	memset(&ussp_driver, 0, sizeof(ussp_driver));
+	ussp_driver.magic                = TTY_DRIVER_MAGIC;
+	ussp_driver.driver_name          = "perle";
+	ussp_driver.name                 = "ttyUSSP";
+	ussp_driver.major                = USSP_NORMAL_MAJOR;
+	ussp_driver.num                  = 4;
+	ussp_driver.type                 = TTY_DRIVER_TYPE_SERIAL;
+	ussp_driver.subtype              = SERIAL_TYPE_NORMAL;
+	ussp_driver.init_termios         = tty_std_termios;
+	ussp_driver.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	ussp_driver.flags                = TTY_DRIVER_REAL_RAW;
+	ussp_driver.refcount             = &ussp_refcount;
+	ussp_driver.table                = ussp_table;
+	ussp_driver.termios              = ussp_termios;
+	ussp_driver.termios_locked       = ussp_termios_locked;
+
+	ussp_driver.open	         = ussp_tty_open;
+	ussp_driver.close                = ussp_tty_close;
+	ussp_driver.write                = ussp_tty_write;
+	ussp_driver.put_char             = ussp_tty_put_char;
+	ussp_driver.flush_chars          = ussp_tty_flush_chars;
+	ussp_driver.write_room           = ussp_tty_write_room;
+	ussp_driver.chars_in_buffer      = ussp_tty_chars_in_buffer;
+	ussp_driver.flush_buffer         = ussp_tty_flush_buffer;
+	ussp_driver.ioctl                = ussp_tty_ioctl;
+	ussp_driver.throttle             = ussp_dummy;
+	ussp_driver.unthrottle           = ussp_dummy;
+	ussp_driver.set_termios          = ussp_tty_set_termios;
+	ussp_driver.stop                 = ussp_tty_stop;
+	ussp_driver.start                = ussp_tty_start;
+	ussp_driver.hangup               = ussp_tty_hangup;
+
+	status = tty_register_driver (&ussp_driver);
+	printk (KERN_INFO "Return value registering: %d\n", status);
+	if(status == 0)
+		printk(KERN_INFO "USSP driver registered.\n");
+	else
+		printk(KERN_ERR "error registering driver: %d\n",
+		       status);
+
+	if (misc_register(&ussp_ctl_device) < 0) {
+		printk(KERN_ERR "USSP: Unable to register control device.\n");
+		return -EIO;
+	}
+
+	func_exit();
+	return status;
+}
+
+
+#if 0
+void ussp_tty_receive_chars (struct ussp_port *port)
+{
+	int count;
+
+	func_enter ();
+
+	count = TTY_COUNTER(port);
+
+	memcpy(port->tty->flip.char_buf_ptr, port->tty_buffer+port->tty_head, count);
+	memset(port->tty->flip.flag_buf_ptr, TTY_NORMAL, count);
+	port->tty->flip.count += count;
+	port->tty->flip.char_buf_ptr += count;
+	port->tty->flip.flag_buf_ptr += count;
+	port->tty_tail = port->tty_head;
+	tty_flip_buffer_push (port->tty);
+
+	func_exit ();
+}
+#endif
+
+
+int copy_to_circular_buffer (char *buffer, int bufsz, int *head, int *tail, 
+			     const void *data, int count, int from_user)
+{	
+	int c, r, s;
+
+	func_enter ();
+
+	s = SPACE_IN_BUFFER(*head, *tail, bufsz); 
+
+	if (count > s){
+		ussp_dprintk (DEBUG_BUFFERS, 
+			      "ctcb: No space in buffer: count: %d s: %d\n", 
+			      count, s);
+		return 0;
+	}
+	
+	r = 0;
+	while (count > 0) {
+		c = count;
+		if (c > (bufsz - *head)) c = bufsz - *head;
+
+		if (from_user) 
+			copy_from_user (buffer + *head, data, c);
+		else 
+			memcpy (buffer + *head, data, c);
+		
+		data += c;
+		*head += c;
+		if (*head >= bufsz) *head = 0;
+		count -= c;
+		r += c;
+	}
+	func_exit ();
+	return r;
+}
+
+
+int copy_from_circular_buffer (char *buffer, int bufsz, int *head, int *tail, 
+			       void *data, int count, int to_user)
+{	
+	int c, s;
+
+	func_enter ();
+
+	s = *head - *tail; 
+	if (s < 0) s += bufsz;
+
+	if (count > s) {
+		ussp_dprintk (DEBUG_BUFFERS, 
+			      "cfcb: Not enough data in buffer for requested amount. %d s: %d\n", 
+			      count, s);
+		return -1;
+	}
+	while (count > 0) {
+		c = count;
+		if (c > (bufsz - *tail)) c = bufsz - *tail;
+
+		if (to_user) 
+			copy_to_user (data, buffer + *tail, c);
+		else 
+			memcpy (data, buffer + *tail, c);
+		
+		data += c;
+		*tail += c;
+		if (*tail >= bufsz) *tail = 0;
+		count -= c;
+	}
+
+	func_exit ();
+	return 0;
+}
+
+
+static ssize_t ussp_write_to_ctl(struct tty_struct * tty, int from_user, 
+                                 const unsigned char *buf, int count, int operation)
+{
+	struct ussp_operation info;
+	struct ussp_port *port;
+	int sib, r;
+
+	func_enter();
+	if (count <= 0){
+		printk ("Count is smaller than 0!\n");
+		func_exit ();
+		return 0;
+	}
+
+	port = tty->driver_data;
+
+	if (!(port->flags & USSP_DEAMON_PRESENT)) {
+		printk("no deamon. Flags: %x\n", port->flags);
+		func_exit ();
+		return -ENODEV;
+	}
+
+	ussp_dprintk(DEBUG_WRITE_TO_CTL, "Port: %p, buf %p, count %d. ", port, buf, count);
+
+	if (!port->daemon_buffer) {
+		printk(KERN_ERR "ERROR!! port->daemon_buf is NULL!!!\n");
+		return -1;
+	}
+
+	sib = SPACE_IN_BUFFER (port->daemon_head, port->daemon_tail, PAGE_SIZE);
+	if (count > sib - sizeof (info))
+		count = sib - sizeof (info);
+
+	ussp_dprintk (DEBUG_WRITE_TO_CTL, "sib: %d count: %d\n", sib, count);
+
+	if (count <= 0) return 0;
+
+	info.op = operation;
+	info.len = count;
+	info.arg = 0;
+
+	r  = copy_to_circular_buffer (port->daemon_buffer, PAGE_SIZE, 
+				      &port->daemon_head, &port->daemon_tail,
+				      &info, sizeof (info), 0);
+	r += copy_to_circular_buffer (port->daemon_buffer, PAGE_SIZE, 
+				      &port->daemon_head, &port->daemon_tail,
+				      buf, count, from_user);
+	if (r != (count + sizeof(info))) {
+		ussp_dprintk (DEBUG_WRITE_TO_CTL, 
+			      "Not enough space in buffer: r: %d, count: %d\n",
+			      r, count);
+		return 0;
+	}
+
+	ussp_dprintk (DEBUG_WRITE_TO_CTL, "Waking up queue: %p\n", 
+		      &port->daemon_wait);
+	wake_up(&port->daemon_wait);
+
+	func_exit();
+	return count;
+}
+
+
+void ussp_tty_set_termios (struct tty_struct * tty, 
+                           struct termios * old_termios)
+{
+	func_enter ();
+
+	ussp_dprintk (USSP_SET_TERMIOS, "c_cflag: %x\n", tty->termios->c_cflag);
+
+	if (ussp_write_to_ctl (tty, 0, (char*)tty->termios, sizeof (struct termios), USSP_SET_TERMIOS) <= 0) 
+		ussp_dprintk (DEBUG_WRITE_TO_CTL, "XXX Fix set termios: wait for space in buffer...\n");
+
+	func_exit ();
+}
+
+
+static ssize_t ussp_tty_write(struct tty_struct * tty, int from_user, 
+                              const unsigned char *buf, int count)
+{
+	int ret;
+
+	func_enter ();
+
+	ret = ussp_write_to_ctl (tty, from_user, buf, count, USSP_WRITE);
+
+	func_exit ();
+	return ret;
+}
+
+
+static void ussp_tty_put_char (struct tty_struct * tty, unsigned char ch)
+{
+	char tempchar = ch;
+
+	func_enter ();
+
+	ussp_tty_write (tty, 0, &tempchar, 1);
+
+	func_exit ();
+	return;
+}
+
+
+static int ussp_tty_open (struct tty_struct *tty, struct file * filp)
+{
+  	struct ussp_port *port; 
+	struct ussp_operation op;
+	int line;
+
+	func_enter();
+
+	MOD_INC_USE_COUNT;
+
+	line = MINOR (tty->device);
+	ussp_dprintk (1, "%d: opening line %d, tty=%p ctty=%p)\n", 
+		      current->pid, line, tty, current->tty);
+
+	port = & ussp_ports[line];
+
+	if (!(port->flags & USSP_DEAMON_PRESENT)) {
+		ussp_dprintk(DEBUG_OPEN, "no deamon. Flags: %x\n", 
+			     port->flags);
+		func_exit ();
+		return -ENODEV;
+	}
+	
+	port->tty = tty;
+	tty->driver_data = port;
+
+	/* The userspace deamon will already packetize the dataflow,
+	   so we don't need to introduce extra delay here in the driver. */
+	if (ussp_set_lowlatency) 
+		tty->low_latency = 1;
+
+	ussp_dprintk (DEBUG_OPEN, "Nusers = %d.\n", port->nusers);
+	port->nusers++;
+	if (port->nusers > 1) 
+		return 0;
+
+	port->callout_termios = tty_std_termios;
+	port->normal_termios = tty_std_termios;
+	
+ 	op.op = USSP_OPEN;
+	op.len = 0;
+	op.arg = filp->f_flags;
+	
+	copy_to_circular_buffer(port->daemon_buffer, PAGE_SIZE, 
+				&port->daemon_head, &port->daemon_tail,
+				&op, sizeof (op), 0);
+
+	ussp_dprintk(DEBUG_OPEN, "Waking up daemon_wait\n");
+	wake_up(&port->daemon_wait);
+	while ((!TTY_DATA_AVAILABLE(port)) && 
+	       (port->flags & USSP_DEAMON_PRESENT)) {
+		interruptible_sleep_on (&port->tty_wait);
+		ussp_dprintk (DEBUG_OPEN, "Back from sleep\n");
+		if (signal_pending (current)) {
+			func_exit ();
+			/* XXX Dec Use count????? */
+			return -EINTR;
+		}
+	}
+
+	if (!(port->flags & USSP_DEAMON_PRESENT)) {
+		ussp_dprintk(DEBUG_OPEN, "Daemon disappeared.\n"); 
+		return -EINTR;
+	}
+
+	copy_from_circular_buffer (port->tty_buffer, PAGE_SIZE,
+				   &port->tty_head, &port->tty_tail,
+				   &op, sizeof (op), 0);
+
+	if ((op.op == USSP_OPEN_RESULT) && (op.arg < 0)) {
+		ussp_dprintk(DEBUG_OPEN, "Daemon returned error.\n"); 
+		return -EINTR;
+	}
+
+	ussp_dprintk (DEBUG_OPEN, "current->leader: %d current->tty: %d tty->session: %d\n", (int)current->leader, (int)current->tty, (int)tty->session);
+	if (current->leader && !current->tty && tty->session == 0){
+		ussp_dprintk (DEBUG_OPEN, "setting!\n");
+		current->tty = tty;
+		current->tty_old_pgrp = 0;
+		tty->session = current->session;
+		tty->pgrp = current->pgrp;
+	}
+
+	func_exit();
+	return op.arg;
+}
+
+
+static void ussp_tty_close (struct tty_struct *tty, struct file * filep)
+{
+	struct ussp_port *port = tty->driver_data; 
+	struct ussp_operation op;
+
+	func_enter();
+	
+	ussp_dprintk(DEBUG_CLOSE, "Port: %p\n", port);
+	if (port) {
+		port->nusers--;
+		if (port->nusers < 0) {
+			printk (KERN_WARNING "Aaargh, nusers count has been corrupted: %d.\n", port->nusers);
+			port->nusers = 0;
+		}
+		
+		if (port->nusers == 0){
+			op.op = USSP_CLOSE;
+			op.len = 0;
+			op.arg = 0;
+	                ussp_dprintk (DEBUG_CLOSE, "Sending close packet to daemon\n");	
+			if (port->flags & USSP_DEAMON_PRESENT)
+				copy_to_circular_buffer(port->daemon_buffer, PAGE_SIZE, 
+							&port->daemon_head, &port->daemon_tail,
+							&op, sizeof (op), 0);
+			wake_up_interruptible (&port->daemon_wait);
+			port->tty = NULL;
+
+		}
+	}
+	MOD_DEC_USE_COUNT;
+	func_exit();
+}
+
+
+static int ussp_tty_ioctl (struct tty_struct * tty, struct file * filp, 
+                           unsigned int cmd, unsigned long arg)
+{
+	struct ussp_port *port;
+	int rc;
+	int ival;
+
+	func_enter();
+
+	port = tty->driver_data;
+	if (!(port->flags & USSP_DEAMON_PRESENT)) {
+		ussp_dprintk(DEBUG_IOCTL, "no daemon. Flags: %x\n", 
+			     port->flags);
+		func_exit ();
+		return -ENODEV;
+	}
+
+	ussp_dprintk (DEBUG_IOCTL, "IOCTL %x: %lx\n", cmd, arg);
+
+	rc = 0;
+	switch (cmd ){
+	case TIOCGSOFTCAR:
+		rc = Put_user(((tty->termios->c_cflag & CLOCAL) ? 1 : 0),
+		              (unsigned int *) arg);
+		break;	
+	case TCGETA:
+	case TCGETS:
+		ussp_dprintk (DEBUG_IOCTL, "TCGETS\n");
+		rc = n_tty_ioctl (tty, (struct file *) filp, cmd, (unsigned long) arg);
+		ussp_dprintk (DEBUG_IOCTL, "Returning: %d\n", rc);
+		
+		break;
+	case TIOCSSOFTCAR:
+		if ((rc = verify_area(VERIFY_READ, (void *) arg,
+		                      sizeof(int))) == 0) {
+			Get_user(ival, (unsigned int *) arg);
+			tty->termios->c_cflag =
+				(tty->termios->c_cflag & ~CLOCAL) |
+				(ival ? CLOCAL : 0);
+		}
+		break;
+	case TIOCMGET:
+		ussp_dprintk (DEBUG_IOCTL, "TIOCMGET\n");
+		if (copy_to_user ((unsigned int *)arg, &port->line_status, sizeof(int)))
+			rc = -EFAULT;
+		break;
+
+	case FIONREAD:
+		ussp_dprintk (DEBUG_IOCTL, "FIONREAD\n");
+		ival = PAGE_SIZE - ((port->daemon_head - port->daemon_tail) & (PAGE_SIZE-1)) - 1;
+		if (copy_to_user (tty->driver_data, &ival, sizeof(int)))
+			rc = -EFAULT;
+		break;
+	default: 
+		printk (KERN_DEBUG "illegal ioctl: %x\n", cmd);
+		rc = -ENOIOCTLCMD;
+	}
+	
+	func_exit();
+	return rc;
+}
+
+
+static int ussp_tty_write_room(struct tty_struct * tty)
+{
+	struct ussp_port *port = tty->driver_data;
+	int ret, ret2;
+
+	func_enter ();
+
+	ret = PAGE_SIZE - ((port->daemon_head - port->daemon_tail) & (PAGE_SIZE-1)) - 1;
+	ret2 = (port->daemon_tail - port->daemon_head) & (PAGE_SIZE-1);
+
+	ussp_dprintk (DEBUG_CIB, "Free size: %d ret2: %d\n", ret, ret2);
+
+	if(ret != ret2) {
+		printk(KERN_ERR "Size not equal\n");
+	}
+	if (ret < 0){
+		ret = 0;
+		printk(KERN_ERR "Something is very wrong here\n");
+	}
+
+	func_exit ();
+	return ret;
+}
+
+
+static int ussp_ctl_open(struct inode *inode, struct file *filp)
+{
+	func_enter();
+
+	MOD_INC_USE_COUNT;
+	filp->private_data = NULL;
+	func_exit();
+
+	return 0;
+}
+
+static int ussp_ctl_ioctl (struct inode *inode, struct file *filp,
+                           unsigned int cmd, unsigned long arg)
+{
+	struct ussp_port *port;
+	unsigned long flags;
+
+	func_enter();
+
+	port = filp->private_data;
+
+	ussp_dprintk (DEBUG_IOCTL, "CTL_IOCTL %x: %lx %lx\n", cmd, arg, USSP_SET_PORT);
+
+	switch (cmd ) {
+
+	case USSP_SET_PORT:
+		ussp_dprintk (DEBUG_IOCTL, "USSP_SET_PORT\n");
+		if (port) {
+			port->flags &= ~USSP_DEAMON_PRESENT;
+			if (port->daemon_buffer)
+				free_page ((long) port->daemon_buffer);
+			if (port->tty_buffer)
+				free_page ((long) port->tty_buffer);
+			port->daemon_buffer = 
+				port->tty_buffer = NULL;
+			filp->private_data = NULL;
+		}
+		if ((arg < 0) || ((int)arg > ussp_nports)) {
+			ussp_dprintk (DEBUG_IOCTL, "invalid arg: %d\n", (int)arg);
+			func_exit ();
+			return -EINVAL;
+		}
+		ussp_dprintk (DEBUG_IOCTL, "arg: %d\n", (int)arg);
+		port =  &ussp_ports[(int)arg];
+		save_flags (flags);
+		cli ();
+		if (port->flags & USSP_DEAMON_PRESENT) {
+			return -EBUSY;
+		}
+		port->flags |= USSP_DEAMON_PRESENT;
+		restore_flags (flags);
+		printk("Setting private date to %p\n", filp->private_data);
+		filp->private_data = port;
+		init_waitqueue_head (&port->daemon_wait);
+		init_waitqueue_head (&port->tty_wait);
+		port->nusers = 0;
+		port->daemon_head = port->daemon_tail = port->tty_head = port->tty_tail = 0;
+		port->tty_buffer = (char*)get_free_page(GFP_KERNEL);
+		port->daemon_buffer = (char*)get_free_page(GFP_KERNEL);
+		printk("Got pages: %p, %p\n",port->daemon_buffer,  port->tty_buffer);
+		port->line_status = 0;
+		break;
+	default: 
+		printk ("illegal ioctl: %x\n", cmd);
+	}
+
+	func_exit();
+	return 0;
+}
+
+
+static ssize_t ussp_ctl_read(struct file * filp, char * buf,
+   			     size_t count, loff_t *ppos)
+{
+	struct ussp_port *port;
+
+	func_enter();
+
+	if (!filp){
+		func_exit ();
+		return -EINVAL;
+	}
+
+	port = filp->private_data;
+	if (!port) {
+		func_exit ();
+		return -EINVAL;
+	}
+	ussp_dprintk (DEBUG_READ_CTL, "Checking data available: %ld\n", D_DATA_AVAILABLE(port));
+	while (!D_DATA_AVAILABLE(port)) {
+		interruptible_sleep_on (&port->daemon_wait);
+		if (signal_pending (current)) {
+			func_exit ();
+			return -EINTR;
+		}
+	}
+
+	if (count > D_DATA_AVAILABLE (port))
+		count = D_DATA_AVAILABLE (port);
+	if (copy_from_circular_buffer (port->daemon_buffer, PAGE_SIZE,
+				       &port->daemon_head, &port->daemon_tail,
+				       buf, count, 1)){
+		printk("Error copying to the daemon\n");
+		func_exit ();
+		return -EFAULT;
+	}
+	
+	if (port->tty) {
+		if ((port->tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    (port->tty->ldisc.write_wakeup) && 
+		    (D_DATA_AVAILABLE(port) < (PAGE_SIZE/4)))
+			port->tty->ldisc.write_wakeup(port->tty);
+		ussp_dprintk (DEBUG_READ_CTL, "Waking up write_wait\n");
+		wake_up_interruptible(&port->tty->write_wait);
+	}
+	
+	func_exit ();
+	
+	return count;
+}
+
+
+static ssize_t ussp_ctl_write(struct file * filp, const char * buf,
+	  		      size_t count, loff_t *ppos)
+{
+	struct ussp_operation op;
+	struct ussp_port *port;
+	func_enter();
+  
+	port = filp->private_data;
+
+	if (count <= 0){
+		ussp_dprintk (DEBUG_WRITE_TO_CTL, "Count is smaller then 0!\n");
+		func_exit ();
+		return 0;
+	}
+
+	if (!filp->private_data){
+		func_exit ();
+		return -EINVAL;
+	}
+
+	if (!port->tty_buffer)
+		ussp_dprintk (DEBUG_WRITE_TO_CTL, "ERROR!! port->tty_buffer is NULL!!!\n");
+	
+	if (!port->tty){
+		ussp_dprintk (DEBUG_WRITE_TO_CTL, "ERROR!! port->tty is NULL !!!!!!\n");
+		func_exit ();
+		return -EINVAL;
+	}
+	copy_from_user (&op, buf, sizeof (op));
+	switch(op.op) {
+	case USSP_OPEN_RESULT:
+		printk ("USSP_OPEN_RESULT %d\n", (int)op.arg);
+		copy_to_circular_buffer (port->tty_buffer, PAGE_SIZE,
+					 &port->tty_head, &port->tty_tail,
+					 buf, sizeof (op), 1);
+		wake_up_interruptible (&port->tty_wait);
+		break;
+	case USSP_READ:
+		printk ("USSP_READ %d\n", (int)op.len);
+		copy_from_user (port->tty->flip.char_buf_ptr, buf + sizeof(struct ussp_operation), op.len); 
+		memset(port->tty->flip.flag_buf_ptr, TTY_NORMAL, op.len);
+		port->tty->flip.count += op.len;
+		port->tty->flip.char_buf_ptr += op.len;
+		port->tty->flip.flag_buf_ptr += op.len;
+		tty_flip_buffer_push (port->tty);
+		break;
+	case USSP_MSC:
+		printk ("USSP_MSC packet: %x %x\n", (int)op.arg, (int)port->line_status);
+		if ((port->line_status & USSP_DCD) && (!(op.arg & USSP_DCD))) {
+			ussp_dprintk (DEBUG_IOCTL, "Obliged to perform hangup... \n");
+			/* tty_hangup (port->tty); */
+		}
+		port->line_status = op.arg;
+		break;
+	};
+	func_exit();
+	return 0;
+}
+
+
+static int ussp_ctl_close(struct inode *inodes, struct file * filp)
+{
+	struct ussp_port *port;
+
+	func_enter ();
+	
+	ussp_dprintk(DEBUG_CLOSE, "filp: %p\n", filp);
+	if (filp) {
+		port = filp->private_data;
+		if (port) {
+			if (port->tty) {
+				ussp_dprintk (DEBUG_CLOSE, "Hanging up: %p\n", port);
+				/* Make sure the tty sides of this gets shutdown properly... */
+				tty_hangup (port->tty);
+				port->tty = NULL;
+			}
+			ussp_dprintk(DEBUG_CLOSE, "Freeing pages: %p, %p\n", port->daemon_buffer,  port->tty_buffer);
+			if (port->daemon_buffer)
+				free_page ((long)port->daemon_buffer);
+
+			if (port->tty_buffer)
+				free_page ((long)port->tty_buffer);
+
+			port->daemon_buffer = port->tty_buffer = NULL;
+			ussp_dprintk(DEBUG_CLOSE, "Removing flag\n");
+			port->flags &= ~USSP_DEAMON_PRESENT;
+			wake_up_interruptible (&port->tty_wait);
+		} else {
+			/* This deamon must've been unattached... */
+			ussp_dprintk(DEBUG_CLOSE, "close: NULL Port!\n");
+		}
+	}
+	
+	MOD_DEC_USE_COUNT;
+	func_exit();
+
+	return 0;
+}
+
+
+static unsigned int ussp_ctl_poll (struct file *filep, poll_table * wait)
+{
+	struct ussp_port *port;
+	int mask;
+
+	func_enter();
+	port = filep->private_data;
+	printk("port: %p\n", port);
+	if (port) {
+
+		printk("Before poll_wait port: %p,head: %x, tail: %x\n", 
+		       port, port->daemon_head, port->daemon_tail);
+		poll_wait (filep, &port->daemon_wait, wait);
+
+		mask = 0;
+		if(port->daemon_head != port->daemon_tail)
+			mask |= POLLIN;
+		
+		printk("After poll_wait port: %p,head: %x, tail: %x, mask=%x\n", 
+		       port, port->daemon_head, port->daemon_tail, mask);
+	} else
+	  {
+	    printk("Port is 0\n");
+		mask = -ENODEV;
+	  }
+	func_exit();
+	return mask;
+}
+
+
+static int ussp_tty_chars_in_buffer (struct tty_struct *tty) 
+{
+	struct ussp_port *port;
+	int rv;
+
+	func_enter ();
+	port = tty->driver_data;
+	rv = (port->daemon_head - port->daemon_tail) & (PAGE_SIZE -1);
+	ussp_dprintk(DEBUG_CIB, "Chars in buffer %d\n", rv);
+	func_exit ();
+
+	return rv;
+}
+
+
+#ifdef MODULE
+void
+cleanup_module(void)
+{
+	func_enter();
+	
+	if (misc_deregister(&ussp_ctl_device) < 0) {
+		printk (KERN_INFO "ussp: couldn't deregister control device.\n");
+	}
+	if (tty_unregister_driver(&ussp_driver) < 0) {
+		printk (KERN_INFO "ussp:  couldn't deregister tty device.\n");
+	}
+	func_exit();
+}
+#endif
diff -u -r --new-file linux-2.4.0-test7.clean/include/linux/ussp.h linux-2.4.0-test7.rio/include/linux/ussp.h
--- linux-2.4.0-test7.clean/include/linux/ussp.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.0-test7.rio/include/linux/ussp.h	Mon Aug 28 14:01:37 2000
@@ -0,0 +1,76 @@
+/* -*- linux-c -*- */
+
+/*
+ *  ussp.h
+ *
+ *  Copyright (C) 2000 R.E.Wolff@BitWizard.nl, patrick@BitWizard.nl
+ *
+ *  Version 0.1 April 2000 .
+ */
+
+#define USSP_WRITE       1
+#define USSP_READ        2
+#define USSP_SET_TERMIOS 3
+#define USSP_MSC         4
+#define USSP_OPEN        5
+#define USSP_CLOSE       6
+#define USSP_OPEN_RESULT 7
+#define USSP_FORCE_CLOSE 8
+
+/* Don't clash with normal openflags */
+#define USSP_ISCALLOUT   0x10000000
+
+#define USSP_MAX_PORTS 16
+
+struct ussp_operation {
+       int op;
+       unsigned long len;	
+       unsigned long arg;
+       unsigned char data[0];
+};
+
+#define USSP_SET_PORT         _IOW('U', 1, int)
+#define USSP_SET_PORT_WATCHER _IOW('U', 2, int)
+#define TIOSTATGET            _IOW('U', 3, void *)
+
+#define USSP_DEAMON_PRESENT  0x000000001
+
+#ifdef __KERNEL__
+
+struct ussp_port {
+  int                     flags;
+  int                     nusers;
+  int			  line_status;
+  wait_queue_head_t       daemon_wait;
+  char                   *daemon_buffer;
+  int                     daemon_head, daemon_tail;
+  wait_queue_head_t       tty_wait;
+  char                   *tty_buffer;
+  int                     tty_head, tty_tail;
+
+  struct termios          normal_termios;
+  struct termios          callout_termios;
+  struct tty_struct      *tty;
+};
+#endif
+
+#define USSP_DCD TIOCM_CAR
+#define USSP_RI  TIOCM_RNG
+#define USSP_RTS TIOCM_RTS
+#define USSP_CTS TIOCM_CTS
+#define USSP_DTR TIOCM_DTR
+#define USSP_DSR TIOCM_DSR
+
+
+#ifndef USSPCTL_MISC_MINOR 
+/* Allow others to gather this into "major.h" or something like that */
+#define USSPCTL_MISC_MINOR    192
+#endif
+
+#ifndef USSP_NORMAL_MAJOR
+/* This allows overriding on the compiler commandline, or in a "major.h" 
+   include or something like that */
+#define USSP_NORMAL_MAJOR  120
+#define USSP_CALLOUT_MAJOR 121
+#endif
+





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
