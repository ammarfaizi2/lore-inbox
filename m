Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVIFUVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVIFUVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVIFUVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:21:10 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:64183 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750863AbVIFUVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:21:08 -0400
Date: Tue, 6 Sep 2005 22:21:02 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Omnikey Cardman 4040 driver (UPDATE)
Message-ID: <20050906202102.GN14984@sunbeam.de.gnumonks.org>
References: <20050905195404.GA16056@rama.de.gnumonks.org> <20050905190635.GA18315@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline
In-Reply-To: <20050905190635.GA18315@infradead.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi hch, thanks for your feedback. An updated version of
	the patch is at the bottom of this mail. On Mon, Sep 05, 2005 at
	08:06:35PM +0100, Christoph Hellwig wrote: > > +#include
	<linux/version.h> > > I don't think you need this one. [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_FC                  BODY: Odd Letter Triples with FC
	0.1 TW_DB                  BODY: Odd Letter Triples with DB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi hch, thanks for your feedback.

An updated version of the patch is at the bottom of this mail.

On Mon, Sep 05, 2005 at 08:06:35PM +0100, Christoph Hellwig wrote:
> > +#include <linux/version.h>
>=20
> I don't think you need this one.

done

> > +#include <pcmcia/version.h>
>=20
> you shouldn't need this one.

done

