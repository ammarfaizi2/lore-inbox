Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVIET33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVIET33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVIET32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:29:28 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:18609 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932409AbVIET31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:29:27 -0400
Date: Tue, 6 Sep 2005 03:35:45 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] Omnikey Cardman 4000 driver
Message-ID: <20050906013545.GB16056@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Following-up to the Cardman 4040 driver, I'm now sumitting a driver for
the Cardman 4000 reader.  It is, too, a PCMCIA smartcard reader and the
predecessor of the 4040.

=46rom a technical point of view, the two devices have nothing in common,
so there is no possibility of code sharing.

Please consider mergin mainline, thanks. =20

Note: The patch is incremental to the Cardman 4040 driver that has
already been submitted.

*********************************************************8

Add new Omnikey Cardman 4000 smartcard reader driver

Signed-off-by: Harald Welte <laforge@gnumonks.org>

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1737,6 +1737,11 @@ L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
=20
+OMNIKEY CARDMAN 4000 DRIVER
+P:	Harald Welte
+M:	laforge@gnumonks.org
+S:	Maintained
+
 OMNIKEY CARDMAN 4040 DRIVER
 P:	Harald Welte
 M:	laforge@gnumonks.org
diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
--- a/drivers/char/pcmcia/Kconfig
+++ b/drivers/char/pcmcia/Kconfig
@@ -18,6 +18,17 @@ config SYNCLINK_CS
 	  The module will be called synclinkmp.  If you want to do that, say M
 	  here.
