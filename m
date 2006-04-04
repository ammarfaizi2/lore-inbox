Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWDDAAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWDDAAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWDDAAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:00:02 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:16567 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964893AbWDCX7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:39 -0400
Date: Tue, 4 Apr 2006 02:00:25 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/13] isdn4linux: Siemens Gigaset drivers - code cleanup
Message-ID: <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch contains source code formatting cleanups for the Siemens
Gigaset drivers, such as line length, comments, removal of unused
declarations, and typo corrections. It does not introduce any
functional changes. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c   |   13 -
 drivers/isdn/gigaset/bas-gigaset.c |   41 +--
 drivers/isdn/gigaset/common.c      |   36 +-
 drivers/isdn/gigaset/ev-layer.c    |  289 ++++++++++------------
 drivers/isdn/gigaset/gigaset.h     |  468 ++++++++++++++++++++-----------------
 drivers/isdn/gigaset/i4l.c         |   40 +--
 drivers/isdn/gigaset/interface.c   |   18 -
 drivers/isdn/gigaset/isocdata.c    |   16 -
 drivers/isdn/gigaset/proc.c        |   12 
 drivers/isdn/gigaset/usb-gigaset.c |  127 ++--------
 10 files changed, 521 insertions(+), 539 deletions(-)

--- linux-2.6.16-git15/drivers/isdn/gigaset/gigaset.h	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:37:04.000000000 +0200
@@ -1,11 +1,16 @@
-/* Siemens Gigaset 307x driver
+/*
+ * Siemens Gigaset 307x driver
  * Common header file for all connection variants
  *
  * Written by Stefan Eilers <Eilers.Stefan@epost.de>
  *        and Hansjoerg Lipp <hjlipp@web.de>
  *
- * Version: $Id: gigaset.h,v 1.97.4.26 2006/02/04 18:28:16 hjlipp Exp $
- * ===========================================================================
+ * =====================================================================
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ * =====================================================================
  */
 
 #ifndef GIGASET_H
@@ -15,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/atomic.h>
 #include <linux/spinlock.h>
 #include <linux/isdnif.h>
 #include <linux/usb.h>
@@ -27,21 +31,22 @@
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/list.h>
+#include <asm/atomic.h>
 
 #define GIG_VERSION {0,5,0,0}
 #define GIG_COMPAT  {0,4,0,0}
 
-#define MAX_REC_PARAMS 10                         /* Max. number of params in response string */
-#define MAX_RESP_SIZE 512                         /* Max. size of a response string */
-#define HW_HDR_LEN 2                              /* Header size used to store ack info */
+#define MAX_REC_PARAMS 10	/* Max. number of params in response string */
+#define MAX_RESP_SIZE 512	/* Max. size of a response string */
+#define HW_HDR_LEN 2		/* Header size used to store ack info */
 
-#define MAX_EVENTS 64                          /* size of event queue */
+#define MAX_EVENTS 64		/* size of event queue */
 
 #define RBUFSIZE 8192
-#define SBUFSIZE 4096				/* sk_buff payload size */
+#define SBUFSIZE 4096		/* sk_buff payload size */
 
-#define MAX_BUF_SIZE (SBUFSIZE - 2)		/* Max. size of a data packet from LL */
-#define TRANSBUFSIZE 768			/* bytes per skb for transparent receive */
+#define TRANSBUFSIZE 768	/* bytes per skb for transparent receive */
+#define MAX_BUF_SIZE (SBUFSIZE - 2)	/* Max. size of a data packet from LL */
 
 /* compile time options */
 #define GIG_MAJOR 0
@@ -67,68 +72,108 @@
 
 #define MAXACT 3
 
-#define IFNULL(a)         if (unlikely(!(a)))
-#define IFNULLRET(a)      if (unlikely(!(a))) {err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); return; }
-#define IFNULLRETVAL(a,b) if (unlikely(!(a))) {err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); return (b); }
-#define IFNULLCONT(a)     if (unlikely(!(a))) {err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); continue; }
-#define IFNULLGOTO(a,b)   if (unlikely(!(a))) {err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); goto b; }
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
 
 extern int gigaset_debuglevel;	/* "needs" cast to (enum debuglevel) */
 
-/* any combination of these can be given with the 'debug=' parameter to insmod, e.g.
- * 'insmod usb_gigaset.o debug=0x2c' will set DEBUG_OPEN, DEBUG_CMD and DEBUG_INTR. */
+/* any combination of these can be given with the 'debug=' parameter to insmod,
+ * e.g. 'insmod usb_gigaset.o debug=0x2c' will set DEBUG_OPEN, DEBUG_CMD and
+ * DEBUG_INTR.
+ */
 enum debuglevel { /* up to 24 bits (atomic_t) */
-	DEBUG_REG	  = 0x0002, /* serial port I/O register operations */
+	DEBUG_REG	  = 0x0002,/* serial port I/O register operations */
 	DEBUG_OPEN	  = 0x0004, /* open/close serial port */
 	DEBUG_INTR	  = 0x0008, /* interrupt processing */
-	DEBUG_INTR_DUMP   = 0x0010, /* Activating hexdump debug output on interrupt
-				      requests, not available as run-time option */
+	DEBUG_INTR_DUMP   = 0x0010, /* Activating hexdump debug output on
+				       interrupt requests, not available as
+				       run-time option */
 	DEBUG_CMD	  = 0x00020, /* sent/received LL commands */
 	DEBUG_STREAM	  = 0x00040, /* application data stream I/O events */
 	DEBUG_STREAM_DUMP = 0x00080, /* application data stream content */
 	DEBUG_LLDATA	  = 0x00100, /* sent/received LL data */
-	DEBUG_INTR_0	  = 0x00200, /* serial port output interrupt processing */
+	DEBUG_INTR_0	  = 0x00200, /* serial port interrupt processing */
 	DEBUG_DRIVER	  = 0x00400, /* driver structure */
 	DEBUG_HDLC	  = 0x00800, /* M10x HDLC processing */
 	DEBUG_WRITE	  = 0x01000, /* M105 data write */
-	DEBUG_TRANSCMD    = 0x02000, /*AT-COMMANDS+RESPONSES*/
-	DEBUG_MCMD        = 0x04000, /*COMMANDS THAT ARE SENT VERY OFTEN*/
-	DEBUG_INIT	  = 0x08000, /* (de)allocation+initialization of data structures */
+	DEBUG_TRANSCMD    = 0x02000, /* AT-COMMANDS+RESPONSES */
+	DEBUG_MCMD        = 0x04000, /* COMMANDS THAT ARE SENT VERY OFTEN */
+	DEBUG_INIT	  = 0x08000, /* (de)allocation+initialization of data
+					structures */
 	DEBUG_LOCK	  = 0x10000, /* semaphore operations */
 	DEBUG_OUTPUT	  = 0x20000, /* output to device */
 	DEBUG_ISO         = 0x40000, /* isochronous transfers */
 	DEBUG_IF	  = 0x80000, /* character device operations */
-	DEBUG_USBREQ	  = 0x100000, /* USB communication (except payload data) */
-	DEBUG_LOCKCMD     = 0x200000, /* AT commands and responses when MS_LOCKED */
+	DEBUG_USBREQ	  = 0x100000, /* USB communication (except payload
+					 data) */
+	DEBUG_LOCKCMD     = 0x200000, /* AT commands and responses when
+					 MS_LOCKED */
 
-	DEBUG_ANY	  = 0x3fffff, /* print message if any of the others is activated */
+	DEBUG_ANY	  = 0x3fffff, /* print message if any of the others is
+					 activated */
 };
 
 #ifdef CONFIG_GIGASET_DEBUG
 #define DEBUG_DEFAULT (DEBUG_INIT | DEBUG_TRANSCMD | DEBUG_CMD | DEBUG_USBREQ)
-//#define DEBUG_DEFAULT (DEBUG_LOCK | DEBUG_INIT | DEBUG_TRANSCMD | DEBUG_CMD | DEBUF_IF | DEBUG_DRIVER | DEBUG_OUTPUT | DEBUG_INTR)
 #else
 #define DEBUG_DEFAULT 0
 #endif
 