> > +static atomic_t cm4040_num_devices_open;
> > +
> > +#ifdef PCMCIA_DEBUG
> > +static int pc_debug =3D PCMCIA_DEBUG;
> > +module_param(pc_debug, int, 0600);
> > +#define DEBUG(n, x, args...) do { if (pc_debug >=3D (n)) 			    \
> > +				  printk(KERN_DEBUG "%s:%s:" x, MODULE_NAME, \
> > +					 __FUNCTION__, ##args); } while (0)
> > +#else
> > +#define DEBUG(n, args...)
> > +#endif
>=20
> What about just using pr_debug (or dev_dbg where you have a struct device
> handy)

I really appreciate the multiple debug levels of the driver, sorry.
However, I have converted the DEBUG macro to use dev_printk as a
compromise.
=20
> Please make the poll timer per device.  We generally try to avoid
> global state, and this allows to get rid of the opencount tracking aswell.

done.

> > +static ssize_t cm4040_read(struct file *filp, char __user *buf,
> > +			size_t count, loff_t *ppos)
> > +{
> > +	struct reader_dev *dev =3D (struct reader_dev *) filp->private_data;
>=20
> no need to case a void pointer.

well, but good style in my opioion anyway.  Anway, I don't really mind,
so it has been removed.

> > +	if (count < 10)
> > +		return -EFAULT;
> > +
> > +	if (filp->f_flags & O_NONBLOCK) {=20
> > +		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
> > +		DEBUG(2, "<- cm4040_read (failure)\n");
> > +		return -EAGAIN;
> > +	}
>=20
> this sounds rather pointless.  letting an O_NONBLOCK open fail all
> the time doesn't sound like a good idea.

what about fcntl enabling NONBLOCK after the open? =20
Other character drivers (such as rtc) do the same, btw.
Is there any way how I can tell the VFS to make any nonblocking
operation fail?

> please use iminor.

done.

> given that you fail O_NONLOCK in open already the code above makes even
> less sense.

see my comment above.

> > +	dev->owner =3D current;
>=20
> this doesn't make a lot of sense and seems to be only used in
> debug code, I'd suggest killing it.

done.

> you should be able to use file->private_data here.

done

> I think these events became methods of their own recently, not sure
> if it hit -mm or mainline yet.

I cannot find anything like that in mainline, thus my code remains
unchanged for now.

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1737,6 +1737,11 @@ L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
=20
+OMNIKEY CARDMAN 4040 DRIVER
+P:	Harald Welte
+M:	laforge@gnumonks.org
+S:	Maintained
+
 ONSTREAM SCSI TAPE DRIVER
 P:	Willem Riede
 M:	osst@riede.org
diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
--- a/drivers/char/pcmcia/Kconfig
+++ b/drivers/char/pcmcia/Kconfig
@@ -18,5 +18,18 @@ config SYNCLINK_CS
 	  The module will be called synclinkmp.  If you want to do that, say M
 	  here.
=20
+config CARDMAN_4040
+	tristate "Omnikey CardMan 4040 support"
+	depends on PCMCIA
+	help
+	  Enable support for the Omnikey CardMan 4040 PCMCIA Smartcard
+	  reader.
+	 =20
+	  This card is basically a USB CCID device connected to a FIFO
+	  in I/O space.  To use the kernel driver, you will need either the
+	  PC/SC ifdhandler provided from the Omnikey homepage
+	  (http://www.omnikey.com/), or a current development version of OpenCT
+	  (http://www.opensc.org/).
+
 endmenu
=20
diff --git a/drivers/char/pcmcia/Makefile b/drivers/char/pcmcia/Makefile
--- a/drivers/char/pcmcia/Makefile
+++ b/drivers/char/pcmcia/Makefile
@@ -5,3 +5,4 @@
 #
=20
 obj-$(CONFIG_SYNCLINK_CS) +=3D synclink_cs.o
+obj-$(CONFIG_CARDMAN_4040) +=3D cm4040_cs.o
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_c=
s.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -0,0 +1,835 @@
+/*
+ * A driver for the Omnikey PCMCIA smartcard reader CardMan 4040
+ *
+ * (c) 2000-2004 Omnikey AG (http://www.omnikey.com/)
+ *
+ * (C) 2005 Harald Welte <laforge@gnumonks.org>
+ * 	- add support for poll()
+ * 	- driver cleanup
+ * 	- add waitqueues
+ * 	- adhere to linux kernel coding style and policies
+ * 	- support 2.6.13 "new style" pcmcia interface
+ *
+ * The device basically is a USB CCID compliant device that has been
+ * attached to an I/O-Mapped FIFO.
+ *
+ * All rights reserved, Dual BSD/GPL Licensed.
+ */
+
+/* #define PCMCIA_DEBUG 6 */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/cistpl.h>
+#include <pcmcia/cisreg.h>
+#include <pcmcia/ciscode.h>
+#include <pcmcia/ds.h>
+
+#include "cm4040_cs.h"
+
+
+#ifdef PCMCIA_DEBUG
+#define reader_to_dev(x)	(&handle_to_dev(x->link.handle))
+static int pc_debug =3D PCMCIA_DEBUG;
+module_param(pc_debug, int, 0600);
+#define DEBUGP(n, rdr, x, args...) do { 				\
+	if (pc_debug >=3D (n)) 						\
+		dev_printk(KERN_DEBUG, reader_to_dev(rdr), "%s:" x, 	\
+			   __FUNCTION__, ##args); 			\
+	} while (0)
+#else
+#define DEBUGP(n, rdr, x, args...)
+#endif
+
+static char *version =3D
+"OMNIKEY CardMan 4040 v1.1.0gm4 - All bugs added by Harald Welte";
+
+#define	CCID_DRIVER_BULK_DEFAULT_TIMEOUT  	(150*HZ)
+#define	CCID_DRIVER_ASYNC_POWERUP_TIMEOUT 	(35*HZ)
+#define	CCID_DRIVER_MINIMUM_TIMEOUT 		(3*HZ)
+#define READ_WRITE_BUFFER_SIZE 512
+#define POLL_LOOP_COUNT				1000
+
+/* how often to poll for fifo status change */
+#define POLL_PERIOD 				msecs_to_jiffies(10)
+
+static void reader_release(dev_link_t *link);
+static void reader_detach(dev_link_t *link);
+
+static int major;
+
+#define		BS_READABLE	0x01
+#define		BS_WRITABLE	0x02
+
+struct reader_dev {
+	dev_link_t		link;
+	dev_node_t		node;
+	wait_queue_head_t	devq;
+	wait_queue_head_t	poll_wait;
+	wait_queue_head_t	read_wait;
+	wait_queue_head_t	write_wait;
+	unsigned int 	  	buffer_status;
+	unsigned long     	timeout;
+	unsigned char     	s_buf[READ_WRITE_BUFFER_SIZE];
+	unsigned char     	r_buf[READ_WRITE_BUFFER_SIZE];
+	struct timer_list 	poll_timer;
+};
+
+static dev_info_t dev_info =3D MODULE_NAME;
+static dev_link_t *dev_table[CM_MAX_DEV] =3D { NULL, };
+
+#ifndef PCMCIA_DEBUG
+#define	xoutb	outb
+#define	xinb	inb
+#else
+static inline void xoutb(unsigned char val, unsigned short port)
+{
+	if (pc_debug >=3D 7)
+		printk(KERN_DEBUG "outb(val=3D%.2x,port=3D%.4x)\n", val, port);
+	outb(val, port);
+}
+
+static inline unsigned char xinb(unsigned short port)
+{
+	unsigned char val;
+
+	val =3D inb(port);
+	if (pc_debug >=3D 7)
+		printk(KERN_DEBUG "%.2x=3Dinb(%.4x)\n", val, port);
+	return val;
+}
+#endif
+
+/* poll the device fifo status register.  not to be confused with
+ * the poll syscall. */
+static void cm4040_do_poll(unsigned long dummy)
+{
+	struct reader_dev *dev =3D (struct reader_dev *) dummy;
+	unsigned int obs =3D xinb(dev->link.io.BasePort1
+				+ REG_OFFSET_BUFFER_STATUS);
+
+	if ((obs & BSR_BULK_IN_FULL)) {
+		set_bit(BS_READABLE, &dev->buffer_status);
+		DEBUGP(4, dev, "waking up read_wait\n");
+		wake_up_interruptible(&dev->read_wait);
+	} else
+		clear_bit(BS_READABLE, &dev->buffer_status);
+
+	if (!(obs & BSR_BULK_OUT_FULL)) {
+		set_bit(BS_WRITABLE, &dev->buffer_status);
+		DEBUGP(4, dev, "waking up write_wait\n");
+		wake_up_interruptible(&dev->write_wait);
+	} else
+		clear_bit(BS_WRITABLE, &dev->buffer_status);
+
+	if (dev->buffer_status)
+		wake_up_interruptible(&dev->poll_wait);
+
+	mod_timer(&dev->poll_timer, jiffies + POLL_PERIOD);
+}
+
+static int wait_for_bulk_out_ready(struct reader_dev *dev)
+{
+	int i, rc;
+	int iobase =3D dev->link.io.BasePort1;
+
+	for (i =3D 0; i < POLL_LOOP_COUNT; i++) {
+		if ((xinb(iobase + REG_OFFSET_BUFFER_STATUS)
+		    & BSR_BULK_OUT_FULL) =3D=3D 0) {
+			DEBUGP(4, dev, "BulkOut empty (i=3D%d)\n", i);
+			return 1;
+		}
+	}
+
+	DEBUGP(4, dev, "wait_event_interruptible_timeout(timeout=3D%ld\n",
+		dev->timeout);
+	rc =3D wait_event_interruptible_timeout(dev->write_wait,
+					      test_and_clear_bit(BS_WRITABLE,
+						       &dev->buffer_status),
+					      dev->timeout);
+
+	if (rc > 0)
+		DEBUGP(4, dev, "woke up: BulkOut empty\n");
+	else if (rc =3D=3D 0)
+		DEBUGP(4, dev, "woke up: BulkOut full, returning 0 :(\n");
+	else if (rc < 0)
+		DEBUGP(4, dev, "woke up: signal arrived\n");
+
+	return rc;
+}
+
+/* Write to Sync Control Register */
+static int write_sync_reg(unsigned char val, struct reader_dev *dev)
+{
+	int iobase =3D dev->link.io.BasePort1;
+	int rc;
+
+	rc =3D wait_for_bulk_out_ready(dev);
+	if (rc <=3D 0)
+		return rc;
+
+	xoutb(val, iobase + REG_OFFSET_SYNC_CONTROL);
+	rc =3D wait_for_bulk_out_ready(dev);
+	if (rc <=3D 0)
+		return rc;
+
+	return 1;
+}
+
+static int wait_for_bulk_in_ready(struct reader_dev *dev)
+{
+	int i, rc;
+	int iobase =3D dev->link.io.BasePort1;
+
+	for (i =3D 0; i < POLL_LOOP_COUNT; i++) {
+		if ((xinb(iobase + REG_OFFSET_BUFFER_STATUS)
+		    & BSR_BULK_IN_FULL) =3D=3D BSR_BULK_IN_FULL) {
+			DEBUGP(3, dev, "BulkIn full (i=3D%d)\n", i);
+			return 1;
+		}
+	}
+
+	DEBUGP(4, dev, "wait_event_interruptible_timeout(timeout=3D%ld\n",
+		dev->timeout);
+	rc =3D wait_event_interruptible_timeout(dev->read_wait,
+					      test_and_clear_bit(BS_READABLE,
+						 	&dev->buffer_status),
+					      dev->timeout);
+	if (rc > 0)
+		DEBUGP(4, dev, "woke up: BulkIn full\n");
+	else if (rc =3D=3D 0)
+		DEBUGP(4, dev, "woke up: BulkIn not full, returning 0 :(\n");
+	else if (rc < 0)
+		DEBUGP(4, dev, "woke up: signal arrived\n");
+
+	return rc;
+}
+
+static ssize_t cm4040_read(struct file *filp, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct reader_dev *dev =3D filp->private_data;
+	int iobase =3D dev->link.io.BasePort1;
+	unsigned long bytes_to_read;
+	unsigned long i;
+	unsigned long min_bytes_to_read;
+	int rc;
+	unsigned char uc;
+
+	DEBUGP(2, dev, "-> cm4040_read(%s,%d)\n", current->comm, current->pid);
+
+	if (count =3D=3D 0)
+		return 0;
+
+	if (count < 10)
+		return -EFAULT;
+
+	if (filp->f_flags & O_NONBLOCK) {
+		DEBUGP(4, dev, "filep->f_flags O_NONBLOCK set\n");
+		DEBUGP(2, dev, "<- cm4040_read (failure)\n");
+		return -EAGAIN;
+	}
+
+	if ((dev->link.state & DEV_PRESENT)=3D=3D0)
+		return -ENODEV;
+
+	schedule_timeout(1*HZ);
+	for (i =3D 0; i < 5; i++) {
+		rc =3D wait_for_bulk_in_ready(dev);
+		if (rc <=3D 0) {
+			DEBUGP(5, dev, "wait_for_bulk_in_ready rc=3D%.2x\n", rc);
+			DEBUGP(2, dev, "<- cm4040_read (failed)\n");
+			if (rc =3D=3D -ERESTARTSYS)
+				return rc;
+			return -EIO;
+		}
+	  	dev->r_buf[i] =3D xinb(iobase + REG_OFFSET_BULK_IN);
+#ifdef PCMCIA_DEBUG
+		if (pc_debug >=3D 6)
+			printk(KERN_DEBUG "%lu:%2x ", i, dev->r_buf[i]);
+	}
+	printk("\n");
+#else
+	}
+#endif
+
+	bytes_to_read =3D 5 + le32_to_cpu(*(__le32 *)&dev->r_buf[1]);
+
+	DEBUGP(6, dev, "BytesToRead=3D%lu\n", bytes_to_read);
+
+	min_bytes_to_read =3D min(count, bytes_to_read + 5);
+
+	DEBUGP(6, dev, "Min=3D%lu\n", min_bytes_to_read);
+
+	for (i =3D 0; i < (min_bytes_to_read-5); i++) {
+		rc =3D wait_for_bulk_in_ready(dev);
+		if (rc <=3D 0) {
+			DEBUGP(5, dev, "wait_for_bulk_in_ready rc=3D%.2x\n", rc);
+			DEBUGP(2, dev, "<- cm4040_read (failed)\n");
+			if (rc =3D=3D -ERESTARTSYS)
+				return rc;
+			return -EIO;
+		}
+		dev->r_buf[i+5] =3D xinb(iobase + REG_OFFSET_BULK_IN);
+#ifdef PCMCIA_DEBUG
+		if (pc_debug >=3D 6)
+			printk(KERN_DEBUG "%lu:%2x ", i, dev->r_buf[i]);
+	}
+	printk("\n");
+#else
+	}
+#endif
+
+	*ppos =3D min_bytes_to_read;
+	if (copy_to_user(buf, dev->r_buf, min_bytes_to_read))
+		return -EFAULT;
+
+	rc =3D wait_for_bulk_in_ready(dev);
+	if (rc <=3D 0) {
+		DEBUGP(5, dev, "wait_for_bulk_in_ready rc=3D%.2x\n", rc);
+		DEBUGP(2, dev, "<- cm4040_read (failed)\n");
+		if (rc =3D=3D -ERESTARTSYS)
+			return rc;
+		return -EIO;
+	}
+
+	rc =3D write_sync_reg(SCR_READER_TO_HOST_DONE, dev);
+	if (rc <=3D 0) {
+		DEBUGP(5, dev, "write_sync_reg c=3D%.2x\n", rc);
+		DEBUGP(2, dev, "<- cm4040_read (failed)\n");
+		if (rc =3D=3D -ERESTARTSYS)
+			return rc;
+		else
+			return -EIO;
+	}
+
+	uc =3D xinb(iobase + REG_OFFSET_BULK_IN);
+
+	DEBUGP(2, dev, "<- cm4040_read (successfully)\n");
+	return min_bytes_to_read;
+}
+
+static ssize_t cm4040_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct reader_dev *dev =3D filp->private_data;
+	int iobase =3D dev->link.io.BasePort1;
+	ssize_t rc;
+	int i;
+	unsigned int bytes_to_write;
+
+	DEBUGP(2, dev, "-> cm4040_write(%s,%d)\n", current->comm, current->pid);
+
+	if (count =3D=3D 0) {
+		DEBUGP(2, dev, "<- cm4040_write empty read (successfully)\n");
+		return 0;
+	}
+
+	if (count < 5) {
+		DEBUGP(2, dev, "<- cm4040_write buffersize=3D%Zd < 5\n", count);
+		return -EIO;
+	}
+
+	if (filp->f_flags & O_NONBLOCK) {
+		DEBUGP(4, dev, "filep->f_flags O_NONBLOCK set\n");
+		DEBUGP(4, dev, "<- cm4040_write (failure)\n");
+		return -EAGAIN;
+	}
+
+	if ((dev->link.state & DEV_PRESENT) =3D=3D 0)
+		return -ENODEV;
+
+	bytes_to_write =3D count;
+	if (copy_from_user(dev->s_buf, buf, bytes_to_write))
+		return -EFAULT;
+
+	switch (dev->s_buf[0]) {
+		case CMD_PC_TO_RDR_XFRBLOCK:
+		case CMD_PC_TO_RDR_SECURE:
+		case CMD_PC_TO_RDR_TEST_SECURE:
+		case CMD_PC_TO_RDR_OK_SECURE:
+			dev->timeout =3D CCID_DRIVER_BULK_DEFAULT_TIMEOUT;
+			break;
+
+		case CMD_PC_TO_RDR_ICCPOWERON:
+			dev->timeout =3D CCID_DRIVER_ASYNC_POWERUP_TIMEOUT;
+			break;
+
+		case CMD_PC_TO_RDR_GETSLOTSTATUS:
+		case CMD_PC_TO_RDR_ICCPOWEROFF:
+		case CMD_PC_TO_RDR_GETPARAMETERS:
+		case CMD_PC_TO_RDR_RESETPARAMETERS:
+		case CMD_PC_TO_RDR_SETPARAMETERS:
+		case CMD_PC_TO_RDR_ESCAPE:
+		case CMD_PC_TO_RDR_ICCCLOCK:
+		default:
+			dev->timeout =3D CCID_DRIVER_MINIMUM_TIMEOUT;
+			break;
+	}
+
+	rc =3D write_sync_reg(SCR_HOST_TO_READER_START, dev);
+	if (rc <=3D 0) {
+		DEBUGP(5, dev, "write_sync_reg c=3D%.2Zx\n", rc);
+		DEBUGP(2, dev, "<- cm4040_write (failed)\n");
+		if (rc =3D=3D -ERESTARTSYS)
+			return rc;
+		else
+			return -EIO;
+	}
+
+	DEBUGP(4, dev, "start \n");
+
+	for (i =3D 0; i < bytes_to_write; i++) {
+		rc =3D wait_for_bulk_out_ready(dev);
+		if (rc <=3D 0) {
+			DEBUGP(5, dev, "wait_for_bulk_out_ready rc=3D%.2Zx\n",
+			       rc);
+			DEBUGP(2, dev, "<- cm4040_write (failed)\n");
+			if (rc =3D=3D -ERESTARTSYS)
+				return rc;
+			else
+				return -EIO;
+		}
+
+		xoutb(dev->s_buf[i],iobase + REG_OFFSET_BULK_OUT);
+	}
+	DEBUGP(4, dev, "end\n");
+
+	rc =3D write_sync_reg(SCR_HOST_TO_READER_DONE, dev);
+
+	if (rc <=3D 0) {
+		DEBUGP(5, dev, "write_sync_reg c=3D%.2Zx\n", rc);
+		DEBUGP(2, dev, "<- cm4040_write (failed)\n");
+		if (rc =3D=3D -ERESTARTSYS)
+			return rc;
+		else
+			return -EIO;
+	}
+
+	DEBUGP(2, dev, "<- cm4040_write (successfully)\n");
+	return count;
+}
+
+static unsigned int cm4040_poll(struct file *filp, poll_table *wait)
+{
+	struct reader_dev *dev =3D filp->private_data;
+	unsigned int mask =3D 0;
+
+	poll_wait(filp, &dev->poll_wait, wait);
+
+	if (test_and_clear_bit(BS_READABLE, &dev->buffer_status))
+		mask |=3D POLLIN | POLLRDNORM;
+	if (test_and_clear_bit(BS_WRITABLE, &dev->buffer_status))
+		mask |=3D POLLOUT | POLLWRNORM;
+
+	DEBUGP(2, dev, "<- cm4040_poll(%u)\n", mask);
+
+	return mask;
+}
+
+static int cm4040_open(struct inode *inode, struct file *filp)
+{
+	struct reader_dev *dev;
+	dev_link_t *link;
+	int minor =3D iminor(inode);
+
+	if (minor >=3D CM_MAX_DEV)
+		return -ENODEV;
+
+	link =3D dev_table[minor];
+	if (link =3D=3D NULL || !(DEV_OK(link)))
+		return -ENODEV;
+
+	if (link->open)
+		return -EBUSY;
+
+	dev =3D (struct reader_dev *)link->priv;
+	filp->private_data =3D dev;
+
+	if (filp->f_flags & O_NONBLOCK) {
+		DEBUGP(4, dev, "filep->f_flags O_NONBLOCK set\n");
+		return -EAGAIN;
+	}
+
+	link->open =3D 1;
+
+	dev->poll_timer.data =3D (unsigned long) dev;
+	mod_timer(&dev->poll_timer, jiffies + POLL_PERIOD);
+
+	DEBUGP(2, dev, "<- cm4040_open (successfully)\n");
+	return nonseekable_open(inode, filp);
+}
+
+static int cm4040_close(struct inode *inode, struct file *filp)
+{
+	struct reader_dev *dev =3D filp->private_data;
+	dev_link_t *link;
+	int minor =3D iminor(inode);
+
+	DEBUGP(2, dev, "-> cm4040_close(maj/min=3D%d.%d)\n", imajor(inode),=20
+	      iminor(inode));
+
+	if (minor >=3D CM_MAX_DEV)
+		return -ENODEV;
+
+	link =3D dev_table[minor];
+	if (link =3D=3D NULL)
+		return -ENODEV;
+
+	link->open =3D 0;
+	wake_up(&dev->devq);
+
+	DEBUGP(2, dev, "<- cm4040_close\n");
+	return 0;
+}
+
+static void cm4040_reader_release(dev_link_t *link)
+{
+	struct reader_dev *dev =3D link->priv;
+
+	DEBUGP(3, dev, "-> cm4040_reader_release\n");
+	while (link->open) {
+		DEBUGP(3, dev, KERN_INFO MODULE_NAME ": delaying release "
+		       "until process has terminated\n");
+ 		wait_event(dev->devq, (link->open =3D=3D 0));
+	}
+	DEBUGP(3, dev, "<- cm4040_reader_release\n");
+	return;
+}
+
+static void reader_config(dev_link_t *link, int devno)
+{
+	client_handle_t handle;
+	struct reader_dev *dev;
+	tuple_t tuple;
+	cisparse_t parse;
+	config_info_t conf;
+	u_char buf[64];
+	int fail_fn, fail_rc;
+	int rc;
+
+	handle =3D link->handle;
+
+	tuple.DesiredTuple =3D CISTPL_CONFIG;
+	tuple.Attributes =3D 0;
+	tuple.TupleData =3D buf;
+	tuple.TupleDataMax =3D sizeof(buf);
+ 	tuple.TupleOffset =3D 0;
+
+	if ((fail_rc =3D pcmcia_get_first_tuple(handle, &tuple)) !=3D CS_SUCCESS)=
 {
+		fail_fn =3D GetFirstTuple;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D pcmcia_get_tuple_data(handle, &tuple)) !=3D CS_SUCCESS) {
+		fail_fn =3D GetTupleData;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D pcmcia_parse_tuple(handle, &tuple, &parse))
+							!=3D CS_SUCCESS) {
+		fail_fn =3D ParseTuple;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D pcmcia_get_configuration_info(handle, &conf))
+							!=3D CS_SUCCESS) {
+		fail_fn =3D GetConfigurationInfo;
+		goto cs_failed;
+	}
+
+	link->state |=3D DEV_CONFIG;
+	link->conf.ConfigBase =3D parse.config.base;
+	link->conf.Present =3D parse.config.rmask[0];
+	link->conf.Vcc =3D conf.Vcc;
+
+	link->io.BasePort2 =3D 0;
+	link->io.NumPorts2 =3D 0;
+	link->io.Attributes2 =3D 0;
+	tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
+	for (rc =3D pcmcia_get_first_tuple(handle, &tuple);
+	     rc =3D=3D CS_SUCCESS;
+	     rc =3D pcmcia_get_next_tuple(handle, &tuple)) {
+		rc =3D pcmcia_get_tuple_data(handle, &tuple);
+		if (rc !=3D CS_SUCCESS)
+			continue;
+		rc =3D pcmcia_parse_tuple(handle, &tuple, &parse);
+		if (rc !=3D CS_SUCCESS)
+			continue;
+
+		link->conf.ConfigIndex =3D parse.cftable_entry.index;
+
+		if (!parse.cftable_entry.io.nwin)
+			continue;
+
+		link->io.BasePort1 =3D parse.cftable_entry.io.win[0].base;
+		link->io.NumPorts1 =3D parse.cftable_entry.io.win[0].len;
+		link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_AUTO;
+		if (!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))
+			link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_16;
+		if (!(parse.cftable_entry.io.flags & CISTPL_IO_16BIT))
+			link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
+		link->io.IOAddrLines =3D parse.cftable_entry.io.flags
+						& CISTPL_IO_LINES_MASK;
+		rc =3D pcmcia_request_io(handle, &link->io);
+
+		dev_printk(KERN_INFO, &handle_to_dev(handle), "foo");
+		if (rc =3D=3D CS_SUCCESS)
+			break;
+		else
+			dev_printk(KERN_INFO, &handle_to_dev(handle),
+				   "pcmcia_request_io failed 0x%x\n", rc);
+	}
+	if (rc !=3D CS_SUCCESS)
+		goto cs_release;
+
+	link->conf.IntType =3D 00000002;
+
+	if ((fail_rc =3D pcmcia_request_configuration(handle,&link->conf))
+								!=3DCS_SUCCESS) {
+		fail_fn =3D RequestConfiguration;
+		dev_printk(KERN_INFO, &handle_to_dev(handle),=20
+			   "pcmcia_request_configuration failed 0x%x\n",
+			   fail_rc);
+		goto cs_release;
+	}
+
+	dev =3D link->priv;
+	sprintf(dev->node.dev_name, DEVICE_NAME "%d", devno);
+	dev->node.major =3D major;
+	dev->node.minor =3D devno;
+	dev->node.next =3D NULL;
+	link->dev =3D &dev->node;
+	link->state &=3D ~DEV_CONFIG_PENDING;
+
+	DEBUGP(2, dev, "device " DEVICE_NAME "%d at 0x%.4x-0x%.4x\n", devno,
+	      link->io.BasePort1, link->io.BasePort1+link->io.NumPorts1);
+	DEBUGP(2, dev, "<- reader_config (succ)\n");
+
+	return;
+
+cs_failed:
+	cs_error(handle, fail_fn, fail_rc);
+cs_release:
+	reader_release(link);
+	link->state &=3D ~DEV_CONFIG_PENDING;
+}
+
+static int reader_event(event_t event, int priority,
+			event_callback_args_t *args)
+{
+	dev_link_t *link;
+	struct reader_dev *dev;
+	int devno;
+
+	link =3D args->client_data;
+	dev =3D link->priv;
+	DEBUGP(3, dev, "-> reader_event\n");
+	for (devno =3D 0; devno < CM_MAX_DEV; devno++) {
+		if (dev_table[devno] =3D=3D link)
+			break;
+	}
+	if (devno =3D=3D CM_MAX_DEV)
+		return CS_BAD_ADAPTER;
+
+	switch (event) {
+		case CS_EVENT_CARD_INSERTION:
+			DEBUGP(5, dev, "CS_EVENT_CARD_INSERTION\n");
+			link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
+			reader_config(link, devno);
+			break;
+		case CS_EVENT_CARD_REMOVAL:
+			DEBUGP(5, dev, "CS_EVENT_CARD_REMOVAL\n");
+			link->state &=3D ~DEV_PRESENT;
+			break;
+		case CS_EVENT_PM_SUSPEND:
+			DEBUGP(5, dev, "CS_EVENT_PM_SUSPEND "
+			      "(fall-through to CS_EVENT_RESET_PHYSICAL)\n");
+			link->state |=3D DEV_SUSPEND;
+
+		case CS_EVENT_RESET_PHYSICAL:
+			DEBUGP(5, dev, "CS_EVENT_RESET_PHYSICAL\n");
+			if (link->state & DEV_CONFIG) {
+		  		DEBUGP(5, dev, "ReleaseConfiguration\n");
+		  		pcmcia_release_configuration(link->handle);
+			}
+			break;
+		case CS_EVENT_PM_RESUME:
+			DEBUGP(5, dev, "CS_EVENT_PM_RESUME "
+			      "(fall-through to CS_EVENT_CARD_RESET)\n");
+			link->state &=3D ~DEV_SUSPEND;
+
+		case CS_EVENT_CARD_RESET:
+			DEBUGP(5, dev, "CS_EVENT_CARD_RESET\n");
+			if ((link->state & DEV_CONFIG)) {
+				DEBUGP(5, dev, "RequestConfiguration\n");
+		  		pcmcia_request_configuration(link->handle,
+							     &link->conf);
+			}
+			break;
+		default:
+			DEBUGP(5, dev, "reader_event: unknown event %.2x\n",
+			       event);
+			break;
+	}
+	DEBUGP(3, dev, "<- reader_event\n");
+	return CS_SUCCESS;
+}
+
+static void reader_release(dev_link_t *link)
+{
+	cm4040_reader_release(link->priv);
+	pcmcia_release_configuration(link->handle);
+	pcmcia_release_io(link->handle, &link->io);
+}
+
+static dev_link_t *reader_attach(void)
+{
+	struct reader_dev *dev;
+	dev_link_t *link;
+	client_reg_t client_reg;
+	int i;
+
+	for (i =3D 0; i < CM_MAX_DEV; i++) {
+		if (dev_table[i] =3D=3D NULL)
+			break;
+	}
+
+	if (i =3D=3D CM_MAX_DEV)
+		return NULL;
+
+	dev =3D kmalloc(sizeof(struct reader_dev), GFP_KERNEL);
+	if (dev =3D=3D NULL)
+		return NULL;
+
+	memset(dev, 0, sizeof(struct reader_dev));
+	dev->timeout =3D CCID_DRIVER_MINIMUM_TIMEOUT;
+	dev->buffer_status =3D 0;
+
+	link =3D &dev->link;
+	link->priv =3D dev;
+
+	link->conf.IntType =3D INT_MEMORY_AND_IO;
+	dev_table[i] =3D link;
+
+	client_reg.dev_info =3D &dev_info;
+	client_reg.Attributes =3D INFO_IO_CLIENT | INFO_CARD_SHARE;
+	client_reg.EventMask=3D
+		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+		CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.Version =3D 0x0210;
+	client_reg.event_callback_args.client_data =3D link;
+	i =3D pcmcia_register_client(&link->handle, &client_reg);
+	if (i) {
+		cs_error(link->handle, RegisterClient, i);
+		reader_detach(link);
+		return NULL;
+	}
+	init_waitqueue_head(&dev->devq);
+	init_waitqueue_head(&dev->poll_wait);
+	init_waitqueue_head(&dev->read_wait);
+	init_waitqueue_head(&dev->write_wait);
+	init_timer(&dev->poll_timer);
+	dev->poll_timer.function =3D &cm4040_do_poll;
+
+	return link;
+}
+
+static void reader_detach_by_devno(int devno, dev_link_t *link)
+{
+	struct reader_dev *dev =3D link->priv;
+
+	if (link->state & DEV_CONFIG) {
+		DEBUGP(5, dev, "device still configured (try to release it)\n");
+		reader_release(link);
+	}
+
+	pcmcia_deregister_client(link->handle);
+	dev_table[devno] =3D NULL;
+	DEBUGP(5, dev, "freeing dev=3D%p\n", dev);
+	kfree(dev);
+	return;
+}
+
+static void reader_detach(dev_link_t *link)
+{
+	int i;
+
+	/* find device */
+	for (i =3D 0; i < CM_MAX_DEV; i++) {
+		if (dev_table[i] =3D=3D link)
+			break;
+	}
+	if (i =3D=3D CM_MAX_DEV)
+		return;
+
+	reader_detach_by_devno(i, link);
+	return;
+}
+
+static struct file_operations reader_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.read		=3D cm4040_read,
+	.write		=3D cm4040_write,
+	.open		=3D cm4040_open,
+	.release	=3D cm4040_close,
+	.poll		=3D cm4040_poll,
+};
+
+static struct pcmcia_device_id cm4040_ids[] =3D {
+	PCMCIA_DEVICE_MANF_CARD(0x0223, 0x0200),
+	PCMCIA_DEVICE_PROD_ID12("OMNIKEY", "CardMan 4040",
+				0xE32CDD8C, 0x8F23318B),
+	PCMCIA_DEVICE_NULL,
+};
+MODULE_DEVICE_TABLE(pcmcia, cm4040_ids);
+
+static struct pcmcia_driver reader_driver =3D {
+  	.owner		=3D THIS_MODULE,
+  	.drv		=3D {
+		.name	=3D "cm4040_cs",
+	},
+	.attach		=3D reader_attach,
+	.detach		=3D reader_detach,
+	.event		=3D reader_event,
+	.id_table	=3D cm4040_ids,
+};
+
+static int __init cm4040_init(void)
+{
+	printk(KERN_INFO "%s\n", version);
+	pcmcia_register_driver(&reader_driver);
+	major =3D register_chrdev(0, DEVICE_NAME, &reader_fops);
+	if (major < 0) {
+		printk(KERN_WARNING MODULE_NAME
+			": could not get major number\n");
+		return -1;
+	}
+	return 0;
+}
+
+static void __exit cm4040_exit(void)
+{
+	int i;
+
+	printk(KERN_INFO MODULE_NAME ": unloading\n");
+	pcmcia_unregister_driver(&reader_driver);
+	for (i =3D 0; i < CM_MAX_DEV; i++) {
+		if (dev_table[i])
+			reader_detach_by_devno(i, dev_table[i]);
+	}
+	unregister_chrdev(major, DEVICE_NAME);
+}
+
+module_init(cm4040_init);
+module_exit(cm4040_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/char/pcmcia/cm4040_cs.h b/drivers/char/pcmcia/cm4040_c=
s.h
new file mode 100644
--- /dev/null
+++ b/drivers/char/pcmcia/cm4040_cs.h
@@ -0,0 +1,47 @@
+#ifndef	_CM4040_H_
+#define	_CM4040_H_
+
+#define	CM_MAX_DEV		4
+
+#define	DEVICE_NAME		"cmx"
+#define	MODULE_NAME		"cm4040_cs"
+
+#define REG_OFFSET_BULK_OUT      0
+#define REG_OFFSET_BULK_IN       0
+#define REG_OFFSET_BUFFER_STATUS 1
+#define REG_OFFSET_SYNC_CONTROL  2
+
+#define BSR_BULK_IN_FULL  0x02
+#define BSR_BULK_OUT_FULL 0x01
+
+#define SCR_HOST_TO_READER_START 0x80
+#define SCR_ABORT                0x40
+#define SCR_EN_NOTIFY            0x20
+#define SCR_ACK_NOTIFY           0x10
+#define SCR_READER_TO_HOST_DONE  0x08
+#define SCR_HOST_TO_READER_DONE  0x04
+#define SCR_PULSE_INTERRUPT      0x02
+#define SCR_POWER_DOWN           0x01
+
+
+#define  CMD_PC_TO_RDR_ICCPOWERON       0x62
+#define  CMD_PC_TO_RDR_GETSLOTSTATUS    0x65
+#define  CMD_PC_TO_RDR_ICCPOWEROFF      0x63
+#define  CMD_PC_TO_RDR_SECURE           0x69
+#define  CMD_PC_TO_RDR_GETPARAMETERS    0x6C
+#define  CMD_PC_TO_RDR_RESETPARAMETERS  0x6D
+#define  CMD_PC_TO_RDR_SETPARAMETERS    0x61
+#define  CMD_PC_TO_RDR_XFRBLOCK         0x6F
+#define  CMD_PC_TO_RDR_ESCAPE           0x6B
+#define  CMD_PC_TO_RDR_ICCCLOCK         0x6E
+#define  CMD_PC_TO_RDR_TEST_SECURE      0x74
+#define  CMD_PC_TO_RDR_OK_SECURE        0x89
+
+
+#define  CMD_RDR_TO_PC_SLOTSTATUS         0x81
+#define  CMD_RDR_TO_PC_DATABLOCK          0x80
+#define  CMD_RDR_TO_PC_PARAMETERS         0x82
+#define  CMD_RDR_TO_PC_ESCAPE             0x83
+#define  CMD_RDR_TO_PC_OK_SECURE          0x89
+
+#endif	/* _CM4040_H_ */
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHfouXaXGVTD0i/8RAnSqAJ0YY0Zmf8xvU7aiFf363MfYfhrlwwCfbaGH
o8iR9ydC118H8xKvP9IePCQ=
=jMTd
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--