=20
+config CARDMAN_4000
+	tristate "Omnikey Cardman 4000 support"
+	depends on PCMCIA
+	help
+	  Enable support for the Omnikey Cardman 4000 PCMCIA Smartcard
+	  reader.
+
+	  This kernel driver requires additional userspace support, either
+	  by the vendor-provided PC/SC ifd_handler (http://www.omnikey.com/),
+	  or via the cm4000 backend of OpenCT (http://www.opensc.com/).
+
 config CARDMAN_4040
 	tristate "Omnikey CardMan 4040 support"
 	depends on PCMCIA
diff --git a/drivers/char/pcmcia/Makefile b/drivers/char/pcmcia/Makefile
--- a/drivers/char/pcmcia/Makefile
+++ b/drivers/char/pcmcia/Makefile
@@ -5,4 +5,5 @@
 #
=20
 obj-$(CONFIG_SYNCLINK_CS) +=3D synclink_cs.o
+obj-$(CONFIG_CARDMAN_4000) +=3D cm4000_cs.o
 obj-$(CONFIG_CARDMAN_4040) +=3D cm4040_cs.o
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_c=
s.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -0,0 +1,2163 @@
+ /*
+  * A driver for the PCMCIA Smartcard Reader "Omnikey CardMan Mobile 4000"
+  *
+  * cm4000_cs.c support.linux@omnikey.com
+  *
+  * Tue Oct 23 11:32:43 GMT 2001 herp - cleaned up header files
+  * Sun Jan 20 10:11:15 MET 2002 herp - added modversion header files
+  * Thu Nov 14 16:34:11 GMT 2002 mh   - added PPS functionality
+  * Tue Nov 19 16:36:27 GMT 2002 mh   - added SUSPEND/RESUME functionailty
+  * Wed Jul 28 12:55:01 CEST 2004 mh  - kernel 2.6 adjustments
+  *
+  * current version: 2.4.0gm4
+  *
+  * (C) 2000,2001,2002,2003,2004 Omnikey AG
+  *
+  * (C) 2005 Harald Welte <laforge@gnumonks.org>
+  * 	- Adhere to Kernel CodingStyle
+  * 	- Port to 2.6.13 "new" style PCMCIA
+  * 	- Check for copy_{from,to}_user return values
+  * 	- Use nonseekable_open()
+  *
+  * All rights reserved. Licensed under dual BSD/GPL license.
+  */
+
+/* #define PCMCIA_DEBUG 6 */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
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
+#include <linux/cm4000_cs.h>
+
+/* #define ATR_CSUM */
+
+#ifdef PCMCIA_DEBUG
+static int pc_debug =3D PCMCIA_DEBUG;
+module_param(pc_debug, int, 0600);
+#define DEBUG(n, x, args...) do { if (pc_debug >=3D (n))			   \
+				printk(KERN_DEBUG "%s:%s:" x, MODULE_NAME, \
+					__FUNCTION__, ## args); } while(0)
+#else
+#define DEBUG(n, x, args...)
+#endif
+static char *version =3D "cm4000_cs.c v2.4.0gm4 - All bugs added by Harald=
 Welte";
+
+#define	T_1SEC		(HZ)
+#define	T_10MSEC	msecs_to_jiffies(10)
+#define	T_20MSEC	msecs_to_jiffies(20)
+#define	T_25MSEC	msecs_to_jiffies(25)
+#define	T_40MSEC	msecs_to_jiffies(40)
+#define	T_50MSEC	msecs_to_jiffies(50)
+#define	T_100MSEC	msecs_to_jiffies(100)
+#define	T_500MSEC	msecs_to_jiffies(500)
+
+static void cm4000_detach(dev_link_t *link);
+static void cm4000_release(dev_link_t *link);
+
+static int major;		/* major number we get from the kernel */
+
+/* note: the first state has to have number 0 always */
+
+#define	M_FETCH_ATR	0
+#define	M_TIMEOUT_WAIT	1
+#define	M_READ_ATR_LEN	2
+#define	M_READ_ATR	3
+#define	M_ATR_PRESENT	4
+#define	M_BAD_CARD	5
+#define M_CARDOFF	6
+
+#ifdef PCMCIA_DEBUG
+static char *m_stnames[] =3D {
+	"M_FETCH_ATR",
+	"M_TIMEOUT_WAIT",
+	"M_READ_ATR_LEN",
+	"M_READ_ATR",
+	"M_ATR_PRESENT",
+	"M_BAD_CARD"
+};
+#endif
+
+#define	LOCK_IO			0
+#define	LOCK_MONITOR		1
+
+#define IS_AUTOPPS_ACT		 6
+#define	IS_PROCBYTE_PRESENT	 7
+#define	IS_INVREV		 8
+#define IS_ANY_T0		 9
+#define	IS_ANY_T1		10
+#define	IS_ATR_PRESENT		11
+#define	IS_ATR_VALID		12
+#define	IS_CMM_ABSENT		13
+#define	IS_BAD_LENGTH		14
+#define	IS_BAD_CSUM		15
+#define	IS_BAD_CARD		16
+
+#define REG_FLAGS0(x)		(x + 0)
+#define REG_FLAGS1(x)		(x + 1)
+#define REG_NUM_BYTES(x)	(x + 2)
+#define REG_BUF_ADDR(x)		(x + 3)
+#define REG_BUF_DATA(x)		(x + 4)
+#define REG_NUM_SEND(x)		(x + 5)
+#define REG_BAUDRATE(x)		(x + 6)
+#define REG_STOPBITS(x)		(x + 7)
+
+struct cm4000_dev {
+	dev_link_t link;		/* pcmcia link */
+	dev_node_t node;		/* OS node (major,minor) */
+
+	unsigned char atr[MAX_ATR];
+	unsigned char rbuf[512];
+	unsigned char sbuf[512];
+
+	wait_queue_head_t devq;		/* when removing cardman must not be
+					   zeroed! */
+
+	wait_queue_head_t ioq;		/* if IO is locked, wait on this Q */
+	wait_queue_head_t atrq;		/* wait for ATR valid */
+	wait_queue_head_t readq;	/* used by write to wake blk.read */
+
+	/* warning: do not move this fields. =20
+	 * initialising to zero depends on it - see ZERO_DEV below.  */
+	unsigned char atr_csum;
+	unsigned char atr_len_retry;
+	unsigned short atr_len;
+	unsigned short rlen;	/* bytes avail. after write */
+	unsigned short rpos;	/* latest read pos. write zeroes */
+	unsigned char procbyte;	/* T=3D0 procedure byte */
+	unsigned char mstate;	/* state of card monitor */
+	unsigned char cwarn;	/* slow down warning */
+	unsigned char flags0;	/* cardman IO-flags 0 */
+	unsigned char flags1;	/* cardman IO-flags 1 */
+	unsigned int mdelay;	/* variable monitor speeds */
+
+	unsigned int baudv;	/* baud value for speed */
+	unsigned char ta1;
+	unsigned char proto;	/* T=3D0, T=3D1, ... */
+	unsigned long flags;	/* lock+flags (MONITOR,IO,ATR) * for concurrent
+				   access */
+
+	unsigned char pts[4];
+
+	struct timer_list timer;	/* used to keep monitor running */
+	struct task_struct *owner;	/* who opened us (only one per dev) */
+	int monitor_running;
+};
+
+#define	ZERO_DEV(dev)  						\
+	memset(&dev->atr_csum,0,				\
+		sizeof(struct cm4000_dev) - 			\
+		/*link*/ sizeof(dev_link_t) - 			\
+		/*node*/ sizeof(dev_node_t) - 			\
+		/*atr*/ MAX_ATR*sizeof(char) - 			\
+		/*rbuf*/ 512*sizeof(char) - 			\
+		/*sbuf*/ 512*sizeof(char) - 			\
+		/*queue*/ 4*sizeof(wait_queue_head_t))
+
+static dev_info_t dev_info =3D MODULE_NAME;
+static dev_link_t *dev_table[CM4000_MAX_DEV] =3D { NULL, };
+
+/* This table doesn't use spaces after the comma between fields and thus
+ * violates CodingStyle.  However, I don't really think wrapping it around=
 will
+ * make it any clearer to read -HW */
+static unsigned char fi_di_table[10][14] =3D {
+/*FI     00   01   02   03   04   05   06   07   08   09   10   11   12   =
13 */
+/*DI */
+/* 0 */ {0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,=
0x11},
+/* 1 */ {0x01,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x91,0x11,0x11,0x11,=
0x11},
+/* 2 */ {0x02,0x12,0x22,0x32,0x11,0x11,0x11,0x11,0x11,0x92,0xA2,0xB2,0x11,=
0x11},
+/* 3 */ {0x03,0x13,0x23,0x33,0x43,0x53,0x63,0x11,0x11,0x93,0xA3,0xB3,0xC3,=
0xD3},
+/* 4 */ {0x04,0x14,0x24,0x34,0x44,0x54,0x64,0x11,0x11,0x94,0xA4,0xB4,0xC4,=
0xD4},
+/* 5 */ {0x00,0x15,0x25,0x35,0x45,0x55,0x65,0x11,0x11,0x95,0xA5,0xB5,0xC5,=
0xD5},
+/* 6 */ {0x06,0x16,0x26,0x36,0x46,0x56,0x66,0x11,0x11,0x96,0xA6,0xB6,0xC6,=
0xD6},
+/* 7 */ {0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,=
0x11},
+/* 8 */ {0x08,0x11,0x28,0x38,0x48,0x58,0x68,0x11,0x11,0x98,0xA8,0xB8,0xC8,=
0xD8},
+/* 9 */ {0x09,0x19,0x29,0x39,0x49,0x59,0x69,0x11,0x11,0x99,0xA9,0xB9,0xC9,=
0xD9}
+};
+
+#if (!defined PCMCIA_DEBUG) || (PCMCIA_DEBUG < 7)
+#define	xoutb	outb
+#define	xinb	inb
+#else
+static inline void xoutb(unsigned char val, unsigned short port)
+{
+	DEBUG(7, "outb(val=3D%.2x,port=3D%.4x)\n", val, port);
+	outb(val, port);
+}
+static inline unsigned char xinb(unsigned short port)
+{
+	unsigned char val;
+
+	val =3D inb(port);
+	DEBUG(7, "%.2x=3Dinb(%.4x)\n", val, port);
+
+	return val;
+}
+#endif
+
+#define	b_0000	15
+#define	b_0001	14
+#define	b_0010	13
+#define	b_0011	12
+#define	b_0100	11
+#define	b_0101	10
+#define	b_0110	9
+#define	b_0111	8
+#define	b_1000	7
+#define	b_1001	6
+#define	b_1010	5
+#define	b_1011	4
+#define	b_1100	3
+#define	b_1101	2
+#define	b_1110	1
+#define	b_1111	0
+
+static unsigned char irtab[16] =3D {
+	b_0000, b_1000, b_0100, b_1100,
+	b_0010, b_1010, b_0110, b_1110,
+	b_0001, b_1001, b_0101, b_1101,
+	b_0011, b_1011, b_0111, b_1111
+};
+
+static void str_invert_revert(unsigned char *b, int len)
+{
+	int i;
+
+	for (i =3D 0; i < len; i++)
+		b[i] =3D (irtab[b[i] & 0x0f] << 4) | irtab[b[i] >> 4];
+}
+
+static unsigned char invert_revert(unsigned char ch)
+{
+	return (irtab[ch & 0x0f] << 4) | irtab[ch >> 4];
+}
+
+#define	ATRLENCK(dev,pos) \
+	if (pos>=3Ddev->atr_len || pos>=3DMAX_ATR) \
+		goto return_0;
+
+/* interruptible_pause() */
+static inline void ipause(unsigned long amount)
+{
+	current->state =3D TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* uninterruptible_pause() */
+static inline void upause(unsigned long amount)
+{
+	current->state =3D TASK_UNINTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+static unsigned int calc_baudv(unsigned char fidi)
+{
+	unsigned int wcrcf, wbrcf, fi_rfu, di_rfu;
+
+	fi_rfu =3D 372;
+	di_rfu =3D 1;
+
+	DEBUG(3, " -> calc_baudv (fidi =3D 0x%.2x)\n", fidi);
+
+	/* FI */
+	switch ((fidi >> 4) & 0x0F) {
+	case 0x00:
+		wcrcf =3D 372;
+		break;
+	case 0x01:
+		wcrcf =3D 372;
+		break;
+	case 0x02:
+		wcrcf =3D 558;
+		break;
+	case 0x03:
+		wcrcf =3D 744;
+		break;
+	case 0x04:
+		wcrcf =3D 1116;
+		break;
+	case 0x05:
+		wcrcf =3D 1488;
+		break;
+	case 0x06:
+		wcrcf =3D 1860;
+		break;
+	case 0x07:
+		wcrcf =3D fi_rfu;
+		break;
+	case 0x08:
+		wcrcf =3D fi_rfu;
+		break;
+	case 0x09:
+		wcrcf =3D 512;
+		break;
+	case 0x0A:
+		wcrcf =3D 768;
+		break;
+	case 0x0B:
+		wcrcf =3D 1024;
+		break;
+	case 0x0C:
+		wcrcf =3D 1536;
+		break;
+	case 0x0D:
+		wcrcf =3D 2048;
+		break;
+	default:
+		wcrcf =3D fi_rfu;
+		break;
+	}
+
+	/* DI */
+	switch (fidi & 0x0F) {
+	case 0x00:
+		wbrcf =3D di_rfu;
+		break;
+	case 0x01:
+		wbrcf =3D 1;
+		break;
+	case 0x02:
+		wbrcf =3D 2;
+		break;
+	case 0x03:
+		wbrcf =3D 4;
+		break;
+	case 0x04:
+		wbrcf =3D 8;
+		break;
+	case 0x05:
+		wbrcf =3D 16;
+		break;
+	case 0x06:
+		wbrcf =3D 32;
+		break;
+	case 0x07:
+		wbrcf =3D di_rfu;
+		break;
+	case 0x08:
+		wbrcf =3D 12;
+		break;
+	case 0x09:
+		wbrcf =3D 20;
+		break;
+	default:
+		wbrcf =3D di_rfu;
+		break;
+	}
+
+	DEBUG(3, "<- calc_baudv returns 0x%.4x\n", (wcrcf / wbrcf));
+	return (wcrcf / wbrcf);
+}
+
+static unsigned short io_read_num_rec_bytes(ioaddr_t iobase, unsigned shor=
t *s)
+{
+	unsigned short tmp;
+
+	tmp =3D *s =3D 0;
+	do {
+		*s =3D tmp;
+		tmp =3D inb(REG_NUM_BYTES(iobase)) |=20
+				(inb(REG_FLAGS0(iobase)) & 4 ? 0x100 : 0);
+	} while (tmp !=3D *s);
+
+	return *s;
+}
+
+static int parse_atr(struct cm4000_dev *dev)
+{
+	unsigned char any_t1, any_t0;
+	unsigned char ch, ifno;
+	int ix, done;
+
+	DEBUG(3, "-> parse_atr: dev->atr_len =3D %i\n", dev->atr_len);
+
+	if (dev->atr_len < 3) {
+		DEBUG(5, "parse_atr: atr_len < 3\n");
+		return 0;
+	}
+
+	if (dev->atr[0] =3D=3D 0x3f)
+		set_bit(IS_INVREV, &dev->flags);
+	else
+		clear_bit(IS_INVREV, &dev->flags);
+	ix =3D 1;
+	ifno =3D 1;
+	ch =3D dev->atr[1];
+	dev->proto =3D 0;		/* XXX PROTO */
+	any_t1 =3D any_t0 =3D done =3D 0;
+	dev->ta1 =3D 0x11;	/* defaults to 9600 baud */
+	do {
+		if (ifno =3D=3D 1 && (ch & 0x10)) {=09
+			/* read first interface byte and TA1 is present */
+			dev->ta1 =3D dev->atr[2];
+			DEBUG(5, "Card says FiDi is 0x%.2x\n", dev->ta1);
+			ifno++;
+		} else if ((ifno =3D=3D 2) && (ch & 0x10)) { /* TA(2) */
+			dev->ta1 =3D 0x11;
+			ifno++;
+		}
+
+		DEBUG(5, "Yi=3D%.2x\n", ch & 0xf0);
+		ix +=3D ((ch & 0x10) >> 4)	/* no of int.face chars */
+		    +((ch & 0x20) >> 5)
+		    + ((ch & 0x40) >> 6)
+		    + ((ch & 0x80) >> 7);
+		/* ATRLENCK(dev,ix); */
+		if (ch & 0x80) {	/* TDi */
+			ch =3D dev->atr[ix];
+			if ((ch & 0x0f)) {
+				any_t1 =3D 1;
+				DEBUG(5, "card is capable of T=3D1\n");
+			} else {
+				any_t0 =3D 1;
+				DEBUG(5, "card is capable of T=3D0\n");
+			}
+		} else
+			done =3D 1;
+	} while (!done);
+
+	DEBUG(5, "ix=3D%d noHist=3D%d any_t1=3D%d\n",
+	      ix, dev->atr[1] & 15, any_t1);
+	if (ix + 1 + (dev->atr[1] & 0x0f) + any_t1 !=3D dev->atr_len) {
+		DEBUG(5, "length error\n");
+		return 0;
+	}
+	if (any_t0)
+		set_bit(IS_ANY_T0, &dev->flags);
+
+	if (any_t1) {		/* compute csum */
+		dev->atr_csum =3D 0;
+#ifdef ATR_CSUM
+		for (i =3D 1; i < dev->atr_len; i++)
+			dev->atr_csum ^=3D dev->atr[i];
+		if (dev->atr_csum) {
+			set_bit(IS_BAD_CSUM, &dev->flags);
+			DEBUG(5, "bad checksum\n");
+			goto return_0;
+		}
+#endif
+		if (any_t0 =3D=3D 0)
+			dev->proto =3D 1;	/* XXX PROTO */
+		set_bit(IS_ANY_T1, &dev->flags);
+	}
+
+	return 1;
+}
+
+struct card_fixup {
+	char atr[12];
+	u_int8_t atr_len;
+	u_int8_t stopbits;
+};
+=09
+static struct card_fixup card_fixups[] =3D {
+	{	/* ACOS */
+		.atr =3D { 0x3b, 0xb3, 0x11, 0x00, 0x00, 0x41, 0x01 },
+		.atr_len =3D 7,
+		.stopbits =3D 0x03,
+	},
+	{	/* Motorola */
+		.atr =3D {0x3b, 0x76, 0x13, 0x00, 0x00, 0x80, 0x62, 0x07,
+			0x41, 0x81, 0x81 },
+		.atr_len =3D 11,
+		.stopbits =3D 0x04,
+	},
+};
+
+static void set_cardparameter(struct cm4000_dev *dev)
+{
+	int i;
+	ioaddr_t iobase =3D dev->link.io.BasePort1;
+	u_int8_t stopbits =3D 0x02; /* ISO default */
+
+	DEBUG(3, "-> set_cardparameter\n");
+
+	dev->flags1 =3D dev->flags1 | (((dev->baudv - 1) & 0x0100) >> 8);
+	xoutb(dev->flags1, REG_FLAGS1(iobase));
+	DEBUG(5, "flags1 =3D 0x%02x\n", dev->flags1);
+
+	/* set baudrate */
+	xoutb((unsigned char)((dev->baudv - 1) & 0xFF), REG_BAUDRATE(iobase));
+
+	DEBUG(5, "baudv =3D %i -> write 0x%02x\n", dev->baudv,
+	      ((dev->baudv - 1) & 0xFF));
+
+	/* set stopbits */
+	for (i =3D 0; i < sizeof(card_fixups)/sizeof(struct card_fixup); i++) {
+		if (!memcmp(dev->atr, card_fixups[i].atr,=20
+			    card_fixups[i].atr_len))
+			stopbits =3D card_fixups[i].stopbits;
+	}
+	xoutb(stopbits, REG_STOPBITS(iobase));
+
+	DEBUG(3, "<- set_cardparameter\n");
+}
+
+static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
+{
+
+	unsigned long tmp, i;
+	unsigned short num_bytes_read;
+	unsigned char pts_reply[4];
+	ssize_t rc;
+	ioaddr_t iobase =3D dev->link.io.BasePort1;
+
+	rc =3D 0;
+
+	DEBUG(3, "-> set_protocol\n");
+	DEBUG(5, "ptsreq->Protocol =3D 0x%.8x, ptsreq->Flags=3D0x%.8x, "
+		 "ptsreq->pts1=3D0x%.2x, ptsreq->pts2=3D0x%.2x, "
+		 "ptsreq->pts3=3D0x%.2x\n", (unsigned int)ptsreq->protocol,
+		 (unsigned int)ptsreq->flags, ptsreq->pts1, ptsreq->pts2,
+		 ptsreq->pts3);
+
+	/* Fill PTS structure */
+	dev->pts[0] =3D 0xff;
+	dev->pts[1] =3D 0x00;
+	tmp =3D ptsreq->protocol;
+	while ((tmp =3D (tmp >> 1)) > 0) {
+		dev->pts[1]++;
+	}
+	dev->proto =3D dev->pts[1];	/* Set new protocol */
+	dev->pts[1] =3D (0x01 << 4) | (dev->pts[1]);
+
+	/* Correct Fi/Di according to CM4000 Fi/Di table */
+	DEBUG(5, "Ta(1) from ATR is 0x%.2x\n", dev->ta1);
+	/* set Fi/Di according to ATR TA(1) */
+	dev->pts[2] =3D fi_di_table[dev->ta1 & 0x0F][(dev->ta1 >> 4) & 0x0F];=09
+
+	/* Calculate PCK character */
+	dev->pts[3] =3D dev->pts[0] ^ dev->pts[1] ^ dev->pts[2];
+
+	DEBUG(5, "pts0=3D%.2x, pts1=3D%.2x, pts2=3D%.2x, pts3=3D%.2x\n", dev->pts=
[0],
+		dev->pts[1], dev->pts[2], dev->pts[3]);
+
+	/* check card convention */
+	if (test_bit(IS_INVREV, &dev->flags))
+		str_invert_revert(dev->pts, 4);
+
+	/* reset SM */
+	xoutb(0x80, REG_FLAGS0(iobase));
+
+	/* Enable access to the message buffer */
+	DEBUG(5, "Enable access to the messages buffer\n");
+	dev->flags1 =3D 0x20	/* T_Active */
+	    | (test_bit(IS_INVREV, &dev->flags) ? 0x02 : 0x00) /* inv parity */
+	    | ((dev->baudv >> 8) & 0x01);	/* MSB-baud */
+	xoutb(dev->flags1, REG_FLAGS1(iobase));
+
+	DEBUG(5, "Enable message buffer -> flags1 =3D 0x%.2x\n", dev->flags1);
+
+	/* write challenge to the buffer */
+	DEBUG(5, "Write challenge to buffer: ");
+	for (i =3D 0; i < 4; i++) {
+		xoutb(i, REG_BUF_ADDR(iobase));
+		xoutb(dev->pts[i], REG_BUF_DATA(iobase));	/* buf data */
+#ifdef PCMCIA_DEBUG
+		if (pc_debug >=3D 5)
+			printk("0x%.2x ", dev->pts[i]);
+#endif
+	}
+	DEBUG(5, "\n");
+
+	/* set number of bytes to write */
+	DEBUG(5, "Set number of bytes to write\n");
+	xoutb(0x04, REG_NUM_SEND(iobase));
+
+	/* Trigger CARDMAN CONTROLLER */
+	xoutb(0x50, REG_FLAGS0(iobase));
+
+	/* Monitor progress */
+	/* wait for xmit done */
+	DEBUG(5, "Waiting for NumRecBytes getting valid\n");
+
+	for (i =3D 0; i < 100; i++) {
+		if (inb(REG_FLAGS0(iobase)) & 0x08) {
+			DEBUG(5, "NumRecBytes is valid\n");
+			break;
+		}
+		mdelay(T_10MSEC);
+	}
+	if (i =3D=3D 100) {
+		DEBUG(5, "Timeout waiting for NumRecBytes getting valid\n");
+		rc =3D -EIO;
+		goto exit_setprotocol;
+	}
+
+	DEBUG(5, "Reading NumRecBytes\n");
+	for (i =3D 0; i < 100; i++) {
+		io_read_num_rec_bytes(iobase, &num_bytes_read);
+		if (num_bytes_read >=3D 4) {
+			DEBUG(2, "NumRecBytes =3D %i\n", num_bytes_read);
+			break;
+		}
+		mdelay(T_10MSEC);
+	}
+
+	/* check whether it is a short PTS reply? */
+	if (num_bytes_read =3D=3D 3)
+		i =3D 0;
+
+	if (i =3D=3D 100) {
+		DEBUG(5, "Timeout reading num_bytes_read\n");
+		rc =3D -EIO;
+		goto exit_setprotocol;
+	}
+
+	DEBUG(5, "Reset the CARDMAN CONTROLLER\n");
+	xoutb(0x80, REG_FLAGS0(iobase));
+
+	/* Read PPS reply */
+	DEBUG(5, "Read PPS reply\n");
+	for (i =3D 0; i < num_bytes_read; i++) {
+		xoutb(i, REG_BUF_ADDR(iobase));
+		pts_reply[i] =3D inb(REG_BUF_DATA(iobase));
+	}
+
+#ifdef PCMCIA_DEBUG
+	DEBUG(2, "PTSreply: ");
+	for (i =3D 0; i < num_bytes_read; i++) {
+		if (pc_debug >=3D 5)
+			printk("0x%.2x ", pts_reply[i]);
+	}
+	printk("\n");
+#endif	/* PCMCIA_DEBUG */
+
+	DEBUG(5, "Clear Tactive in Flags1\n");
+	xoutb(0x20, REG_FLAGS1(iobase));
+
+	/* Compare ptsreq and ptsreply */
+	if ((dev->pts[0] =3D=3D pts_reply[0]) &&
+	    (dev->pts[1] =3D=3D pts_reply[1]) &&
+	    (dev->pts[2] =3D=3D pts_reply[2]) && (dev->pts[3] =3D=3D pts_reply[3]=
)) {
+		/* setcardparameter according to PPS */
+		dev->baudv =3D calc_baudv(dev->pts[2]);
+		set_cardparameter(dev);
+	} else if ((dev->pts[0] =3D=3D pts_reply[0]) &&=20
+		   ((dev->pts[1] & 0xef) =3D=3D pts_reply[1]) &&=20
+		   ((pts_reply[0] ^ pts_reply[1]) =3D=3D pts_reply[2])) {
+		/* short PTS reply, set card parameter to default values */
+		dev->baudv =3D calc_baudv(0x11);
+		set_cardparameter(dev);
+	} else
+		rc =3D -EIO;
+
+exit_setprotocol:
+	DEBUG(3, "<- set_protocol\n");
+	return rc;
+}
+
+static int io_detect_cm4000(ioaddr_t iobase, struct cm4000_dev * dev)
+{
+
+	/* note: statemachine is assumed to be reset */
+	if (inb(REG_FLAGS0(iobase)) & 8) {
+		clear_bit(IS_ATR_VALID, &dev->flags);
+		set_bit(IS_CMM_ABSENT, &dev->flags);
+		return 0;	/* detect CMM =3D 1 -> failure */
+	}
+	/* xoutb(0x40, REG_FLAGS1(iobase)); detectCMM */
+	xoutb(dev->flags1 | 0x40, REG_FLAGS1(iobase));
+	if ((inb(REG_FLAGS0(iobase)) & 8) =3D=3D 0) {
+		clear_bit(IS_ATR_VALID, &dev->flags);
+		set_bit(IS_CMM_ABSENT, &dev->flags);
+		return 0;	/* detect CMM=3D0 -> failure */
+	}
+	/* clear detectCMM again by restoring original flags1 */
+	xoutb(dev->flags1, REG_FLAGS1(iobase));
+	return 1;
+}
+
+static void terminate_monitor(struct cm4000_dev * dev)
+{
+
+	/* tell the monitor to stop and wait until
+	 * it terminates.
+	 */
+	DEBUG(3, "-> terminate_monitor\n");
+	wait_event_interruptible(dev->devq,
+				 test_and_set_bit(LOCK_MONITOR,
+						  (void *)&dev->flags));
+
+	/* now, LOCK_MONITOR has been set.
+	 * allow a last cycle in the monitor.
+	 * the monitor will indicate that it has
+	 * finished by clearing this bit.
+	 */
+	DEBUG(5, "Now allow last cycle of monitor!\n");
+	while (test_bit(LOCK_MONITOR, (void *)&dev->flags)) {
+		upause(T_25MSEC);
+	}
+	DEBUG(5, "Delete timer\n");
+	del_timer(&dev->timer);
+#ifdef PCMCIA_DEBUG
+	dev->monitor_running =3D 0;
+#endif
+
+	DEBUG(3, "<- terminate_monitor\n");
+}
+
+/*
+ * monitor the card every 50msec. as a side-effect, retrieve the
+ * atr once a card is inserted. another side-effect of retrieving the
+ * atr is that the card will be powered on, so there is no need to
+ * power on the card explictely from the application: the driver
+ * is already doing that for you.
+ */
+
+static void monitor_card(unsigned long p)
+{
+	struct cm4000_dev *dev =3D (struct cm4000_dev *) p;
+	ioaddr_t iobase =3D dev->link.io.BasePort1;
+	unsigned short s;
+	struct ptsreq ptsreq;
+	int i, atrc;
+
+	DEBUG(7, "->  monitor_card\n");
+
+	/* if someone has set the lock for us: we're done! */
+	if (test_and_set_bit(LOCK_MONITOR, &dev->flags)) {
+		DEBUG(4, "About to stop monitor\n");
+		/* no */
+		dev->rlen =3D
+		    dev->rpos =3D
+		    dev->atr_csum =3D dev->atr_len_retry =3D dev->cwarn =3D 0;
+		dev->mstate =3D M_FETCH_ATR;
+		clear_bit(LOCK_MONITOR, &dev->flags);
+		/* close et al. are sleeping on devq, so wake it */
+		wake_up_interruptible(&dev->devq);
+		DEBUG(2, "<- monitor_card (we are done now)\n");
+		return;
+	}
+
+	/* try to lock io: if it is already locked, just add another timer */
+	if (test_and_set_bit(LOCK_IO, (void *)&dev->flags)) {
+		DEBUG(4, "monitor_card: Couldn't get IO lock\n");
+		goto return_with_timer;
+	}
+
+	/* is a card/a reader inserted at all ? */
+	dev->flags0 =3D xinb(REG_FLAGS0(iobase));
+	DEBUG(7, "dev->flags0 =3D 0x%2x\n", dev->flags0);
+	DEBUG(7, "smartcard present: %s\n", dev->flags0 & 1 ? "yes" : "no");
+	DEBUG(7, "cardman present: %s\n", dev->flags0 =3D=3D 0xff ? "no" : "yes");
+
+	if ((dev->flags0 & 1) =3D=3D 0	/* no smartcard inserted */
+	    || dev->flags0 =3D=3D 0xff) {	/* no cardman inserted */
+		/* no */
+		dev->rlen =3D
+		    dev->rpos =3D
+		    dev->atr_csum =3D dev->atr_len_retry =3D dev->cwarn =3D 0;
+		dev->mstate =3D M_FETCH_ATR;
+
+		dev->flags &=3D 0x000000ff; /* only keep IO and MONITOR locks */
+
+		if (dev->flags0 =3D=3D 0xff) {
+			DEBUG(4, "set IS_CMM_ABSENT bit\n");
+			set_bit(IS_CMM_ABSENT, &dev->flags);
+		} else if (test_bit(IS_CMM_ABSENT, &dev->flags)) {
+			DEBUG(4, "clear IS_CMM_ABSENT bit (card is removed)\n");
+			clear_bit(IS_CMM_ABSENT, &dev->flags);
+		}
+
+		goto release_io;
+	} else if ((dev->flags0 & 1) && test_bit(IS_CMM_ABSENT, &dev->flags)) {
+		/* cardman and card present but cardman was absent before
+		 * (after suspend with inserted card) */
+		DEBUG(4, "clear IS_CMM_ABSENT bit (card is inserted)\n");
+		clear_bit(IS_CMM_ABSENT, &dev->flags);
+	}
+
+	if (test_bit(IS_ATR_VALID, &dev->flags) =3D=3D 1) {
+		DEBUG(7, "believe ATR is already valid (do nothing)\n");
+		goto release_io;
+	}
+
+	switch (dev->mstate) {
+		unsigned char flags0;
+	case M_CARDOFF:
+		DEBUG(4, "M_CARDOFF\n");
+		flags0 =3D inb(REG_FLAGS0(iobase));
+		if (flags0 & 0x02) {=09
+			/* wait until Flags0 indicate power is off */
+			dev->mdelay =3D T_10MSEC;
+		} else {
+			/* Flags0 indicate power off and no card inserted now;
+			 * Reset CARDMAN CONTROLLER */
+			xoutb(0x80, REG_FLAGS0(iobase));
+
+			/* prepare for fetching ATR again: after card off ATR
+			 * is read again automatically */
+			dev->rlen =3D
+			    dev->rpos =3D
+			    dev->atr_csum =3D
+			    dev->atr_len_retry =3D dev->cwarn =3D 0;
+			dev->mstate =3D M_FETCH_ATR;
+
+			/* minimal gap between CARDOFF and read ATR is 50msec */
+			dev->mdelay =3D T_50MSEC;
+		}
+		break;
+	case M_FETCH_ATR:
+		DEBUG(4, "M_FETCH_ATR\n");
+		xoutb(0x80, REG_FLAGS0(iobase));
+		DEBUG(4, "Reset BAUDV to 9600\n");
+		dev->baudv =3D 0x173;	/* 9600 */
+		xoutb(0x02, REG_STOPBITS(iobase));	/* stopbits=3D2 */
+		xoutb(0x73, REG_BAUDRATE(iobase));	/* baud value */
+		xoutb(0x21, REG_FLAGS1(iobase));	/* T_Active=3D1, baud
+							   value */
+		/* warm start vs. power on: */
+		xoutb(dev->flags0 & 2 ? 0x46 : 0x44, REG_FLAGS0(iobase));
+		dev->mdelay =3D T_40MSEC;
+		dev->mstate =3D M_TIMEOUT_WAIT;
+		break;
+	case M_TIMEOUT_WAIT:
+		DEBUG(4, "M_TIMEOUT_WAIT\n");
+		/* numRecBytes */
+		io_read_num_rec_bytes(iobase, &dev->atr_len);
+		dev->mdelay =3D T_10MSEC;
+		dev->mstate =3D M_READ_ATR_LEN;
+		break;
+	case M_READ_ATR_LEN:
+		DEBUG(4, "M_READ_ATR_LEN\n");
+		/* infinite loop possible, since there is no timeout */
+
+#define	MAX_ATR_LEN_RETRY	100
+
+		if (dev->atr_len =3D=3D io_read_num_rec_bytes(iobase, &s)) {
+			if (dev->atr_len_retry++ >=3D MAX_ATR_LEN_RETRY) {					/* + XX msec */
+				dev->mdelay =3D T_10MSEC;
+				dev->mstate =3D M_READ_ATR;
+			}
+		} else {
+			dev->atr_len =3D s;
+			dev->atr_len_retry =3D 0;	/* set new timeout */
+		}
+
+		DEBUG(4, "Current ATR_LEN =3D %i\n", dev->atr_len);
+		break;
+	case M_READ_ATR:
+		DEBUG(4, "M_READ_ATR\n");
+		xoutb(0x80, REG_FLAGS0(iobase));	/* reset SM */
+		for (i =3D 0; i < dev->atr_len; i++) {
+			xoutb(i, REG_BUF_ADDR(iobase));
+			dev->atr[i] =3D inb(REG_BUF_DATA(iobase));
+		}
+		/* Deactivate T_Active flags */
+		DEBUG(4, "Deactivate T_Active flags\n");
+		dev->flags1 =3D 0x01;
+		xoutb(dev->flags1, REG_FLAGS1(iobase));
+
+		/* atr is present (which doesnt mean it's valid) */
+		set_bit(IS_ATR_PRESENT, &dev->flags);
+		if (dev->atr[0] =3D=3D 0x03)
+			str_invert_revert(dev->atr, dev->atr_len);
+		atrc =3D parse_atr(dev);
+		if (atrc =3D=3D 0) {	/* atr invalid */
+			dev->mdelay =3D 0;
+			dev->mstate =3D M_BAD_CARD;
+		} else {
+			dev->mdelay =3D T_50MSEC;
+			dev->mstate =3D M_ATR_PRESENT;
+			set_bit(IS_ATR_VALID, &dev->flags);
+		}
+
+		if (test_bit(IS_ATR_VALID, &dev->flags) =3D=3D 1) {
+			DEBUG(4, "monitor_card: ATR valid\n");
+ 			/* if ta1 =3D=3D 0x11, no PPS necessary (default values) */
+			/* do not do PPS with multi protocol cards */
+			if ((test_bit(IS_AUTOPPS_ACT, &dev->flags) =3D=3D 0) &&=20
+			    (dev->ta1 !=3D 0x11) &&
+			    !(test_bit(IS_ANY_T0, &dev->flags) &&=20
+			    test_bit(IS_ANY_T1, &dev->flags))) {
+				DEBUG(4, "Perform AUTOPPS\n");
+				set_bit(IS_AUTOPPS_ACT, &dev->flags);
+				ptsreq.protocol =3D ptsreq.protocol =3D
+				    (0x01 << dev->proto);
+				ptsreq.flags =3D 0x01;
+				ptsreq.pts1 =3D 0x00;
+				ptsreq.pts2 =3D 0x00;
+				ptsreq.pts3 =3D 0x00;
+				if (set_protocol(dev, &ptsreq) =3D=3D 0) {
+					DEBUG(4, "AUTOPPS returns SUCC\n");
+					clear_bit(IS_AUTOPPS_ACT, &dev->flags);
+					wake_up_interruptible(&dev->atrq);
+				} else {
+					DEBUG(4, "AUTOPPS failed: repower "
+						"using defaults\n");
+					/* prepare for repowering  */
+					clear_bit(IS_ATR_PRESENT, &dev->flags);
+					clear_bit(IS_ATR_VALID, &dev->flags);
+					dev->rlen =3D
+					    dev->rpos =3D
+					    dev->atr_csum =3D
+					    dev->atr_len_retry =3D dev->cwarn =3D 0;
+					dev->mstate =3D M_FETCH_ATR;
+
+					dev->mdelay =3D T_50MSEC;
+				}
+			} else {
+				/* for cards which use slightly different
+				 * params (extra guard time) */
+				set_cardparameter(dev);=09
+				if (test_bit(IS_AUTOPPS_ACT, &dev->flags) =3D=3D 1)
+					DEBUG(4, "AUTOPPS already active "
+					      "(2nd try:use default values)\n");
+				if (dev->ta1 =3D=3D 0x11)
+					DEBUG(4, "No AUTOPPS necessary "
+						"TA(1)=3D=3D0x11\n");
+				if (test_bit(IS_ANY_T0, &dev->flags)
+				    && test_bit(IS_ANY_T1, &dev->flags))
+					DEBUG(4, "Do NOT perform AUTOPPS "
+						"with multiprotocol cards\n");
+				clear_bit(IS_AUTOPPS_ACT, &dev->flags);
+				wake_up_interruptible(&dev->atrq);
+			}
+		} else {
+			DEBUG(4, "ATR invalid\n");
+			wake_up_interruptible(&dev->atrq);
+		}
+		break;
+	case M_BAD_CARD:
+		DEBUG(4, "M_BAD_CARD\n");
+		/* slow down warning, but prompt immediately after insertion */
+		if (dev->cwarn =3D=3D 0 || dev->cwarn =3D=3D 10) {
+			set_bit(IS_BAD_CARD, &dev->flags);
+			printk(KERN_WARNING MODULE_NAME ": device %s: ",
+			       dev->node.dev_name);
+			if (test_bit(IS_BAD_CSUM, &dev->flags)) {
+				DEBUG(4, "ATR checksum (0x%.2x, should be "
+					"zero) failed\n", dev->atr_csum);
+			}
+#ifdef PCMCIA_DEBUG
+			else if (test_bit(IS_BAD_LENGTH, &dev->flags)) {
+				DEBUG(4, "ATR length error\n");
+			} else {
+				DEBUG(4, "card damaged or wrong way "
+					"inserted\n");
+			}
+#endif
+			dev->cwarn =3D 0;
+			wake_up_interruptible(&dev->atrq);	/* wake open */
+		}
+		dev->cwarn++;
+		dev->mdelay =3D T_100MSEC;
+		dev->mstate =3D M_FETCH_ATR;
+		break;
+	default:
+		DEBUG(7, "monitor_card: Unknown action\n");
+		break;		/* nothing */
+	}
+
+release_io:
+	DEBUG(7, "release_io\n");
+	clear_bit(LOCK_IO, &dev->flags);
+	wake_up_interruptible(&dev->ioq);	/* whoever needs IO */
+
+return_with_timer:
+	DEBUG(7, "<- monitor_card (returns with timer)\n");
+	dev->timer.expires =3D jiffies + dev->mdelay;
+	add_timer(&dev->timer);
+	clear_bit(LOCK_MONITOR, &dev->flags);
+}
+
+/* Interface to userland (file_operations) */
+
+static ssize_t cmm_read(struct file *filp, __user char *buf, size_t count,
+			loff_t *ppos)
+{
+	struct cm4000_dev *dev =3D (struct cm4000_dev *) filp->private_data;
+	ioaddr_t iobase =3D dev->link.io.BasePort1;
+	ssize_t rc;
+	int i, j, k;
+
+	DEBUG(2, "-> cmm_read(%s,%d)\n", current->comm, current->pid);
+
+	if (count =3D=3D 0)		/* according to manpage */
+		return 0;
+
+	if ((dev->link.state & DEV_PRESENT) =3D=3D 0 ||	/* socket removed */
+	    test_bit(IS_CMM_ABSENT, &dev->flags))
+		return -ENODEV;
+
+	if (test_bit(IS_BAD_CSUM, &dev->flags))
+		return -EIO;
+
+	/* also see the note about this in cmm_write */
+	if (wait_event_interruptible
+	    (dev->atrq,
+	     ((filp->f_flags & O_NONBLOCK)
+	      || (test_bit(IS_ATR_PRESENT, (void *)&dev->flags) !=3D 0)))) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		return -ERESTARTSYS;
+	}
+
+	if (test_bit(IS_ATR_VALID, &dev->flags) =3D=3D 0)
+		return -EIO;
+
+	/* this one implements blocking IO */
+	if (wait_event_interruptible
+	    (dev->readq,
+	     ((filp->f_flags & O_NONBLOCK) || (dev->rpos < dev->rlen)))) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		return -ERESTARTSYS;
+	}
+
+	/* lock io */
+	if (wait_event_interruptible
+	    (dev->ioq,
+	     ((filp->f_flags & O_NONBLOCK)
+	      || (test_and_set_bit(LOCK_IO, (void *)&dev->flags) =3D=3D 0)))) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		return -ERESTARTSYS;
+	}
+
+	rc =3D 0;
+	dev->flags0 =3D inb(REG_FLAGS0(iobase));
+	if ((dev->flags0 & 1) =3D=3D 0	/* no smartcard inserted */
+	    || dev->flags0 =3D=3D 0xff) {	/* no cardman inserted */
+		clear_bit(IS_ATR_VALID, &dev->flags);
+		if (dev->flags0 & 1) {
+			set_bit(IS_CMM_ABSENT, &dev->flags);
+			rc =3D -ENODEV;
+		}
+		rc =3D -EIO;
+		goto release_io;
+	}
+
+	DEBUG(4, "cm4000_cs: begin read answer\n");
+	j =3D min(count, (size_t)(dev->rlen - dev->rpos));
+	k =3D dev->rpos;
+	if (k + j > 255)
+		j =3D 256 - k;
+	DEBUG(4, "cm4000_cs: read1 j=3D%d\n", j);
+	for (i =3D 0; i < j; i++) {
+		xoutb(k++, REG_BUF_ADDR(iobase));
+		dev->rbuf[i] =3D xinb(REG_BUF_DATA(iobase));
+	}
+	j =3D min(count, (size_t)(dev->rlen - dev->rpos));
+	if (k + j > 255) {
+		DEBUG(4, "cm4000_cs: read2 j=3D%d\n", j);
+		dev->flags1 |=3D 0x10;	/* MSB buf addr set */
+		xoutb(dev->flags1, REG_FLAGS1(iobase));
+		for (; i < j; i++) {
+			xoutb(k++, REG_BUF_ADDR(iobase));
+			dev->rbuf[i] =3D xinb(REG_BUF_DATA(iobase));
+		}
+	}
+
+	if (dev->proto =3D=3D 0 && count > dev->rlen - dev->rpos) {
+		DEBUG(4, "T=3D0 and count > buffer\n");
+		dev->rbuf[i] =3D dev->rbuf[i - 1];
+		dev->rbuf[i - 1] =3D dev->procbyte;
+		j++;
+	}
+	count =3D j;
+
+	dev->rpos =3D dev->rlen + 1;
+
+	/* Clear T1Active */
+	DEBUG(4, "Clear T1Active\n");
+	dev->flags1 &=3D 0xdf;
+	xoutb(dev->flags1, REG_FLAGS1(iobase));
+
+	xoutb(0, REG_FLAGS1(iobase));	/* clear detectCMM */
+	/* last check before exit */
+	if (!io_detect_cm4000(iobase, dev))
+		count =3D -ENODEV;
+
+	if (test_bit(IS_INVREV, &dev->flags) && count > 0)
+		str_invert_revert(dev->rbuf, count);
+
+	if (copy_to_user(buf, dev->rbuf, count))
+		return -EFAULT;
+
+release_io:
+	clear_bit(LOCK_IO, &dev->flags);
+	wake_up_interruptible(&dev->ioq);
+
+	DEBUG(2, "<- cmm_read returns: rc =3D %Zi\n", (rc < 0 ? rc : count));
+	return rc < 0 ? rc : count;
+}
+
+static ssize_t cmm_write(struct file *filp, const char __user *buf,=20
+			 size_t count, loff_t *ppos)
+{
+	struct cm4000_dev *dev =3D (struct cm4000_dev *) filp->private_data;
+	ioaddr_t iobase =3D dev->link.io.BasePort1;
+	unsigned short s;
+	unsigned char tmp;
+	unsigned char infolen;
+	unsigned char sendT0;
+	unsigned short nsend;
+	unsigned short nr;
+	ssize_t rc;
+	int i;
+
+	DEBUG(2, "-> cmm_write(%s,%d)\n", current->comm, current->pid);
+
+	if (count =3D=3D 0)		/* according to manpage */
+		return 0;
+
+	if (dev->proto =3D=3D 0 && count < 4) {
+		/* T0 must have at least 4 bytes */
+		DEBUG(4, "T0 short write\n");
+		return -EIO;
+	}
+
+	nr =3D count & 0x1ff;	/* max bytes to write */
+
+	sendT0 =3D dev->proto ? 0 : nr > 5 ? 0x08 : 0;
+
+	if ((dev->link.state & DEV_PRESENT) =3D=3D 0 ||	/* socket removed */
+	    test_bit(IS_CMM_ABSENT, &dev->flags))
+		return -ENODEV;
+
+	if (test_bit(IS_BAD_CSUM, &dev->flags)) {
+		DEBUG(4, "bad csum\n");
+		return -EIO;
+	}
+
+	/*
+	 * wait for atr to become valid.
+	 * note: it is important to lock this code. if we dont, the monitor
+	 * could be run between test_bit and the the call the sleep on the
+	 * atr-queue.  if *then* the monitor detects atr valid, it will wake up
+	 * any process on the atr-queue, *but* since we have been interrupted,
+	 * we do not yet sleep on this queue. this would result in a missed
+	 * wake_up and the calling process would sleep forever (until
+	 * interrupted).  also, do *not* restore_flags before sleep_on, because
+	 * this could result in the same situation!
+	 */
+	if (wait_event_interruptible
+	    (dev->atrq,
+	     ((filp->f_flags & O_NONBLOCK)
+	      || (test_bit(IS_ATR_PRESENT, (void *)&dev->flags) !=3D 0)))) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		return -ERESTARTSYS;
+	}
+
+	if (test_bit(IS_ATR_VALID, &dev->flags) =3D=3D 0) {	/* invalid atr */
+		DEBUG(4, "invalid ATR\n");
+		return -EIO;
+	}
+
+	/* lock io */
+	if (wait_event_interruptible
+	    (dev->ioq,
+	     ((filp->f_flags & O_NONBLOCK)
+	      || (test_and_set_bit(LOCK_IO, (void *)&dev->flags) =3D=3D 0)))) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		return -ERESTARTSYS;
+	}
+
+	if (copy_from_user(dev->sbuf, buf, ((count > 512) ? 512 : count)))
+		return -EFAULT;
+
+	rc =3D 0;
+	dev->flags0 =3D inb(REG_FLAGS0(iobase));
+	if ((dev->flags0 & 1) =3D=3D 0	/* no smartcard inserted */
+	    || dev->flags0 =3D=3D 0xff) {	/* no cardman inserted */
+		clear_bit(IS_ATR_VALID, &dev->flags);
+		if (dev->flags0 & 1) {
+			set_bit(IS_CMM_ABSENT, &dev->flags);
+			rc =3D -ENODEV;
+		} else {
+			DEBUG(4, "IO error\n");
+			rc =3D -EIO;
+		}
+		goto release_io;
+	}
+
+	xoutb(0x80, REG_FLAGS0(iobase));	/* reset SM  */
+
+	if (!io_detect_cm4000(iobase, dev)) {
+		rc =3D -ENODEV;
+		goto release_io;
+	}
+
+	/* reflect T=3D0 send/read mode in flags1 */
+	dev->flags1 |=3D (sendT0);
+
+	set_cardparameter(dev);
+
+	/* dummy read, reset flag procedure received */
+	tmp =3D inb(REG_FLAGS1(iobase));
+
+	dev->flags1 =3D 0x20	/* T_Active */
+	    | (sendT0)
+	    | (test_bit(IS_INVREV, &dev->flags) ? 2 : 0)/* inverse parity  */
+	    | (((dev->baudv - 1) & 0x0100) >> 8);	/* MSB-Baud */
+	DEBUG(1, "set dev->flags1 =3D 0x%.2x\n", dev->flags1);
+	xoutb(dev->flags1, REG_FLAGS1(iobase));
+
+	/* xmit data */
+	DEBUG(4, "Xmit data\n");
+	for (i =3D 0; i < nr; i++) {
+		if (i >=3D 256) {
+			dev->flags1 =3D 0x20	/* T_Active */
+			    | (sendT0)	/* SendT0 */
+			    | (test_bit(IS_INVREV, &dev->flags) ? 2 : 0)/* inverse parity */
+			    | (((dev->baudv - 1) & 0x0100) >> 8) /* MSB-Baud */
+			    | 0x10;	/* set address high */
+			DEBUG(4, "dev->flags =3D 0x%.2x - set address high\n",
+			      dev->flags1);
+			xoutb(dev->flags1, REG_FLAGS1(iobase));
+		}
+		if (test_bit(IS_INVREV, &dev->flags)) {
+			DEBUG(4, "Apply inverse convention for 0x%.2x "
+				"-> 0x%.2x\n", (unsigned char)dev->sbuf[i],
+			      invert_revert(dev->sbuf[i]));
+			xoutb(i, REG_BUF_ADDR(iobase));
+			xoutb(invert_revert(dev->sbuf[i]),
+			      REG_BUF_DATA(iobase));
+		} else {
+			xoutb(i, REG_BUF_ADDR(iobase));
+			xoutb(dev->sbuf[i], REG_BUF_DATA(iobase));
+		}
+	}
+	DEBUG(4, "Xmit done\n");
+
+	if (dev->proto =3D=3D 0) {
+		/* T=3D0 proto: 0 byte reply  */
+		if (nr =3D=3D 4) {
+			DEBUG(4, "T=3D0 assumes 0 byte reply\n");
+			xoutb(i, REG_BUF_ADDR(iobase));
+			if (test_bit(IS_INVREV, &dev->flags))
+				xoutb(0xff, REG_BUF_DATA(iobase));
+			else
+				xoutb(0x00, REG_BUF_DATA(iobase));
+		}
+
+		/* numSendBytes */
+		if (sendT0)
+			nsend =3D nr;
+		else {
+			if (nr =3D=3D 4)
+				nsend =3D 5;
+			else {
+				nsend =3D 5 + (unsigned char)dev->sbuf[4];
+				if (dev->sbuf[4] =3D=3D 0)
+					nsend +=3D 0x100;
+			}
+		}
+	} else
+		nsend =3D nr;
+
+	/* T0: output procedure byte */
+	if (test_bit(IS_INVREV, &dev->flags)) {
+		DEBUG(4, "T=3D0 set Procedure byte (inverse-reverse) 0x%.2x \n",
+		      invert_revert(dev->sbuf[1]));
+		xoutb(invert_revert(dev->sbuf[1]), REG_NUM_BYTES(iobase));
+	} else {
+		DEBUG(4, "T=3D0 set Procedure byte 0x%.2x\n", dev->sbuf[1]);
+		xoutb(dev->sbuf[1], REG_NUM_BYTES(iobase));
+	}
+
+	DEBUG(1, "set NumSendBytes =3D 0x%.2x\n", (unsigned char)(nsend & 0xff));
+	xoutb((unsigned char)(nsend & 0xff), REG_NUM_SEND(iobase));
+
+	DEBUG(1, "Trigger CARDMAN CONTROLLER (0x%.2x)\n", 0x40	/* SM_Active */
+	      | (dev->flags0 & 2 ? 0 : 4)	/* power on if needed */
+	      |(dev->proto ? 0x10 : 0x08)	/* T=3D1/T=3D0 */
+	      |(nsend & 0x100) >> 8 /* MSB numSendBytes */ );
+	xoutb(0x40		/* SM_Active */
+	      | (dev->flags0 & 2 ? 0 : 4)	/* power on if needed */
+	      |(dev->proto ? 0x10 : 0x08)	/* T=3D1/T=3D0 */
+	      |(nsend & 0x100) >> 8,	/* MSB numSendBytes */
+	      REG_FLAGS0(iobase));
+
+	/* wait for xmit done */
+	if (dev->proto =3D=3D 1) {
+		DEBUG(4, "Wait for xmit done\n");
+		for (i =3D 0; i < 1000; i++) {
+			if (inb(REG_FLAGS0(iobase)) & 0x08)
+				break;
+			ipause(T_10MSEC);
+		}
+		if (i =3D=3D 1000) {
+			DEBUG(4, "timeout waiting for xmit done\n");
+			rc =3D -EIO;
+			goto release_io;
+		}
+	}
+
+	/* T=3D1: wait for infoLen */
+
+	infolen =3D 0;
+	if (dev->proto) {
+		/* wait until infoLen is valid */
+		for (i =3D 0; i < 6000; i++) {	/* max waiting time of 1 min */
+			io_read_num_rec_bytes(iobase, &s);
+			if (s >=3D 3) {
+				infolen =3D inb(REG_FLAGS1(iobase));
+				DEBUG(4, "infolen=3D%d\n", infolen);
+				break;
+			}
+			ipause(T_10MSEC);
+		}
+		if (i =3D=3D 6000) {
+			DEBUG(4, " timeout waiting for infoLen\n");
+			rc =3D -EIO;
+			goto release_io;
+		}
+	} else
+		clear_bit(IS_PROCBYTE_PRESENT, &dev->flags);
+
+	/* numRecBytes | bit9 of numRecytes */
+	io_read_num_rec_bytes(iobase, &dev->rlen);
+	for (i =3D 0; i < 600; i++) {	/* max waiting time of 2 sec */
+		if (dev->proto) {
+			if (dev->rlen >=3D infolen + 4)
+				break;
+		}
+		ipause(T_10MSEC);
+		/* numRecBytes | bit9 of numRecytes */
+		io_read_num_rec_bytes(iobase, &s);
+		if (s > dev->rlen) {
+			DEBUG(1, "NumRecBytes incremented (reset timeout)\n");
+			i =3D 0;	/* reset timeout */
+			dev->rlen =3D s;
+		}
+		/* T=3D0: we are done when numRecBytes doesn't
+		 *      increment any more and NoProcedureByte
+		 *      is set and numRecBytes =3D=3D bytes sent + 6
+		 *      (header bytes + data + 1 for sw2)
+		 *      except when the card replies an error
+		 *      which means, no data will be sent back.
+		 */
+		else {
+			if (dev->proto =3D=3D 0) {
+				if ((inb(REG_BUF_ADDR(iobase)) & 0x80)) {
+					/* no procedure byte received since
+					 * last read */
+					DEBUG(1, "NoProcedure byte set\n");
+					/* i=3D0; */
+				} else {
+					/* procedure byte received since last
+					 * read */
+					DEBUG(1, "NoProcedure byte unset "
+						"(reset timeout)\n");
+					dev->procbyte =3D inb(REG_FLAGS1(iobase));
+					DEBUG(1, "Read procedure byte 0x%.2x\n",
+					      dev->procbyte);
+					i =3D 0;	/* resettimeout */
+				}
+			}
+			if ((dev->proto =3D=3D 0)=20
+			    && (inb(REG_FLAGS0(iobase)) & 0x08)) {
+				DEBUG(1, "T0Done flag set (read reply)\n");
+				break;
+			}
+		}
+		if (dev->proto)
+			infolen =3D inb(REG_FLAGS1(iobase));
+	}
+	if (i =3D=3D 600) {
+		DEBUG(1, "timeout waiting for numRecBytes\n");
+		rc =3D -EIO;
+		goto release_io;
+	} else {
+		if (dev->proto =3D=3D 0) {
+			DEBUG(1, "Wait for T0Done bit to be  set\n");
+			for (i =3D 0; i < 1000; i++) {
+				if (inb(REG_FLAGS0(iobase)) & 0x08)
+					break;
+				ipause(T_10MSEC);
+			}
+			if (i =3D=3D 1000) {
+				DEBUG(1, "timeout waiting for T0Done\n");
+				rc =3D -EIO;
+				goto release_io;
+			}
+
+			dev->procbyte =3D inb(REG_FLAGS1(iobase));
+			DEBUG(4, "Read procedure byte 0x%.2x\n",
+			      dev->procbyte);
+
+			io_read_num_rec_bytes(iobase, &dev->rlen);
+			DEBUG(4, "Read NumRecBytes =3D %i\n", dev->rlen);
+
+		}
+	}
+	/* T=3D1: read offset=3Dzero, T=3D0: read offset=3Dafter challenge */
+	dev->rpos =3D dev->proto ? 0 : nr =3D=3D 4 ? 5 : nr > dev->rlen ? 5 : nr;
+	DEBUG(4, "dev->rlen =3D %i,  dev->rpos =3D %i, nr =3D %i\n",
+	      dev->rlen, dev->rpos, nr);
+
+release_io:
+	DEBUG(4, "Reset SM\n");
+	xoutb(0x80, REG_FLAGS0(iobase));	/* reset SM */
+
+	if (rc < 0) {
+		DEBUG(4, "Write failed but clear T_Active\n");
+		dev->flags1 &=3D 0xdf;
+		xoutb(dev->flags1, REG_FLAGS1(iobase));
+	}
+
+	clear_bit(LOCK_IO, &dev->flags);
+	wake_up_interruptible(&dev->ioq);
+	wake_up_interruptible(&dev->readq);	/* tell read we have data */
+
+	/* ITSEC E2: clear write buffer */
+	memset((char *)dev->sbuf, 0, 512);
+
+	/* return error or actually written bytes */
+	DEBUG(2, "<- cmm_write\n");
+	return rc < 0 ? rc : nr;
+}
+
+static void start_monitor(struct cm4000_dev *dev)
+{
+	DEBUG(3, "-> start_monitor\n");
+	if (!dev->monitor_running) {
+		DEBUG(5, "create, init and add timer\n");
+		init_timer(&dev->timer);
+		dev->monitor_running =3D 1;
+		dev->timer.expires =3D jiffies;
+		dev->timer.data =3D (unsigned long) dev;
+		dev->timer.function =3D monitor_card;
+		add_timer(&dev->timer);
+	} else
+		DEBUG(5, "monitor already running\n");
+	DEBUG(3, "<- start_monitor\n");
+}
+
+static void stop_monitor(struct cm4000_dev *dev)
+{
+	DEBUG(3, "-> stop_monitor\n");
+	if (dev->monitor_running) {
+		DEBUG(5, "stopping monitor\n");
+		terminate_monitor(dev);
+		/* reset monitor SM */
+		clear_bit(IS_ATR_VALID, &dev->flags);
+		clear_bit(IS_ATR_PRESENT, &dev->flags);
+	} else
+		DEBUG(5, "monitor already stopped\n");
+	DEBUG(3, "<- stop_monitor\n");
+}
+
+static int cmm_ioctl(struct inode *inode, struct file *filp, unsigned int =
cmd,
+		     unsigned long arg)
+{
+	struct cm4000_dev *dev =3D (struct cm4000_dev *) filp->private_data;
+	ioaddr_t iobase =3D dev->link.io.BasePort1;
+	dev_link_t *link;
+	int size;
+	int rc;
+#ifdef PCMCIA_DEBUG
+	char *ioctl_names[CM_IOC_MAXNR + 1] =3D {
+		[_IOC_NR(CM_IOCGSTATUS)] "CM_IOCGSTATUS",
+		[_IOC_NR(CM_IOCGATR)] "CM_IOCGATR",
+		[_IOC_NR(CM_IOCARDOFF)] "CM_IOCARDOFF",
+		[_IOC_NR(CM_IOCSPTS)] "CM_IOCSPTS",
+		[_IOC_NR(CM_IOSDBGLVL)] "CM4000_DBGLVL",
+		[_IOC_NR(CM4000_IOCMONITOR)] "CM4000_IOCMONITOR",
+		[_IOC_NR(CM4000_IOCDUMPATR)] "CM4000_IOCDUMPATR",
+		[_IOC_NR(CM4000_IOCDECUSECOUNT)] "CM4000_IOCDECUSECOUNT",
+		[_IOC_NR(CM4000_IOCPOWERON)] "CM4000_IOCPOWERON",
+		[_IOC_NR(CM4000_IOCGIOADDR)] "CM4000_IOCGIOADDR",
+	};
+#endif
+	DEBUG(3, "cmm_ioctl(device=3D%d.%d process=3D%s,%d) %s\n",
+	      MAJOR(inode->i_rdev), MINOR(inode->i_rdev),
+	      dev->owner->comm, dev->owner->pid, ioctl_names[_IOC_NR(cmd)]);
+
+	link =3D dev_table[MINOR(inode->i_rdev)];
+	if (!(DEV_OK(link))) {
+		DEBUG(4, "DEV_OK false\n");
+		return -ENODEV;
+	}
+
+	if (test_bit(IS_CMM_ABSENT, &dev->flags)) {
+		DEBUG(4, "CMM_ABSENT flag set\n");
+		return -ENODEV;
+	}
+
+	if (_IOC_TYPE(cmd) !=3D CM_IOC_MAGIC) {
+		DEBUG(4, "ioctype mismatch\n");
+		return -EINVAL;
+	}
+	if (_IOC_NR(cmd) > CM_IOC_MAXNR) {
+		DEBUG(4, "iocnr mismatch\n");
+		return -EINVAL;
+	}
+	size =3D _IOC_SIZE(cmd);
+	rc =3D 0;
+	DEBUG(4, "iocdir=3D%.4x iocr=3D%.4x iocw=3D%.4x iocsize=3D%d cmd=3D%.4x\n=
",
+	      _IOC_DIR(cmd), _IOC_READ, _IOC_WRITE, size, cmd);
+
+	if (_IOC_DIR(cmd) & _IOC_READ) {
+		if (!access_ok(VERIFY_WRITE, (void *)arg, size))
+			return -EFAULT;
+	}
+	if (_IOC_DIR(cmd) & _IOC_WRITE) {
+		if (!access_ok(VERIFY_READ, (void *)arg, size))
+			return -EFAULT;
+	}
+
+	switch (cmd) {
+	case CM_IOCGSTATUS:
+		DEBUG(4, " ... in CM_IOCGSTATUS\n");
+		{
+			int status;
+
+			/* clear other bits, but leave inserted & powered as
+			 * they are */
+			status =3D dev->flags0 & 3;
+			if (test_bit(IS_ATR_PRESENT, &dev->flags))
+				status |=3D CM_ATR_PRESENT;
+			if (test_bit(IS_ATR_VALID, &dev->flags))
+				status |=3D CM_ATR_VALID;
+			if (test_bit(IS_CMM_ABSENT, &dev->flags))
+				status |=3D CM_NO_READER;
+			if (test_bit(IS_BAD_CARD, &dev->flags))
+				status |=3D CM_BAD_CARD;
+			if (copy_to_user((int *)arg, &status, sizeof(int)))
+				return -EFAULT;
+		}
+		return 0;
+	case CM_IOCGATR:
+		DEBUG(4, "... in CM_IOCGATR\n");
+		{
+			struct atreq *atreq =3D (struct atreq *) arg;
+			int tmp;
+			/* allow nonblocking io and being interrupted */
+			if (wait_event_interruptible
+			    (dev->atrq,
+			     ((filp->f_flags & O_NONBLOCK)
+			      || (test_bit(IS_ATR_PRESENT, (void *)&dev->flags)
+				  !=3D 0)))) {
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				return -ERESTARTSYS;
+			}
+
+			if (test_bit(IS_ATR_VALID, &dev->flags) =3D=3D 0) {
+				tmp =3D -1;
+				if (copy_to_user(&(atreq->atr_len), &tmp,=20
+						 sizeof(int)))
+					return -EFAULT;
+			} else {
+				if (copy_to_user(atreq->atr, dev->atr,
+						 dev->atr_len))
+					return -EFAULT;
+
+				tmp =3D dev->atr_len;
+				if (copy_to_user(&(atreq->atr_len), &tmp, sizeof(int)))
+					return -EFAULT;
+			}
+			return 0;
+		}
+	case CM_IOCARDOFF:
+
+#ifdef PCMCIA_DEBUG
+		DEBUG(4, "... in CM_IOCARDOFF\n");
+		if (dev->flags0 & 0x01) {
+			DEBUG(4, "    Card inserted\n");
+		} else {
+			DEBUG(2, "    No card inserted\n");
+		}
+		if (dev->flags0 & 0x02) {
+			DEBUG(4, "    Card powered\n");
+		} else {
+			DEBUG(2, "    Card not powered\n");
+		}
+#endif
+
+		/* is a card inserted and powered? */
+		if ((dev->flags0 & 0x01) && (dev->flags0 & 0x02)) {
+
+			/* get IO lock */
+			if (wait_event_interruptible
+			    (dev->ioq,
+			     ((filp->f_flags & O_NONBLOCK)
+			      || (test_and_set_bit(LOCK_IO, (void *)&dev->flags)
+				  =3D=3D 0)))) {
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				return -ERESTARTSYS;
+			}
+			/* Set Flags0 =3D 0x42 */
+			DEBUG(4, "Set Flags0=3D0x42 \n");
+			xoutb(0x42, REG_FLAGS0(iobase));
+			clear_bit(IS_ATR_PRESENT, &dev->flags);
+			clear_bit(IS_ATR_VALID, &dev->flags);
+			dev->mstate =3D M_CARDOFF;
+			clear_bit(LOCK_IO, &dev->flags);
+			if (wait_event_interruptible
+			    (dev->atrq,
+			     ((filp->f_flags & O_NONBLOCK)
+			      || (test_bit(IS_ATR_VALID, (void *)&dev->flags) !=3D
+				  0)))) {
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				return -ERESTARTSYS;
+			}
+		}
+		/* release lock */
+		clear_bit(LOCK_IO, &dev->flags);
+		wake_up_interruptible(&dev->ioq);
+
+		return 0;
+	case CM_IOCSPTS:
+		{
+			struct ptsreq krnptsreq;
+
+			if (copy_from_user(&krnptsreq, (struct ptsreq *) arg,=20
+					   sizeof(struct ptsreq)))
+				return -EFAULT;
+
+			rc =3D 0;
+			DEBUG(4, "... in CM_IOCSPTS\n");
+			/* wait for ATR to get valid */
+			if (wait_event_interruptible
+			    (dev->atrq,
+			     ((filp->f_flags & O_NONBLOCK)
+			      || (test_bit(IS_ATR_PRESENT, (void *)&dev->flags)
+				  !=3D 0)))) {
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				return -ERESTARTSYS;
+			}
+			/* get IO lock */
+			if (wait_event_interruptible
+			    (dev->ioq,
+			     ((filp->f_flags & O_NONBLOCK)
+			      || (test_and_set_bit(LOCK_IO, (void *)&dev->flags)
+				  =3D=3D 0)))) {
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				return -ERESTARTSYS;
+			}
+
+			if ((rc =3D set_protocol(dev, &krnptsreq)) !=3D 0) {
+				/* auto power_on again */
+				dev->mstate =3D M_FETCH_ATR;
+				clear_bit(IS_ATR_VALID, &dev->flags);
+			}
+			/* release lock */
+			clear_bit(LOCK_IO, &dev->flags);
+			wake_up_interruptible(&dev->ioq);
+
+		}
+		return rc;
+#ifdef PCMCIA_DEBUG
+	case CM_IOSDBGLVL:	/* set debug log level */
+		{
+			int old_pc_debug =3D 0;
+
+			old_pc_debug =3D pc_debug;
+			if (copy_from_user(&pc_debug, (int *)arg, sizeof(int)))
+				return -EFAULT;
+
+			if (old_pc_debug !=3D pc_debug)
+				DEBUG(0, "Changed debug log level to %i\n",
+				      pc_debug);
+		}
+		return rc;
+#endif
+	default:
+		DEBUG(4, "... in default (unknown IOCTL code)\n");
+		return -EINVAL;
+	}
+}
+
+static int cmm_open(struct inode *inode, struct file *filp)
+{
+	struct cm4000_dev *dev;
+	dev_link_t *link;
+	int i, rc;
+
+	DEBUG(2, "-> cmm_open(device=3D%d.%d process=3D%s,%d)\n",
+	      MAJOR(inode->i_rdev), MINOR(inode->i_rdev),
+	      current->comm, current->pid);
+
+	i =3D MINOR(inode->i_rdev);
+	if (i >=3D CM4000_MAX_DEV) {
+		DEBUG(4, "cm4000_cs: MAX_DEV reached\n");
+		return -ENODEV;
+	}
+	link =3D dev_table[MINOR(inode->i_rdev)];
+	if (link =3D=3D NULL || !(DEV_OK(link))) {
+		DEBUG(4, "link=3D=3D NULL || DEV_OK false\n");
+		return -ENODEV;
+	}
+	if (link->open) {
+		DEBUG(4, "DEVICE BUSY\n");
+		return -EBUSY;
+	}
+
+	dev =3D (struct cm4000_dev *) link->priv;
+	filp->private_data =3D dev;
+
+	/* init device variables, they may be "polluted" after close
+	 * or, the device may never have been closed (i.e. open failed)
+	 */
+
+	ZERO_DEV(dev);
+
+	/* opening will always block since the
+	 * monitor will be started by open, which
+	 * means we have to wait for ATR becoming
+	 * vaild =3D block until valid (or card
+	 * inserted)
+	 */
+	if (filp->f_flags & O_NONBLOCK)
+		return -EAGAIN;
+
+	dev->owner =3D current;
+	dev->mdelay =3D T_50MSEC;
+
+	/* start monitoring the cardstatus */
+	start_monitor(dev);
+
+	link->open =3D 1;		/* only one open per device */
+	rc =3D 0;
+
+	DEBUG(2, "<- cmm_open\n");
+	return nonseekable_open(inode, filp);
+}
+
+static int cmm_close(struct inode *inode, struct file *filp)
+{
+	struct cm4000_dev *dev;
+	dev_link_t *link;
+	int i;
+
+	DEBUG(2, "-> cmm_close(maj/min=3D%d.%d)\n",
+	      MAJOR(inode->i_rdev), MINOR(inode->i_rdev));
+
+	i =3D MINOR(inode->i_rdev);
+	if (i >=3D CM4000_MAX_DEV)
+		return -ENODEV;
+
+	link =3D dev_table[MINOR(inode->i_rdev)];
+	if (link =3D=3D NULL)
+		return -ENODEV;
+
+	dev =3D (struct cm4000_dev *) link->priv;
+	stop_monitor(dev);
+
+	ZERO_DEV(dev);
+
+	link->open =3D 0;		/* only one open per device */
+	wake_up(&dev->devq);	/* socket removed? */
+
+	DEBUG(2, "cmm_close\n");
+	return 0;
+}
+
+static void cmm_cm4000_release(dev_link_t * link)
+{
+	struct cm4000_dev *dev =3D (struct cm4000_dev *) link->priv;
+
+	/* dont terminate the monitor, rather rely on
+	 * close doing that for us.
+	 */
+	DEBUG(3, "-> cmm_cm4000_release\n");
+	while (link->open) {
+		printk(KERN_INFO MODULE_NAME ": delaying release until "
+		       "process '%s', pid %d has terminated\n",
+		       dev->owner->comm, dev->owner->pid);
+		/* note: don't interrupt us:
+		 * close the applications which own
+		 * the devices _first_ !
+		 */
+		wait_event(dev->devq, (link->open =3D=3D 0));
+	}
+	/* dev->devq=3DNULL;	this cannot be zeroed earlier */
+	DEBUG(3, "<- cmm_cm4000_release\n");
+	return;
+}
+
+/*=3D=3D=3D=3D Interface to PCMCIA Layer =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D*/
+
+static void cm4000_config(dev_link_t * link, int devno)
+{
+	client_handle_t handle;
+	struct cm4000_dev *dev;
+	tuple_t tuple;
+	cisparse_t parse;
+	config_info_t conf;
+	u_char buf[64];
+	int fail_fn, fail_rc;
+	int rc;
+
+	DEBUG(3, "-> cm4000_config\n");
+
+	/* read the config-tuples */
+
+	handle =3D link->handle;
+
+	tuple.DesiredTuple =3D CISTPL_CONFIG;
+	tuple.Attributes =3D 0;
+	tuple.TupleData =3D buf;
+	tuple.TupleDataMax =3D sizeof(buf);
+	tuple.TupleOffset =3D 0;
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
+	if ((fail_rc =3D
+	     pcmcia_parse_tuple(handle, &tuple, &parse)) !=3D CS_SUCCESS) {
+		fail_fn =3D ParseTuple;
+		goto cs_failed;
+	}
+	if ((fail_rc =3D
+	     pcmcia_get_configuration_info(handle, &conf)) !=3D CS_SUCCESS) {
+		fail_fn =3D GetConfigurationInfo;
+		goto cs_failed;
+	}
+
+	link->state |=3D DEV_CONFIG;
+	link->conf.ConfigBase =3D parse.config.base;
+	link->conf.Present =3D parse.config.rmask[0];
+	link->conf.Vcc =3D conf.Vcc;
+	DEBUG(5, "link->conf.Vcc=3D%d\n", link->conf.Vcc);
+
+	link->io.BasePort2 =3D 0;
+	link->io.NumPorts2 =3D 0;
+	link->io.Attributes2 =3D 0;
+	tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
+	for (rc =3D pcmcia_get_first_tuple(handle, &tuple);
+	     rc =3D=3D CS_SUCCESS; rc =3D pcmcia_get_next_tuple(handle, &tuple)) {
+
+		DEBUG(5, "Examing CIS Tuple!\n");
+		rc =3D pcmcia_get_tuple_data(handle, &tuple);
+		if (rc !=3D CS_SUCCESS)
+			continue;
+		rc =3D pcmcia_parse_tuple(handle, &tuple, &parse);
+		if (rc !=3D CS_SUCCESS)
+			continue;
+
+		DEBUG(5, "tupleIndex=3D%d\n", parse.cftable_entry.index);
+		link->conf.ConfigIndex =3D parse.cftable_entry.index;
+
+		if (!parse.cftable_entry.io.nwin)
+			continue;
+
+		/* Get the IOaddr */
+		link->io.BasePort1 =3D parse.cftable_entry.io.win[0].base;
+		link->io.NumPorts1 =3D parse.cftable_entry.io.win[0].len;
+		link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_AUTO;
+		if (!(parse.cftable_entry.io.flags & CISTPL_IO_8BIT))
+			link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_16;
+		if (!(parse.cftable_entry.io.flags & CISTPL_IO_16BIT))
+			link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
+		link->io.IOAddrLines =3D parse.cftable_entry.io.flags
+		    & CISTPL_IO_LINES_MASK;
+		DEBUG(5, "io.BasePort1=3D%.4x\n", link->io.BasePort1);
+		DEBUG(5, "io.NumPorts1=3D%.4x\n", link->io.NumPorts1);
+		DEBUG(5, "io.BasePort2=3D%.4x\n", link->io.BasePort2);
+		DEBUG(5, "io.NumPorts2=3D%.4x\n", link->io.NumPorts2);
+		DEBUG(5, "io.IOAddrLines=3D%.4x\n", link->io.IOAddrLines);
+
+		rc =3D pcmcia_request_io(handle, &link->io);
+		if (rc =3D=3D CS_SUCCESS) {
+			DEBUG(5, "RequestIO OK\n");
+			break;	/* we are done */
+		} else
+			DEBUG(5, "RequestIO failed\n");
+	}
+	if (rc !=3D CS_SUCCESS) {
+		DEBUG(5, "Couldn't configure cardman\n");
+		goto cs_release;
+	}
+
+	link->conf.IntType =3D 00000002;
+
+	if ((fail_rc =3D
+	     pcmcia_request_configuration(handle, &link->conf)) !=3D CS_SUCCESS) {
+		fail_fn =3D RequestConfiguration;
+		goto cs_release;
+	}
+
+	DEBUG(5, "RequestConfiguration OK\n");
+	dev =3D link->priv;
+	sprintf(dev->node.dev_name, DEVICE_NAME "%d", devno);
+	dev->node.major =3D major;
+	dev->node.minor =3D devno;
+	dev->node.next =3D NULL;
+	link->dev =3D &dev->node;
+	link->state &=3D ~DEV_CONFIG_PENDING;
+
+	DEBUG(5, "device " DEVICE_NAME "%d at 0x%.4x-0x%.4x\n",
+	      devno,
+	      link->io.BasePort1, link->io.BasePort1 + link->io.NumPorts1);
+
+	DEBUG(5, "<- cm4000_config (succ)\n");
+	return;
+
+cs_failed:
+	cs_error(handle, fail_fn, fail_rc);
+cs_release:
+	cm4000_release(link);
+
+	link->state &=3D ~DEV_CONFIG_PENDING;
+
+	DEBUG(5, "<- cm4000_config (failure)\n");
+}
+
+static int cm4000_event(event_t event, int priority,=20
+			event_callback_args_t *args)
+{
+	dev_link_t *link;
+	struct cm4000_dev *dev;
+	int devno;
+
+	DEBUG(3, "-> cm4000_event\n");
+	link =3D args->client_data;
+	dev =3D link->priv;
+
+	for (devno =3D 0; devno < CM4000_MAX_DEV; devno++)
+		if (dev_table[devno] =3D=3D link)
+			break;
+
+	if (devno =3D=3D CM4000_MAX_DEV)
+		return CS_BAD_ADAPTER;
+
+	switch (event) {
+	case CS_EVENT_CARD_INSERTION:
+		DEBUG(5, "CS_EVENT_CARD_INSERTION\n");
+		link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
+		cm4000_config(link, devno);
+		break;
+	case CS_EVENT_CARD_REMOVAL:
+		DEBUG(5, "CS_EVENT_CARD_REMOVAL\n");
+		link->state &=3D ~DEV_PRESENT;
+		stop_monitor(dev);
+		break;
+	case CS_EVENT_PM_SUSPEND:
+		DEBUG(5, "CS_EVENT_PM_SUSPEND "
+		      "(fall-through to CS_EVENT_RESET_PHYSICAL)\n");
+		link->state |=3D DEV_SUSPEND;
+		/* fall-through */
+	case CS_EVENT_RESET_PHYSICAL:
+		DEBUG(5, "CS_EVENT_RESET_PHYSICAL\n");
+		if (link->state & DEV_CONFIG) {
+			DEBUG(5, "ReleaseConfiguration\n");
+			pcmcia_release_configuration(link->handle);
+		}
+		stop_monitor(dev);
+		break;
+	case CS_EVENT_PM_RESUME:
+		DEBUG(5, "CS_EVENT_PM_RESUME "
+		      "(fall-through to CS_EVENT_CARD_RESET)\n");
+		link->state &=3D ~DEV_SUSPEND;
+		/* fall-through */
+	case CS_EVENT_CARD_RESET:
+		DEBUG(5, "CS_EVENT_CARD_RESET\n");
+		if ((link->state & DEV_CONFIG)) {
+			DEBUG(5, "RequestConfiguration\n");
+			pcmcia_request_configuration(link->handle, &link->conf);
+		}
+		if (link->open)
+			start_monitor(dev);
+		break;
+	default:
+		DEBUG(5, "unknown event %.2x\n", event);
+		break;
+	}
+	DEBUG(3, "<- cm4000_event\n");
+	return CS_SUCCESS;
+}
+
+static void cm4000_release(dev_link_t *link)
+{
+	int rc;
+
+	DEBUG(3, "-> cm4000_release\n");
+	cmm_cm4000_release(link->priv);	/* delay release until device closed */
+
+	rc =3D pcmcia_release_configuration(link->handle);
+	if (rc !=3D CS_SUCCESS)
+		DEBUG(5, "couldn't ReleaseConfiguration reasoncode=3D%.2x\n", rc);
+
+	rc =3D pcmcia_release_io(link->handle, &link->io);
+	if (rc !=3D CS_SUCCESS)
+		DEBUG(5, "couldn't ReleaseIO reasoncode=3D%.2x\n", rc);
+
+	DEBUG(3, "<- cm4000_release\n");
+}
+
+static dev_link_t *cm4000_attach(void)
+{
+	struct cm4000_dev *dev;
+	dev_link_t *link;
+	client_reg_t client_reg;
+	int i;
+
+	DEBUG(3, "cm4000_attach\n");
+
+	for (i =3D 0; i < CM4000_MAX_DEV; i++)
+		if (dev_table[i] =3D=3D NULL)
+			break;
+
+	if (i =3D=3D CM4000_MAX_DEV) {
+		printk(KERN_NOTICE MODULE_NAME ": all devices in use\n");
+		return NULL;
+	}
+
+	/* create a new cm4000_cs device */
+	DEBUG(5, "create cardman device instance\n");
+	dev =3D kmalloc(sizeof(struct cm4000_dev), GFP_KERNEL);
+	if (dev =3D=3D NULL)
+		return NULL;
+
+	memset(dev, 0, sizeof(struct cm4000_dev));
+	link =3D &dev->link;
+	link->priv =3D dev;
+	link->conf.IntType =3D INT_MEMORY_AND_IO;
+	dev_table[i] =3D link;
+
+	/* register with card services */
+	DEBUG(5, "Register with Card Services\n");
+	client_reg.dev_info =3D &dev_info;
+	client_reg.EventMask =3D
+	    CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+	    CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+	    CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.Version =3D 0x0210;
+	client_reg.event_callback_args.client_data =3D link;
+
+	i =3D pcmcia_register_client(&link->handle, &client_reg);
+	if (i) {
+		cs_error(link->handle, RegisterClient, i);
+		cm4000_detach(link);
+		return NULL;
+	}
+
+	init_waitqueue_head(&dev->devq);
+	init_waitqueue_head(&dev->ioq);
+	init_waitqueue_head(&dev->atrq);
+	init_waitqueue_head(&dev->readq);
+
+	return link;
+}
+
+static void cm4000_detach_by_devno(int devno, dev_link_t * link)
+{
+	struct cm4000_dev *dev =3D link->priv;
+
+	DEBUG(3, "-> detach_by_devno(devno=3D%d)\n", devno);
+
+	if (link->state & DEV_CONFIG) {
+		DEBUG(5, "device still configured (try to release it)\n");
+		cm4000_release(link);
+	}
+
+	if (link->handle) {
+		pcmcia_deregister_client(link->handle);
+	}
+	dev_table[devno] =3D NULL;
+
+	DEBUG(5, "freeing dev=3D%p\n", dev);
+	kfree(dev);
+
+	DEBUG(3, "<- detach_by_devno\n");
+	return;
+}
+
+static void cm4000_detach(dev_link_t * link)
+{
+	int i;
+
+	DEBUG(3, "-> cm4000_detach(link=3D%p\n", link);
+
+	/* find device */
+	for (i =3D 0; i < CM4000_MAX_DEV; i++)
+		if (dev_table[i] =3D=3D link)
+			break;
+
+	if (i =3D=3D CM4000_MAX_DEV) {
+		printk(KERN_WARNING MODULE_NAME
+		       ": detach for unkown device aborted\n");
+		return;
+	}
+
+	cm4000_detach_by_devno(i, link);
+
+	DEBUG(3, "<- cm4000_detach\n");
+	return;
+}
+
+static struct file_operations cm4000_fops =3D {
+	.owner	=3D THIS_MODULE,
+	.read	=3D cmm_read,
+	.write	=3D cmm_write,
+	.ioctl	=3D cmm_ioctl,
+	.open	=3D cmm_open,
+	.release=3D cmm_close,
+};
+
+static struct pcmcia_device_id cm4000_ids[] =3D {
+	PCMCIA_DEVICE_MANF_CARD(0x0223, 0x0002),
+	PCMCIA_DEVICE_PROD_ID12("CardMan", "4000", 0x2FB368CA, 0xA2BD8C39),
+	PCMCIA_DEVICE_NULL,
+};
+MODULE_DEVICE_TABLE(pcmcia, cm4000_ids);
+
+static struct pcmcia_driver cm4000_driver =3D {
+	.owner	  =3D THIS_MODULE,
+	.drv	  =3D {
+		.name =3D "cm4000_cs",
+		},
+	.attach   =3D cm4000_attach,
+	.detach   =3D cm4000_detach,
+	.event	  =3D cm4000_event,
+	.id_table =3D cm4000_ids,
+};
+
+static int __init cmm_init(void)
+{
+	printk(KERN_INFO "%s\n", version);
+	pcmcia_register_driver(&cm4000_driver);
+	major =3D register_chrdev(0, DEVICE_NAME, &cm4000_fops);
+	if (major < 0) {
+		printk(KERN_WARNING MODULE_NAME=20
+			": could not get major number\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void __exit cmm_exit(void)
+{
+	int i;
+
+	printk(KERN_INFO MODULE_NAME ": unloading\n");
+	pcmcia_unregister_driver(&cm4000_driver);
+	for (i =3D 0; i < CM4000_MAX_DEV; i++)
+		if (dev_table[i])
+			cm4000_detach_by_devno(i, dev_table[i]);
+	unregister_chrdev(major, DEVICE_NAME);
+};
+
+module_init(cmm_init);
+module_exit(cmm_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/cm4000_cs.h b/include/linux/cm4000_cs.h
new file mode 100644
--- /dev/null
+++ b/include/linux/cm4000_cs.h
@@ -0,0 +1,66 @@
+#ifndef	_CM4000_H_
+#define	_CM4000_H_
+
+#define	MAX_ATR			33
+
+#define	CM4000_MAX_DEV		4
+
+/* those two structures are passed via ioctl() from/to userspace.  They are
+ * used by existing userspace programs, so I kepth the awkward "bIFSD" nam=
ing
+ * not to break compilation of userspace apps. -HW */
+
+typedef struct atreq {
+	int32_t atr_len;
+	unsigned char atr[64];
+	int32_t power_act;
+	unsigned char bIFSD;
+	unsigned char bIFSC;
+} atreq_t;
+
+
+/* what is particularly stupid in the original driver is the arch-dependant
+ * member sizes. This leads to CONFIG_COMPAT breakage, since 32bit userspa=
ce
+ * will lay out the structure members differently than the 64bit kernel.
+ *
+ * I've changed "ptsreq.protocol" from "unsigned long" to "u_int32_t".
+ * On 32bit this will make no difference.  With 64bit kernels, it will make
+ * 32bit apps work, too.
+ */
+
+typedef struct ptsreq {
+	u_int32_t protocol; /*T=3D0: 2^0, T=3D1:  2^1*/
+ 	unsigned char flags;
+ 	unsigned char pts1;
+ 	unsigned char pts2;
+	unsigned char pts3;
+} ptsreq_t;
+
+#define	CM_IOC_MAGIC		'c'
+#define	CM_IOC_MAXNR	        255
+
+#define	CM_IOCGSTATUS		_IOR (CM_IOC_MAGIC, 0, unsigned char *)
+#define	CM_IOCGATR		_IOWR(CM_IOC_MAGIC, 1, atreq_t *)
+#define	CM_IOCSPTS		_IOW (CM_IOC_MAGIC, 2, ptsreq_t *)
+#define	CM_IOCSRDR		_IO  (CM_IOC_MAGIC, 3)
+#define CM_IOCARDOFF            _IO  (CM_IOC_MAGIC, 4)
+
+#define CM_IOSDBGLVL            _IOW(CM_IOC_MAGIC, 250, int*)=20
+
+/* card and device states */
+#define	CM_CARD_INSERTED		0x01
+#define	CM_CARD_POWERED			0x02
+#define	CM_ATR_PRESENT			0x04
+#define	CM_ATR_VALID	 		0x08
+#define	CM_STATE_VALID			0x0f
+/* extra info only from CM4000 */
+#define	CM_NO_READER			0x10
+#define	CM_BAD_CARD			0x20
+
+
+#ifdef __KERNEL__
+
+#define	DEVICE_NAME		"cmm"
+#define	MODULE_NAME		"cm4000_cs"
+
+#endif	/* __KERNEL__ */
+#endif	/* _CM4000_H_ */
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHPJxXaXGVTD0i/8RAm6XAJ4ki9xSevmNctDV3DUv8FDdFrearQCeKwq7
hyvQ7z5xVK3QzFtyz0nYl1A=
=DiFv
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
