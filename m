Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbUDTQO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUDTQO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUDTQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:14:58 -0400
Received: from gherkin.frus.com ([192.158.254.49]:14990 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S263399AbUDTQLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:11:15 -0400
Subject: [PATCH] sym53c500_cs PCMCIA SCSI driver (second round)
In-Reply-To: <20040417104527.A16676@infradead.org> "from Christoph Hellwig at
 Apr 17, 2004 10:45:27 am"
To: Christoph Hellwig <hch@infradead.org>
Date: Tue, 20 Apr 2004 11:11:11 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM767678912-1331-0_
Content-Transfer-Encoding: 7bit
Message-Id: <20040420161111.3DCC9DBE4@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM767678912-1331-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

(Summary -- new version of sym53c500_cs driver attached.)

Christoph Hellwig wrote:
>  - the driver doesn't even try to deal with multiple HBAs
> 
> It looks like nsp_cs at least tries to :-)

I'm not sure that nsp_cs does much more than assign a value to the
"unique_id" member of the scsi_host structure (base port), and I
probably missed what I was looking for, but I can certainly do as
much :-).  Is there any way to test whether the driver code can
support multiple HBAs short of having more than one?

> Hey, you don't need to apologize.   Anyt 2.6 driver is better than none and
> your looks quite okay from the functional standpoint.  We just need to have
> a little higher bars for new drivers as we already have lots of maintaince
> overhead for old and sloppy written drivers.

Thank you for the explanation: clearly I don't want to increase the
maintenance burden on myself and/or anyone else.

Attached is the second attempt at a 2.6 PCMCIA driver for SCSI cards
based on the Symbios 53c500 controller.  The patch set was tested with
(and applies cleanly to) 2.6.5.  As requested, the driver source has
been consolidated into a single file.  All remnants of code that might
have supported non-PCMCIA host adapters have been ripped out, which
allowed for the requested streamlining of the detection logic: Card
Services is doing most of the heavy lifting in that area anyway :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM767678912-1331-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch05_sym53c500

--- linux/drivers/scsi/pcmcia/Kconfig.orig	Fri Apr 16 16:00:41 2004
+++ linux/drivers/scsi/pcmcia/Kconfig	Fri Apr  9 20:17:36 2004
@@ -69,4 +69,14 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called qlogic_cs.
 
+config PCMCIA_SYM53C500
+	tristate "Symbios 53c500 PCMCIA support"
+	depends on m
+	help
+	  Say Y here if you have a New Media Bus Toaster or other PCMCIA
+	  SCSI adapter based on the Symbios 53c500 controller.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sym53c500_cs.
+
 endmenu
--- linux/drivers/scsi/pcmcia/Makefile.orig	Fri Apr 16 16:00:41 2004
+++ linux/drivers/scsi/pcmcia/Makefile	Fri Apr 16 20:23:44 2004
@@ -6,6 +6,7 @@
 obj-$(CONFIG_PCMCIA_FDOMAIN)	+= fdomain_cs.o
 obj-$(CONFIG_PCMCIA_AHA152X)	+= aha152x_cs.o
 obj-$(CONFIG_PCMCIA_NINJA_SCSI)	+= nsp_cs.o
+obj-$(CONFIG_PCMCIA_SYM53C500)	+= sym53c500_cs.o
 
 aha152x_cs-objs	:= aha152x_stub.o aha152x_core.o
 fdomain_cs-objs	:= fdomain_stub.o fdomain_core.o
