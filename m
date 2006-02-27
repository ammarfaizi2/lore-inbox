Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWB0GZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWB0GZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWB0GZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:25:48 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:65247 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751472AbWB0GZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:25:09 -0500
Date: Mon, 27 Feb 2006 07:23:10 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 1/7] isdn4linux: Siemens Gigaset drivers - common module
Message-ID: <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch adds the common include file for the Siemens Gigaset drivers,
providing definitions used by all of the Gigaset ISDN driver source files.
It also adds the main source file of the gigaset module which manages
common functions not specific to the type of connection to the device.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/common.c  | 1213 +++++++++++++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/gigaset.h |  979 +++++++++++++++++++++++++++++++++
 2 files changed, 2192 insertions(+)

--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/gigaset.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/gigaset.h	2006-02-26 01:22:39.000000000 +0100
@@ -0,0 +1,979 @@
+/*
+ * Siemens Gigaset 307x driver
+ * Common header file for all connection variants
+ *
+ * Written by Stefan Eilers <Eilers.Stefan@epost.de>
+ *        and Hansjoerg Lipp <hjlipp@web.de>
+ *
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
+ */
+
+#ifndef GIGASET_H
+#define GIGASET_H
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/isdnif.h>
+#include <linux/usb.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/ppp_defs.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/list.h>
+#include <asm/atomic.h>
+
+#define GIG_VERSION {0,5,0,0}
+#define GIG_COMPAT  {0,4,0,0}
+
+#define MAX_REC_PARAMS 10	/* Max. number of params in response string */
+#define MAX_RESP_SIZE 512	/* Max. size of a response string */
+#define HW_HDR_LEN 2		/* Header size used to store ack info */
+
+#define MAX_EVENTS 64		/* size of event queue */
+
+#define RBUFSIZE 8192
+#define SBUFSIZE 4096		/* sk_buff payload size */
+
+#define TRANSBUFSIZE 768	/* bytes per skb for transparent receive */
+#define MAX_BUF_SIZE (SBUFSIZE - 2)	/* Max. size of a data packet from LL */
+
+/* compile time options */
+#define GIG_MAJOR 0
+
+#define GIG_MAYINITONDIAL
+#define GIG_RETRYCID
+#define GIG_X75
+
+#define MAX_TIMER_INDEX 1000
+#define MAX_SEQ_INDEX   1000
+
+#define GIG_TICK 100		/* in milliseconds */
+
+/* timeout values (unit: 1 sec) */
+#define INIT_TIMEOUT 1
+
+/* timeout values (unit: 0.1 sec) */
+#define RING_TIMEOUT 3		/* for additional parameters to RING */
+#define BAS_TIMEOUT 20		/* for response to Base USB ops */
+#define ATRDY_TIMEOUT 3		/* for HD_READY_SEND_ATDATA */
+
+#define BAS_RETRY 3		/* max. retries for base USB ops */
+
+#define MAXACT 3
+
+#define IFNULL(a) \
+	if (unlikely(!(a)))
+
+#define IFNULLRET(a) \
+	if (unlikely(!(a))) { \
+		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
+		return; \
+	}
+
+#define IFNULLRETVAL(a,b) \
+	if (unlikely(!(a))) { \
+		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
+		return (b); \
+	}
+
+#define IFNULLCONT(a) \
+	if (unlikely(!(a))) { \
+		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
+		continue; \
+	}
+
+#define IFNULLGOTO(a,b) \
+	if (unlikely(!(a))) { \
+		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
+		goto b; \
+	}
+
+extern int gigaset_debuglevel;	/* "needs" cast to (enum debuglevel) */
+
+/* any combination of these can be given with the 'debug=' parameter to insmod,
+ * e.g. 'insmod usb_gigaset.o debug=0x2c' will set DEBUG_OPEN, DEBUG_CMD and
+ * DEBUG_INTR.
+ */
+enum debuglevel { /* up to 24 bits (atomic_t) */
+	DEBUG_REG	  = 0x0002, /* serial port I/O register operations */
+	DEBUG_OPEN	  = 0x0004, /* open/close serial port */
+	DEBUG_INTR	  = 0x0008, /* interrupt processing */
+	DEBUG_INTR_DUMP	  = 0x0010, /* Activating hexdump debug output on
+				       interrupt requests, not available as
+				       run-time option */
+	DEBUG_CMD	  = 0x00020, /* sent/received LL commands */
+	DEBUG_STREAM	  = 0x00040, /* application data stream I/O events */
+	DEBUG_STREAM_DUMP = 0x00080, /* application data stream content */
+	DEBUG_LLDATA	  = 0x00100, /* sent/received LL data */
+	DEBUG_INTR_0	  = 0x00200, /* serial port interrupt processing */
+	DEBUG_DRIVER	  = 0x00400, /* driver structure */
+	DEBUG_HDLC	  = 0x00800, /* M10x HDLC processing */
+	DEBUG_WRITE	  = 0x01000, /* M105 data write */
+	DEBUG_TRANSCMD	  = 0x02000, /* AT-COMMANDS+RESPONSES */
+	DEBUG_MCMD	  = 0x04000, /* COMMANDS THAT ARE SENT VERY OFTEN */
+	DEBUG_INIT	  = 0x08000, /* (de)allocation+initialization of data
+					structures */
+	DEBUG_LOCK	  = 0x10000, /* semaphore operations */
+	DEBUG_OUTPUT	  = 0x20000, /* output to device */
+	DEBUG_ISO	  = 0x40000, /* isochronous transfers */
+	DEBUG_IF	  = 0x80000, /* character device operations */
+	DEBUG_USBREQ	  = 0x100000, /* USB communication (except payload
+					 data) */
+	DEBUG_LOCKCMD	  = 0x200000, /* AT commands and responses when
+					 MS_LOCKED */
+
+	DEBUG_ANY	  = 0x3fffff, /* print message if any of the others is
+					 activated */
+};
+
+/* missing from linux/device.h ... */
+#ifndef dev_notice
+#define dev_notice(dev, format, arg...)		\
+	dev_printk(KERN_NOTICE , dev , format , ## arg)
+#endif
+
+/* missing from linux/usb.h ... */
+#ifndef notice
+#define notice(format, arg...) \
+	printk(KERN_NOTICE "%s: " format "\n", \
+	       THIS_MODULE ? THIS_MODULE->name : __FILE__ , ## arg)
+#endif
+
+#ifdef CONFIG_GIGASET_DEBUG
+
+#define gig_dbg(level, format, arg...) \
+	do { \
+		if (unlikely(((enum debuglevel)gigaset_debuglevel) & (level))) \
+			printk(KERN_DEBUG "%s: " format "\n", \
+			       THIS_MODULE ? THIS_MODULE->name : __FILE__ \
+			       , ## arg); \
+	} while (0)
+#define DEBUG_DEFAULT (DEBUG_INIT | DEBUG_TRANSCMD | DEBUG_CMD | DEBUG_USBREQ)
+
+#else
+
+#define gig_dbg(level, format, arg...) do {} while (0)
+#define DEBUG_DEFAULT 0
+
+#endif
+
+void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
+			size_t len, const unsigned char *buf, int from_user);
+
+/* connection state */
+#define ZSAU_NONE			0
+#define ZSAU_DISCONNECT_IND		4
+#define ZSAU_OUTGOING_CALL_PROCEEDING	1
+#define ZSAU_PROCEEDING			1
+#define ZSAU_CALL_DELIVERED		2
+#define ZSAU_ACTIVE			3
+#define ZSAU_NULL			5
+#define ZSAU_DISCONNECT_REQ		6
+#define ZSAU_UNKNOWN			-1
+
+/* USB control transfer requests */
+#define OUT_VENDOR_REQ	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT)
+#define IN_VENDOR_REQ	(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT)
+
+/* int-in-events 3070 */
+#define HD_B1_FLOW_CONTROL		0x80
+#define HD_B2_FLOW_CONTROL		0x81
+#define HD_RECEIVEATDATA_ACK		(0x35)		// 3070
+						// att: HD_RECEIVE>>AT<<DATA_ACK
+#define HD_READY_SEND_ATDATA		(0x36)		// 3070
+#define HD_OPEN_ATCHANNEL_ACK		(0x37)		// 3070
+#define HD_CLOSE_ATCHANNEL_ACK		(0x38)		// 3070
+#define HD_DEVICE_INIT_OK		(0x11)		// ISurf USB + 3070
+#define HD_OPEN_B1CHANNEL_ACK		(0x51)		// ISurf USB + 3070
+#define HD_OPEN_B2CHANNEL_ACK		(0x52)		// ISurf USB + 3070
+#define HD_CLOSE_B1CHANNEL_ACK		(0x53)		// ISurf USB + 3070
+#define HD_CLOSE_B2CHANNEL_ACK		(0x54)		// ISurf USB + 3070
+// 	 Powermangment
+#define HD_SUSPEND_END			(0x61)		// ISurf USB
+//   Configuration
+#define HD_RESET_INTERRUPT_PIPE_ACK	(0xFF)		// ISurf USB + 3070
+
+/* control requests 3070 */
+#define	HD_OPEN_B1CHANNEL		(0x23)		// ISurf USB + 3070
+#define	HD_CLOSE_B1CHANNEL		(0x24)		// ISurf USB + 3070
+#define	HD_OPEN_B2CHANNEL		(0x25)		// ISurf USB + 3070
+#define	HD_CLOSE_B2CHANNEL		(0x26)		// ISurf USB + 3070
+#define HD_RESET_INTERRUPT_PIPE		(0x27)		// ISurf USB + 3070
+#define	HD_DEVICE_INIT_ACK		(0x34)		// ISurf USB + 3070
+#define	HD_WRITE_ATMESSAGE		(0x12)		// 3070
+#define	HD_READ_ATMESSAGE		(0x13)		// 3070
+#define	HD_OPEN_ATCHANNEL		(0x28)		// 3070
+#define	HD_CLOSE_ATCHANNEL		(0x29)		// 3070
+
+/* USB frames for isochronous transfer */
+#define BAS_FRAMETIME	1	/* number of milliseconds between frames */
+#define BAS_NUMFRAMES	8	/* number of frames per URB */
+#define BAS_MAXFRAME	16	/* allocated bytes per frame */
+#define BAS_NORMFRAME	8	/* send size without flow control */
+#define BAS_HIGHFRAME	10	/* "    "    with positive flow control */
+#define BAS_LOWFRAME	5	/* "    "    with negative flow control */
+#define BAS_CORRFRAMES	4	/* flow control multiplicator */
+
+#define BAS_INBUFSIZE	(BAS_MAXFRAME * BAS_NUMFRAMES)
+					/* size of isoc in buf per URB */
+#define BAS_OUTBUFSIZE	4096		/* size of common isoc out buffer */
+#define BAS_OUTBUFPAD	BAS_MAXFRAME	/* size of pad area for isoc out buf */
+
+#define BAS_INURBS	3
+#define BAS_OUTURBS	3
+
+/* variable commands in struct bc_state */
+#define AT_ISO		0
+#define AT_DIAL		1
+#define AT_MSN		2
+#define AT_BC		3
+#define AT_PROTO	4
+#define AT_TYPE		5
+#define AT_HLC		6
+#define AT_NUM		7
+
+/* variables in struct at_state_t */
+#define VAR_ZSAU	0
+#define VAR_ZDLE	1
+#define VAR_ZVLS	2
+#define VAR_ZCTP	3
+#define VAR_NUM		4
+
+#define STR_NMBR	0
+#define STR_ZCPN	1
+#define STR_ZCON	2
+#define STR_ZBC		3
+#define STR_ZHLC	4
+#define STR_NUM		5
+
+#define EV_TIMEOUT	-105
+#define EV_IF_VER	-106
+#define EV_PROC_CIDMODE	-107
+#define EV_SHUTDOWN	-108
+#define EV_START	-110
+#define EV_STOP		-111
+#define EV_IF_LOCK	-112
+#define EV_PROTO_L2	-113
+#define EV_ACCEPT	-114
+#define EV_DIAL		-115
+#define EV_HUP		-116
+#define EV_BC_OPEN	-117
+#define EV_BC_CLOSED	-118
+
+/* input state */
+#define INS_command	0x0001
+#define INS_DLE_char	0x0002
+#define INS_byte_stuff	0x0004
+#define INS_have_data	0x0008
+#define INS_skip_frame	0x0010
+#define INS_DLE_command	0x0020
+#define INS_flag_hunt	0x0040
+
+/* channel state */
+#define CHS_D_UP	0x01
+#define CHS_B_UP	0x02
+#define CHS_NOTIFY_LL	0x04
+
+#define ICALL_REJECT	0
+#define ICALL_ACCEPT	1
+#define ICALL_IGNORE	2
+
+/* device state */
+#define MS_UNINITIALIZED	0
+#define MS_INIT			1
+#define MS_LOCKED		2
+#define MS_SHUTDOWN		3
+#define MS_RECOVER		4
+#define MS_READY		5
+
+/* mode */
+#define M_UNKNOWN	0
+#define M_CONFIG	1
+#define M_UNIMODEM	2
+#define M_CID		3
+
+/* start mode */
+#define SM_LOCKED	0
+#define SM_ISDN		1 /* default */
+
+struct gigaset_ops;
+struct gigaset_driver;
+
+struct usb_cardstate;
+struct ser_cardstate;
+struct bas_cardstate;
+
+struct bc_state;
+struct usb_bc_state;
+struct ser_bc_state;
+struct bas_bc_state;
+
+struct reply_t {
+	int	resp_code;	/* RSP_XXXX */
+	int	min_ConState;	/* <0 => ignore */
+	int	max_ConState;	/* <0 => ignore */
+	int	parameter;	/* e.g. ZSAU_XXXX <0: ignore*/
+	int	new_ConState;	/* <0 => ignore */
+	int	timeout;	/* >0 => *HZ; <=0 => TOUT_XXXX*/
+	int	action[MAXACT];	/* ACT_XXXX */
+	char	*command;	/* NULL==none */
+};
+
+extern struct reply_t gigaset_tab_cid_m10x[];
+extern struct reply_t gigaset_tab_nocid_m10x[];
+
+struct inbuf_t {
+	unsigned char		*rcvbuf;	/* usb-gigaset receive buffer */
+	struct bc_state		*bcs;
+	struct cardstate	*cs;
+	int			inputstate;
+	atomic_t		head, tail;
+	unsigned char		data[RBUFSIZE];
+};
+
+/* isochronous write buffer structure
+ * circular buffer with pad area for extraction of complete USB frames
+ * - data[read..nextread-1] is valid data already submitted to the USB subsystem
+ * - data[nextread..write-1] is valid data yet to be sent
+ * - data[write] is the next byte to write to
+ *   - in byte-oriented L2 procotols, it is completely free
+ *   - in bit-oriented L2 procotols, it may contain a partial byte of valid data
+ * - data[write+1..read-1] is free
+ * - wbits is the number of valid data bits in data[write], starting at the LSB
+ * - writesem is the semaphore for writing to the buffer:
+ *   if writesem <= 0, data[write..read-1] is currently being written to
+ * - idle contains the byte value to repeat when the end of valid data is
+ *   reached; if nextread==write (buffer contains no data to send), either the
+ *   BAS_OUTBUFPAD bytes immediately before data[write] (if
+ *   write>=BAS_OUTBUFPAD) or those of the pad area (if write<BAS_OUTBUFPAD)
+ *   are also filled with that value
+ */
+struct isowbuf_t {
+	atomic_t	read;
+	atomic_t	nextread;
+	atomic_t	write;
+	atomic_t	writesem;
+	int		wbits;
+	unsigned char	data[BAS_OUTBUFSIZE + BAS_OUTBUFPAD];
+	unsigned char	idle;
+};
+
+/* isochronous write URB context structure
+ * data to be stored along with the URB and retrieved when it is returned
+ * as completed by the USB subsystem
+ * - urb: pointer to the URB itself
+ * - bcs: pointer to the B Channel control structure
+ * - limit: end of write buffer area covered by this URB
+ */
+struct isow_urbctx_t {
+	struct urb *urb;
+	struct bc_state *bcs;
+	int limit;
+};
+
+/* AT state structure
+ * data associated with the state of an ISDN connection, whether or not
+ * it is currently assigned a B channel
+ */
+struct at_state_t {
+	struct list_head	list;
+	int			waiting;
+	int			getstring;
+	atomic_t		timer_index;
+	unsigned long		timer_expires;
+	int			timer_active;
+	unsigned int		ConState;	/* State of connection */
+	struct reply_t		*replystruct;
+	int			cid;
+	int			int_var[VAR_NUM];	/* see VAR_XXXX */
+	char			*str_var[STR_NUM];	/* see STR_XXXX */
+	unsigned		pending_commands;	/* see PC_XXXX */
+	atomic_t		seq_index;
+
+	struct cardstate	*cs;
+	struct bc_state		*bcs;
+};
+
+struct resp_type_t {
+	unsigned char	*response;
+	int		resp_code;	/* RSP_XXXX */
+	int		type;		/* RT_XXXX */
+};
+
+struct event_t {
+	int type;
+	void *ptr, *arg;
+	int parameter;
+	int cid;
+	struct at_state_t *at_state;
+};
+
+/* This buffer holds all information about the used B-Channel */
+struct bc_state {
+	struct sk_buff *tx_skb;		/* Current transfer buffer to modem */
+	struct sk_buff_head squeue;	/* B-Channel send Queue */
+
+	/* Variables for debugging .. */
+	int corrupted;			/* Counter for corrupted packages */
+	int trans_down;			/* Counter of packages (downstream) */
+	int trans_up;			/* Counter of packages (upstream) */
+
+	struct at_state_t at_state;
+	unsigned long rcvbytes;
+
+	__u16 fcs;
+	struct sk_buff *skb;
+	int inputstate;			/* see INS_XXXX */
+
+	int channel;
+
+	struct cardstate *cs;
+
+	unsigned chstate;		/* bitmap (CHS_*) */
+	int ignore;
+	unsigned proto2;		/* Layer 2 protocol (ISDN_PROTO_L2_*) */
+	char *commands[AT_NUM];		/* see AT_XXXX */
+
+#ifdef CONFIG_GIGASET_DEBUG
+	int emptycount;
+#endif
+	int busy;
+	int use_count;
+
+	/* private data of hardware drivers */
+	union {
+		struct ser_bc_state *ser;	/* serial hardware driver */
+		struct usb_bc_state *usb;	/* usb hardware driver (m105) */
+		struct bas_bc_state *bas;	/* usb hardware driver (base) */
+	} hw;
+};
+
+struct cardstate {
+	struct gigaset_driver *driver;
+	unsigned minor_index;
+	struct device *dev;
+
+	const struct gigaset_ops *ops;
+
+	/* Stuff to handle communication */
+	wait_queue_head_t waitqueue;
+	int waiting;
+	atomic_t mode;			/* see M_XXXX */
+	atomic_t mstate;		/* Modem state: see MS_XXXX */
+					/* only changed by the event layer */
+	int cmd_result;
+
+	int channels;
+	struct bc_state *bcs;		/* Array of struct bc_state */
+
+	int onechannel;			/* data and commands transmitted in one
+					   stream (M10x) */
+
+	spinlock_t lock;
+	struct at_state_t at_state;	/* at_state_t for cid == 0 */
+	struct list_head temp_at_states;/* list of temporary "struct
+					   at_state_t"s without B channel */
+
+	struct inbuf_t *inbuf;
+
+	struct cmdbuf_t *cmdbuf, *lastcmdbuf;
+	spinlock_t cmdlock;
+	unsigned curlen, cmdbytes;
+
+	unsigned open_count;
+	struct tty_struct *tty;
+	struct tasklet_struct if_wake_tasklet;
+	unsigned control_state;
+
+	unsigned fwver[4];
+	int gotfwver;
+
+	atomic_t running;		/* !=0 if events are handled */
+	atomic_t connected;		/* !=0 if hardware is connected */
+
+	atomic_t cidmode;
+
+	int myid;			/* id for communication with LL */
+	isdn_if iif;
+
+	struct reply_t *tabnocid;
+	struct reply_t *tabcid;
+	int cs_init;
+	int ignoreframes;		/* frames to ignore after setting up the
+					   B channel */
+	struct semaphore sem;		/* locks this structure:
+					 *   connected is not changed,
+					 *   hardware_up is not changed,
+					 *   MState is not changed to or from
+					 *   MS_LOCKED */
+
+	struct timer_list timer;
+	int retry_count;
+	int dle;			/* !=0 if modem commands/responses are
+					   dle encoded */
+	int cur_at_seq;			/* sequence of AT commands being
+					   processed */
+	int curchannel;			/* channel those commands are meant
+					   for */
+	atomic_t commands_pending;	/* flag(s) in xxx.commands_pending have
+					   been set */
+	struct tasklet_struct event_tasklet;
+					/* tasklet for serializing AT commands.
+					 * Scheduled
+					 *   -> for modem reponses (and
+					 *      incoming data for M10x)
+					 *   -> on timeout
+					 *   -> after setting bits in
+					 *      xxx.at_state.pending_command
+					 *      (e.g. command from LL) */
+	struct tasklet_struct write_tasklet;
+					/* tasklet for serial output
+					 * (not used in base driver) */
+
+	/* event queue */
+	struct event_t events[MAX_EVENTS];
+	atomic_t ev_tail, ev_head;
+	spinlock_t ev_lock;
+
+	/* current modem response */
+	unsigned char respdata[MAX_RESP_SIZE];
+	unsigned cbytes;
+
+	/* private data of hardware drivers */
+	union {
+		struct usb_cardstate *usb; /* USB hardware driver (m105) */
+		struct ser_cardstate *ser; /* serial hardware driver */
+		struct bas_cardstate *bas; /* USB hardware driver (base) */
+	} hw;
+};
+
+struct gigaset_driver {
+	struct list_head list;
+	spinlock_t lock;		/* locks minor tables and blocked */
+	struct tty_driver *tty;
+	unsigned have_tty;
+	unsigned minor;
+	unsigned minors;
+	struct cardstate *cs;
+	unsigned *flags;
+	int blocked;
+
+	const struct gigaset_ops *ops;
+	struct module *owner;
+};
+
+struct cmdbuf_t {
+	struct cmdbuf_t *next, *prev;
+	int len, offset;
+	struct tasklet_struct *wake_tasklet;
+	unsigned char buf[0];
+};
+
+struct bas_bc_state {
+	/* isochronous output state */
+	atomic_t	running;
+	atomic_t	corrbytes;
+	spinlock_t	isooutlock;
+	struct isow_urbctx_t	isoouturbs[BAS_OUTURBS];
+	struct isow_urbctx_t	*isooutdone, *isooutfree, *isooutovfl;
+	struct isowbuf_t	*isooutbuf;
+	unsigned numsub;		/* submitted URB counter
+					   (for diagnostic messages only) */
+	struct tasklet_struct	sent_tasklet;
+
+	/* isochronous input state */
+	spinlock_t isoinlock;
+	struct urb *isoinurbs[BAS_INURBS];
+	unsigned char isoinbuf[BAS_INBUFSIZE * BAS_INURBS];
+	struct urb *isoindone;		/* completed isoc read URB */
+	int loststatus;			/* status of dropped URB */
+	unsigned isoinlost;		/* number of bytes lost */
+	/* state of bit unstuffing algorithm
+	   (in addition to BC_state.inputstate) */
+	unsigned seqlen;		/* number of '1' bits not yet
+					   unstuffed */
+	unsigned inbyte, inbits;	/* collected bits for next byte */
+	/* statistics */
+	unsigned goodbytes;		/* bytes correctly received */
+	unsigned alignerrs;		/* frames with incomplete byte at end */
+	unsigned fcserrs;		/* FCS errors */
+	unsigned frameerrs;		/* framing errors */
+	unsigned giants;		/* long frames */
+	unsigned runts;			/* short frames */
+	unsigned aborts;		/* HDLC aborts */
+	unsigned shared0s;		/* '0' bits shared between flags */
+	unsigned stolen0s;		/* '0' stuff bits also serving as
+					   leading flag bits */
+	struct tasklet_struct rcvd_tasklet;
+};
+
+struct gigaset_ops {
+	/* Called from ev-layer.c/interface.c for sending AT commands to the
+	   device */
+	int (*write_cmd)(struct cardstate *cs,
+			 const unsigned char *buf, int len,
+			 struct tasklet_struct *wake_tasklet);
+
+	/* Called from interface.c for additional device control */
+	int (*write_room)(struct cardstate *cs);
+	int (*chars_in_buffer)(struct cardstate *cs);
+	int (*brkchars)(struct cardstate *cs, const unsigned char buf[6]);
+
+	/* Called from ev-layer.c after setting up connection
+	 * Should call gigaset_bchannel_up(), when finished. */
+	int (*init_bchannel)(struct bc_state *bcs);
+
+	/* Called from ev-layer.c after hanging up
+	 * Should call gigaset_bchannel_down(), when finished. */
+	int (*close_bchannel)(struct bc_state *bcs);
+
+	/* Called by gigaset_initcs() for setting up bcs->hw.xxx */
+	int (*initbcshw)(struct bc_state *bcs);
+
+	/* Called by gigaset_freecs() for freeing bcs->hw.xxx */
+	int (*freebcshw)(struct bc_state *bcs);
+
+	/* Called by gigaset_stop() or gigaset_bchannel_down() for resetting
+	   bcs->hw.xxx */
+	void (*reinitbcshw)(struct bc_state *bcs);
+
+	/* Called by gigaset_initcs() for setting up cs->hw.xxx */
+	int (*initcshw)(struct cardstate *cs);
+
+	/* Called by gigaset_freecs() for freeing cs->hw.xxx */
+	void (*freecshw)(struct cardstate *cs);
+
+	/* Called from common.c/interface.c for additional serial port
+	   control */
+	int (*set_modem_ctrl)(struct cardstate *cs, unsigned old_state,
+			      unsigned new_state);
+	int (*baud_rate)(struct cardstate *cs, unsigned cflag);
+	int (*set_line_ctrl)(struct cardstate *cs, unsigned cflag);
+
+	/* Called from i4l.c to put an skb into the send-queue. */
+	int (*send_skb)(struct bc_state *bcs, struct sk_buff *skb);
+
+	/* Called from ev-layer.c to process a block of data
+	 * received through the common/control channel. */
+	void (*handle_input)(struct inbuf_t *inbuf);
+
+};
+
+/* = Common structures and definitions ======================================= */
+
+/* Parser states for DLE-Event:
+ * <DLE-EVENT>: <DLE_FLAG> "X" <EVENT> <DLE_FLAG> "."
+ * <DLE_FLAG>:  0x10
+ * <EVENT>:     ((a-z)* | (A-Z)* | (0-10)*)+
+ */
+#define DLE_FLAG	0x10
+
+/* ===========================================================================
+ *  Functions implemented in asyncdata.c
+ */
+
+/* Called from i4l.c to put an skb into the send-queue.
+ * After sending gigaset_skb_sent() should be called. */
+int gigaset_m10x_send_skb(struct bc_state *bcs, struct sk_buff *skb);
+
+/* Called from ev-layer.c to process a block of data
+ * received through the common/control channel. */
+void gigaset_m10x_input(struct inbuf_t *inbuf);
+
+/* ===========================================================================
+ *  Functions implemented in isocdata.c
+ */
+
+/* Called from i4l.c to put an skb into the send-queue.
+ * After sending gigaset_skb_sent() should be called. */
+int gigaset_isoc_send_skb(struct bc_state *bcs, struct sk_buff *skb);
+
+/* Called from ev-layer.c to process a block of data
+ * received through the common/control channel. */
+void gigaset_isoc_input(struct inbuf_t *inbuf);
+
+/* Called from bas-gigaset.c to process a block of data
+ * received through the isochronous channel */
+void gigaset_isoc_receive(unsigned char *src, unsigned count,
+			  struct bc_state *bcs);
+
+/* Called from bas-gigaset.c to put a block of data
+ * into the isochronous output buffer */
+int gigaset_isoc_buildframe(struct bc_state *bcs, unsigned char *in, int len);
+
+/* Called from bas-gigaset.c to initialize the isochronous output buffer */
+void gigaset_isowbuf_init(struct isowbuf_t *iwb, unsigned char idle);
+
+/* Called from bas-gigaset.c to retrieve a block of bytes for sending */
+int gigaset_isowbuf_getbytes(struct isowbuf_t *iwb, int size);
+
+/* ===========================================================================
+ *  Functions implemented in i4l.c/gigaset.h
+ */
+
+/* Called by gigaset_initcs() for setting up with the isdn4linux subsystem */
+int gigaset_register_to_LL(struct cardstate *cs, const char *isdnid);
+
+/* Called from xxx-gigaset.c to indicate completion of sending an skb */
+void gigaset_skb_sent(struct bc_state *bcs, struct sk_buff *skb);
+
+/* Called from common.c/ev-layer.c to indicate events relevant to the LL */
+int gigaset_isdn_icall(struct at_state_t *at_state);
+int gigaset_isdn_setup_accept(struct at_state_t *at_state);
+int gigaset_isdn_setup_dial(struct at_state_t *at_state, void *data);
+
+void gigaset_i4l_cmd(struct cardstate *cs, int cmd);
+void gigaset_i4l_channel_cmd(struct bc_state *bcs, int cmd);
+
+
+static inline void gigaset_isdn_rcv_err(struct bc_state *bcs)
+{
+	isdn_ctrl response;
+
+	/* error -> LL */
+	gig_dbg(DEBUG_CMD, "sending L1ERR");
+	response.driver = bcs->cs->myid;
+	response.command = ISDN_STAT_L1ERR;
+	response.arg = bcs->channel;
+	response.parm.errcode = ISDN_STAT_L1ERR_RECV;
+	bcs->cs->iif.statcallb(&response);
+}
+
+/* ===========================================================================
+ *  Functions implemented in ev-layer.c
+ */
+
+/* tasklet called from common.c to process queued events */
+void gigaset_handle_event(unsigned long data);
+
+/* called from isocdata.c / asyncdata.c
+ * when a complete modem response line has been received */
+void gigaset_handle_modem_response(struct cardstate *cs);
+
+/* ===========================================================================
+ *  Functions implemented in proc.c
+ */
+
+/* initialize sysfs for device */
+void gigaset_init_dev_sysfs(struct cardstate *cs);
+void gigaset_free_dev_sysfs(struct cardstate *cs);
+
+/* ===========================================================================
+ *  Functions implemented in common.c/gigaset.h
+ */
+
+void gigaset_bcs_reinit(struct bc_state *bcs);
+void gigaset_at_init(struct at_state_t *at_state, struct bc_state *bcs,
+		     struct cardstate *cs, int cid);
+int gigaset_get_channel(struct bc_state *bcs);
+void gigaset_free_channel(struct bc_state *bcs);
+int gigaset_get_channels(struct cardstate *cs);
+void gigaset_free_channels(struct cardstate *cs);
+void gigaset_block_channels(struct cardstate *cs);
+
+/* Allocate and initialize driver structure. */
+struct gigaset_driver *gigaset_initdriver(unsigned minor, unsigned minors,
+					  const char *procname,
+					  const char *devname,
+					  const char *devfsname,
+					  const struct gigaset_ops *ops,
+					  struct module *owner);
+
+/* Deallocate driver structure. */
+void gigaset_freedriver(struct gigaset_driver *drv);
+void gigaset_debugdrivers(void);
+struct cardstate *gigaset_get_cs_by_minor(unsigned minor);
+struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty);
+struct cardstate *gigaset_get_cs_by_id(int id);
+
+/* For drivers without fixed assignment device<->cardstate (usb) */
+struct cardstate *gigaset_getunassignedcs(struct gigaset_driver *drv);
+void gigaset_unassign(struct cardstate *cs);
+void gigaset_blockdriver(struct gigaset_driver *drv);
+
+/* Allocate and initialize card state. Calls hardware dependent
+   gigaset_init[b]cs(). */
+struct cardstate *gigaset_initcs(struct gigaset_driver *drv, int channels,
+				 int onechannel, int ignoreframes,
+				 int cidmode, const char *modulename);
+
+/* Free card state. Calls hardware dependent gigaset_free[b]cs(). */
+void gigaset_freecs(struct cardstate *cs);
+
+/* Tell common.c that hardware and driver are ready. */
+int gigaset_start(struct cardstate *cs);
+
+/* Tell common.c that the device is not present any more. */
+void gigaset_stop(struct cardstate *cs);
+
+/* Tell common.c that the driver is being unloaded. */
+void gigaset_shutdown(struct cardstate *cs);
+
+/* Tell common.c that an skb has been sent. */
+void gigaset_skb_sent(struct bc_state *bcs, struct sk_buff *skb);
+
+/* Append event to the queue.
+ * Returns NULL on failure or a pointer to the event on success.
+ * ptr must be kmalloc()ed (and not be freed by the caller).
+ */
+struct event_t *gigaset_add_event(struct cardstate *cs,
+				  struct at_state_t *at_state, int type,
+				  void *ptr, int parameter, void *arg);
+
+/* Called on CONFIG1 command from frontend. */
+int gigaset_enterconfigmode(struct cardstate *cs); //0: success <0: errorcode
+
+/* cs->lock must not be locked */
+static inline void gigaset_schedule_event(struct cardstate *cs)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&cs->lock, flags);
+	if (atomic_read(&cs->running))
+		tasklet_schedule(&cs->event_tasklet);
+	spin_unlock_irqrestore(&cs->lock, flags);
+}
+
+/* Tell common.c that B channel has been closed. */
+/* cs->lock must not be locked */
+static inline void gigaset_bchannel_down(struct bc_state *bcs)
+{
+	gigaset_add_event(bcs->cs, &bcs->at_state, EV_BC_CLOSED, NULL, 0, NULL);
+
+	gig_dbg(DEBUG_CMD, "scheduling BC_CLOSED");
+	gigaset_schedule_event(bcs->cs);
+}
+
+/* Tell common.c that B channel has been opened. */
+/* cs->lock must not be locked */
+static inline void gigaset_bchannel_up(struct bc_state *bcs)
+{
+	gigaset_add_event(bcs->cs, &bcs->at_state, EV_BC_OPEN, NULL, 0, NULL);
+
+	gig_dbg(DEBUG_CMD, "scheduling BC_OPEN");
+	gigaset_schedule_event(bcs->cs);
+}
+
+/* handling routines for sk_buff */
+/* ============================= */
+
+/* private version of __skb_put()
+ * append 'len' bytes to the content of 'skb', already knowing that the
+ * existing buffer can accomodate them
+ * returns a pointer to the location where the new bytes should be copied to
+ * This function does not take any locks so it must be called with the
+ * appropriate locks held only.
+ */
+static inline unsigned char *gigaset_skb_put_quick(struct sk_buff *skb,
+						   unsigned int len)
+{
+	unsigned char *tmp = skb->tail;
+	/*SKB_LINEAR_ASSERT(skb);*/		/* not needed here */
+	skb->tail += len;
+	skb->len += len;
+	return tmp;
+}
+
+/* pass received skb to LL
+ * Warning: skb must not be accessed anymore!
+ */
+static inline void gigaset_rcv_skb(struct sk_buff *skb,
+				   struct cardstate *cs,
+				   struct bc_state *bcs)
+{
+	cs->iif.rcvcallb_skb(cs->myid, bcs->channel, skb);
+	bcs->trans_down++;
+}
+
+/* handle reception of corrupted skb
+ * Warning: skb must not be accessed anymore!
+ */
+static inline void gigaset_rcv_error(struct sk_buff *procskb,
+				     struct cardstate *cs,
+				     struct bc_state *bcs)
+{
+	if (procskb)
+		dev_kfree_skb(procskb);
+
+	if (bcs->ignore)
+		--bcs->ignore;
+	else {
+		++bcs->corrupted;
+		gigaset_isdn_rcv_err(bcs);
+	}
+}
+
+
+/* bitwise byte inversion table */
+extern __u8 gigaset_invtab[];	/* in common.c */
+
+
+/* append received bytes to inbuf */
+static inline int gigaset_fill_inbuf(struct inbuf_t *inbuf,
+				     const unsigned char *src,
+				     unsigned numbytes)
+{
+	unsigned n, head, tail, bytesleft;
+
+	gig_dbg(DEBUG_INTR, "received %u bytes", numbytes);
+
+	if (!numbytes)
+		return 0;
+
+	bytesleft = numbytes;
+	tail = atomic_read(&inbuf->tail);
+	head = atomic_read(&inbuf->head);
+	gig_dbg(DEBUG_INTR, "buffer state: %u -> %u", head, tail);
+
+	while (bytesleft) {
+		if (head > tail)
+			n = head - 1 - tail;
+		else if (head == 0)
+			n = (RBUFSIZE-1) - tail;
+		else
+			n = RBUFSIZE - tail;
+		if (!n) {
+			dev_err(inbuf->cs->dev,
+				"buffer overflow (%u bytes lost)", bytesleft);
+			break;
+		}
+		if (n > bytesleft)
+			n = bytesleft;
+		memcpy(inbuf->data + tail, src, n);
+		bytesleft -= n;
+		tail = (tail + n) % RBUFSIZE;
+		src += n;
+	}
+	gig_dbg(DEBUG_INTR, "setting tail to %u", tail);
+	atomic_set(&inbuf->tail, tail);
+	return numbytes != bytesleft;
+}
+
+/* ===========================================================================
+ *  Functions implemented in interface.c
+ */
+
+/* initialize interface */
+void gigaset_if_initdriver(struct gigaset_driver *drv, const char *procname,
+			   const char *devname, const char *devfsname);
+/* release interface */
+void gigaset_if_freedriver(struct gigaset_driver *drv);
+/* add minor */
+void gigaset_if_init(struct cardstate *cs);
+/* remove minor */
+void gigaset_if_free(struct cardstate *cs);
+/* device received data */
+void gigaset_if_receive(struct cardstate *cs,
+			unsigned char *buffer, size_t len);
+
+#endif
--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/common.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/common.c	2006-02-26 01:22:39.000000000 +0100
@@ -0,0 +1,1213 @@
+/*
+ * Stuff used by all variants of the driver
+ *
+ * Copyright (c) 2001 by Stefan Eilers <Eilers.Stefan@epost.de>,
+ *                       Hansjoerg Lipp <hjlipp@web.de>,
+ *                       Tilman Schmidt <tilman@imap.cc>.
+ *
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
+ */
+
+#include "gigaset.h"
+#include <linux/ctype.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+/* Version Information */
+#define DRIVER_AUTHOR "Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>, Stefan Eilers <Eilers.Stefan@epost.de>"
+#define DRIVER_DESC "Driver for Gigaset 307x"
+
+/* Module parameters */
+int gigaset_debuglevel = DEBUG_DEFAULT;
+EXPORT_SYMBOL_GPL(gigaset_debuglevel);
+module_param_named(debug, gigaset_debuglevel, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(debug, "debug level");
+
+/*======================================================================
+  Prototypes of internal functions
+ */
+
+static struct cardstate *alloc_cs(struct gigaset_driver *drv);
+static void free_cs(struct cardstate *cs);
+static void make_valid(struct cardstate *cs, unsigned mask);
+static void make_invalid(struct cardstate *cs, unsigned mask);
+
+#define VALID_MINOR	0x01
+#define VALID_ID	0x02
+#define ASSIGNED	0x04
+
+/* bitwise byte inversion table */
+__u8 gigaset_invtab[256] = {
+	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
+	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
+	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
+	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
+	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
+	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
+	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
+	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
+	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
+	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
+	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
+	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
+	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
+	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
+	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
+	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
+	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
+	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
+	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
+	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
+	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
+	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
+	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
+	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
+	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
+	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
+	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
+	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
+	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
+	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
+	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
+	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff
+};
+EXPORT_SYMBOL_GPL(gigaset_invtab);
+
+void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
+			size_t len, const unsigned char *buf, int from_user)
+{
+	unsigned char outbuf[80];
+	unsigned char inbuf[80 - 1];
+	unsigned char c;
+	size_t numin;
+	const unsigned char *in;
+	size_t space = sizeof outbuf - 1;
+	unsigned char *out = outbuf;
+
+	if (!from_user) {
+		in = buf;
+		numin = len;
+	} else {
+		numin = len < sizeof inbuf ? len : sizeof inbuf;
+		in = inbuf;
+		if (copy_from_user(inbuf, (const unsigned char __user *) buf,
+				   numin)) {
+			gig_dbg(level, "%s (%u bytes) - copy_from_user failed",
+				msg, (unsigned) len);
+			return;
+		}
+	}
+
+	while (numin-- > 0) {
+		c = *buf++;
+		if (c == '~' || c == '^' || c == '\\') {
+			if (space-- <= 0)
+				break;
+			*out++ = '\\';
+		}
+		if (c & 0x80) {
+			if (space-- <= 0)
+				break;
+			*out++ = '~';
+			c ^= 0x80;
+		}
+		if (c < 0x20 || c == 0x7f) {
+			if (space-- <= 0)
+				break;
+			*out++ = '^';
+			c ^= 0x40;
+		}
+		if (space-- <= 0)
+			break;
+		*out++ = c;
+	}
+	*out = 0;
+
+	gig_dbg(level, "%s (%u bytes): %s", msg, (unsigned) len, outbuf);
+}
+EXPORT_SYMBOL_GPL(gigaset_dbg_buffer);
+
+static int setflags(struct cardstate *cs, unsigned flags, unsigned delay)
+{
+	int r;
+
+	r = cs->ops->set_modem_ctrl(cs, cs->control_state, flags);
+	cs->control_state = flags;
+	if (r < 0)
+		return r;
+
+	if (delay) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(delay * HZ / 1000);
+	}
+
+	return 0;
+}
+
+int gigaset_enterconfigmode(struct cardstate *cs)
+{
+	int i, r;
+
+	if (!atomic_read(&cs->connected)) {
+		err("not connected!");
+		return -1;
+	}
+
+	cs->control_state = TIOCM_RTS; //FIXME
+
+	r = setflags(cs, TIOCM_DTR, 200);
+	if (r < 0)
+		goto error;
+	r = setflags(cs, 0, 200);
+	if (r < 0)
+		goto error;
+	for (i = 0; i < 5; ++i) {
+		r = setflags(cs, TIOCM_RTS, 100);
+		if (r < 0)
+			goto error;
+		r = setflags(cs, 0, 100);
+		if (r < 0)
+			goto error;
+	}
+	r = setflags(cs, TIOCM_RTS|TIOCM_DTR, 800);
+	if (r < 0)
+		goto error;
+
+	return 0;
+
+error:
+	dev_err(cs->dev, "error %d on setuartbits\n", -r);
+	cs->control_state = TIOCM_RTS|TIOCM_DTR; // FIXME is this a good value?
+	cs->ops->set_modem_ctrl(cs, 0, TIOCM_RTS|TIOCM_DTR);
+
+	return -1; //r
+}
+
+static int test_timeout(struct at_state_t *at_state)
+{
+	if (!at_state->timer_expires)
+		return 0;
+
+	if (--at_state->timer_expires) {
+		gig_dbg(DEBUG_MCMD, "decreased timer of %p to %lu",
+			at_state, at_state->timer_expires);
+		return 0;
+	}
+
+	if (!gigaset_add_event(at_state->cs, at_state, EV_TIMEOUT, NULL,
+			       atomic_read(&at_state->timer_index), NULL)) {
+		//FIXME what should we do?
+	}
+
+	return 1;
+}
+
+static void timer_tick(unsigned long data)
+{
+	struct cardstate *cs = (struct cardstate *) data;
+	unsigned long flags;
+	unsigned channel;
+	struct at_state_t *at_state;
+	int timeout = 0;
+
+	spin_lock_irqsave(&cs->lock, flags);
+
+	for (channel = 0; channel < cs->channels; ++channel)
+		if (test_timeout(&cs->bcs[channel].at_state))
+			timeout = 1;
+
+	if (test_timeout(&cs->at_state))
+		timeout = 1;
+
+	list_for_each_entry(at_state, &cs->temp_at_states, list)
+		if (test_timeout(at_state))
+			timeout = 1;
+
+	if (atomic_read(&cs->running)) {
+		mod_timer(&cs->timer, jiffies + msecs_to_jiffies(GIG_TICK));
+		if (timeout) {
+			gig_dbg(DEBUG_CMD, "scheduling timeout");
+			tasklet_schedule(&cs->event_tasklet);
+		}
+	}
+
+	spin_unlock_irqrestore(&cs->lock, flags);
+}
+
+int gigaset_get_channel(struct bc_state *bcs)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcs->cs->lock, flags);
+	if (bcs->use_count) {
+		gig_dbg(DEBUG_ANY, "could not allocate channel %d",
+			bcs->channel);
+		spin_unlock_irqrestore(&bcs->cs->lock, flags);
+		return 0;
+	}
+	++bcs->use_count;
+	bcs->busy = 1;
+	gig_dbg(DEBUG_ANY, "allocated channel %d", bcs->channel);
+	spin_unlock_irqrestore(&bcs->cs->lock, flags);
+	return 1;
+}
+
+void gigaset_free_channel(struct bc_state *bcs)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bcs->cs->lock, flags);
+	if (!bcs->busy) {
+		gig_dbg(DEBUG_ANY, "could not free channel %d", bcs->channel);
+		spin_unlock_irqrestore(&bcs->cs->lock, flags);
+		return;
+	}
+	--bcs->use_count;
+	bcs->busy = 0;
+	gig_dbg(DEBUG_ANY, "freed channel %d", bcs->channel);
+	spin_unlock_irqrestore(&bcs->cs->lock, flags);
+}
+
+int gigaset_get_channels(struct cardstate *cs)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&cs->lock, flags);
+	for (i = 0; i < cs->channels; ++i)
+		if (cs->bcs[i].use_count) {
+			spin_unlock_irqrestore(&cs->lock, flags);
+			gig_dbg(DEBUG_ANY, "could not allocate all channels");
+			return 0;
+		}
+	for (i = 0; i < cs->channels; ++i)
+		++cs->bcs[i].use_count;
+	spin_unlock_irqrestore(&cs->lock, flags);
+
+	gig_dbg(DEBUG_ANY, "allocated all channels");
+
+	return 1;
+}
+
+void gigaset_free_channels(struct cardstate *cs)
+{
+	unsigned long flags;
+	int i;
+
+	gig_dbg(DEBUG_ANY, "unblocking all channels");
+	spin_lock_irqsave(&cs->lock, flags);
+	for (i = 0; i < cs->channels; ++i)
+		--cs->bcs[i].use_count;
+	spin_unlock_irqrestore(&cs->lock, flags);
+}
+
+void gigaset_block_channels(struct cardstate *cs)
+{
+	unsigned long flags;
+	int i;
+
+	gig_dbg(DEBUG_ANY, "blocking all channels");
+	spin_lock_irqsave(&cs->lock, flags);
+	for (i = 0; i < cs->channels; ++i)
+		++cs->bcs[i].use_count;
+	spin_unlock_irqrestore(&cs->lock, flags);
+}
+
+static void clear_events(struct cardstate *cs)
+{
+	struct event_t *ev;
+	unsigned head, tail;
+
+	/* no locking needed (no reader/writer allowed) */
+
+	head = atomic_read(&cs->ev_head);
+	tail = atomic_read(&cs->ev_tail);
+
+	while (tail != head) {
+		ev = cs->events + head;
+		kfree(ev->ptr);
+
+		head = (head + 1) % MAX_EVENTS;
+	}
+
+	atomic_set(&cs->ev_head, tail);
+}
+
+struct event_t *gigaset_add_event(struct cardstate *cs,
+				  struct at_state_t *at_state, int type,
+				  void *ptr, int parameter, void *arg)
+{
+	unsigned long flags;
+	unsigned next, tail;
+	struct event_t *event = NULL;
+
+	spin_lock_irqsave(&cs->ev_lock, flags);
+
+	tail = atomic_read(&cs->ev_tail);
+	next = (tail + 1) % MAX_EVENTS;
+	if (unlikely(next == atomic_read(&cs->ev_head)))
+		err("event queue full");
+	else {
+		event = cs->events + tail;
+		event->type = type;
+		event->at_state = at_state;
+		event->cid = -1;
+		event->ptr = ptr;
+		event->arg = arg;
+		event->parameter = parameter;
+		atomic_set(&cs->ev_tail, next);
+	}
+
+	spin_unlock_irqrestore(&cs->ev_lock, flags);
+
+	return event;
+}
+EXPORT_SYMBOL_GPL(gigaset_add_event);
+
+static void free_strings(struct at_state_t *at_state)
+{
+	int i;
+
+	for (i = 0; i < STR_NUM; ++i) {
+		kfree(at_state->str_var[i]);
+		at_state->str_var[i] = NULL;
+	}
+}
+
+static void clear_at_state(struct at_state_t *at_state)
+{
+	free_strings(at_state);
+}
+
+static void dealloc_at_states(struct cardstate *cs)
+{
+	struct at_state_t *cur, *next;
+
+	list_for_each_entry_safe(cur, next, &cs->temp_at_states, list) {
+		list_del(&cur->list);
+		free_strings(cur);
+		kfree(cur);
+	}
+}
+
+static void gigaset_freebcs(struct bc_state *bcs)
+{
+	int i;
+
+	gig_dbg(DEBUG_INIT, "freeing bcs[%d]->hw", bcs->channel);
+	if (!bcs->cs->ops->freebcshw(bcs)) {
+		gig_dbg(DEBUG_INIT, "failed");
+	}
+
+	gig_dbg(DEBUG_INIT, "clearing bcs[%d]->at_state", bcs->channel);
+	clear_at_state(&bcs->at_state);
+	gig_dbg(DEBUG_INIT, "freeing bcs[%d]->skb", bcs->channel);
+
+	if (bcs->skb)
+		dev_kfree_skb(bcs->skb);
+	for (i = 0; i < AT_NUM; ++i) {
+		kfree(bcs->commands[i]);
+		bcs->commands[i] = NULL;
+	}
+}
+
+void gigaset_freecs(struct cardstate *cs)
+{
+	int i;
+	unsigned long flags;
+
+	if (!cs)
+		return;
+
+	down(&cs->sem);
+
+	if (!cs->bcs)
+		goto f_cs;
+	if (!cs->inbuf)
+		goto f_bcs;
+
+	spin_lock_irqsave(&cs->lock, flags);
+	atomic_set(&cs->running, 0);
+	spin_unlock_irqrestore(&cs->lock, flags); /* event handler and timer are
+						     not rescheduled below */
+
+	tasklet_kill(&cs->event_tasklet);
+	del_timer_sync(&cs->timer);
+
+	switch (cs->cs_init) {
+	default:
+		gigaset_if_free(cs);
+
+		gig_dbg(DEBUG_INIT, "clearing hw");
+		cs->ops->freecshw(cs);
+
+		//FIXME cmdbuf
+
+		/* fall through */
+	case 2: /* error in initcshw */
+		/* Deregister from LL */
+		make_invalid(cs, VALID_ID);
+		gig_dbg(DEBUG_INIT, "clearing iif");
+		gigaset_i4l_cmd(cs, ISDN_STAT_UNLOAD);
+
+		/* fall through */
+	case 1: /* error when regestering to LL */
+		gig_dbg(DEBUG_INIT, "clearing at_state");
+		clear_at_state(&cs->at_state);
+		dealloc_at_states(cs);
+
+		/* fall through */
+	case 0: /* error in one call to initbcs */
+		for (i = 0; i < cs->channels; ++i) {
+			gig_dbg(DEBUG_INIT, "clearing bcs[%d]", i);
+			gigaset_freebcs(cs->bcs + i);
+		}
+
+		clear_events(cs);
+		gig_dbg(DEBUG_INIT, "freeing inbuf");
+		kfree(cs->inbuf);
+	}
+f_bcs:	gig_dbg(DEBUG_INIT, "freeing bcs[]");
+	kfree(cs->bcs);
+f_cs:	gig_dbg(DEBUG_INIT, "freeing cs");
+	up(&cs->sem);
+	free_cs(cs);
+}
+EXPORT_SYMBOL_GPL(gigaset_freecs);
+
+void gigaset_at_init(struct at_state_t *at_state, struct bc_state *bcs,
+		     struct cardstate *cs, int cid)
+{
+	int i;
+
+	INIT_LIST_HEAD(&at_state->list);
+	at_state->waiting = 0;
+	at_state->getstring = 0;
+	at_state->pending_commands = 0;
+	at_state->timer_expires = 0;
+	at_state->timer_active = 0;
+	atomic_set(&at_state->timer_index, 0);
+	atomic_set(&at_state->seq_index, 0);
+	at_state->ConState = 0;
+	for (i = 0; i < STR_NUM; ++i)
+		at_state->str_var[i] = NULL;
+	at_state->int_var[VAR_ZDLE] = 0;
+	at_state->int_var[VAR_ZCTP] = -1;
+	at_state->int_var[VAR_ZSAU] = ZSAU_NULL;
+	at_state->cs = cs;
+	at_state->bcs = bcs;
+	at_state->cid = cid;
+	if (!cid)
+		at_state->replystruct = cs->tabnocid;
+	else
+		at_state->replystruct = cs->tabcid;
+}
+
+
+static void gigaset_inbuf_init(struct inbuf_t *inbuf, struct bc_state *bcs,
+			       struct cardstate *cs, int inputstate)
+/* inbuf->read must be allocated before! */
+{
+	atomic_set(&inbuf->head, 0);
+	atomic_set(&inbuf->tail, 0);
+	inbuf->cs = cs;
+	inbuf->bcs = bcs; /*base driver: NULL*/
+	inbuf->rcvbuf = NULL; //FIXME
+	inbuf->inputstate = inputstate;
+}
+
+/* Initialize the b-channel structure */
+static struct bc_state *gigaset_initbcs(struct bc_state *bcs,
+					struct cardstate *cs, int channel)
+{
+	int i;
+
+	bcs->tx_skb = NULL; //FIXME -> hw part
+
+	skb_queue_head_init(&bcs->squeue);
+
+	bcs->corrupted = 0;
+	bcs->trans_down = 0;
+	bcs->trans_up = 0;
+
+	gig_dbg(DEBUG_INIT, "setting up bcs[%d]->at_state", channel);
+	gigaset_at_init(&bcs->at_state, bcs, cs, -1);
+
+	bcs->rcvbytes = 0;
+
+#ifdef CONFIG_GIGASET_DEBUG
+	bcs->emptycount = 0;
+#endif
+
+	gig_dbg(DEBUG_INIT, "allocating bcs[%d]->skb", channel);
+	bcs->fcs = PPP_INITFCS;
+	bcs->inputstate = 0;
+	if (cs->ignoreframes) {
+		bcs->inputstate |= INS_skip_frame;
+		bcs->skb = NULL;
+	} else if ((bcs->skb = dev_alloc_skb(SBUFSIZE + HW_HDR_LEN)) != NULL)
+		skb_reserve(bcs->skb, HW_HDR_LEN);
+	else {
+		dev_warn(cs->dev, "could not allocate skb\n");
+		bcs->inputstate |= INS_skip_frame;
+	}
+
+	bcs->channel = channel;
+	bcs->cs = cs;
+
+	bcs->chstate = 0;
+	bcs->use_count = 1;
+	bcs->busy = 0;
+	bcs->ignore = cs->ignoreframes;
+
+	for (i = 0; i < AT_NUM; ++i)
+		bcs->commands[i] = NULL;
+
+	gig_dbg(DEBUG_INIT, "  setting up bcs[%d]->hw", channel);
+	if (cs->ops->initbcshw(bcs))
+		return bcs;
+
+	gig_dbg(DEBUG_INIT, "  failed");
+
+	gig_dbg(DEBUG_INIT, "  freeing bcs[%d]->skb", channel);
+	if (bcs->skb)
+		dev_kfree_skb(bcs->skb);
+
+	return NULL;
+}
+
+/* gigaset_initcs
+ * Allocate and initialize cardstate structure for Gigaset driver
+ * Calls hardware dependent gigaset_initcshw() function
+ * Calls B channel initialization function gigaset_initbcs() for each B channel
+ * parameters:
+ *	drv		hardware driver the device belongs to
+ *	channels	number of B channels supported by device
+ *	onechannel	!=0: B channel data and AT commands share one
+ *			     communication channel
+ *			==0: B channels have separate communication channels
+ *	ignoreframes	number of frames to ignore after setting up B channel
+ *	cidmode		!=0: start in CallID mode
+ *	modulename	name of driver module (used for I4L registration)
+ * return value:
+ *	pointer to cardstate structure
+ */
+struct cardstate *gigaset_initcs(struct gigaset_driver *drv, int channels,
+				 int onechannel, int ignoreframes,
+				 int cidmode, const char *modulename)
+{
+	struct cardstate *cs = NULL;
+	int i;
+
+	gig_dbg(DEBUG_INIT, "allocating cs");
+	cs = alloc_cs(drv);
+	if (!cs)
+		goto error;
+	gig_dbg(DEBUG_INIT, "allocating bcs[0..%d]", channels - 1);
+	cs->bcs = kmalloc(channels * sizeof(struct bc_state), GFP_KERNEL);
+	if (!cs->bcs)
+		goto error;
+	gig_dbg(DEBUG_INIT, "allocating inbuf");
+	cs->inbuf = kmalloc(sizeof(struct inbuf_t), GFP_KERNEL);
+	if (!cs->inbuf)
+		goto error;
+
+	cs->cs_init = 0;
+	cs->channels = channels;
+	cs->onechannel = onechannel;
+	cs->ignoreframes = ignoreframes;
+	INIT_LIST_HEAD(&cs->temp_at_states);
+	atomic_set(&cs->running, 0);
+	init_timer(&cs->timer); /* clear next & prev */
+	spin_lock_init(&cs->ev_lock);
+	atomic_set(&cs->ev_tail, 0);
+	atomic_set(&cs->ev_head, 0);
+	init_MUTEX_LOCKED(&cs->sem);
+	tasklet_init(&cs->event_tasklet, &gigaset_handle_event,
+		     (unsigned long) cs);
+	atomic_set(&cs->commands_pending, 0);
+	cs->cur_at_seq = 0;
+	cs->gotfwver = -1;
+	cs->open_count = 0;
+	cs->dev = NULL;
+	cs->tty = NULL;
+	atomic_set(&cs->cidmode, cidmode != 0);
+
+	//if(onechannel) { //FIXME
+		cs->tabnocid = gigaset_tab_nocid_m10x;
+		cs->tabcid = gigaset_tab_cid_m10x;
+	//} else {
+	//	cs->tabnocid = gigaset_tab_nocid;
+	//	cs->tabcid = gigaset_tab_cid;
+	//}
+
+	init_waitqueue_head(&cs->waitqueue);
+	cs->waiting = 0;
+
+	atomic_set(&cs->mode, M_UNKNOWN);
+	atomic_set(&cs->mstate, MS_UNINITIALIZED);
+
+	for (i = 0; i < channels; ++i) {
+		gig_dbg(DEBUG_INIT, "setting up bcs[%d].read", i);
+		if (!gigaset_initbcs(cs->bcs + i, cs, i))
+			goto error;
+	}
+
+	++cs->cs_init;
+
+	gig_dbg(DEBUG_INIT, "setting up at_state");
+	spin_lock_init(&cs->lock);
+	gigaset_at_init(&cs->at_state, NULL, cs, 0);
+	cs->dle = 0;
+	cs->cbytes = 0;
+
+	gig_dbg(DEBUG_INIT, "setting up inbuf");
+	if (onechannel) {			//FIXME distinction necessary?
+		gigaset_inbuf_init(cs->inbuf, cs->bcs, cs, INS_command);
+	} else
+		gigaset_inbuf_init(cs->inbuf, NULL,    cs, INS_command);
+
+	atomic_set(&cs->connected, 0);
+
+	gig_dbg(DEBUG_INIT, "setting up cmdbuf");
+	cs->cmdbuf = cs->lastcmdbuf = NULL;
+	spin_lock_init(&cs->cmdlock);
+	cs->curlen = 0;
+	cs->cmdbytes = 0;
+
+	gig_dbg(DEBUG_INIT, "setting up iif");
+	if (!gigaset_register_to_LL(cs, modulename)) {
+		err("register_isdn failed");
+		goto error;
+	}
+
+	make_valid(cs, VALID_ID);
+	++cs->cs_init;
+	gig_dbg(DEBUG_INIT, "setting up hw");
+	if (!cs->ops->initcshw(cs))
+		goto error;
+
+	++cs->cs_init;
+
+	gigaset_if_init(cs);
+
+	atomic_set(&cs->running, 1);
+	setup_timer(&cs->timer, timer_tick, (unsigned long) cs);
+	cs->timer.expires = jiffies + msecs_to_jiffies(GIG_TICK);
+	/* FIXME: can jiffies increase too much until the timer is added?
+	 * Same problem(?) with mod_timer() in timer_tick(). */
+	add_timer(&cs->timer);
+
+	gig_dbg(DEBUG_INIT, "cs initialized");
+	up(&cs->sem);
+	return cs;
+
+error:	if (cs)
+		up(&cs->sem);
+	gig_dbg(DEBUG_INIT, "failed");
+	gigaset_freecs(cs);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gigaset_initcs);
+
+/* ReInitialize the b-channel structure */
+/* e.g. called on hangup, disconnect */
+void gigaset_bcs_reinit(struct bc_state *bcs)
+{
+	struct sk_buff *skb;
+	struct cardstate *cs = bcs->cs;
+	unsigned long flags;
+
+	while ((skb = skb_dequeue(&bcs->squeue)) != NULL)
+		dev_kfree_skb(skb);
+
+	spin_lock_irqsave(&cs->lock, flags);
+	clear_at_state(&bcs->at_state);
+	bcs->at_state.ConState = 0;
+	bcs->at_state.timer_active = 0;
+	bcs->at_state.timer_expires = 0;
+	bcs->at_state.cid = -1;			/* No CID defined */
+	spin_unlock_irqrestore(&cs->lock, flags);
+
+	bcs->inputstate = 0;
+
+#ifdef CONFIG_GIGASET_DEBUG
+	bcs->emptycount = 0;
+#endif
+
+	bcs->fcs = PPP_INITFCS;
+	bcs->chstate = 0;
+
+	bcs->ignore = cs->ignoreframes;
+	if (bcs->ignore)
+		bcs->inputstate |= INS_skip_frame;
+
+
+	cs->ops->reinitbcshw(bcs);
+}
+
+static void cleanup_cs(struct cardstate *cs)
+{
+	struct cmdbuf_t *cb, *tcb;
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cs->lock, flags);
+
+	atomic_set(&cs->mode, M_UNKNOWN);
+	atomic_set(&cs->mstate, MS_UNINITIALIZED);
+
+	clear_at_state(&cs->at_state);
+	dealloc_at_states(cs);
+	free_strings(&cs->at_state);
+	gigaset_at_init(&cs->at_state, NULL, cs, 0);
+
+	kfree(cs->inbuf->rcvbuf);
+	cs->inbuf->rcvbuf = NULL;
+	cs->inbuf->inputstate = INS_command;
+	atomic_set(&cs->inbuf->head, 0);
+	atomic_set(&cs->inbuf->tail, 0);
+
+	cb = cs->cmdbuf;
+	while (cb) {
+		tcb = cb;
+		cb = cb->next;
+		kfree(tcb);
+	}
+	cs->cmdbuf = cs->lastcmdbuf = NULL;
+	cs->curlen = 0;
+	cs->cmdbytes = 0;
+	cs->gotfwver = -1;
+	cs->dle = 0;
+	cs->cur_at_seq = 0;
+	atomic_set(&cs->commands_pending, 0);
+	cs->cbytes = 0;
+
+	spin_unlock_irqrestore(&cs->lock, flags);
+
+	for (i = 0; i < cs->channels; ++i) {
+		gigaset_freebcs(cs->bcs + i);
+		if (!gigaset_initbcs(cs->bcs + i, cs, i))
+			break;			//FIXME error handling
+	}
+
+	if (cs->waiting) {
+		cs->cmd_result = -ENODEV;
+		cs->waiting = 0;
+		wake_up_interruptible(&cs->waitqueue);
+	}
+}
+
+
+int gigaset_start(struct cardstate *cs)
+{
+	if (down_interruptible(&cs->sem))
+		return 0;
+
+	atomic_set(&cs->connected, 1);
+
+	if (atomic_read(&cs->mstate) != MS_LOCKED) {
+		cs->ops->set_modem_ctrl(cs, 0, TIOCM_DTR|TIOCM_RTS);
+		cs->ops->baud_rate(cs, B115200);
+		cs->ops->set_line_ctrl(cs, CS8);
+		cs->control_state = TIOCM_DTR|TIOCM_RTS;
+	} else {
+		//FIXME use some saved values?
+	}
+
+	cs->waiting = 1;
+
+	if (!gigaset_add_event(cs, &cs->at_state, EV_START, NULL, 0, NULL)) {
+		cs->waiting = 0;
+		//FIXME what should we do?
+		goto error;
+	}
+
+	gig_dbg(DEBUG_CMD, "scheduling START");
+	gigaset_schedule_event(cs);
+
+	wait_event(cs->waitqueue, !cs->waiting);
+
+	/* set up device sysfs */
+	gigaset_init_dev_sysfs(cs);
+
+	up(&cs->sem);
+	return 1;
+
+error:
+	up(&cs->sem);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gigaset_start);
+
+void gigaset_shutdown(struct cardstate *cs)
+{
+	down(&cs->sem);
+
+	cs->waiting = 1;
+
+	if (!gigaset_add_event(cs, &cs->at_state, EV_SHUTDOWN, NULL, 0, NULL)) {
+		//FIXME what should we do?
+		goto exit;
+	}
+
+	gig_dbg(DEBUG_CMD, "scheduling SHUTDOWN");
+	gigaset_schedule_event(cs);
+
+	if (wait_event_interruptible(cs->waitqueue, !cs->waiting)) {
+		warn("%s: aborted", __func__);
+		//FIXME
+	}
+
+	if (atomic_read(&cs->mstate) != MS_LOCKED) {
+		//FIXME?
+		//gigaset_baud_rate(cs, B115200);
+		//gigaset_set_line_ctrl(cs, CS8);
+		//gigaset_set_modem_ctrl(cs, TIOCM_DTR|TIOCM_RTS, 0);
+		//cs->control_state = 0;
+	} else {
+		//FIXME use some saved values?
+	}
+
+	cleanup_cs(cs);
+
+exit:
+	up(&cs->sem);
+}
+EXPORT_SYMBOL_GPL(gigaset_shutdown);
+
+void gigaset_stop(struct cardstate *cs)
+{
+	down(&cs->sem);
+
+	/* clear device sysfs */
+	gigaset_free_dev_sysfs(cs);
+
+	atomic_set(&cs->connected, 0);
+
+	cs->waiting = 1;
+
+	if (!gigaset_add_event(cs, &cs->at_state, EV_STOP, NULL, 0, NULL)) {
+		//FIXME what should we do?
+		goto exit;
+	}
+
+	gig_dbg(DEBUG_CMD, "scheduling STOP");
+	gigaset_schedule_event(cs);
+
+	if (wait_event_interruptible(cs->waitqueue, !cs->waiting)) {
+		warn("%s: aborted", __func__);
+		//FIXME
+	}
+
+	/* Tell the LL that the device is not available .. */
+	gigaset_i4l_cmd(cs, ISDN_STAT_STOP); // FIXME move to event layer?
+
+	cleanup_cs(cs);
+
+exit:
+	up(&cs->sem);
+}
+EXPORT_SYMBOL_GPL(gigaset_stop);
+
+static LIST_HEAD(drivers);
+static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+
+struct cardstate *gigaset_get_cs_by_id(int id)
+{
+	unsigned long flags;
+	static struct cardstate *ret = NULL;
+	static struct cardstate *cs;
+	struct gigaset_driver *drv;
+	unsigned i;
+
+	spin_lock_irqsave(&driver_lock, flags);
+	list_for_each_entry(drv, &drivers, list) {
+		spin_lock(&drv->lock);
+		for (i = 0; i < drv->minors; ++i) {
+			if (drv->flags[i] & VALID_ID) {
+				cs = drv->cs + i;
+				if (cs->myid == id)
+					ret = cs;
+			}
+			if (ret)
+				break;
+		}
+		spin_unlock(&drv->lock);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&driver_lock, flags);
+	return ret;
+}
+
+void gigaset_debugdrivers(void)
+{
+	unsigned long flags;
+	static struct cardstate *cs;
+	struct gigaset_driver *drv;
+	unsigned i;
+
+	spin_lock_irqsave(&driver_lock, flags);
+	list_for_each_entry(drv, &drivers, list) {
+		gig_dbg(DEBUG_DRIVER, "driver %p", drv);
+		spin_lock(&drv->lock);
+		for (i = 0; i < drv->minors; ++i) {
+			gig_dbg(DEBUG_DRIVER, "  index %u", i);
+			gig_dbg(DEBUG_DRIVER, "    flags 0x%02x",
+				drv->flags[i]);
+			cs = drv->cs + i;
+			gig_dbg(DEBUG_DRIVER, "    cardstate %p", cs);
+			gig_dbg(DEBUG_DRIVER, "    minor_index %u",
+				cs->minor_index);
+			gig_dbg(DEBUG_DRIVER, "    driver %p", cs->driver);
+			gig_dbg(DEBUG_DRIVER, "    i4l id %d", cs->myid);
+		}
+		spin_unlock(&drv->lock);
+	}
+	spin_unlock_irqrestore(&driver_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gigaset_debugdrivers);
+
+struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty)
+{
+	if (tty->index < 0 || tty->index >= tty->driver->num)
+		return NULL;
+	return gigaset_get_cs_by_minor(tty->index + tty->driver->minor_start);
+}
+
+struct cardstate *gigaset_get_cs_by_minor(unsigned minor)
+{
+	unsigned long flags;
+	static struct cardstate *ret = NULL;
+	struct gigaset_driver *drv;
+	unsigned index;
+
+	spin_lock_irqsave(&driver_lock, flags);
+	list_for_each_entry(drv, &drivers, list) {
+		if (minor < drv->minor || minor >= drv->minor + drv->minors)
+			continue;
+		index = minor - drv->minor;
+		spin_lock(&drv->lock);
+		if (drv->flags[index] & VALID_MINOR)
+			ret = drv->cs + index;
+		spin_unlock(&drv->lock);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&driver_lock, flags);
+	return ret;
+}
+
+void gigaset_freedriver(struct gigaset_driver *drv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&driver_lock, flags);
+	list_del(&drv->list);
+	spin_unlock_irqrestore(&driver_lock, flags);
+
+	gigaset_if_freedriver(drv);
+	module_put(drv->owner);
+
+	kfree(drv->cs);
+	kfree(drv->flags);
+	kfree(drv);
+}
+EXPORT_SYMBOL_GPL(gigaset_freedriver);
+
+/* gigaset_initdriver
+ * Allocate and initialize gigaset_driver structure. Initialize interface.
+ * parameters:
+ *	minor		First minor number
+ *	minors		Number of minors this driver can handle
+ *	procname	Name of the driver
+ *	devname		Name of the device files (prefix without minor number)
+ *	devfsname	Devfs name of the device files without %d
+ * return value:
+ *	Pointer to the gigaset_driver structure on success, NULL on failure.
+ */
+struct gigaset_driver *gigaset_initdriver(unsigned minor, unsigned minors,
+					  const char *procname,
+					  const char *devname,
+					  const char *devfsname,
+					  const struct gigaset_ops *ops,
+					  struct module *owner)
+{
+	struct gigaset_driver *drv;
+	unsigned long flags;
+	unsigned i;
+
+	drv = kmalloc(sizeof *drv, GFP_KERNEL);
+	if (!drv)
+		return NULL;
+	if (!try_module_get(owner))
+		return NULL;
+
+	drv->cs = NULL;
+	drv->have_tty = 0;
+	drv->minor = minor;
+	drv->minors = minors;
+	spin_lock_init(&drv->lock);
+	drv->blocked = 0;
+	drv->ops = ops;
+	drv->owner = owner;
+	INIT_LIST_HEAD(&drv->list);
+
+	drv->cs = kmalloc(minors * sizeof *drv->cs, GFP_KERNEL);
+	if (!drv->cs)
+		goto out1;
+	drv->flags = kmalloc(minors * sizeof *drv->flags, GFP_KERNEL);
+	if (!drv->flags)
+		goto out2;
+
+	for (i = 0; i < minors; ++i) {
+		drv->flags[i] = 0;
+		drv->cs[i].driver = drv;
+		drv->cs[i].ops = drv->ops;
+		drv->cs[i].minor_index = i;
+	}
+
+	gigaset_if_initdriver(drv, procname, devname, devfsname);
+
+	spin_lock_irqsave(&driver_lock, flags);
+	list_add(&drv->list, &drivers);
+	spin_unlock_irqrestore(&driver_lock, flags);
+
+	return drv;
+
+out2:
+	kfree(drv->cs);
+out1:
+	kfree(drv);
+	module_put(owner);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gigaset_initdriver);
+
+static struct cardstate *alloc_cs(struct gigaset_driver *drv)
+{
+	unsigned long flags;
+	unsigned i;
+	static struct cardstate *ret = NULL;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (i = 0; i < drv->minors; ++i) {
+		if (!(drv->flags[i] & VALID_MINOR)) {
+			drv->flags[i] = VALID_MINOR;
+			ret = drv->cs + i;
+		}
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+	return ret;
+}
+
+static void free_cs(struct cardstate *cs)
+{
+	unsigned long flags;
+	struct gigaset_driver *drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->flags[cs->minor_index] = 0;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
+static void make_valid(struct cardstate *cs, unsigned mask)
+{
+	unsigned long flags;
+	struct gigaset_driver *drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->flags[cs->minor_index] |= mask;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
+static void make_invalid(struct cardstate *cs, unsigned mask)
+{
+	unsigned long flags;
+	struct gigaset_driver *drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->flags[cs->minor_index] &= ~mask;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
+/* For drivers without fixed assignment device<->cardstate (usb) */
+struct cardstate *gigaset_getunassignedcs(struct gigaset_driver *drv)
+{
+	unsigned long flags;
+	struct cardstate *cs = NULL;
+	unsigned i;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	if (drv->blocked)
+		goto exit;
+	for (i = 0; i < drv->minors; ++i) {
+		if ((drv->flags[i] & VALID_MINOR) &&
+		    !(drv->flags[i] & ASSIGNED)) {
+			drv->flags[i] |= ASSIGNED;
+			cs = drv->cs + i;
+			break;
+		}
+	}
+exit:
+	spin_unlock_irqrestore(&drv->lock, flags);
+	return cs;
+}
+EXPORT_SYMBOL_GPL(gigaset_getunassignedcs);
+
+void gigaset_unassign(struct cardstate *cs)
+{
+	unsigned long flags;
+	unsigned *minor_flags;
+	struct gigaset_driver *drv;
+
+	if (!cs)
+		return;
+	drv = cs->driver;
+	spin_lock_irqsave(&drv->lock, flags);
+	minor_flags = drv->flags + cs->minor_index;
+	if (*minor_flags & VALID_MINOR)
+		*minor_flags &= ~ASSIGNED;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gigaset_unassign);
+
+void gigaset_blockdriver(struct gigaset_driver *drv)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&drv->lock, flags);
+	drv->blocked = 1;
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gigaset_blockdriver);
+
+static int __init gigaset_init_module(void)
+{
+	/* in accordance with the principle of least astonishment,
+	 * setting the 'debug' parameter to 1 activates a sensible
+	 * set of default debug levels
+	 */
+	if (gigaset_debuglevel == 1)
+		gigaset_debuglevel = DEBUG_DEFAULT;
+
+	info(DRIVER_AUTHOR);
+	info(DRIVER_DESC);
+	return 0;
+}
+
+static void __exit gigaset_exit_module(void)
+{
+}
+
+module_init(gigaset_init_module);
+module_exit(gigaset_exit_module);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+
+MODULE_LICENSE("GPL");