-/* redefine syslog macros to prepend module name instead of entire source path */
-/* The space before the comma in ", ##" is needed by gcc 2.95 */
+/* redefine syslog macros to prepend module name instead of entire
+ * source path */
 #undef info
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
+#define info(format, arg...) \
+	printk(KERN_INFO "%s: " format "\n", \
+	       THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
 
 #undef notice
-#define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
+#define notice(format, arg...) \
+	printk(KERN_NOTICE "%s: " format "\n", \
+	       THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
 
 #undef warn
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
+#define warn(format, arg...) \
+	printk(KERN_WARNING "%s: " format "\n", \
+	       THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
 
 #undef err
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
+#define err(format, arg...) \
+	printk(KERN_ERR "%s: " format "\n", \
+	       THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
 
 #undef dbg
 #ifdef CONFIG_GIGASET_DEBUG
-#define dbg(level, format, arg...) do { if (unlikely(((enum debuglevel)gigaset_debuglevel) & (level))) \
-	printk(KERN_DEBUG "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg); } while (0)
+#define dbg(level, format, arg...) \
+	do { \
+		if (unlikely(((enum debuglevel)gigaset_debuglevel) & (level))) \
+			printk(KERN_DEBUG "%s: " format "\n", \
+			       THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" \
+			       , ## arg); \
+	} while (0)
 #else
 #define dbg(level, format, arg...) do {} while (0)
 #endif
@@ -148,13 +193,14 @@ void gigaset_dbg_buffer(enum debuglevel 
 #define ZSAU_UNKNOWN			-1
 
 /* USB control transfer requests */
-#define OUT_VENDOR_REQ			(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT)
-#define IN_VENDOR_REQ			(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT)
+#define OUT_VENDOR_REQ	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT)
+#define IN_VENDOR_REQ	(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT)
 
 /* int-in-events 3070 */
 #define HD_B1_FLOW_CONTROL		0x80
 #define HD_B2_FLOW_CONTROL		0x81
-#define HD_RECEIVEATDATA_ACK		(0x35)		// 3070		// att: HD_RECEIVE>>AT<<DATA_ACK
+#define HD_RECEIVEATDATA_ACK		(0x35)		// 3070
+						// att: HD_RECEIVE>>AT<<DATA_ACK
 #define HD_READY_SEND_ATDATA		(0x36)		// 3070
 #define HD_OPEN_ATCHANNEL_ACK		(0x37)		// 3070
 #define HD_CLOSE_ATCHANNEL_ACK		(0x38)		// 3070
@@ -181,17 +227,18 @@ void gigaset_dbg_buffer(enum debuglevel 
 #define	HD_CLOSE_ATCHANNEL		(0x29)		// 3070
 
 /* USB frames for isochronous transfer */
-#define BAS_FRAMETIME	1		/* number of milliseconds between frames */
-#define BAS_NUMFRAMES	8		/* number of frames per URB */
-#define BAS_MAXFRAME	16		/* allocated bytes per frame */
-#define BAS_NORMFRAME	8		/* send size without flow control */
-#define BAS_HIGHFRAME	10		/* "    "    with positive flow control */
-#define BAS_LOWFRAME	5		/* "    "    with negative flow control */
-#define BAS_CORRFRAMES	4		/* flow control multiplicator */
-
-#define BAS_INBUFSIZE	(BAS_MAXFRAME * BAS_NUMFRAMES) /* size of isochronous input buffer per URB */
-#define BAS_OUTBUFSIZE	4096		/* size of common isochronous output buffer */
-#define BAS_OUTBUFPAD	BAS_MAXFRAME	/* size of pad area for isochronous output buffer */
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
 
 #define BAS_INURBS	3
 #define BAS_OUTURBS	3
@@ -207,40 +254,40 @@ void gigaset_dbg_buffer(enum debuglevel 
 #define AT_NUM		7
 
 /* variables in struct at_state_t */
-#define VAR_ZSAU   0
-#define VAR_ZDLE   1
-#define VAR_ZVLS   2
-#define VAR_ZCTP   3
-#define VAR_NUM    4
-
-#define STR_NMBR   0
-#define STR_ZCPN   1
-#define STR_ZCON   2
-#define STR_ZBC    3
-#define STR_ZHLC   4
-#define STR_NUM    5
-
-#define EV_TIMEOUT      -105
-#define EV_IF_VER       -106
-#define EV_PROC_CIDMODE -107
-#define EV_SHUTDOWN     -108
-#define EV_START        -110
-#define EV_STOP         -111
-#define EV_IF_LOCK      -112
-#define EV_PROTO_L2     -113
-#define EV_ACCEPT       -114
-#define EV_DIAL         -115
-#define EV_HUP          -116
-#define EV_BC_OPEN      -117
-#define EV_BC_CLOSED    -118
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
 
 /* input state */
-#define INS_command     0x0001
-#define INS_DLE_char    0x0002
-#define INS_byte_stuff  0x0004
-#define INS_have_data   0x0008
-#define INS_skip_frame  0x0010
-#define INS_DLE_command 0x0020
+#define INS_command	0x0001
+#define INS_DLE_char	0x0002
+#define INS_byte_stuff	0x0004
+#define INS_have_data	0x0008
+#define INS_skip_frame	0x0010
+#define INS_DLE_command	0x0020
 #define INS_flag_hunt	0x0040
 
 /* channel state */
@@ -248,27 +295,27 @@ void gigaset_dbg_buffer(enum debuglevel 
 #define CHS_B_UP	0x02
 #define CHS_NOTIFY_LL	0x04
 
-#define ICALL_REJECT  0
-#define ICALL_ACCEPT  1
-#define ICALL_IGNORE  2
+#define ICALL_REJECT	0
+#define ICALL_ACCEPT	1
+#define ICALL_IGNORE	2
 
 /* device state */
-#define MS_UNINITIALIZED        0
-#define MS_INIT                 1
-#define MS_LOCKED               2
-#define MS_SHUTDOWN             3
-#define MS_RECOVER              4
-#define MS_READY                5
+#define MS_UNINITIALIZED	0
+#define MS_INIT			1
+#define MS_LOCKED		2
+#define MS_SHUTDOWN		3
+#define MS_RECOVER		4
+#define MS_READY		5
 
 /* mode */
-#define M_UNKNOWN       0
-#define M_CONFIG        1
-#define M_UNIMODEM      2
-#define M_CID           3
+#define M_UNKNOWN	0
+#define M_CONFIG	1
+#define M_UNIMODEM	2
+#define M_CID		3
 
 /* start mode */
-#define SM_LOCKED       0
-#define SM_ISDN         1 /* default */
+#define SM_LOCKED	0
+#define SM_ISDN		1 /* default */
 
 struct gigaset_ops;
 struct gigaset_driver;
@@ -283,27 +330,26 @@ struct ser_bc_state;
 struct bas_bc_state;
 
 struct reply_t {
-	int	resp_code;      /* RSP_XXXX */
-	int	min_ConState;   /* <0 => ignore */
-	int	max_ConState;   /* <0 => ignore */
-	int	parameter;      /* e.g. ZSAU_XXXX <0: ignore*/
-	int	new_ConState;   /* <0 => ignore */
-	int	timeout;        /* >0 => *HZ; <=0 => TOUT_XXXX*/
-	int	action[MAXACT]; /* ACT_XXXX */
-	char *command;        /* NULL==none */
+	int	resp_code;	/* RSP_XXXX */
+	int	min_ConState;	/* <0 => ignore */
+	int	max_ConState;	/* <0 => ignore */
+	int	parameter;	/* e.g. ZSAU_XXXX <0: ignore*/
+	int	new_ConState;	/* <0 => ignore */
+	int	timeout;	/* >0 => *HZ; <=0 => TOUT_XXXX*/
+	int	action[MAXACT];	/* ACT_XXXX */
+	char	*command;	/* NULL==none */
 };
 
 extern struct reply_t gigaset_tab_cid_m10x[];
 extern struct reply_t gigaset_tab_nocid_m10x[];
 
 struct inbuf_t {
-	unsigned char           *rcvbuf;                /* usb-gigaset receive buffer */
+	unsigned char		*rcvbuf;	/* usb-gigaset receive buffer */
 	struct bc_state		*bcs;
-	struct cardstate *cs;
-	int inputstate;
-
-	atomic_t head, tail;
-	unsigned char data[RBUFSIZE];
+	struct cardstate	*cs;
+	int			inputstate;
+	atomic_t		head, tail;
+	unsigned char		data[RBUFSIZE];
 };
 
 /* isochronous write buffer structure
@@ -319,16 +365,19 @@ struct inbuf_t {
  *   if writesem <= 0, data[write..read-1] is currently being written to
  * - idle contains the byte value to repeat when the end of valid data is
  *   reached; if nextread==write (buffer contains no data to send), either the
- *   BAS_OUTBUFPAD bytes immediately before data[write] (if write>=BAS_OUTBUFPAD)
- *   or those of the pad area (if write<BAS_OUTBUFPAD) are also filled with that
- *   value
- * - optionally, the following statistics on the buffer's usage can be collected:
- *   maxfill: maximum number of bytes occupied
- *   idlefills: number of times a frame of idle bytes is prepared
- *   emptygets: number of times the buffer was empty when a data frame was requested
+ *   BAS_OUTBUFPAD bytes immediately before data[write] (if
+ *   write>=BAS_OUTBUFPAD) or those of the pad area (if write<BAS_OUTBUFPAD)
+ *   are also filled with that value
+ * - optionally, the following statistics on the buffer's usage can be
+ *   collected:
+ *   maxfill:    maximum number of bytes occupied
+ *   idlefills:  number of times a frame of idle bytes is prepared
+ *   emptygets:  number of times the buffer was empty when a data frame was
+ *               requested
  *   backtoback: number of times two data packets were entered into the buffer
- *    without intervening idle flags
- *   nakedback: set if no idle flags have been inserted since the last data packet
+ *               without intervening idle flags
+ *   nakedback:  set if no idle flags have been inserted since the last data
+ *               packet
  */
 struct isowbuf_t {
 	atomic_t	read;
@@ -358,34 +407,28 @@ struct isow_urbctx_t {
  * it is currently assigned a B channel
  */
 struct at_state_t {
-	struct list_head        list;
-	int                     waiting;
-	int                     getstring;
+	struct list_head	list;
+	int			waiting;
+	int			getstring;
 	atomic_t		timer_index;
 	unsigned long		timer_expires;
 	int			timer_active;
-	unsigned int		ConState;                           /* State of connection */
-	struct reply_t          *replystruct;
-	int                     cid;
-	int                     int_var[VAR_NUM];   /* see VAR_XXXX */
-	char                    *str_var[STR_NUM];  /* see STR_XXXX */
-	unsigned                pending_commands;   /* see PC_XXXX */
-	atomic_t                seq_index;
+	unsigned int		ConState;	/* State of connection */
+	struct reply_t		*replystruct;
+	int			cid;
+	int			int_var[VAR_NUM];	/* see VAR_XXXX */
+	char			*str_var[STR_NUM];	/* see STR_XXXX */
+	unsigned		pending_commands;	/* see PC_XXXX */
+	atomic_t		seq_index;
 
-	struct cardstate    *cs;
-	struct bc_state         *bcs;
+	struct cardstate	*cs;
+	struct bc_state		*bcs;
 };
 
 struct resp_type_t {
 	unsigned char	*response;
-	int		resp_code;           /* RSP_XXXX */
-	int		type;                /* RT_XXXX */
-};
-
-struct prot_skb {
-	atomic_t		empty;
-	struct semaphore	*sem;
-	struct sk_buff		*skb;
+	int		resp_code;	/* RSP_XXXX */
+	int		type;		/* RT_XXXX */
 };
 
 struct event_t {
@@ -398,29 +441,29 @@ struct event_t {
 
 /* This buffer holds all information about the used B-Channel */
 struct bc_state {
-	struct sk_buff *tx_skb;                        /* Current transfer buffer to modem */
-	struct sk_buff_head squeue;	               /* B-Channel send Queue */
+	struct sk_buff *tx_skb;		/* Current transfer buffer to modem */
+	struct sk_buff_head squeue;	/* B-Channel send Queue */
 
 	/* Variables for debugging .. */
-	int corrupted;                                   /* Counter for corrupted packages */
-	int trans_down;                                  /* Counter of packages (downstream) */
-	int trans_up;                                    /* Counter of packages (upstream) */
+	int corrupted;			/* Counter for corrupted packages */
+	int trans_down;			/* Counter of packages (downstream) */
+	int trans_up;			/* Counter of packages (upstream) */
 
 	struct at_state_t at_state;
 	unsigned long rcvbytes;
 
 	__u16 fcs;
 	struct sk_buff *skb;
-	int inputstate; /* see INS_XXXX */
+	int inputstate;			/* see INS_XXXX */
 
 	int channel;
 
 	struct cardstate *cs;
 
-	unsigned chstate;			/* bitmap (CHS_*) */
+	unsigned chstate;		/* bitmap (CHS_*) */
 	int ignore;
-	unsigned	proto2;			/* Layer 2 protocol (ISDN_PROTO_L2_*) */
-	char		*commands[AT_NUM]; /* see AT_XXXX */
+	unsigned proto2;		/* Layer 2 protocol (ISDN_PROTO_L2_*) */
+	char *commands[AT_NUM];		/* see AT_XXXX */
 
 #ifdef CONFIG_GIGASET_DEBUG
 	int emptycount;
@@ -430,9 +473,9 @@ struct bc_state {
 
 	/* hardware drivers */
 	union {
-		struct ser_bc_state *ser;		 /* private data of serial hardware driver */
-		struct usb_bc_state *usb;		 /* private data of usb hardware driver */
-		struct bas_bc_state *bas;
+		struct ser_bc_state *ser;	/* serial hardware driver */
+		struct usb_bc_state *usb;	/* usb hardware driver (m105) */
+		struct bas_bc_state *bas;	/* usb hardware driver (base) */
 	} hw;
 };
 
@@ -443,22 +486,23 @@ struct cardstate {
 	const struct gigaset_ops *ops;
 
 	/* Stuff to handle communication */
-	//wait_queue_head_t initwait;
 	wait_queue_head_t waitqueue;
 	int waiting;
-	atomic_t mode;                       /* see M_XXXX */
-	atomic_t mstate;                     /* Modem state: see MS_XXXX */
-	                                     /* only changed by the event layer */
+	atomic_t mode;			/* see M_XXXX */
+	atomic_t mstate;		/* Modem state: see MS_XXXX */
+					/* only changed by the event layer */
 	int cmd_result;
 
 	int channels;
-	struct bc_state *bcs;                /* Array of struct bc_state */
+	struct bc_state *bcs;		/* Array of struct bc_state */
 
-	int onechannel;                      /* data and commands transmitted in one stream (M10x) */
+	int onechannel;			/* data and commands transmitted in one
+					   stream (M10x) */
 
 	spinlock_t lock;
-	struct at_state_t at_state;          /* at_state_t for cid == 0 */
-	struct list_head temp_at_states;     /* list of temporary "struct at_state_t"s without B channel */
+	struct at_state_t at_state;	/* at_state_t for cid == 0 */
+	struct list_head temp_at_states;/* list of temporary "struct
+					   at_state_t"s without B channel */
 
 	struct inbuf_t *inbuf;
 
@@ -474,36 +518,47 @@ struct cardstate {
 	unsigned fwver[4];
 	int gotfwver;
 
-	atomic_t running;                    /* !=0 if events are handled */
-	atomic_t connected;                  /* !=0 if hardware is connected */
+	atomic_t running;		/* !=0 if events are handled */
+	atomic_t connected;		/* !=0 if hardware is connected */
 
 	atomic_t cidmode;
 
-	int myid;                            /* id for communication with LL */
+	int myid;			/* id for communication with LL */
 	isdn_if iif;
 
 	struct reply_t *tabnocid;
 	struct reply_t *tabcid;
 	int cs_init;
-	int ignoreframes;                    /* frames to ignore after setting up the B channel */
-	struct semaphore sem;                /* locks this structure: */
-	                                     /*   connected is not changed, */
-	                                     /*   hardware_up is not changed, */
-	                                     /*   MState is not changed to or from MS_LOCKED */
+	int ignoreframes;		/* frames to ignore after setting up the
+					   B channel */
+	struct semaphore sem;		/* locks this structure: */
+					/*   connected is not changed, */
+					/*   hardware_up is not changed, */
+					/*   MState is not changed to or from
+					     MS_LOCKED */
 
 	struct timer_list timer;
 	int retry_count;
-	int dle;                             /* !=0 if modem commands/responses are dle encoded */
-	int cur_at_seq;                      /* sequence of AT commands being processed */
-	int curchannel;                      /* channel, those commands are meant for */
-	atomic_t commands_pending;           /* flag(s) in xxx.commands_pending have been set */
-	struct tasklet_struct event_tasklet; /* tasklet for serializing AT commands. Scheduled
-	                                      *   -> for modem reponses (and incomming data for M10x)
-	                                      *   -> on timeout
-	                                      *   -> after setting bits in xxx.at_state.pending_command
-	                                      *      (e.g. command from LL) */
-	struct tasklet_struct write_tasklet; /* tasklet for serial output
-					      * (not used in base driver) */
+	int dle;			/* !=0 if modem commands/responses are
+					   dle encoded */
+	int cur_at_seq;			/* sequence of AT commands being
+					   processed */
+	int curchannel;			/* channel, those commands are meant
+					   for */
+	atomic_t commands_pending;	/* flag(s) in xxx.commands_pending have
+					   been set */
+	struct tasklet_struct event_tasklet;
+					/* tasklet for serializing AT commands.
+					 * Scheduled
+					 *   -> for modem reponses (and
+					 *      incomming data for M10x)
+					 *   -> on timeout
+					 *   -> after setting bits in
+					 *      xxx.at_state.pending_command
+					 *      (e.g. command from LL) */
+	struct tasklet_struct write_tasklet;
+					/* tasklet for serial output
+					 * (not used in base driver) */
 
 	/* event queue */
 	struct event_t events[MAX_EVENTS];
@@ -516,16 +571,15 @@ struct cardstate {
 
 	/* hardware drivers */
 	union {
-		struct usb_cardstate *usb; /* private data of USB hardware driver */
-		struct ser_cardstate *ser; /* private data of serial hardware driver */
-		struct bas_cardstate *bas; /* private data of base hardware driver */
+		struct usb_cardstate *usb; /* USB hardware driver (m105) */
+		struct ser_cardstate *ser; /* serial hardware driver */
+		struct bas_cardstate *bas; /* USB hardware driver (base) */
 	} hw;
 };
 
 struct gigaset_driver {
 	struct list_head list;
-	spinlock_t lock;                       /* locks minor tables and blocked */
-	//struct semaphore sem;                /* locks this structure */
+	spinlock_t lock;		/* locks minor tables and blocked */
 	struct tty_driver *tty;
 	unsigned have_tty;
 	unsigned minor;
@@ -553,7 +607,8 @@ struct bas_bc_state {
 	struct isow_urbctx_t	isoouturbs[BAS_OUTURBS];
 	struct isow_urbctx_t	*isooutdone, *isooutfree, *isooutovfl;
 	struct isowbuf_t	*isooutbuf;
-	unsigned numsub;			/* submitted URB counter (for diagnostic messages only) */
+	unsigned numsub;			/* submitted URB counter (for
+						   diagnostic messages only) */
 	struct tasklet_struct	sent_tasklet;
 
 	/* isochronous input state */
@@ -563,24 +618,31 @@ struct bas_bc_state {
 	struct urb *isoindone;	                /* completed isoc read URB */
 	int loststatus;				/* status of dropped URB */
 	unsigned isoinlost;			/* number of bytes lost */
-	/* state of bit unstuffing algorithm (in addition to BC_state.inputstate) */
-	unsigned seqlen;			/* number of '1' bits not yet unstuffed */
-	unsigned inbyte, inbits;		/* collected bits for next byte */
+	/* state of bit unstuffing algorithm (in addition to
+	   BC_state.inputstate) */
+	unsigned seqlen;			/* number of '1' bits not yet
+						   unstuffed */
+	unsigned inbyte, inbits;		/* collected bits for next byte
+						*/
 	/* statistics */
 	unsigned goodbytes;			/* bytes correctly received */
-	unsigned alignerrs;			/* frames with incomplete byte at end */
+	unsigned alignerrs;			/* frames with incomplete byte
+						   at end */
 	unsigned fcserrs;			/* FCS errors */
 	unsigned frameerrs;			/* framing errors */
 	unsigned giants;			/* long frames */
 	unsigned runts;				/* short frames */
 	unsigned aborts;			/* HDLC aborts */
-	unsigned shared0s;			/* '0' bits shared between flags */
-	unsigned stolen0s;			/* '0' stuff bits also serving as leading flag bits */
+	unsigned shared0s;			/* '0' bits shared between flags
+						*/
+	unsigned stolen0s;			/* '0' stuff bits also serving
+						   as leading flag bits */
 	struct tasklet_struct rcvd_tasklet;
 };
 
 struct gigaset_ops {
-	/* Called from ev-layer.c/interface.c for sending AT commands to the device */
+	/* Called from ev-layer.c/interface.c for sending AT commands to the
+	   device */
 	int (*write_cmd)(struct cardstate *cs,
 	                 const unsigned char *buf, int len,
 	                 struct tasklet_struct *wake_tasklet);
@@ -604,7 +666,8 @@ struct gigaset_ops {
 	/* Called by gigaset_freecs() for freeing bcs->hw.xxx */
 	int (*freebcshw)(struct bc_state *bcs);
 
-	/* Called by gigaset_stop() or gigaset_bchannel_down() for resetting bcs->hw.xxx */
+	/* Called by gigaset_stop() or gigaset_bchannel_down() for resetting
+	   bcs->hw.xxx */
 	void (*reinitbcshw)(struct bc_state *bcs);
 
 	/* Called by gigaset_initcs() for setting up cs->hw.xxx */
@@ -613,13 +676,10 @@ struct gigaset_ops {
 	/* Called by gigaset_freecs() for freeing cs->hw.xxx */
 	void (*freecshw)(struct cardstate *cs);
 
-	///* Called by gigaset_stop() for killing URBs, shutting down the device, ...
-	//   hardwareup: ==0: don't try to shut down the device, hardware is really not accessible
-	//	       !=0: hardware still up */
-	//void (*stophw)(struct cardstate *cs, int hardwareup);
-
-	/* Called from common.c/interface.c for additional serial port control */
-	int (*set_modem_ctrl)(struct cardstate *cs, unsigned old_state, unsigned new_state);
+	/* Called from common.c/interface.c for additional serial port
+	   control */
+	int (*set_modem_ctrl)(struct cardstate *cs, unsigned old_state,
+			      unsigned new_state);
 	int (*baud_rate)(struct cardstate *cs, unsigned cflag);
 	int (*set_line_ctrl)(struct cardstate *cs, unsigned cflag);
 
@@ -667,7 +727,8 @@ void gigaset_isoc_input(struct inbuf_t *
 
 /* Called from bas-gigaset.c to process a block of data
  * received through the isochronous channel */
-void gigaset_isoc_receive(unsigned char *src, unsigned count, struct bc_state *bcs);
+void gigaset_isoc_receive(unsigned char *src, unsigned count,
+			  struct bc_state *bcs);
 
 /* Called from bas-gigaset.c to put a block of data
  * into the isochronous output buffer */
@@ -763,7 +824,8 @@ struct cardstate *gigaset_getunassignedc
 void gigaset_unassign(struct cardstate *cs);
 void gigaset_blockdriver(struct gigaset_driver *drv);
 
-/* Allocate and initialize card state. Calls hardware dependent gigaset_init[b]cs(). */
+/* Allocate and initialize card state. Calls hardware dependent
+   gigaset_init[b]cs(). */
 struct cardstate *gigaset_initcs(struct gigaset_driver *drv, int channels,
 				 int onechannel, int ignoreframes,
 				 int cidmode, const char *modulename);
--- linux-2.6.16-git15/drivers/isdn/gigaset/common.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/common.c	2006-04-02 18:37:04.000000000 +0200
@@ -11,10 +11,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: common.c,v 1.104.4.22 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -101,7 +97,8 @@ void gigaset_dbg_buffer(enum debuglevel 
 	} else {
 		numin = len < sizeof inbuf ? len : sizeof inbuf;
 		in = inbuf;
-		if (copy_from_user(inbuf, (const unsigned char __user *) buf, numin)) {
+		if (copy_from_user(inbuf, (const unsigned char __user *) buf,
+				   numin)) {
 			strncpy(inbuf, "<FAULT>", sizeof inbuf);
 			numin = sizeof "<FAULT>" - 1;
 		}
@@ -425,7 +422,8 @@ void gigaset_freecs(struct cardstate *cs
 
 	spin_lock_irqsave(&cs->lock, flags);
 	atomic_set(&cs->running, 0);
-	spin_unlock_irqrestore(&cs->lock, flags); /* event handler and timer are not rescheduled below */
+	spin_unlock_irqrestore(&cs->lock, flags); /* event handler and timer are
+						     not rescheduled below */
 
 	tasklet_kill(&cs->event_tasklet);
 	del_timer_sync(&cs->timer);
@@ -563,7 +561,6 @@ static struct bc_state *gigaset_initbcs(
 	if (cs->ops->initbcshw(bcs))
 		return bcs;
 
-//error:
 	dbg(DEBUG_INIT, "  failed");
 
 	dbg(DEBUG_INIT, "  freeing bcs[%d]->skb", channel);
@@ -580,7 +577,8 @@ static struct bc_state *gigaset_initbcs(
  * parameters:
  *      drv		hardware driver the device belongs to
  *	channels	number of B channels supported by device
- *	onechannel	!=0: B channel data and AT commands share one communication channel
+ *	onechannel	!=0: B channel data and AT commands share one
+ *			     communication channel
  *			==0: B channels have separate communication channels
  *	ignoreframes	number of frames to ignore after setting up B channel
  *	cidmode		!=0: start in CallID mode
@@ -619,7 +617,8 @@ struct cardstate *gigaset_initcs(struct 
 	atomic_set(&cs->ev_tail, 0);
 	atomic_set(&cs->ev_head, 0);
 	init_MUTEX_LOCKED(&cs->sem);
-	tasklet_init(&cs->event_tasklet, &gigaset_handle_event, (unsigned long) cs);
+	tasklet_init(&cs->event_tasklet, &gigaset_handle_event,
+		     (unsigned long) cs);
 	atomic_set(&cs->commands_pending, 0);
 	cs->cur_at_seq = 0;
 	cs->gotfwver = -1;
@@ -669,14 +668,6 @@ struct cardstate *gigaset_initcs(struct 
 	cs->curlen = 0;
 	cs->cmdbytes = 0;
 
-	/*
-	 * Tell the ISDN4Linux subsystem (the LL) that
-	 * a driver for a USB-Device is available !
-	 * If this is done, "isdnctrl" is able to bind a device for this driver even
-	 * if no physical usb-device is currently connected.
-	 * But this device will just be accessable if a physical USB device is connected
-	 * (via "gigaset_probe") .
-	 */
 	dbg(DEBUG_INIT, "setting up iif");
 	if (!gigaset_register_to_LL(cs, modulename)) {
 		err("register_isdn=>error");
@@ -713,7 +704,8 @@ error:	if (cs)
 }
 EXPORT_SYMBOL_GPL(gigaset_initcs);
 
-/* ReInitialize the b-channel structure */ /* e.g. called on hangup, disconnect */
+/* ReInitialize the b-channel structure */
+/* e.g. called on hangup, disconnect */
 void gigaset_bcs_reinit(struct bc_state *bcs)
 {
 	struct sk_buff *skb;
@@ -723,7 +715,7 @@ void gigaset_bcs_reinit(struct bc_state 
 	while ((skb = skb_dequeue(&bcs->squeue)) != NULL)
 		dev_kfree_skb(skb);
 
-	spin_lock_irqsave(&cs->lock, flags); //FIXME
+	spin_lock_irqsave(&cs->lock, flags);
 	clear_at_state(&bcs->at_state);
 	bcs->at_state.ConState = 0;
 	bcs->at_state.timer_active = 0;
@@ -805,7 +797,6 @@ int gigaset_start(struct cardstate *cs)
 {
 	if (down_interruptible(&cs->sem))
 		return 0;
-	//info("USB device for Gigaset 307x now attached to Dev %d", ucs->minor);
 
 	atomic_set(&cs->connected, 1);
 
@@ -954,7 +945,8 @@ void gigaset_debugdrivers(void)
 			dbg(DEBUG_DRIVER, "    flags 0x%02x", drv->flags[i]);
 			cs = drv->cs + i;
 			dbg(DEBUG_DRIVER, "    cardstate %p", cs);
-			dbg(DEBUG_DRIVER, "    minor_index %u", cs->minor_index);
+			dbg(DEBUG_DRIVER, "    minor_index %u",
+			    cs->minor_index);
 			dbg(DEBUG_DRIVER, "    driver %p", cs->driver);
 			dbg(DEBUG_DRIVER, "    i4l id %d", cs->myid);
 		}
@@ -1016,7 +1008,7 @@ EXPORT_SYMBOL_GPL(gigaset_freedriver);
  * parameters:
  *      minor           First minor number
  *      minors          Number of minors this driver can handle
- *      procname        Name of the driver (e.g. for /proc/tty/drivers, path in /proc/driver)
+ *      procname        Name of the driver
  *      devname         Name of the device files (prefix without minor number)
  *      devfsname       Devfs name of the device files without %d
  * return value:
--- linux-2.6.16-git15/drivers/isdn/gigaset/ev-layer.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:37:04.000000000 +0200
@@ -11,82 +11,78 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: ev-layer.c,v 1.4.2.18 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
 
 /* ========================================================== */
 /* bit masks for pending commands */
-#define PC_INIT       0x004
-#define PC_DLE0       0x008
-#define PC_DLE1       0x010
-#define PC_CID        0x080
-#define PC_NOCID      0x100
-#define PC_HUP        0x002
-#define PC_DIAL       0x001
-#define PC_ACCEPT     0x040
-#define PC_SHUTDOWN   0x020
-#define PC_CIDMODE    0x200
-#define PC_UMMODE     0x400
+#define PC_DIAL		0x001
+#define PC_HUP		0x002
+#define PC_INIT		0x004
+#define PC_DLE0		0x008
+#define PC_DLE1		0x010
+#define PC_SHUTDOWN	0x020
+#define PC_ACCEPT	0x040
+#define PC_CID		0x080
+#define PC_NOCID	0x100
+#define PC_CIDMODE	0x200
+#define PC_UMMODE	0x400
 
 /* types of modem responses */
-#define RT_NOTHING 0
-#define RT_ZSAU    1
-#define RT_RING    2
-#define RT_NUMBER  3
-#define RT_STRING  4
-#define RT_HEX     5
-#define RT_ZCAU    6
+#define RT_NOTHING	0
+#define RT_ZSAU		1
+#define RT_RING		2
+#define RT_NUMBER	3
+#define RT_STRING	4
+#define RT_HEX		5
+#define RT_ZCAU		6
 
 /* Possible ASCII responses */
-#define RSP_OK           0
-//#define RSP_BUSY       1
-//#define RSP_CONNECT    2
-#define RSP_ZGCI         3
-#define RSP_RING         4
-#define RSP_ZAOC         5
-#define RSP_ZCSTR        6
-#define RSP_ZCFGT        7
-#define RSP_ZCFG         8
-#define RSP_ZCCR         9
-#define RSP_EMPTY        10
-#define RSP_ZLOG         11
-#define RSP_ZCAU         12
-#define RSP_ZMWI         13
-#define RSP_ZABINFO      14
-#define RSP_ZSMLSTCHG    15
-#define RSP_VAR          100
-#define RSP_ZSAU         (RSP_VAR + VAR_ZSAU)
-#define RSP_ZDLE         (RSP_VAR + VAR_ZDLE)
-#define RSP_ZVLS         (RSP_VAR + VAR_ZVLS)
-#define RSP_ZCTP         (RSP_VAR + VAR_ZCTP)
-#define RSP_STR          (RSP_VAR + VAR_NUM)
-#define RSP_NMBR         (RSP_STR + STR_NMBR)
-#define RSP_ZCPN         (RSP_STR + STR_ZCPN)
-#define RSP_ZCON         (RSP_STR + STR_ZCON)
-#define RSP_ZBC          (RSP_STR + STR_ZBC)
-#define RSP_ZHLC         (RSP_STR + STR_ZHLC)
-#define RSP_ERROR       -1       /* ERROR              */
-#define RSP_WRONG_CID   -2       /* unknown cid in cmd */
-//#define RSP_EMPTY     -3
-#define RSP_UNKNOWN     -4       /* unknown response   */
-#define RSP_FAIL        -5       /* internal error     */
-#define RSP_INVAL       -6       /* invalid response   */
-
-#define RSP_NONE        -19
-#define RSP_STRING      -20
-#define RSP_NULL        -21
-//#define RSP_RETRYFAIL -22
-//#define RSP_RETRY     -23
-//#define RSP_SKIP      -24
-#define RSP_INIT        -27
-#define RSP_ANY         -26
-#define RSP_LAST        -28
-#define RSP_NODEV       -9
+#define RSP_OK		0
+//#define RSP_BUSY	1
+//#define RSP_CONNECT	2
+#define RSP_ZGCI	3
+#define RSP_RING	4
+#define RSP_ZAOC	5
+#define RSP_ZCSTR	6
+#define RSP_ZCFGT	7
+#define RSP_ZCFG	8
+#define RSP_ZCCR	9
+#define RSP_EMPTY	10
+#define RSP_ZLOG	11
+#define RSP_ZCAU	12
+#define RSP_ZMWI	13
+#define RSP_ZABINFO	14
+#define RSP_ZSMLSTCHG	15
+#define RSP_VAR		100
+#define RSP_ZSAU	(RSP_VAR + VAR_ZSAU)
+#define RSP_ZDLE	(RSP_VAR + VAR_ZDLE)
+#define RSP_ZVLS	(RSP_VAR + VAR_ZVLS)
+#define RSP_ZCTP	(RSP_VAR + VAR_ZCTP)
+#define RSP_STR		(RSP_VAR + VAR_NUM)
+#define RSP_NMBR	(RSP_STR + STR_NMBR)
+#define RSP_ZCPN	(RSP_STR + STR_ZCPN)
+#define RSP_ZCON	(RSP_STR + STR_ZCON)
+#define RSP_ZBC		(RSP_STR + STR_ZBC)
+#define RSP_ZHLC	(RSP_STR + STR_ZHLC)
+#define RSP_ERROR	-1	/* ERROR              */
+#define RSP_WRONG_CID	-2	/* unknown cid in cmd */
+//#define RSP_EMPTY	-3
+#define RSP_UNKNOWN	-4	/* unknown response   */
+#define RSP_FAIL	-5	/* internal error     */
+#define RSP_INVAL	-6	/* invalid response   */
+
+#define RSP_NONE	-19
+#define RSP_STRING	-20
+#define RSP_NULL	-21
+//#define RSP_RETRYFAIL	-22
+//#define RSP_RETRY	-23
+//#define RSP_SKIP	-24
+#define RSP_INIT	-27
+#define RSP_ANY		-26
+#define RSP_LAST	-28
+#define RSP_NODEV	-9
 
 /* actions for process_response */
 #define ACT_NOTHING		0
@@ -112,7 +108,7 @@
 #define ACT_DISCONNECT		20
 #define ACT_CONNECT		21
 #define ACT_REMOTEREJECT	22
-#define ACT_CONNTIMEOUT         23
+#define ACT_CONNTIMEOUT		23
 #define ACT_REMOTEHUP		24
 #define ACT_ABORTHUP		25
 #define ACT_ICALL		26
@@ -127,40 +123,40 @@
 #define ACT_ERROR		35
 #define ACT_ABORTCID		36
 #define ACT_ZCAU		37
-#define ACT_NOTIFY_BC_DOWN      38
-#define ACT_NOTIFY_BC_UP        39
-#define ACT_DIAL                40
-#define ACT_ACCEPT              41
-#define ACT_PROTO_L2            42
-#define ACT_HUP                 43
-#define ACT_IF_LOCK             44
-#define ACT_START               45
-#define ACT_STOP                46
-#define ACT_FAKEDLE0            47
-#define ACT_FAKEHUP             48
-#define ACT_FAKESDOWN           49
-#define ACT_SHUTDOWN            50
-#define ACT_PROC_CIDMODE        51
-#define ACT_UMODESET            52
-#define ACT_FAILUMODE           53
-#define ACT_CMODESET            54
-#define ACT_FAILCMODE           55
-#define ACT_IF_VER              56
+#define ACT_NOTIFY_BC_DOWN	38
+#define ACT_NOTIFY_BC_UP	39
+#define ACT_DIAL		40
+#define ACT_ACCEPT		41
+#define ACT_PROTO_L2		42
+#define ACT_HUP			43
+#define ACT_IF_LOCK		44
+#define ACT_START		45
+#define ACT_STOP		46
+#define ACT_FAKEDLE0		47
+#define ACT_FAKEHUP		48
+#define ACT_FAKESDOWN		49
+#define ACT_SHUTDOWN		50
+#define ACT_PROC_CIDMODE	51
+#define ACT_UMODESET		52
+#define ACT_FAILUMODE		53
+#define ACT_CMODESET		54
+#define ACT_FAILCMODE		55
+#define ACT_IF_VER		56
 #define ACT_CMD			100
 
 /* at command sequences */
-#define SEQ_NONE      0
-#define SEQ_INIT      100
-#define SEQ_DLE0      200
-#define SEQ_DLE1      250
-#define SEQ_CID       300
-#define SEQ_NOCID     350
-#define SEQ_HUP       400
-#define SEQ_DIAL      600
-#define SEQ_ACCEPT    720
-#define SEQ_SHUTDOWN  500
-#define SEQ_CIDMODE   10
-#define SEQ_UMMODE    11
+#define SEQ_NONE	0
+#define SEQ_INIT	100
+#define SEQ_DLE0	200
+#define SEQ_DLE1	250
+#define SEQ_CID		300
+#define SEQ_NOCID	350
+#define SEQ_HUP		400
+#define SEQ_DIAL	600
+#define SEQ_ACCEPT	720
+#define SEQ_SHUTDOWN	500
+#define SEQ_CIDMODE	10
+#define SEQ_UMMODE	11
 
 
 // 100: init, 200: dle0, 250:dle1, 300: get cid (dial), 350: "hup" (no cid), 400: hup, 500: reset, 600: dial, 700: ring
@@ -393,7 +389,7 @@ struct reply_t gigaset_tab_cid_m10x[] = 
 
 
 #if 0
-static struct reply_t tab_nocid[]= /* no dle mode */ //FIXME aenderungen uebernehmen
+static struct reply_t tab_nocid[]= /* no dle mode */ //FIXME
 {
 	/* resp_code, min_ConState, max_ConState, parameter, new_ConState, timeout, action, command */
 
@@ -401,7 +397,7 @@ static struct reply_t tab_nocid[]= /* no
 	{RSP_LAST,0,0,0,0,0,0}
 };
 
-static struct reply_t tab_cid[] = /* no dle mode */ //FIXME aenderungen uebernehmen
+static struct reply_t tab_cid[] = /* no dle mode */ //FIXME
 {
 	/* resp_code, min_ConState, max_ConState, parameter, new_ConState, timeout, action, command */
 
@@ -412,30 +408,30 @@ static struct reply_t tab_cid[] = /* no 
 
 static struct resp_type_t resp_type[]=
 {
-	/*{"",          RSP_EMPTY,  RT_NOTHING},*/
-	{"OK",        RSP_OK,     RT_NOTHING},
-	{"ERROR",     RSP_ERROR,  RT_NOTHING},
-	{"ZSAU",      RSP_ZSAU,   RT_ZSAU},
-	{"ZCAU",      RSP_ZCAU,   RT_ZCAU},
-	{"RING",      RSP_RING,   RT_RING},
-	{"ZGCI",      RSP_ZGCI,   RT_NUMBER},
-	{"ZVLS",      RSP_ZVLS,   RT_NUMBER},
-	{"ZCTP",      RSP_ZCTP,   RT_NUMBER},
-	{"ZDLE",      RSP_ZDLE,   RT_NUMBER},
-	{"ZCFGT",     RSP_ZCFGT,  RT_NUMBER},
-	{"ZCCR",      RSP_ZCCR,   RT_NUMBER},
-	{"ZMWI",      RSP_ZMWI,   RT_NUMBER},
-	{"ZHLC",      RSP_ZHLC,   RT_STRING},
-	{"ZBC",       RSP_ZBC,    RT_STRING},
-	{"NMBR",      RSP_NMBR,   RT_STRING},
-	{"ZCPN",      RSP_ZCPN,   RT_STRING},
-	{"ZCON",      RSP_ZCON,   RT_STRING},
-	{"ZAOC",      RSP_ZAOC,   RT_STRING},
-	{"ZCSTR",     RSP_ZCSTR,  RT_STRING},
-	{"ZCFG",      RSP_ZCFG,   RT_HEX},
-	{"ZLOG",      RSP_ZLOG,   RT_NOTHING},
-	{"ZABINFO",   RSP_ZABINFO, RT_NOTHING},
-	{"ZSMLSTCHG", RSP_ZSMLSTCHG, RT_NOTHING},
+	/*{"",		RSP_EMPTY,	RT_NOTHING},*/
+	{"OK",		RSP_OK,		RT_NOTHING},
+	{"ERROR",	RSP_ERROR,	RT_NOTHING},
+	{"ZSAU",	RSP_ZSAU,	RT_ZSAU},
+	{"ZCAU",	RSP_ZCAU,	RT_ZCAU},
+	{"RING",	RSP_RING,	RT_RING},
+	{"ZGCI",	RSP_ZGCI,	RT_NUMBER},
+	{"ZVLS",	RSP_ZVLS,	RT_NUMBER},
+	{"ZCTP",	RSP_ZCTP,	RT_NUMBER},
+	{"ZDLE",	RSP_ZDLE,	RT_NUMBER},
+	{"ZCFGT",	RSP_ZCFGT,	RT_NUMBER},
+	{"ZCCR",	RSP_ZCCR,	RT_NUMBER},
+	{"ZMWI",	RSP_ZMWI,	RT_NUMBER},
+	{"ZHLC",	RSP_ZHLC,	RT_STRING},
+	{"ZBC",		RSP_ZBC,	RT_STRING},
+	{"NMBR",	RSP_NMBR,	RT_STRING},
+	{"ZCPN",	RSP_ZCPN,	RT_STRING},
+	{"ZCON",	RSP_ZCON,	RT_STRING},
+	{"ZAOC",	RSP_ZAOC,	RT_STRING},
+	{"ZCSTR",	RSP_ZCSTR,	RT_STRING},
+	{"ZCFG",	RSP_ZCFG,	RT_HEX},
+	{"ZLOG",	RSP_ZLOG,	RT_NOTHING},
+	{"ZABINFO",	RSP_ZABINFO,	RT_NOTHING},
+	{"ZSMLSTCHG",	RSP_ZSMLSTCHG,	RT_NOTHING},
 	{NULL,0,0}
 };
 
@@ -837,7 +833,8 @@ static void schedule_init(struct cardsta
 	dbg(DEBUG_CMD, "Scheduling PC_INIT");
 }
 
-/* Add "AT" to a command, add the cid, dle encode it, send the result to the hardware. */
+/* Add "AT" to a command, add the cid, dle encode it, send the result to the
+   hardware. */
 static void send_command(struct cardstate *cs, const char *cmd, int cid,
                          int dle, gfp_t kmallocflags)
 {
@@ -966,19 +963,13 @@ static void start_dial(struct at_state_t
 
 	at_state->pending_commands |= PC_CID;
 	dbg(DEBUG_CMD, "Scheduling PC_CID");
-//#ifdef GIG_MAYINITONDIAL
-//	if (atomic_read(&cs->MState) == MS_UNKNOWN) {
-//		cs->at_state.pending_commands |= PC_INIT;
-//		dbg(DEBUG_CMD, "Scheduling PC_INIT");
-//	}
-//#endif
-	atomic_set(&cs->commands_pending, 1); //FIXME
+	atomic_set(&cs->commands_pending, 1);
 	return;
 
 error:
 	at_state->pending_commands |= PC_NOCID;
 	dbg(DEBUG_CMD, "Scheduling PC_NOCID");
-	atomic_set(&cs->commands_pending, 1); //FIXME
+	atomic_set(&cs->commands_pending, 1);
 	return;
 }
 
@@ -992,12 +983,12 @@ static void start_accept(struct at_state
 	if (retval == 0) {
 		at_state->pending_commands |= PC_ACCEPT;
 		dbg(DEBUG_CMD, "Scheduling PC_ACCEPT");
-		atomic_set(&cs->commands_pending, 1); //FIXME
+		atomic_set(&cs->commands_pending, 1);
 	} else {
 		//FIXME
 		at_state->pending_commands |= PC_HUP;
 		dbg(DEBUG_CMD, "Scheduling PC_HUP");
-		atomic_set(&cs->commands_pending, 1); //FIXME
+		atomic_set(&cs->commands_pending, 1);
 	}
 }
 
@@ -1037,9 +1028,8 @@ static void do_shutdown(struct cardstate
 	if (atomic_read(&cs->mstate) == MS_READY) {
 		atomic_set(&cs->mstate, MS_SHUTDOWN);
 		cs->at_state.pending_commands |= PC_SHUTDOWN;
-		atomic_set(&cs->commands_pending, 1); //FIXME
-		dbg(DEBUG_CMD, "Scheduling PC_SHUTDOWN"); //FIXME
-		//gigaset_schedule_event(cs); //FIXME
+		atomic_set(&cs->commands_pending, 1);
+		dbg(DEBUG_CMD, "Scheduling PC_SHUTDOWN");
 	} else
 		finish_shutdown(cs);
 }
@@ -1160,7 +1150,6 @@ static int do_lock(struct cardstate *cs)
 	mode = atomic_read(&cs->mode);
 	atomic_set(&cs->mstate, MS_LOCKED);
 	atomic_set(&cs->mode, M_UNKNOWN);
-	//FIXME reset card state / at states / bcs states
 
 	return mode;
 }
@@ -1173,7 +1162,6 @@ static int do_unlock(struct cardstate *c
 	atomic_set(&cs->mstate, MS_UNINITIALIZED);
 	atomic_set(&cs->mode, M_UNKNOWN);
 	gigaset_free_channels(cs);
-	//FIXME reset card state / at states / bcs states
 	if (atomic_read(&cs->connected))
 		schedule_init(cs, MS_INIT);
 
@@ -1203,7 +1191,6 @@ static void do_action(int action, struct
 		at_state->waiting = 1;
 		break;
 	case ACT_INIT:
-		//FIXME setup everything
 		cs->at_state.pending_commands &= ~PC_INIT;
 		cs->cur_at_seq = SEQ_NONE;
 		atomic_set(&cs->mode, M_UNIMODEM);
@@ -1213,7 +1200,7 @@ static void do_action(int action, struct
 			break;
 		}
 		cs->at_state.pending_commands |= PC_CIDMODE;
-		atomic_set(&cs->commands_pending, 1); //FIXME
+		atomic_set(&cs->commands_pending, 1);
 		dbg(DEBUG_CMD, "Scheduling PC_CIDMODE");
 		break;
 	case ACT_FAILINIT:
@@ -1428,7 +1415,8 @@ static void do_action(int action, struct
 		at_state->pending_commands |= PC_HUP;
 		atomic_set(&cs->commands_pending, 1);
 		break;
-	case ACT_GETSTRING: /* warning: RING, ZDLE, ... are not handled properly any more */
+	case ACT_GETSTRING: /* warning: RING, ZDLE, ...
+			       are not handled properly any more */
 		at_state->getstring = 1;
 		break;
 	case ACT_SETVER:
@@ -1522,7 +1510,7 @@ static void do_action(int action, struct
 		break;
 	case ACT_HUP:
 		at_state->pending_commands |= PC_HUP;
-		atomic_set(&cs->commands_pending, 1); //FIXME
+		atomic_set(&cs->commands_pending, 1);
 		dbg(DEBUG_CMD, "Scheduling PC_HUP");
 		break;
 
@@ -1649,7 +1637,8 @@ static void process_event(struct cardsta
 			dbg(DEBUG_ANY, "stopped waiting");
 	}
 
-	/* if the response belongs to a variable in at_state->int_var[VAR_XXXX] or at_state->str_var[STR_XXXX], set it */
+	/* if the response belongs to a variable in at_state->int_var[VAR_XXXX]
+	   or at_state->str_var[STR_XXXX], set it */
 	if (ev->type >= RSP_VAR && ev->type < RSP_VAR + VAR_NUM) {
 		index = ev->type - RSP_VAR;
 		at_state->int_var[index] = ev->parameter;
@@ -1657,13 +1646,15 @@ static void process_event(struct cardsta
 		index = ev->type - RSP_STR;
 		kfree(at_state->str_var[index]);
 		at_state->str_var[index] = ev->ptr;
-		ev->ptr = NULL; /* prevent process_events() from deallocating ptr */
+		ev->ptr = NULL; /* prevent process_events() from
+				   deallocating ptr */
 	}
 
 	if (ev->type == EV_TIMEOUT || ev->type == RSP_STRING)
 		at_state->getstring = 0;
 
-	/* Search row in dial array which matches modem response and current constate */
+	/* Search row in dial array which matches modem response and current
+	   constate */
 	for (;; rep++) {
 		rcode = rep->resp_code;
 		/* dbg (DEBUG_ANY, "rcode %d", rcode); */
@@ -1865,11 +1856,7 @@ static void process_command_flags(struct
 	if (cs->at_state.pending_commands & PC_CIDMODE) {
 		cs->at_state.pending_commands &= ~PC_CIDMODE;
 		if (atomic_read(&cs->mode) == M_UNIMODEM) {
-#if 0
-			cs->retry_count = 2;
-#else
 			cs->retry_count = 1;
-#endif
 			schedule_sequence(cs, &cs->at_state, SEQ_CIDMODE);
 			return;
 		}
--- linux-2.6.16-git15/drivers/isdn/gigaset/i4l.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/i4l.c	2006-04-02 18:37:04.000000000 +0200
@@ -11,10 +11,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: i4l.c,v 1.3.2.9 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -29,7 +25,8 @@
  * parameters:
  *	driverID	driver ID as assigned by LL
  *	channel		channel number
- *	ack		if != 0 LL wants to be notified on completion via statcallb(ISDN_STAT_BSENT)
+ *	ack		if != 0 LL wants to be notified on completion via
+ *			statcallb(ISDN_STAT_BSENT)
  *	skb		skb containing data to send
  * return value:
  *	number of accepted bytes
@@ -123,9 +120,6 @@ static int command_from_LL(isdn_ctrl *cn
 	//dbg(DEBUG_ANY, "Gigaset_HW: Receiving command");
 	gigaset_debugdrivers();
 
-	/* Terminate this call if no device is present. Bt if the command is "ISDN_CMD_LOCK" or
-	 * "ISDN_CMD_UNLOCK" then execute it due to the fact that they are device independent !
-	 */
 	//FIXME "remove test for &connected"
 	if ((!cs || !atomic_read(&cs->connected))) {
 		warn("LL tried to access unknown device with nr. %d",
@@ -222,15 +216,15 @@ static int command_from_LL(isdn_ctrl *cn
 		gigaset_schedule_event(cs);
 
 		break;
-	case ISDN_CMD_CLREAZ:               /* Do not signal incoming signals */ //FIXME
+	case ISDN_CMD_CLREAZ: /* Do not signal incoming signals */ //FIXME
 		dbg(DEBUG_ANY, "ISDN_CMD_CLREAZ");
 		break;
-	case ISDN_CMD_SETEAZ:               /* Signal incoming calls for given MSN */ //FIXME
+	case ISDN_CMD_SETEAZ: /* Signal incoming calls for given MSN */ //FIXME
 		dbg(DEBUG_ANY,
 		    "ISDN_CMD_SETEAZ (id:%d, channel: %ld, number: %s)",
 		    cntrl->driver, cntrl->arg, cntrl->parm.num);
 		break;
-	case ISDN_CMD_SETL2:                /* Set L2 to given protocol */
+	case ISDN_CMD_SETL2: /* Set L2 to given protocol */
 		dbg(DEBUG_ANY, "ISDN_CMD_SETL2 (Channel: %ld, Proto: %lx)",
 		     cntrl->arg & 0xff, (cntrl->arg >> 8));
 
@@ -250,7 +244,7 @@ static int command_from_LL(isdn_ctrl *cn
 		dbg(DEBUG_CMD, "scheduling PROTO_L2");
 		gigaset_schedule_event(cs);
 		break;
-	case ISDN_CMD_SETL3:              /* Set L3 to given protocol */
+	case ISDN_CMD_SETL3: /* Set L3 to given protocol */
 		dbg(DEBUG_ANY, "ISDN_CMD_SETL3 (Channel: %ld, Proto: %lx)",
 		     cntrl->arg & 0xff, (cntrl->arg >> 8));
 
@@ -396,10 +390,14 @@ int gigaset_isdn_setup_dial(struct at_st
 	}
 
 	if (bcs->commands[AT_MSN])
-		snprintf(bcs->commands[AT_MSN], length[AT_MSN], "^SMSN=%s\r", sp->eazmsn);
-	snprintf(bcs->commands[AT_BC   ], length[AT_BC   ], "^SBC=%s\r", bc);
-	snprintf(bcs->commands[AT_PROTO], length[AT_PROTO], "^SBPR=%u\r", proto);
-	snprintf(bcs->commands[AT_ISO  ], length[AT_ISO  ], "^SISO=%u\r", (unsigned)bcs->channel + 1);
+		snprintf(bcs->commands[AT_MSN], length[AT_MSN],
+			 "^SMSN=%s\r", sp->eazmsn);
+	snprintf(bcs->commands[AT_BC   ], length[AT_BC   ],
+		 "^SBC=%s\r", bc);
+	snprintf(bcs->commands[AT_PROTO], length[AT_PROTO],
+		 "^SBPR=%u\r", proto);
+	snprintf(bcs->commands[AT_ISO  ], length[AT_ISO  ],
+		 "^SISO=%u\r", (unsigned)bcs->channel + 1);
 
 	return 0;
 }
@@ -441,8 +439,10 @@ int gigaset_isdn_setup_accept(struct at_
 		}
 	}
 
-	snprintf(bcs->commands[AT_PROTO], length[AT_PROTO], "^SBPR=%u\r", proto);
-	snprintf(bcs->commands[AT_ISO  ], length[AT_ISO  ], "^SISO=%u\r", (unsigned) bcs->channel + 1);
+	snprintf(bcs->commands[AT_PROTO], length[AT_PROTO],
+		 "^SBPR=%u\r", proto);
+	snprintf(bcs->commands[AT_ISO  ], length[AT_ISO  ],
+		 "^SISO=%u\r", (unsigned) bcs->channel + 1);
 
 	return 0;
 }
@@ -542,9 +542,9 @@ int gigaset_register_to_LL(struct cardst
 		return -ENOMEM; //FIXME EINVAL/...??
 
 	iif->owner = THIS_MODULE;
-	iif->channels = cs->channels;                        /* I am supporting just one channel *//* I was supporting...*/
+	iif->channels = cs->channels;
 	iif->maxbufsize = MAX_BUF_SIZE;
-	iif->features = ISDN_FEATURE_L2_TRANS |   /* Our device is very advanced, therefore */
+	iif->features = ISDN_FEATURE_L2_TRANS |
 		ISDN_FEATURE_L2_HDLC |
 #ifdef GIG_X75
 		ISDN_FEATURE_L2_X75I |
--- linux-2.6.16-git15/drivers/isdn/gigaset/interface.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/interface.c	2006-04-02 18:37:04.000000000 +0200
@@ -9,8 +9,6 @@
  *    published by the Free Software Foundation; either version 2 of
  *    the License, or (at your option) any later version.
  * =====================================================================
- * Version: $Id: interface.c,v 1.14.4.15 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -173,7 +171,6 @@ static int if_open(struct tty_struct *tt
 		cs->tty = tty;
 		spin_unlock_irqrestore(&cs->lock, flags);
 		tty->low_latency = 1; //FIXME test
-		//FIXME
 	}
 
 	up(&cs->sem);
@@ -202,7 +199,6 @@ static void if_close(struct tty_struct *
 			spin_lock_irqsave(&cs->lock, flags);
 			cs->tty = NULL;
 			spin_unlock_irqrestore(&cs->lock, flags);
-			//FIXME
 		}
 	}
 
@@ -253,24 +249,26 @@ static int if_ioctl(struct tty_struct *t
 			gigaset_dbg_buffer(DEBUG_IF, "GIGASET_BRKCHARS",
 			                   6, (const unsigned char *) arg, 1);
 			if (!atomic_read(&cs->connected)) {
-				dbg(DEBUG_ANY, "can't communicate with unplugged device");
+				dbg(DEBUG_ANY,
+				    "can't communicate with unplugged device");
 				retval = -ENODEV;
 				break;
 			}
 			retval = copy_from_user(&buf,
-			                        (const unsigned char __user *) arg, 6)
+			           (const unsigned char __user *) arg, 6)
 			         ? -EFAULT : 0;
 			if (retval >= 0)
 				retval = cs->ops->brkchars(cs, buf);
 			break;
 		case GIGASET_VERSION:
-			retval = copy_from_user(version, (unsigned __user *) arg,
+			retval = copy_from_user(version,
+			                        (unsigned __user *) arg,
 			                        sizeof version) ? -EFAULT : 0;
 			if (retval >= 0)
 				retval = if_version(cs, version);
 			if (retval >= 0)
-				retval = copy_to_user((unsigned __user *) arg, version,
-				                      sizeof version)
+				retval = copy_to_user((unsigned __user *) arg,
+				                      version, sizeof version)
 				         ? -EFAULT : 0;
 			break;
 	        default:
@@ -575,7 +573,7 @@ static void if_set_termios(struct tty_st
 		new_state &= ~(TIOCM_DTR | TIOCM_RTS);
 	if (new_state != control_state) {
 		dbg(DEBUG_IF, "%u: new_state %x", cs->minor_index, new_state);
-		gigaset_set_modem_ctrl(cs, control_state, new_state); // FIXME: mct_u232.c sets the old state here. is this a bug?
+		gigaset_set_modem_ctrl(cs, control_state, new_state);
 		control_state = new_state;
 	}
 #endif
--- linux-2.6.16-git15/drivers/isdn/gigaset/proc.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/proc.c	2006-04-02 18:37:04.000000000 +0200
@@ -11,23 +11,21 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: proc.c,v 1.5.2.13 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
 #include <linux/ctype.h>
 
-static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct cardstate *cs = usb_get_intfdata(intf);
-	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode)); // FIXME use scnprintf for 13607 bit architectures (if PAGE_SIZE==4096)
+	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode));
 }
 
-static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct cardstate *cs = usb_get_intfdata(intf);
--- linux-2.6.16-git15/drivers/isdn/gigaset/bas-gigaset.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:37:04.000000000 +0200
@@ -13,10 +13,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: bas-gigaset.c,v 1.52.4.19 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -70,9 +66,6 @@ static struct usb_device_id gigaset_tabl
 
 MODULE_DEVICE_TABLE(usb, gigaset_table);
 
-/* Get a minor range for your devices from the usb maintainer */
-#define USB_SKEL_MINOR_BASE	200
-
 /*======================= local function prototypes =============================*/
 
 /* This function is called if a new device is connected to the USB port. It
@@ -240,7 +233,8 @@ static inline void dump_urb(enum debugle
 		    (unsigned long) urb->context,
 		    (unsigned long) urb->complete);
 		for (i = 0; i < urb->number_of_packets; i++) {
-			struct usb_iso_packet_descriptor *pifd = &urb->iso_frame_desc[i];
+			struct usb_iso_packet_descriptor *pifd
+				= &urb->iso_frame_desc[i];
 			dbg(level,
 			    "    {offset=%u, length=%u, actual_length=%u, "
 			    "status=%u}",
@@ -777,10 +771,11 @@ static void read_iso_callback(struct urb
 			urb->iso_frame_desc[i].actual_length = 0;
 		}
 		if (likely(atomic_read(&ubc->running))) {
-			urb->dev = bcs->cs->hw.bas->udev;	/* clobbered by USB subsystem */
+			urb->dev = bcs->cs->hw.bas->udev; /* clobbered by USB subsystem */
 			urb->transfer_flags = URB_ISO_ASAP;
 			urb->number_of_packets = BAS_NUMFRAMES;
-			dbg(DEBUG_ISO, "%s: isoc read overrun/resubmit", __func__);
+			dbg(DEBUG_ISO, "%s: isoc read overrun/resubmit",
+			    __func__);
 			rc = usb_submit_urb(urb, SLAB_ATOMIC);
 			if (unlikely(rc != 0)) {
 				err("could not resubmit isochronous read URB: %s",
@@ -989,7 +984,7 @@ static int submit_iso_write_urb(struct i
 	ubc = ucx->bcs->hw.bas;
 	IFNULLRETVAL(ubc, -EFAULT);
 
-	urb->dev = ucx->bcs->cs->hw.bas->udev;	/* clobbered by USB subsystem */
+	urb->dev = ucx->bcs->cs->hw.bas->udev; /* clobbered by USB subsystem */
 	urb->transfer_flags = URB_ISO_ASAP;
 	urb->transfer_buffer = ubc->isooutbuf->data;
 	urb->transfer_buffer_length = sizeof(ubc->isooutbuf->data);
@@ -1011,7 +1006,8 @@ static int submit_iso_write_urb(struct i
 		//dbg(DEBUG_ISO, "%s: frame %d length=%d", __func__, nframe, ifd->length);
 
 		/* retrieve block of data to send */
-		ifd->offset = gigaset_isowbuf_getbytes(ubc->isooutbuf, ifd->length);
+		ifd->offset = gigaset_isowbuf_getbytes(ubc->isooutbuf,
+						       ifd->length);
 		if (ifd->offset < 0) {
 			if (ifd->offset == -EBUSY) {
 				dbg(DEBUG_ISO, "%s: buffer busy at frame %d",
@@ -1123,7 +1119,8 @@ static void write_iso_tasklet(unsigned l
 			break;
 		case -EXDEV:			/* inspect individual frames */
 			/* assumptions (for lack of documentation):
-			 * - actual_length bytes of the frame in error are successfully sent
+			 * - actual_length bytes of the frame in error are
+			 *   successfully sent
 			 * - all following frames are not sent at all
 			 */
 			dbg(DEBUG_ISO, "%s: URB partially completed", __func__);
@@ -1260,7 +1257,8 @@ static void read_iso_tasklet(unsigned lo
 		switch (urb->status) {
 		case 0:				/* normal completion */
 			break;
-		case -EXDEV:			/* inspect individual frames (we do that anyway) */
+		case -EXDEV:			/* inspect individual frames
+						   (we do that anyway) */
 			dbg(DEBUG_ISO, "%s: URB partially completed", __func__);
 			break;
 		case -ENOENT:
@@ -1284,8 +1282,8 @@ static void read_iso_tasklet(unsigned lo
 		totleft = urb->actual_length;
 		for (frame = 0; totleft > 0 && frame < BAS_NUMFRAMES; frame++) {
 			if (unlikely(urb->iso_frame_desc[frame].status)) {
-				warn("isochronous read: frame %d: %s",
-				     frame, get_usb_statmsg(urb->iso_frame_desc[frame].status));
+				warn("isochronous read: frame %d: %s", frame,
+				     get_usb_statmsg(urb->iso_frame_desc[frame].status));
 				break;
 			}
 			numbytes = urb->iso_frame_desc[frame].actual_length;
@@ -1318,7 +1316,7 @@ static void read_iso_tasklet(unsigned lo
 			urb->iso_frame_desc[frame].status = 0;
 			urb->iso_frame_desc[frame].actual_length = 0;
 		}
-		urb->dev = bcs->cs->hw.bas->udev;	/* clobbered by USB subsystem */
+		urb->dev = bcs->cs->hw.bas->udev; /* clobbered by USB subsystem */
 		urb->transfer_flags = URB_ISO_ASAP;
 		urb->number_of_packets = BAS_NUMFRAMES;
 		if ((rc = usb_submit_urb(urb, SLAB_ATOMIC)) != 0) {
@@ -1792,7 +1790,8 @@ static int start_cbsend(struct cardstate
  *	cs		controller state structure
  *	buf		command string to send
  *	len		number of bytes to send (max. IF_WRITEBUF)
- *	wake_tasklet	tasklet to run when transmission is completed (NULL if none)
+ *	wake_tasklet	tasklet to run when transmission is completed
+ *			(NULL if none)
  * return value:
  *	number of bytes queued on success
  *	error code < 0 on error
@@ -1849,7 +1848,8 @@ static int gigaset_write_cmd(struct card
 
 /* gigaset_write_room
  * tty_driver.write_room interface routine
- * return number of characters the driver will accept to be written via gigaset_write_cmd
+ * return number of characters the driver will accept to be written via
+ * gigaset_write_cmd
  * parameter:
  *	controller state structure
  * return value:
@@ -2299,7 +2299,8 @@ static int __init bas_gigaset_init(void)
 		goto error;
 
 	/* allocate memory for our device state and intialize it */
-	cardstate = gigaset_initcs(driver, 2, 0, 0, cidmode, GIGASET_MODULENAME);
+	cardstate = gigaset_initcs(driver, 2, 0, 0, cidmode,
+				   GIGASET_MODULENAME);
 	if (!cardstate)
 		goto error;
 
--- linux-2.6.16-git15/drivers/isdn/gigaset/isocdata.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:37:04.000000000 +0200
@@ -10,10 +10,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: isocdata.c,v 1.2.2.5 2005/11/13 23:05:19 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -196,7 +192,8 @@ int gigaset_isowbuf_getbytes(struct isow
 				return -EBUSY;
 			/* write position could have changed */
 			if (limit >= (write = atomic_read(&iwb->write))) {
-				pbyte = iwb->data[write]; /* save partial byte */
+				pbyte = iwb->data[write]; /* save
+							     partial byte */
 				limit = write + BAS_OUTBUFPAD;
 				dbg(DEBUG_STREAM,
 				    "%s: filling %d->%d with %02x",
@@ -213,7 +210,8 @@ int gigaset_isowbuf_getbytes(struct isow
 				}
 				dbg(DEBUG_STREAM, "%s: restoring %02x at %d",
 				    __func__, pbyte, limit);
-				iwb->data[limit] = pbyte; /* restore partial byte */
+				iwb->data[limit] = pbyte; /* restore
+							     partial byte */
 				atomic_set(&iwb->write, limit);
 			}
 			isowbuf_donewrite(iwb);
@@ -508,11 +506,13 @@ int gigaset_isoc_buildframe(struct bc_st
 	switch (bcs->proto2) {
 	case ISDN_PROTO_L2_HDLC:
 		result = hdlc_buildframe(bcs->hw.bas->isooutbuf, in, len);
-		dbg(DEBUG_ISO, "%s: %d bytes HDLC -> %d", __func__, len, result);
+		dbg(DEBUG_ISO, "%s: %d bytes HDLC -> %d",
+		    __func__, len, result);
 		break;
 	default:			/* assume transparent */
 		result = trans_buildframe(bcs->hw.bas->isooutbuf, in, len);
-		dbg(DEBUG_ISO, "%s: %d bytes trans -> %d", __func__, len, result);
+		dbg(DEBUG_ISO, "%s: %d bytes trans -> %d",
+		    __func__, len, result);
 	}
 	return result;
 }
--- linux-2.6.16-git15/drivers/isdn/gigaset/usb-gigaset.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:37:04.000000000 +0200
@@ -13,10 +13,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: usb-gigaset.c,v 1.85.4.18 2006/02/04 18:28:16 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -62,10 +58,6 @@ static struct usb_device_id gigaset_tabl
 
 MODULE_DEVICE_TABLE(usb, gigaset_table);
 
-/* Get a minor range for your devices from the usb maintainer */
-#define USB_SKEL_MINOR_BASE	200
-
-
 /*
  * Control requests (empty fields: 00)
  *
@@ -122,29 +114,29 @@ static struct cardstate *cardstate = NUL
 
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver gigaset_usb_driver = {
-	.name =         GIGASET_MODULENAME,
-	.probe =        gigaset_probe,
-	.disconnect =   gigaset_disconnect,
-	.id_table =     gigaset_table,
+	.name =		GIGASET_MODULENAME,
+	.probe =	gigaset_probe,
+	.disconnect =	gigaset_disconnect,
+	.id_table =	gigaset_table,
 };
 
 struct usb_cardstate {
-	struct usb_device       *udev;                  /* save off the usb device pointer */
-	struct usb_interface    *interface;             /* the interface for this device */
-	atomic_t                busy;                   /* bulk output in progress */
-
-	/* Output buffer for commands (M105: and data)*/
-	unsigned char           *bulk_out_buffer;       /* the buffer to send data */
-	int                     bulk_out_size;          /* the size of the send buffer */
-	__u8                    bulk_out_endpointAddr;  /* the address of the bulk out endpoint */
-	struct urb              *bulk_out_urb;          /* the urb used to transmit data */
-
-	/* Input buffer for command responses (M105: and data)*/
-	int                     rcvbuf_size;            /* the size of the receive buffer */
-	struct urb              *read_urb;              /* the urb used to receive data */
-	__u8                    int_in_endpointAddr;    /* the address of the bulk in endpoint */
+	struct usb_device	*udev;		/* usb device pointer */
+	struct usb_interface	*interface;	/* interface for this device */
+	atomic_t		busy;		/* bulk output in progress */
+
+	/* Output buffer */
+	unsigned char		*bulk_out_buffer;	/* send buffer */
+	int			bulk_out_size;		/* send buffer size */
+	__u8			bulk_out_endpointAddr;	/* bulk out endpoint */
+	struct urb		*bulk_out_urb;		/* bulk out urb */
+
+	/* Input buffer */
+	int			rcvbuf_size;		/* rcv buffer */
+	struct urb		*read_urb;		/* rcv buffer size */
+	__u8			int_in_endpointAddr;    /* int in endpoint */
 
-	char                    bchars[6];              /* req. 0x19 */
+	char			bchars[6];		/* request 0x19 */
 };
 
 struct usb_bc_state {};
@@ -166,10 +158,11 @@ static int gigaset_set_modem_ctrl(struct
 	val = tiocm_to_gigaset(new_state);
 
 	dbg(DEBUG_USBREQ, "set flags 0x%02x with mask 0x%02x", val, mask);
+	// don't use this in an interrupt/BH
 	r = usb_control_msg(cs->hw.usb->udev,
 	                    usb_sndctrlpipe(cs->hw.usb->udev, 0), 7, 0x41,
 	                    (val & 0xff) | ((mask & 0xff) << 8), 0,
-	                    NULL, 0, 2000 /*timeout??*/); // don't use this in an interrupt/BH
+	                    NULL, 0, 2000 /* timeout? */);
 	if (r < 0)
 		return r;
 	//..
@@ -309,15 +302,12 @@ static int gigaset_close_bchannel(struct
 	return 0;
 }
 
-//void send_ack_to_LL(void *data);
 static int write_modem(struct cardstate *cs);
 static int send_cb(struct cardstate *cs, struct cmdbuf_t *cb);
 
 
-/* Handling of send queue. If there is already a skb opened, put data to
- * the transfer buffer by calling "write_modem". Otherwise take a new skb out of the queue.
- * This function will be called by the ISR via "transmit_chars" (USB: B-Channel Bulk callback handler
- * via immediate task queue) or by writebuf_from_LL if the LL wants to transmit data.
+/* Write tasklet handler: Continue sending current skb, or send command, or
+ * start sending an skb from the send queue.
  */
 static void gigaset_modem_fill(unsigned long data)
 {
@@ -345,7 +335,8 @@ static void gigaset_modem_fill(unsigned 
 				if (send_cb(cs, cb) < 0) {
 					dbg(DEBUG_OUTPUT,
 					    "modem_fill: send_cb failed");
-					again = 1; /* no callback will be called! */
+					again = 1; /* no callback will be
+						      called! */
 				}
 			} else { /* skbs to send? */
 				bcs->tx_skb = skb_dequeue(&bcs->squeue);
@@ -371,8 +362,7 @@ static void gigaset_modem_fill(unsigned 
 /**
  *	gigaset_read_int_callback
  *
- *      It is called if the data was received from the device. This is almost similiar to
- *      the interrupt service routine in the serial device.
+ *      It is called if the data was received from the device.
  */
 static void gigaset_read_int_callback(struct urb *urb, struct pt_regs *regs)
 {
@@ -381,13 +371,11 @@ static void gigaset_read_int_callback(st
 	struct cardstate *cs;
 	unsigned numbytes;
 	unsigned char *src;
-	//unsigned long flags;
 	struct inbuf_t *inbuf;
 
 	IFNULLRET(urb);
 	inbuf = (struct inbuf_t *) urb->context;
 	IFNULLRET(inbuf);
-	//spin_lock_irqsave(&inbuf->lock, flags);
 	cs = inbuf->cs;
 	IFNULLGOTO(cs, exit);
 	IFNULLGOTO(cardstate, exit);
@@ -422,7 +410,6 @@ static void gigaset_read_int_callback(st
 			resubmit = 1;
 	}
 exit:
-	//spin_unlock_irqrestore(&inbuf->lock, flags);
 	if (resubmit) {
 		r = usb_submit_urb(urb, SLAB_ATOMIC);
 		if (r)
@@ -431,11 +418,7 @@ exit:
 }
 
 
-/* This callback routine is called when data was transmitted to a B-Channel.
- * Therefore it has to check if there is still data to transmit. This
- * happens by calling modem_fill via task queue.
- *
- */
+/* This callback routine is called when data was transmitted to the device. */
 static void gigaset_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
 {
 	struct cardstate *cs = (struct cardstate *) urb->context;
@@ -448,8 +431,9 @@ static void gigaset_write_bulk_callback(
 	}
 #endif
 	if (urb->status)
-		err("bulk transfer failed (status %d)", -urb->status); /* That's all we can do. Communication problems
-		                                                           are handeled by timeouts or network protocols */
+		err("bulk transfer failed (status %d)", -urb->status);
+		/* That's all we can do. Communication problems
+		   are handeled by timeouts or network protocols */
 
 	atomic_set(&cs->hw.usb->busy, 0);
 	tasklet_schedule(&cs->write_tasklet);
@@ -503,16 +487,16 @@ static int send_cb(struct cardstate *cs,
 				atomic_set(&ucs->busy, 0);
 				err("could not submit urb (error %d).",
 				    -status);
-				cb->len = 0; /* skip urb => remove cb+wakeup in next loop cycle */
+				cb->len = 0; /* skip urb => remove cb+wakeup
+						in next loop cycle */
 			}
 		}
-	} while (cb && status); /* bei Fehler naechster Befehl //FIXME: ist das OK? */
+	} while (cb && status); /* next command on error */
 
 	return status;
 }
 
-/* Write string into transbuf and send it to modem.
- */
+/* Send command to device. */
 static int gigaset_write_cmd(struct cardstate *cs, const unsigned char *buf,
                              int len, struct tasklet_struct *wake_tasklet)
 {
@@ -604,7 +588,6 @@ static int gigaset_initbcshw(struct bc_s
 	if (!bcs->hw.usb)
 		return 0;
 
-	//bcs->hw.usb->trans_flg = READY_TO_TRNSMIT; /* B-Channel ready to transmit */
 	return 1;
 }
 
@@ -614,7 +597,6 @@ static void gigaset_reinitbcshw(struct b
 
 static void gigaset_freecshw(struct cardstate *cs)
 {
-	//FIXME
 	tasklet_kill(&cs->write_tasklet);
 	kfree(cs->hw.usb);
 }
@@ -644,19 +626,13 @@ static int gigaset_initcshw(struct cards
 	return 1;
 }
 
-/* Writes the data of the current open skb into the modem.
- * We have to protect against multiple calls until the
- * callback handler () is called , due to the fact that we
- * are just allowed to send data once to an endpoint. Therefore
- * we using "trans_flg" to synchonize ...
- */
+/* Send data from current skb to the device. */
 static int write_modem(struct cardstate *cs)
 {
 	int ret;
 	int count;
 	struct bc_state *bcs = &cs->bcs[0]; /* only one channel */
 	struct usb_cardstate *ucs = cs->hw.usb;
-	//unsigned long flags;
 
 	IFNULLRETVAL(bcs->tx_skb, -EINVAL);
 
@@ -720,12 +696,9 @@ static int gigaset_probe(struct usb_inte
 	struct usb_host_interface *hostif;
 	struct cardstate *cs = NULL;
 	struct usb_cardstate *ucs = NULL;
-	//struct usb_interface_descriptor *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
-	//isdn_ctrl command;
 	int buffer_size;
 	int alt;
-	//unsigned long flags;
 
 	info("%s: Check if device matches .. (Vendor: 0x%x, Product: 0x%x)",
 	    __func__, le16_to_cpu(udev->descriptor.idVendor),
@@ -766,29 +739,6 @@ static int gigaset_probe(struct usb_inte
 	}
 	ucs = cs->hw.usb;
 
-#if 0
-	if (usb_set_configuration(udev, udev->config[0].desc.bConfigurationValue) < 0) {
-		warn("set_configuration failed");
-		goto error;
-	}
-
-
-	if (usb_set_interface(udev, ifnum/*==0*/, alt/*==0*/) < 0) {
-		warn("usb_set_interface failed, device %d interface %d altsetting %d",
-		     udev->devnum, ifnum, alt);
-		goto error;
-	}
-#endif
-
-	/* set up the endpoint information */
-	/* check out the endpoints */
-	/* We will get 2 endpoints: One for sending commands to the device (bulk out) and one to
-	 * poll messages from the device(int in).
-	 * Therefore we will have an almost similiar situation as with our serial port handler.
-	 * If an connection will be established, we will have to create data in/out pipes
-	 * dynamically...
-	 */
-
 	endpoint = &hostif->endpoint[0].desc;
 
 	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
@@ -896,18 +846,15 @@ static void gigaset_disconnect(struct us
 
 	tasklet_kill(&cs->write_tasklet);
 
-	usb_kill_urb(ucs->bulk_out_urb);  /* FIXME: nur, wenn noetig */
-	//usb_kill_urb(ucs->urb_cmd_out);  /* FIXME: nur, wenn noetig */
+	usb_kill_urb(ucs->bulk_out_urb);  /* FIXME: only if active? */
 
 	kfree(ucs->bulk_out_buffer);
 	if (ucs->bulk_out_urb != NULL)
 		usb_free_urb(ucs->bulk_out_urb);
-	//if(ucs->urb_cmd_out != NULL)
-	//	usb_free_urb(ucs->urb_cmd_out);
 	kfree(cs->inbuf[0].rcvbuf);
 	if (ucs->read_urb != NULL)
 		usb_free_urb(ucs->read_urb);
-	ucs->read_urb = ucs->bulk_out_urb/*=ucs->urb_cmd_out*/=NULL;
+	ucs->read_urb = ucs->bulk_out_urb = NULL;
 	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
 
 	gigaset_unassign(cs);
--- linux-2.6.16-git15/drivers/isdn/gigaset/asyncdata.c	2006-03-29 16:21:02.000000000 +0200
+++ linux-2.6.16-gig-cleanup/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:37:04.000000000 +0200
@@ -11,10 +11,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  * =====================================================================
- * ToDo: ...
- * =====================================================================
- * Version: $Id: asyncdata.c,v 1.2.2.7 2005/11/13 23:05:18 hjlipp Exp $
- * =====================================================================
  */
 
 #include "gigaset.h"
@@ -58,7 +54,8 @@ static inline int cmd_loop(unsigned char
 			dbg(DEBUG_TRANSCMD, "%s: End of Command (%d Bytes)",
 			    __func__, cbytes);
 			cs->cbytes = cbytes;
-			gigaset_handle_modem_response(cs); /* can change cs->dle */
+			gigaset_handle_modem_response(cs); /* can change
+							      cs->dle */
 			cbytes = 0;
 
 			if (cs->dle &&
@@ -100,7 +97,8 @@ static inline int lock_loop(unsigned cha
 {
 	struct cardstate *cs = inbuf->cs;
 
-	gigaset_dbg_buffer(DEBUG_LOCKCMD, "received response", numbytes, src, 0);
+	gigaset_dbg_buffer(DEBUG_LOCKCMD, "received response",
+			   numbytes, src, 0);
 	gigaset_if_receive(cs, src, numbytes);
 
 	return numbytes;
@@ -392,8 +390,7 @@ void gigaset_m10x_input(struct inbuf_t *
 
 				if (!(inbuf->inputstate & INS_DLE_char)) {
 
-					/* FIXME Einfach je nach Modus Funktionszeiger in cs setzen [hier+hdlc_loop]?  */
-					/* FIXME Spart folgendes "if" und ermoeglicht andere Protokolle */
+					/* FIXME use function pointers?  */
 					if (inbuf->inputstate & INS_command)
 						procbytes = cmd_loop(c, src, numbytes, inbuf);
 					else if (inbuf->bcs->proto2 == ISDN_PROTO_L2_HDLC)
