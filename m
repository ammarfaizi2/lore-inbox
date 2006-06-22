Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWFVNRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWFVNRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWFVNRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:17:50 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:30604 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1161101AbWFVNRs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:17:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 7/13] Equinox SST driver: driver structures
Date: Thu, 22 Jun 2006 09:17:48 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B7110B@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 7/13] Equinox SST driver: driver structures
Thread-Index: AcaV/kEy/8vFIZEJSECezhTAty0IVQ==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 7: new header file: drivers/char/eqnx/eqnx.h.  Structures and
constants
used by the driver source files.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---

 eqnx.h |  362
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 362 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/eqnx.h
linux-2.6.17.eqnx/drivers/char/eqnx/eqnx.h
--- linux-2.6.17/drivers/char/eqnx/eqnx.h	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/eqnx.h	2006-06-20
09:50:06.000000000 -0400
@@ -0,0 +1,362 @@
+/*
+ * Equinox / Avocent SST (multi-port serial) driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ * Driver structures and definitions
+ */
+
+#define	VERSNUM "5.00.00"
+
+/* lanana assigned major number */
+#define	EQNX_MAJOR	256
+
+/*
+ * LMX structure (SSP64)
+ * LMX is controller within port modules (providing connectors).
+ * Up to MAXLMX (4) LMXs may be present on a single ICP.  Hence
+ * up to MAXLMX (4) LMXs on a SST64 board and up to 2 * MAXLMX (8)
+ * LMXs on a SST128 board.
+ */
+struct lmx_struct {
+	u32	lmx_active;		/* status */
+/* LMX status types */
+#define DEV_VIRGIN	0xff		/* device id is unknown */
+#define DEV_BAD		0		/* device was known but
now offline */
+#define DEV_GOOD	1		/* device known and online */
+#define DEV_INSANE	2		/* hardware error (unexpected)
*/
+#define DEV_WAITING	3
+
+	u32	lmx_id;			/* product id */
+/* LMX product id (partial set) */
+#define LMX_8E_422	0x06		/* ss8-e 422 */
+#define LMX_PM16_422	0x07		/* rm16-rj 422 */
+
+	u32	lmx_speed;		/* maxbaud: 0 = 115200, 1 =
230400 */
+					/* 2 = 460800 3 = 921600 */
+	u32	lmx_chan;		/* number of channels */
+	u32	lmx_bridge;		/* TRUE if bridge, else local */
+	u32	lmx_rmt_active;		/* status for remote LMX */
+	u32	lmx_rmt_id;		/* remote mux product id */
+	u32	lmx_wait;
+	u32	lmx_good_count;
+	struct mpchan *lmx_mpc;		/* first channel mpc */
+};
+
+/*
+ * ICP state structure.  One for each ASIC on a board, up to MAXSSP_BRD
+ * ICPs on a single board 
+ */
+struct icp_struct {
+	u8	icp_rng_last;		/* last ring clock off value */
+					/* TRUE if ring clock OFF */
+	u8	icp_rng_svcreq;		/* state for next poll */
+	u8	icp_rng_state;		/* ring state */
+/* LMX ring state */
+#define RNG_BAD		0
+#define RNG_GOOD	1
+#define RNG_CHK		2
+#define RNG_WAIT	3
+
+	u32     icp_rng_wait;
+	u32	icp_rng_fail_count;	/* ring failure count */
+	u32	icp_rng_good_count;	/* ring established count */
+	void	*icp_dram_start;	/* start of DRAM */
+	void	*icp_tags_start;	/* start of tags */
+	void	*icp_cmds_start;	/* start of cmd buffer */
+	void	*icp_regs_start;	/* start of channel registers */
+	u32	icp_minor_start;	/* start minor number for this
icp */
+	struct lmx_struct lmx[MAXLMX];	/* LMX info */
+	u8	icp_poll_defer;         /* megapoll processing deferred
*/
+};
+
+/*
+ * ICP queue and buffer information
+ */
+struct hwq_struct {
+	u32	hwq_size;		/* queue size (2 per channel) */
+	u32	hwq_hiwat;		/* high threshold */
+	u32	hwq_lowat;		/* low threshold */
+	u8	hwq_rxwrap;
+	u8	hwq_txwrap;
+	u8	hwq_cmdsize;		/* cmd buffer size */
+};
+
+/*
+ * board structure, status and information
+ */
+struct mpdev {
+	u8	mpd_alive;		/* board present */
+	u8	mpd_mem_width;		/* memory access width */
+	struct pci_dev *mpd_pdev;	/* PCI device */
+	struct device *dev;		/* device structure */
+	struct brdtab_t *mpd_board_def;	/* board definition pointer */
+	u16	mpd_nchan;		/* total number of channels */
+	u8	mpd_nicps;		/* number of icps on board */
+	u8	mpd_sspchan;		/* number of channels on icp */
+	u8	mpd_ccode;		/* multimodem country code reg
*/
+	struct mpchan *mpd_mpc;		/* mpchan base address */
+	void	*mpd_pmem;		/* physical memory address */
+	u32	mpd_addrsz;		/* physical memory size */
+	void __iomem *mpd_mem;		/* virtual address of on-board
memory */
+	u32	mpd_memsz;		/* buffer memory size */
+	u32	mpd_minor;		/* start minor number for this
board */
+	struct hwq_struct *mpd_hwq;	/* queue param ptr */
+	struct icp_struct icp[MAXSSP_BRD];
+	u32	mpd_major;		/* major number */
+	u32	mpd_minor_start;	/* 1st minor number */
+	u8	mpd_rev;		/* board rev */
+	u8	mpd_cnfg_state;		/* init state */
+/* configuration state */
+#define	CNFG_STATE_OK		0x1
+#define	CNFG_STATE_FAIL		0x2
+
+	u8	mpd_cnfg_fail;		/* fail reason */
+/* configuration fail reason */
+#define	CNFG_FAIL_MEMORY	0x1	/* memory allocation
failed */
+#define	CNFG_FAIL_MEM_FAIL	0x2	/* memory test failed */
+#define	CNFG_FAIL_PRAM_FAIL	0x3	/* PRAM cached */
+#define	CNFG_FAIL_ICP_FAIL	0x4	/* ICP not found */
+#define	CNFG_FAIL_MAXBRD	0x5	/* maxbrd exceeded */
+
+	u32	mpd_lmx_index;
+	spinlock_t mpd_lock;		/* protection lock */
+};
+
+/*
+ * software copy of icp circular queue (tx and rx)
+ */
+typedef	struct {
+	u8	*q_addr;		/* virtual base address */
+	u32	q_ptr;			/* tail for rx; head for tx */
+	u16	q_begin;		/* start index */
+	u16	q_end;			/* end index */
+	u16	q_size;			/* queue size */
+} queue_t;
+
+/*
+ * channel (port) structure
+ */
+struct mpchan {
+	u32	mpc_flags;
+/* channel flags */
+#define MPC_MODEM	0x2		/* modem control lines in use */
+#define MPC_DIALOUT	0x4		/* line used as dial-out */
+#define MPC_SOFTCAR	0x8		/* disable modem control */
+#define MPC_OPEN	0x20		/* channel open */
+#define MPC_BUSY	0x80		/* output active */
+#define MPC_RXFLUSH	0x200		/* input queue flushed */
+#define MPC_DIALIN	0x2000		/* disconnect on carrier drop */
+#define MPC_CTS		0x4000		/* control in used as
CTSFLOW */
+#define MPC_LOOPBACK	0x80000		/* Port in Internal Loopback */
+#define MPC_DSCOPER	0x100000	/* Port in Datascope Mode for
reads */
+#define MPC_DSCOPEW	0x200000	/* Port in Datascope Mode for
writes*/
+#define MPC_DEFER       0x800000	/* Poll processing deferred */
+
+	u8	mpc_chan;		/* channel number on this device
*/
+	u32	mpc_param;		/* overwrite parameters */
+/* channel overwrite parameters */
+#define	IXONSET		0x1		/* force ixon */
+#define	IXANYIG		0x2		/* ignore ixany setup */
+#define IOCTCTS		0x40
+#define IOCTRTS		0x80
+#define IOCTLLB		0x400
+#define IOCTXON		0x800
+#define IOCTLCK		0x1000		/* force lock port
settings */
+
+	volatile struct icp_in_struct *mpc_icpi; /* input registers */
+	volatile struct icp_out_struct *mpc_icpo; /* output registers */
+	volatile struct cin_bnk_struct *mpc_icpb;/* pointer to freezed
bank */
+
+	struct icp_struct *mpc_icp;	/* pointer to icp_struct */
+	u16	mpc_cin_events;		/* pending input events */
+	u16	mpc_cout_events;	/* pending output events */
+	u16	mpc_cin_ena;		/* input events enabled */
+	u16	mpc_cout_ena;		/* output events enabled */
+	u16	mpc_count;		/* pending output */
+	u16	mpc_tx_last_invent;	/* chars invented by icp in
opost */
+	u16	mpc_rxbase;		/* base tail index */
+	u16	mpc_txbase;		/* base index */
+	queue_t	mpc_rxq;		/* receive queue */
+	queue_t	mpc_txq;		/* transmit queue */
+	struct	mpdev *mpc_mpd;		/* pointer to board info
structure */
+	struct	tty_struct *mpc_tty;	/* pointer to tty structures */
+	u32	mpc_tags;
+	u32	mpc_input;		/* counter total chars rcv */
+	u32	mpc_output;		/* counter total chars send */
+	u8	mpc_start;		/* start output */
+	u8	mpc_stop;		/* stop output */
+	u8	mpc_brdno;		/* board number */
+	u8	mpc_icpno;		/* icp number on the adapter */
+	u8	mpc_lmxno;		/* lmx number from the icp */
+	u8	mpc_rxpg;		/* select page rx buffer */
+	u8	mpc_txpg;		/* select page tx buffer */
+	u8	mpc_tgpg;		/* select page tags buffer */
+	int	flags;			/* linux specific serial flags
*/
+
+	wait_queue_head_t open_wait;
+	wait_queue_head_t close_wait;
+	wait_queue_head_t raw_wait;
+
+	u32	open_wait_wait;		/* DCD wait in open */
+
+	u32	refcount;		/* open count */
+	struct termios *normaltermios;
+	struct termios *callouttermios;
+	pid_t	session;
+	pid_t	pgrp;
+	u32 	openwaitcnt;		/* waiter count in open */
+	u32	close_delay;		/* close delay waiting on open
*/
+	u32	closing_wait;		/* close delay waiting on drain
*/
+	u32	custom_divisor;
+	u32	baud_base;
+	u32	mpc_block;		/* block input */
+	u32	carr_state;		/* DCD state */
+	u8	*xmit_buf;
+	u32	xmit_head;
+	u32	xmit_tail;
+	u32	xmit_cnt;
+
+	u32	mpc_parity_err_cnt;	/* count of parity errors */
+	u32	mpc_framing_err_cnt;	/* count of framing errors */
+	u32	mpc_break_cnt;		/* count of breaks */
+
+	u32	mpc_major;		/* device major number */
+	u32	mpc_minor;		/* device minor number */
+	struct class_device *cdev;	/* class device */
+};
+
+/*
+ * pci configuration information
+ */
+struct pci_cfg {
+	u16	command;
+	u8	rev_id;
+	void	*base_addr_reg0;
+	struct pci_dev *pdev;
+};
+
+/*
+ * datascope structure
+ */
+#define DSQSIZE		(4096) 		/* datascope buffer size
*/
+#define DSQMASK		(4096-1)  	/* datascope mask */
+
+struct datascope {
+	u32	open;			/* data monitor open */
+	u32	chan;			/* port number being scoped */
+	u32	status;			/* status (for WRAP) */
+#define DSQWRAP	0x01
+	queue_t	q;			/* Manage circular q buffer */
+	int	next;
+	u8 buffer[DSQSIZE];		/* Actual circular buffer */
+
+	wait_queue_head_t scope_wait;
+
+	u32	 scope_wait_wait;
+
+};
+
+/*
+ * Layout of a board definition - one for each known + valid board type
+ */
+struct brdtab_t {
+	u8	primary_id;		/* primary id */
+	u8	secondary_id;		/* id extension */
+	u8	asic;			/* asic type */
+	u8	number_of_asics;	/* number of asics on board */
+	u8	number_of_ports;	/* number of valid ports */
+	u32	flags;			/* misc flags */
+	char *name;			/* board name */
+};
+
+/*
+ * special ids
+ */
+#define	NOID		0
+
+/*
+ * ASIC types
+ */
+#define	NOASIC		0
+#define	SSP64		1
+#define	SSP4		2
+
+/*
+ * flags
+ */
+#define	MM		0x2		/* multi-modem board */
+#define	POLL40		0x4		/* poll board every 40
milliseconds */
+#define	RJ		0x8		/* RJ board (limited
control signals) */
+#define	NOPANEL		0x10		/* no panel (SST16) */
+#define	DB9_PAN		0x20		/* DB-9 panel (SST16) */
+#define	DB25_PAN 	0x40		/* DB-25 panel (SST16)
*/
+#define	RJ_PAN		0x80		/* RJ panel (SST16) */
+#define	LP		0x100		/* low-profile board
(SST-4P) */
+
+/*
+ * miscellaneous defines
+ */
+
+#define EQNX_COOKED	1
+#define EQNX_TXINT	2
+
+#define TURNOFF		0		/* turn this channel off
*/
+#define TURNON		1		/* turn this channel on */
+
+#define LOCK_A		1		/* Bank A lock bit */
+#define LOCK_B		2		/* Bank B lock bit */
+
+#define MPTIMEO		((HZ*10)/1000)	/* 10 ms. polling
interval */
+
+#define CLSTIMEO	0		/* change to timeout close drain
*/
+#define EQNX_CLOSEDELAY ((HZ*500)/1000)	/* 1/2 second */
+
+#define false		0
+#define true		(!false)
+
+#define HWREGSLEN	0x4000		/* 16k register space for each
chan */
+
+#define FLAT128_MEM_LEN	0x200000	/* SSP-64 (128) PCI
memory size */
+#define FLAT64_MEM_LEN	0x100000	/* SSP-64 (64) PCI memory size
*/
+#define FLAT64K_MEM_LEN	0x10000		/* SSP-4 PCI memory size
*/
+
+#define HA_FLAT		0		/* flat memory space */
+#define HA_WIN16	1		/* window memory space (ISA) */
+
+#define MM_COUNTRY_CODE_REG	0x8800
+
+#define MPBOARD(i)	((i) / MAXCHNL_BRD)	/* minor device to board
*/
+#define MPCHAN(i)	((i) % MAXCHNL_BRD)	/* minor device to
channel */
+
+#ifndef MIN
+#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
+#endif
+#ifndef MAX
+#define MAX(a,b)	(((a) > (b)) ? (a) : (b))
+#endif
+
+#define XMIT_BUF_SIZE	4096
+
+/*
+ * Memory Space Control bit (bit 1 @ offset 0x04) in I/O Configuration
+ * Space's Command Reg.
+ */
+#define PCI_MSC 0x02
+
+#define PCI_BASE_ADDR_MASK	0xfffffff0