--- linux/drivers/scsi/pcmcia/sym53c500_cs.c.orig	Fri Apr 16 16:05:19 2004
+++ linux/drivers/scsi/pcmcia/sym53c500_cs.c	Tue Apr 20 10:54:55 2004
@@ -0,0 +1,1150 @@
+/*
+*  sym53c500_cs.c	Bob Tracy (rct@frus.com)
+*
+*  A rewrite of the pcmcia-cs add-on driver for newer (circa 1997)
+*  New Media Bus Toaster PCMCIA SCSI cards using the Symbios Logic
+*  53c500 controller.  For inclusion in the 2.6 and later kernel
+*  source trees.  The pcmcia-cs add-on version of this driver is
+*  not supported beyond 2.4.
+*
+*  The rewrite was long overdue, and the 2.6 kernel forced the issue.
+*  All the USE_BIOS code has been ripped out.  It was never used, and
+*  could not have worked anyway.  USE_DMA has gone bye-bye too.
+*
+*  The original pcmcia-cs add-on driver consisted of three files
+*  with history/copyright information as follows:
+*
+*  SYM53C500.h
+*	Bob Tracy (rct@frus.com)
+*	Original by Tom Corner (tcorner@via.at).
+*	Adapted from NCR53c406a.h which is Copyrighted (C) 1994
+*	Normunds Saumanis (normunds@rx.tech.swh.lv)
+*
+*  SYM53C500.c
+*	Bob Tracy (rct@frus.com)
+*	Original driver by Tom Corner (tcorner@via.at) was adapted
+*	from NCR53c406a.c which is Copyrighted (C) 1994, 1995, 1996 
+*	Normunds Saumanis (normunds@fi.ibm.com)
+*
+*  sym53c500.c
+*	Bob Tracy (rct@frus.com)
+*	Original by Tom Corner (tcorner@via.at) was adapted from a
+*	driver for the Qlogic SCSI card written by
+*	David Hinds (dhinds@allegro.stanford.edu).
+* 
+*  This program is free software; you can redistribute it and/or modify it
+*  under the terms of the GNU General Public License as published by the
+*  Free Software Foundation; either version 2, or (at your option) any
+*  later version.
+*
+*  This program is distributed in the hope that it will be useful, but
+*  WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+*  General Public License for more details.
+*/
+
+#define SYM53C500_DEBUG 0
+#define VERBOSE_SYM53C500_DEBUG 0
+
+/* Set this to 0 if you encounter kernel lockups while transferring 
+ * data in PIO mode */
+#define USE_FAST_PIO 1
+
+/* =============== End of user configurable parameters ============== */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/proc_fs.h>
+#include <linux/stat.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/bitops.h>
+#include <asm/irq.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/spinlock.h>
+
+#include <scsi/scsi_ioctl.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_host.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/cistpl.h>
+#include <pcmcia/ds.h>
+#include <pcmcia/ciscode.h>
+
+/* A useful macro... */
+#define MIN(a, b)	((a) > (b) ? (b) : (a))
+
+#ifndef NULL
+#define NULL 0
+#endif
+
+/* Function prototypes. */
+const char *SYM53C500_info(struct Scsi_Host *);
+int SYM53C500_queue(struct scsi_cmnd *, void (*done)(struct scsi_cmnd *));
+int SYM53C500_abort(struct scsi_cmnd *);
+int SYM53C500_device_reset(struct scsi_cmnd *);
+int SYM53C500_bus_reset(struct scsi_cmnd *);
+int SYM53C500_host_reset(struct scsi_cmnd *);
+int SYM53C500_biosparm(struct scsi_device *, struct block_device *, sector_t, int *);
+int SYM53C500_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
+
+/* Static function prototypes */
+static dev_link_t *SYM53C500_attach(void);
+static void SYM53C500_config(dev_link_t *);
+static void SYM53C500_detach(dev_link_t *);
+static int SYM53C500_event(event_t event, int priority, event_callback_args_t *args);
+static void SYM53C500_intr(int, void *, struct pt_regs *);
+static void SYM53C500_release(dev_link_t *link);
+static void chip_init(void);
+static void calc_port_addr(void);
+static irqreturn_t do_SYM53C500_intr(int, void *, struct pt_regs *);
+
+/* ================================================================== */
+
+#ifdef PCMCIA_DEBUG
+static int pc_debug = PCMCIA_DEBUG;
+MODULE_PARM(pc_debug, "i");
+#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
+static char *version =
+"sym53c500_cs.c 0.7 2004/04/01 14:15:58 (Bob Tracy)";
+#else
+#define DEBUG(n, args...)
+#endif
+
+/* ================================================================== */
+
+/* Parameters that can be set with 'insmod' */
+
+/* Bit map of interrupts to choose from */
+static unsigned int irq_mask = 0xdeb8;	/* 3, 6, 7, 9-12, 14, 15 */
+static int irq_list[4] = { -1 };
+
+MODULE_PARM(irq_mask, "i");
+MODULE_PARM(irq_list, "1-4i");
+
+/* ================================================================== */
+
+#define SYNC_MODE 0 		/* Synchronous transfer mode */
+
+/* Default configuration */
+#define C1_IMG   0x07		/* ID=7 */
+#define C2_IMG   0x48		/* FE SCSI2 */
+#define C3_IMG   0x20		/* CDB */
+#define C4_IMG   0x04		/* ANE */
+#define C5_IMG   0xa4		/*? changed from b6= AA PI SIE POL */
+#define C7_IMG   0x80		/* added for SYM53C500 t. corner */
+
+#define REG0 (outb(C4_IMG, CONFIG4)) /* select register set 0 */
+#define REG1 outb(C7_IMG, CONFIG7); outb(C5_IMG, CONFIG5) /* select register set 1 */
+
+#if SYM53C500_DEBUG
+#define DEB(x) x
+#else
+#define DEB(x)
+#endif
+
+#if VERBOSE_SYM53C500_DEBUG
+#define VDEB(x) x
+#else
+#define VDEB(x)
+#endif
+
+#define LOAD_DMA_COUNT(count) \
+  outb(count & 0xff, TC_LSB); \
+  outb((count >> 8) & 0xff, TC_MSB); \
+  outb((count >> 16) & 0xff, TC_HIGH);
+
+/* Chip commands */
+#define DMA_OP               0x80
+
+#define SCSI_NOP             0x00
+#define FLUSH_FIFO           0x01
+#define CHIP_RESET           0x02
+#define SCSI_RESET           0x03
+#define RESELECT             0x40
+#define SELECT_NO_ATN        0x41
+#define SELECT_ATN           0x42
+#define SELECT_ATN_STOP      0x43
+#define ENABLE_SEL           0x44
+#define DISABLE_SEL          0x45
+#define SELECT_ATN3          0x46
+#define RESELECT3            0x47
+#define TRANSFER_INFO        0x10
+#define INIT_CMD_COMPLETE    0x11
+#define MSG_ACCEPT           0x12
+#define TRANSFER_PAD         0x18
+#define SET_ATN              0x1a
+#define RESET_ATN            0x1b
+#define SEND_MSG             0x20
+#define SEND_STATUS          0x21
+#define SEND_DATA            0x22
+#define DISCONN_SEQ          0x23
+#define TERMINATE_SEQ        0x24
+#define TARG_CMD_COMPLETE    0x25
+#define DISCONN              0x27
+#define RECV_MSG             0x28
+#define RECV_CMD             0x29
+#define RECV_DATA            0x2a
+#define RECV_CMD_SEQ         0x2b
+#define TARGET_ABORT_DMA     0x04
+
+/* ================================================================== */
+
+/*
+*  the following will set the monitor border color
+*  (useful to find where things crash or get stuck)
+*
+*  1 = blue
+*  2 = green
+*  3 = cyan
+*  4 = red
+*  5 = magenta
+*  6 = yellow
+*  7 = white
+*/
+
+#if SYM53C500_DEBUG
+#define rtrc(i) {inb(0x3da);outb(0x31,0x3c0);outb((i),0x3c0);}
+#else
+#define rtrc(i) {}
+#endif
+
+/* ================================================================== */
+
+typedef struct scsi_info_t {
+	dev_link_t link;
+	dev_node_t node;
+	struct Scsi_Host *host;
+	unsigned short manf_id;
+} scsi_info_t;
+
+enum Phase {
+    idle,
+    data_out,
+    data_in,
+    command_ph,
+    status_ph,
+    message_out,
+    message_in
+};
+
+/* ================================================================== */
+
+/*
+*  Global (within this module) variables.
+*/
+
+/*
+*  scsi_host_template initializer
+*
+*  Include file defining structure implies proc_info is optional.
+*  Trouble is, directory for host adapter won't get created unless
+*  there's a proc_info routine, i.e., nothing will appear in /proc.
+*  This is different from the 2.4 implementation.
+*/
+static struct scsi_host_template sym53c500_driver_template = {
+     .module			= THIS_MODULE,
+     .name			= "SYM53C500",
+     .info			= SYM53C500_info,
+     .queuecommand		= SYM53C500_queue,
+     .eh_abort_handler		= SYM53C500_abort,
+     .eh_device_reset_handler	= SYM53C500_device_reset,
+     .eh_bus_reset_handler	= SYM53C500_bus_reset,
+     .eh_host_reset_handler	= SYM53C500_host_reset,
+     .bios_param		= SYM53C500_biosparm,
+     .proc_info			= SYM53C500_proc_info,
+     .proc_name			= "SYM53C500",
+     .can_queue			= 1,
+     .this_id			= 7,
+     .sg_tablesize		= 32,
+     .cmd_per_lun		= 1,
+     .use_clustering		= ENABLE_CLUSTERING
+};
+
+static int port_base = 0;
+static int irq_level = -1; /* 0 is 'no irq', so use -1 for 'uninitialized'*/
+
+static int fast_pio = USE_FAST_PIO;
+
+static struct scsi_cmnd *current_SC;
+static char info_msg[256];
+
+/*
+*  possible i/o port addresses: provided for informational purposes only,
+*  because if Card Services can't find the card, the card doesn't exist.
+*
+*	0x130, 0x230, 0x280, 0x290, 0x320, 0x330, 0x340, 0x350
+*/
+
+/* Control Register Set 0 */
+static int TC_LSB;		/* transfer counter lsb		*/
+static int TC_MSB;		/* transfer counter msb		*/
+static int SCSI_FIFO;		/* scsi fifo register		*/
+static int CMD_REG;		/* command register		*/
+static int STAT_REG;		/* status register		*/
+static int DEST_ID;		/* selection/reselection bus id */
+static int INT_REG;		/* interrupt status register    */
+static int SRTIMOUT;		/* select/reselect timeout reg  */
+static int SEQ_REG;		/* sequence step register	*/
+static int SYNCPRD;		/* synchronous transfer period  */
+static int FIFO_FLAGS;		/* indicates # of bytes in fifo */
+static int SYNCOFF;		/* synchronous offset register  */
+static int CONFIG1;		/* configuration register	*/
+static int CLKCONV;		/* clock conversion reg		*/
+/*static int TESTREG;*/		/* test mode register		*/
+static int CONFIG2;		/* Configuration 2 Register     */
+static int CONFIG3;		/* Configuration 3 Register	*/
+static int CONFIG4;		/* Configuration 4 Register     */
+static int TC_HIGH;		/* Transfer Counter High	*/
+/*static int FIFO_BOTTOM;*/	/* Reserve FIFO byte register   */
+
+/* Control Register Set 1 */
+/*static int JUMPER_SENSE;*/	/* Jumper sense port reg (r/w) */
+/*static int SRAM_PTR;*/	/* SRAM address pointer reg (r/w) */
+/*static int SRAM_DATA;*/	/* SRAM data register (r/w) */
+static int PIO_FIFO;		/* PIO FIFO registers (r/w) */
+/*static int PIO_FIFO1;*/	/*  */
+/*static int PIO_FIFO2;*/	/*  */
+/*static int PIO_FIFO3;*/	/*  */
+static int PIO_STATUS;		/* PIO status (r/w) */
+/*static int ATA_CMD;*/		/* ATA command/status reg (r/w) */
+/*static int ATA_ERR;*/		/* ATA features/error register (r/w)*/
+static int PIO_FLAG;		/* PIO flag interrupt enable (r/w) */
+static int CONFIG5;		/* Configuration 5 register (r/w) */
+/*static int SIGNATURE;*/	/* Signature Register (r) */
+/*static int CONFIG6;*/		/* Configuration 6 register (r) */
+static int CONFIG7;
+
+static dev_link_t *dev_list = NULL;
+static dev_info_t dev_info = "sym53c500_cs";
+
+/* ================================================================== */
+
+static dev_link_t *
+SYM53C500_attach(void)
+{
+	scsi_info_t *info;
+	client_reg_t client_reg;
+	dev_link_t *link;
+	int i, ret;
+
+	DEBUG(0, "SYM53C500_attach()\n");
+
+	/* Create new SCSI device */
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	memset(info, 0, sizeof(*info));
+	link = &info->link;
+	link->priv = info;
+	link->io.NumPorts1 = 16;
+	link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
+	link->io.IOAddrLines = 10;
+	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+	link->irq.IRQInfo1 = IRQ_INFO2_VALID | IRQ_LEVEL_ID;
+	if (irq_list[0] == -1)
+		link->irq.IRQInfo2 = irq_mask;
+	else
+		for (i = 0; i < 4; i++)
+			link->irq.IRQInfo2 |= 1 << irq_list[i];
+	link->conf.Attributes = CONF_ENABLE_IRQ;
+	link->conf.Vcc = 50;
+	link->conf.IntType = INT_MEMORY_AND_IO;
+	link->conf.Present = PRESENT_OPTION;
+
+	/* Register with Card Services */
+	link->next = dev_list;
+	dev_list = link;
+	client_reg.dev_info = &dev_info;
+	client_reg.Attributes = INFO_IO_CLIENT | INFO_CARD_SHARE;
+	client_reg.event_handler = &SYM53C500_event;
+	client_reg.EventMask = CS_EVENT_RESET_REQUEST | CS_EVENT_CARD_RESET |
+	    CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+	    CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.Version = 0x0210;
+	client_reg.event_callback_args.client_data = link;
+	ret = pcmcia_register_client(&link->handle, &client_reg);
+	if (ret != 0) {
+		cs_error(link->handle, RegisterClient, ret);
+		SYM53C500_detach(link);
+		return NULL;
+	}
+
+	return link;
+} /* SYM53C500_attach */
+
+static void
+SYM53C500_detach(dev_link_t *link)
+{
+	dev_link_t **linkp;
+
+	DEBUG(0, "SYM53C500_detach(0x%p)\n", link);
+
+	/* Locate device structure */
+	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
+		if (*linkp == link)
+			break;
+	if (*linkp == NULL)
+		return;
+
+	if (link->state & DEV_CONFIG)
+		SYM53C500_release(link);
+
+	if (link->handle)
+		pcmcia_deregister_client(link->handle);
+
+	/* Unlink device structure, free bits. */
+	*linkp = link->next;
+	kfree(link->priv);
+	link->priv = NULL;
+} /* SYM53C500_detach */
+
+#define CS_CHECK(fn, ret) \
+do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
+
+static void
+SYM53C500_config(dev_link_t *link)
+{
+	client_handle_t handle = link->handle;
+	scsi_info_t *info = link->priv;
+	tuple_t tuple;
+	cisparse_t parse;
+	int i, last_ret, last_fn;
+	unsigned short tuple_data[32];
+	struct Scsi_Host *host;
+	struct scsi_host_template *tpnt = &sym53c500_driver_template;
+
+	DEBUG(0, "SYM53C500_config(0x%p)\n", link);
+
+	tuple.TupleData = (cisdata_t *)tuple_data;
+	tuple.TupleDataMax = 64;
+	tuple.TupleOffset = 0;
+	tuple.DesiredTuple = CISTPL_CONFIG;
+	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
+	CS_CHECK(GetTupleData, pcmcia_get_tuple_data(handle, &tuple));
+	CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &parse));
+	link->conf.ConfigBase = parse.config.base;
+
+	tuple.DesiredTuple = CISTPL_MANFID;
+	if ((pcmcia_get_first_tuple(handle, &tuple) == CS_SUCCESS) &&
+	    (pcmcia_get_tuple_data(handle, &tuple) == CS_SUCCESS))
+		info->manf_id = le16_to_cpu(tuple.TupleData[0]);
+
+	/* Configure card */
+	link->state |= DEV_CONFIG;
+
+	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
+	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
+	while (1) {
+		if (pcmcia_get_tuple_data(handle, &tuple) != 0 ||
+		    pcmcia_parse_tuple(handle, &tuple, &parse) != 0)
+			goto next_entry;
+		link->conf.ConfigIndex = parse.cftable_entry.index;
+		link->io.BasePort1 = parse.cftable_entry.io.win[0].base;
+		link->io.NumPorts1 = parse.cftable_entry.io.win[0].len;
+
+		if (link->io.BasePort1 != 0) {
+			i = pcmcia_request_io(handle, &link->io);
+			if (i == CS_SUCCESS)
+				break;
+		}
+next_entry:
+		CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(handle, &tuple));
+	}
+
+	CS_CHECK(RequestIRQ, pcmcia_request_irq(handle, &link->irq));
+	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(handle, &link->conf));
+
+	/*
+	*  That's the trouble with copying liberally from another driver.
+	*  Some things probably aren't relevant, and I suspect this entire
+	*  section dealing with manufacturer IDs can be scrapped.	--rct
+	*/
+	if ((info->manf_id == MANFID_MACNICA) ||
+	    (info->manf_id == MANFID_PIONEER) ||
+	    (info->manf_id == 0x0098)) {
+		/* set ATAcmd */
+		outb(0xb4, link->io.BasePort1 + 0xd);
+		outb(0x24, link->io.BasePort1 + 0x9);
+		outb(0x04, link->io.BasePort1 + 0xd);
+	}
+
+	/*
+	*  Note fast_pio is global and set at compile time.
+	*/
+	port_base = link->io.BasePort1;
+	irq_level = link->irq.AssignedIRQ;
+
+	DEB(printk("SYM53C500: port_base=0x%X, irq=%d, fast_pio=%d\n",
+	    port_base, irq_level, fast_pio);)
+
+	calc_port_addr();
+	chip_init();
+
+	host = scsi_host_alloc(tpnt, 0);
+	if (!host) {
+		printk("SYM53C500: Unable to register host, giving up.\n");
+		goto err_release;
+	}
+
+	if (irq_level > 0) {
+		if (request_irq(irq_level, do_SYM53C500_intr, 0, "SYM53C500", host)) {
+			printk("SYM53C500: unable to allocate IRQ %d\n", irq_level);
+			goto err_free_scsi;
+		}
+		tpnt->can_queue = 1;
+		DEB(printk("SYM53C500: allocated IRQ %d\n", irq_level));
+	} else if (irq_level == 0) {
+		tpnt->can_queue = 0;
+		DEB(printk("SYM53C500: No interrupts detected\n"));
+		goto err_free_scsi;
+	} else {
+		DEB(printk("SYM53C500: Shouldn't get here!\n"));
+		goto err_free_scsi;
+	}
+
+	host->unique_id = port_base;
+	host->irq = irq_level;
+	host->io_port = port_base;
+	host->n_io_port = 0x10;
+	host->dma_channel = -1;
+
+	sprintf(info_msg, "SYM53C500 at 0x%x, IRQ %d, %s PIO mode.", 
+	    port_base, irq_level, fast_pio ? "fast" : "slow");
+
+	sprintf(info->node.dev_name, "scsi%d", host->host_no);
+	link->dev = &info->node;
+	info->host = host;
+
+	scsi_add_host(host, NULL);	/* XXX handle failure */
+	scsi_scan_host(host);
+
+	goto out;	/* SUCCESS */
+
+err_free_scsi:
+	scsi_host_put(host);
+err_release:
+	release_region(port_base, 0x10);
+	printk(KERN_INFO "sym53c500_cs: no SCSI devices found\n");
+
+out:
+	link->state &= ~DEV_CONFIG_PENDING;
+	return;
+
+cs_failed:
+	cs_error(link->handle, last_fn, last_ret);
+	SYM53C500_release(link);
+	return;
+} /* SYM53C500_config */
+
+static void
+SYM53C500_release(dev_link_t *link)
+{
+	scsi_info_t *info = link->priv;
+	struct Scsi_Host *shost = info->host;
+
+	DEBUG(0, "SYM53C500_release(0x%p)\n", link);
+
+	/*
+	*  Interrupts getting hosed on card removal.  Try
+	*  the following code, mostly from qlogicfas.c.
+	*/
+	if (shost->irq)
+		free_irq(shost->irq, shost);
+	if (shost->dma_channel != 0xff)
+		free_dma(shost->dma_channel);
+	if (shost->io_port && shost->n_io_port)
+		release_region(shost->io_port, shost->n_io_port);
+
+	scsi_remove_host(shost);
+	link->dev = NULL;
+
+	pcmcia_release_configuration(link->handle);
+	pcmcia_release_io(link->handle, &link->io);
+	pcmcia_release_irq(link->handle, &link->irq);
+
+	link->state &= ~DEV_CONFIG;
+
+	scsi_host_put(shost);
+} /* SYM53C500_release */
+
+static int
+SYM53C500_event(event_t event, int priority, event_callback_args_t *args)
+{
+	dev_link_t *link = args->client_data;
+	scsi_info_t *info = link->priv;
+
+	DEBUG(1, "SYM53C500_event(0x%06x)\n", event);
+
+	switch (event) {
+	case CS_EVENT_CARD_REMOVAL:
+		link->state &= ~DEV_PRESENT;
+		if (link->state & DEV_CONFIG)
+			SYM53C500_release(link);
+		break;
+	case CS_EVENT_CARD_INSERTION:
+		link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
+		SYM53C500_config(link);
+		break;
+	case CS_EVENT_PM_SUSPEND:
+		link->state |= DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_RESET_PHYSICAL:
+		if (link->state & DEV_CONFIG)
+			pcmcia_release_configuration(link->handle);
+		break;
+	case CS_EVENT_PM_RESUME:
+		link->state &= ~DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_CARD_RESET:
+		if (link->state & DEV_CONFIG) {
+			pcmcia_request_configuration(link->handle, &link->conf);
+			/* See earlier comment about manufacturer IDs. */
+			if ((info->manf_id == MANFID_MACNICA) ||
+			    (info->manf_id == MANFID_PIONEER) ||
+			    (info->manf_id == 0x0098)) {
+				outb(0x80, link->io.BasePort1 + 0xd);
+				outb(0x24, link->io.BasePort1 + 0x9);
+				outb(0x04, link->io.BasePort1 + 0xd);
+			}
+			/* Fugly! */
+			SYM53C500_bus_reset(NULL);
+		}
+		break;
+	}
+	return 0;
+} /* SYM53C500_event */
+
+/*
+*  SYM53C500_proc_info is basically a stub function for now.  It
+*  wouldn't exist except for the fact there were /proc entries for
+*  this driver under 2.4 and earlier kernels, and the author (sole
+*  user?) expects to see them.
+*
+*  buffer:	I/O buffer
+*  start:	if inout == FALSE, pointer into buffer where user
+*		read should start
+*  offset:	current offset
+*  length:	length of buffer
+*  hostno:	Scsi_Host host_no
+*  inout:	1 --> user is writing; 0 --> user is reading
+*/
+
+#undef SPRINTF
+#define SPRINTF(args...) \
+	do { \
+		if (length > (pos - buffer)) \
+			pos += snprintf(pos, length - (pos - buffer) + 1, ## args); \
+	} while (0)
+
+int
+SYM53C500_proc_info(struct Scsi_Host *shost, char *buffer,
+    char **start, off_t offset, int length, int inout)
+{
+	char *pos = buffer;
+	int thislength;
+
+	if (inout)
+		return(-ENOSYS);	/* look, but don't touch */
+
+	/*
+	*  Cheesy, but it's what we had before.
+	*/
+	SPRINTF("%s\n", info_msg);
+
+	thislength = pos - (buffer + offset);
+
+	if (thislength < 0) {
+		*start = 0;
+		return 0;
+	}
+
+	thislength = MIN(thislength, length);
+	*start = buffer + offset;
+
+	return thislength;
+}
+
+static __inline__ int
+SYM53C500_pio_read(unsigned char *request, unsigned int reqlen)
+{
+	int i;
+	int len;	/* current scsi fifo size */
+
+	REG1;
+	while (reqlen) {
+		i = inb(PIO_STATUS);
+		/* VDEB(printk("pio_status=%x\n", i)); */
+		if (i & 0x80) 
+			return 0;
+
+		switch (i & 0x1e) {
+		default:
+		case 0x10:	/* fifo empty */
+			len = 0;
+			break;
+		case 0x0:
+			len = 1;
+			break; 
+		case 0x8:	/* fifo 1/3 full */
+			len = 42;
+			break;
+		case 0xc:	/* fifo 2/3 full */
+			len = 84;
+			break;
+		case 0xe:	/* fifo full */
+			len = 128;
+			break;
+		}
+
+		if ((i & 0x40) && len == 0) { /* fifo empty and interrupt occurred */
+			return 0;
+		}
+
+		if (len) {
+			if (len > reqlen) 
+				len = reqlen;
+
+			if (fast_pio && len > 3) {
+				insl(PIO_FIFO, request, len >> 2);
+				request += len & 0xfc; 
+				reqlen -= len & 0xfc; 
+			} else {
+				while (len--) {
+					*request++ = inb(PIO_FIFO);
+					reqlen--;
+				}
+			} 
+		}
+	}
+	return 0;
+}
+
+static __inline__ int
+SYM53C500_pio_write(unsigned char *request, unsigned int reqlen)
+{
+	int i = 0;
+	int len;	/* current scsi fifo size */
+
+	REG1;
+	while (reqlen && !(i & 0x40)) {
+		i = inb(PIO_STATUS);
+		/* VDEB(printk("pio_status=%x\n", i)); */
+		if (i & 0x80)	/* error */
+			return 0;
+
+		switch (i & 0x1e) {
+		case 0x10:
+			len = 128;
+			break;
+		case 0x0:
+			len = 84;
+			break;
+		case 0x8:
+			len = 42;
+			break;
+		case 0xc:
+			len = 1;
+			break;
+		default:
+		case 0xe:
+			len = 0;
+			break;
+		}
+
+		if (len) {
+			if (len > reqlen)
+				len = reqlen;
+
+			if (fast_pio && len > 3) {
+				outsl(PIO_FIFO, request, len >> 2);
+				request += len & 0xfc;
+				reqlen -= len & 0xfc;
+			} else {
+				while (len--) {
+					outb(*request++, PIO_FIFO);
+					reqlen--;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+const char*
+SYM53C500_info(struct Scsi_Host *SChost)
+{
+	DEB(printk("SYM53C500_info called\n"));
+	return (info_msg);
+}
+
+int 
+SYM53C500_queue(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
+{
+	int i;
+
+	VDEB(printk("SYM53C500_queue called\n"));
+
+	DEB(printk("cmd=%02x, cmd_len=%02x, target=%02x, lun=%02x, bufflen=%d\n", 
+	    SCpnt->cmnd[0], SCpnt->cmd_len, SCpnt->device->id, 
+	    SCpnt->device->lun,  SCpnt->request_bufflen));
+
+	VDEB(for (i = 0; i < SCpnt->cmd_len; i++)
+	    printk("cmd[%d]=%02x  ", i, SCpnt->cmnd[i]));
+	VDEB(printk("\n"));
+
+	current_SC = SCpnt;
+	current_SC->scsi_done = done;
+	current_SC->SCp.phase = command_ph;
+	current_SC->SCp.Status = 0;
+	current_SC->SCp.Message = 0;
+
+	/* We are locked here already by the mid layer */
+	REG0;
+	outb(SCpnt->device->id, DEST_ID);	/* set destination */
+	outb(FLUSH_FIFO, CMD_REG);	/* reset the fifos */
+
+	for (i = 0; i < SCpnt->cmd_len; i++) {
+		outb(SCpnt->cmnd[i], SCSI_FIFO);
+	}
+	outb(SELECT_NO_ATN, CMD_REG);
+
+	rtrc(1);
+	return 0;
+}
+
+int
+SYM53C500_abort(struct scsi_cmnd *SCpnt)
+{
+	DEB(printk("SYM53C500_abort called\n"));
+	return FAILED;		/* Don't know how to abort */
+}
+
+int 
+SYM53C500_host_reset(struct scsi_cmnd *SCpnt)
+{
+	DEB(printk("SYM53C500_host_reset called\n"));
+	outb(C4_IMG, CONFIG4);		/* Select reg set 0 */
+	outb(CHIP_RESET, CMD_REG);
+	outb(SCSI_NOP, CMD_REG);	/* required after reset */
+	outb(SCSI_RESET, CMD_REG);
+	chip_init();
+
+	rtrc(2);
+	return SUCCESS;
+}
+
+int
+SYM53C500_device_reset(struct scsi_cmnd *SCpnt)
+{
+	return FAILED;
+}
+
+int
+SYM53C500_bus_reset(struct scsi_cmnd *SCpnt)
+{
+	return FAILED;
+}
+
+int 
+SYM53C500_biosparm(struct scsi_device *disk,
+    struct block_device *dev,
+    sector_t capacity, int *info_array)
+{
+	int size;
+
+	DEB(printk("SYM53C500_biosparm called\n"));
+
+	size = capacity;
+	info_array[0] = 64;		/* heads */
+	info_array[1] = 32;		/* sectors */
+	info_array[2] = size >> 11;	/* cylinders */
+	if (info_array[2] > 1024) {	/* big disk */
+		info_array[0] = 255;
+		info_array[1] = 63;
+		info_array[2] = size / (255 * 63);
+	}
+	return 0;
+}
+
+static irqreturn_t
+do_SYM53C500_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	struct Scsi_Host *dev = dev_id;
+
+	spin_lock_irqsave(dev->host_lock, flags);
+	SYM53C500_intr(irq, dev_id, regs);
+	spin_unlock_irqrestore(dev->host_lock, flags);
+	return IRQ_HANDLED;
+}
+
+static void
+SYM53C500_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	DEB(unsigned char fifo_size;)
+	DEB(unsigned char seq_reg;)
+	unsigned char status, int_reg;
+	unsigned char pio_status;
+	struct scatterlist *sglist;
+	unsigned int sgcount;
+
+	VDEB(printk("SYM53C500_intr called\n"));
+
+	REG1;
+	pio_status = inb(PIO_STATUS);
+	REG0;
+	status = inb(STAT_REG);
+	DEB(seq_reg = inb(SEQ_REG));
+	int_reg = inb(INT_REG);
+	DEB(fifo_size = inb(FIFO_FLAGS) & 0x1f);
+
+#if SYM53C500_DEBUG
+	printk("status=%02x, seq_reg=%02x, int_reg=%02x, fifo_size=%02x", 
+	    status, seq_reg, int_reg, fifo_size);
+	printk(", pio=%02x\n", pio_status);
+#endif /* SYM53C500_DEBUG */
+
+	if (int_reg & 0x80) {	/* SCSI reset intr */
+		rtrc(3);
+		DEB(printk("SYM53C500: reset intr received\n"));
+		current_SC->SCp.phase = idle;
+		current_SC->result = DID_RESET << 16;
+		current_SC->scsi_done(current_SC);
+		return;
+	}
+
+	if (pio_status & 0x80) {
+		printk("SYM53C500: Warning: PIO error!\n");
+		current_SC->SCp.phase = idle;
+		current_SC->result = DID_ERROR << 16;
+		current_SC->scsi_done(current_SC);
+		return;
+	}
+
+	if (status & 0x20) {		/* Parity error */
+		printk("SYM53C500: Warning: parity error!\n");
+		current_SC->SCp.phase = idle;
+		current_SC->result = DID_PARITY << 16;
+		current_SC->scsi_done(current_SC);
+		return;
+	}
+
+	if (status & 0x40) {		/* Gross error */
+		printk("SYM53C500: Warning: gross error!\n");
+		current_SC->SCp.phase = idle;
+		current_SC->result = DID_ERROR << 16;
+		current_SC->scsi_done(current_SC);
+		return;
+	}
+
+	if (int_reg & 0x20) {		/* Disconnect */
+		DEB(printk("SYM53C500: disconnect intr received\n"));
+		if (current_SC->SCp.phase != message_in) {	/* Unexpected disconnect */
+			current_SC->result = DID_NO_CONNECT << 16;
+		} else {	/* Command complete, return status and message */
+			current_SC->result = (current_SC->SCp.Status & 0xff)
+			    | ((current_SC->SCp.Message & 0xff) << 8) | (DID_OK << 16);
+		}
+
+		rtrc(0);
+		current_SC->SCp.phase = idle;
+		current_SC->scsi_done(current_SC);
+		return;
+	}
+
+	switch (status & 0x07) {	/* scsi phase */
+	case 0x00:			/* DATA-OUT */
+		if (int_reg & 0x10) {	/* Target requesting info transfer */
+			rtrc(5);
+			current_SC->SCp.phase = data_out;
+			VDEB(printk("SYM53C500: Data-Out phase\n"));
+			outb(FLUSH_FIFO, CMD_REG);
+			LOAD_DMA_COUNT(current_SC->request_bufflen);	/* Max transfer size */
+			outb(TRANSFER_INFO | DMA_OP, CMD_REG);
+			if (!current_SC->use_sg)	/* Don't use scatter-gather */
+				SYM53C500_pio_write(current_SC->request_buffer, current_SC->request_bufflen);
+			else {	/* use scatter-gather */
+				sgcount = current_SC->use_sg;
+				sglist = current_SC->request_buffer;
+				while (sgcount--) {
+					SYM53C500_pio_write(page_address(sglist->page) + sglist->offset, sglist->length);
+					sglist++;
+				}
+			}
+			REG0;
+		}
+		break;
+
+	case 0x01:		/* DATA-IN */
+		if (int_reg & 0x10) {	/* Target requesting info transfer */
+			rtrc(6);
+			current_SC->SCp.phase = data_in;
+			VDEB(printk("SYM53C500: Data-In phase\n"));
+			outb(FLUSH_FIFO, CMD_REG);
+			LOAD_DMA_COUNT(current_SC->request_bufflen);	/* Max transfer size */
+			outb(TRANSFER_INFO | DMA_OP, CMD_REG);
+			if (!current_SC->use_sg)	/* Don't use scatter-gather */
+				SYM53C500_pio_read(current_SC->request_buffer, current_SC->request_bufflen);
+			else {	/* Use scatter-gather */
+				sgcount = current_SC->use_sg;
+				sglist = current_SC->request_buffer;
+				while (sgcount--) {
+					SYM53C500_pio_read(page_address(sglist->page) + sglist->offset, sglist->length);
+					sglist++;
+				}
+			}
+			REG0;
+		}
+		break;
+
+	case 0x02:		/* COMMAND */
+		current_SC->SCp.phase = command_ph;
+		printk("SYM53C500: Warning: Unknown interrupt occurred in command phase!\n");
+		break;
+
+	case 0x03:		/* STATUS */
+		rtrc(7);
+		current_SC->SCp.phase = status_ph;
+		VDEB(printk("SYM53C500: Status phase\n"));
+		outb(FLUSH_FIFO, CMD_REG);
+		outb(INIT_CMD_COMPLETE, CMD_REG);
+		break;
+
+	case 0x04:		/* Reserved */
+	case 0x05:		/* Reserved */
+		printk("SYM53C500: WARNING: Reserved phase!!!\n");
+		break;
+
+	case 0x06:		/* MESSAGE-OUT */
+		DEB(printk("SYM53C500: Message-Out phase\n"));
+		current_SC->SCp.phase = message_out;
+		outb(SET_ATN, CMD_REG);	/* Reject the message */
+		outb(MSG_ACCEPT, CMD_REG);
+		break;
+
+	case 0x07:		/* MESSAGE-IN */
+		rtrc(4);
+		VDEB(printk("SYM53C500: Message-In phase\n"));
+		current_SC->SCp.phase = message_in;
+
+		current_SC->SCp.Status = inb(SCSI_FIFO);
+		current_SC->SCp.Message = inb(SCSI_FIFO);
+
+		VDEB(printk("SCSI FIFO size=%d\n", inb(FIFO_FLAGS) & 0x1f));
+		DEB(printk("Status = %02x  Message = %02x\n", current_SC->SCp.Status, current_SC->SCp.Message));
+
+		if (current_SC->SCp.Message == SAVE_POINTERS || current_SC->SCp.Message == DISCONNECT) {
+			outb(SET_ATN, CMD_REG);	/* Reject message */
+			DEB(printk("Discarding SAVE_POINTERS message\n"));
+		}
+		outb(MSG_ACCEPT, CMD_REG);
+		break;
+	}
+}
+
+static void
+chip_init(void)
+{
+	REG1;
+	outb(0x01, PIO_STATUS);
+	outb(0x00, PIO_FLAG);
+
+	outb(C4_IMG, CONFIG4);	/* REG0; */
+	outb(C3_IMG, CONFIG3);
+	outb(C2_IMG, CONFIG2);
+	outb(C1_IMG, CONFIG1);
+
+	outb(0x05, CLKCONV);	/* clock conversion factor */
+	outb(0x9C, SRTIMOUT);	/* Selection timeout */
+	outb(0x05, SYNCPRD);	/* Synchronous transfer period */
+	outb(SYNC_MODE, SYNCOFF);	/* synchronous mode */  
+}
+
+void
+calc_port_addr(void)
+{
+	/* Control Register Set 0 */
+	TC_LSB = (port_base + 0x00);
+	TC_MSB = (port_base + 0x01);
+	SCSI_FIFO = (port_base + 0x02);
+	CMD_REG = (port_base + 0x03);
+	STAT_REG = (port_base + 0x04);
+	DEST_ID = (port_base + 0x04);
+	INT_REG = (port_base + 0x05);
+	SRTIMOUT = (port_base + 0x05);
+	SEQ_REG = (port_base + 0x06);
+	SYNCPRD = (port_base + 0x06);
+	FIFO_FLAGS = (port_base + 0x07);
+	SYNCOFF = (port_base + 0x07);
+	CONFIG1 = (port_base + 0x08);
+	CLKCONV = (port_base + 0x09);
+	/* TESTREG = (port_base + 0x0A); */
+	CONFIG2 = (port_base + 0x0B);
+	CONFIG3 = (port_base + 0x0C);
+	CONFIG4 = (port_base + 0x0D);
+	TC_HIGH = (port_base + 0x0E);
+	/* FIFO_BOTTOM = (port_base + 0x0F); */
+
+	/* Control Register Set 1 */
+	/* JUMPER_SENSE = (port_base + 0x00); */
+	/* SRAM_PTR = (port_base + 0x01); */
+	/* SRAM_DATA = (port_base + 0x02); */
+	PIO_FIFO = (port_base + 0x04);
+	/* PIO_FIFO1 = (port_base + 0x05); */
+	/* PIO_FIFO2 = (port_base + 0x06); */
+	/* PIO_FIFO3 = (port_base + 0x07); */
+	PIO_STATUS = (port_base + 0x08);
+	/* ATA_CMD = (port_base + 0x09); */
+	/* ATA_ERR = (port_base + 0x0A); */
+	PIO_FLAG = (port_base + 0x0B);
+	CONFIG5 = (port_base + 0x09);
+	/* SIGNATURE = (port_base + 0x0E); */
+	/* CONFIG6 = (port_base +0x0F); */
+	CONFIG7 = (port_base + 0x0d);
+}
+
+MODULE_AUTHOR("Bob Tracy <rct@frus.com>");
+MODULE_DESCRIPTION("SYM53C500 PCMCIA SCSI driver");
+MODULE_LICENSE("GPL");
+
+static struct pcmcia_driver sym53c500_cs_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "sym53c500_cs",
+	},
+	.attach		= SYM53C500_attach,
+	.detach		= SYM53C500_detach,
+};
+
+static int __init
+init_sym53c500_cs(void)
+{
+	return pcmcia_register_driver(&sym53c500_cs_driver);
+}
+
+static void __exit
+exit_sym53c500_cs(void)
+{
+	pcmcia_unregister_driver(&sym53c500_cs_driver);
+
+	/* XXX: this really needs to move into generic code... */
+	while (dev_list != NULL)
+		SYM53C500_detach(dev_list);
+}
+
+module_init(init_sym53c500_cs);
+module_exit(exit_sym53c500_cs);
--- linux/Documentation/scsi/sym53c500_cs.txt.orig	Fri Apr 16 16:06:19 2004
+++ linux/Documentation/scsi/sym53c500_cs.txt	Fri Apr 16 15:05:53 2004
@@ -0,0 +1,17 @@
+The sym53c500_cs driver originated as an add-on to David Hinds' pcmcia-cs
+package, and was written by Tom Corner (tcorner@via.at).  This rewrite
+addresses the following concerns:
+
+	(1) extensive kernel changes between 2.4 and 2.6.
+	(2) deprecated PCMCIA support outside the kernel.
+
+The Symbios Logic 53c500 chip was used in the "new" (circa 1997) version
+of the New Media Bus Toaster PCMCIA SCSI controller.  Presumably there are
+other products using this chip, but I've never laid eyes (much less hands)
+on one.
+
+Through the years, there have been a number of downloads of the pcmcia-cs
+version of this driver, and I guess it worked for those users.  It worked
+for Tom Corner, and it works for me.  Your mileage will probably vary.
+
+--Bob Tracy (rct@frus.com)
--- linux/Documentation/scsi/00-INDEX.orig	Fri Apr 16 16:07:11 2004
+++ linux/Documentation/scsi/00-INDEX	Fri Apr  9 20:17:36 2004
@@ -62,6 +62,8 @@
 	- info on API between SCSI layer and low level drivers
 st.txt
 	- info on scsi tape driver
+sym53c500_cs.txt
+	- info on PCMCIA driver for Symbios Logic 53c500 based adapters
 sym53c8xx_2.txt
 	- info on second generation driver for sym53c8xx based adapters
 tmscsim.txt

--ELM767678912-1331-0_--
