Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVL2Alr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVL2Alr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVL2Aje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:34 -0500
Received: from mx.pathscale.com ([64.160.42.68]:51944 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932578AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 20] ipath - misc driver support code
X-Mercurial-Node: 5e9b0b7876e2d570f25e4b75dc17293382fe28ce
Message-Id: <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:31 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e8af3873b0d9 -r 5e9b0b7876e2 drivers/infiniband/hw/ipath/ipath_ht400.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,1137 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+/*
+ * The first part of this file is shared with the diags, the second
+ * part is used only in the kernel.
+ */
+
+#include <stddef.h>		/* for offsetof */
+
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/wait.h>
+#include "ipath_kernel.h"
+
+#include "ipath_registers.h"
+#include "ipath_common.h"
+
+/*
+ * This lists the InfiniPath registers, in the actual chip layout.  This
+ * structure should never be directly accessed.  It is included by the
+ * user mode diags, and so must be able to be compiled in both user
+ * and kernel mode.
+ */
+struct _infinipath_do_not_use_kernel_regs {
+	unsigned long long Revision;
+	unsigned long long Control;
+	unsigned long long PageAlign;
+	unsigned long long PortCnt;
+	unsigned long long DebugPortSelect;
+	unsigned long long DebugPort;
+	unsigned long long SendRegBase;
+	unsigned long long UserRegBase;
+	unsigned long long CounterRegBase;
+	unsigned long long Scratch;
+	unsigned long long ReservedMisc1;
+	unsigned long long InterruptConfig;
+	unsigned long long IntBlocked;
+	unsigned long long IntMask;
+	unsigned long long IntStatus;
+	unsigned long long IntClear;
+	unsigned long long ErrorMask;
+	unsigned long long ErrorStatus;
+	unsigned long long ErrorClear;
+	unsigned long long HwErrMask;
+	unsigned long long HwErrStatus;
+	unsigned long long HwErrClear;
+	unsigned long long HwDiagCtrl;
+	unsigned long long MDIO;
+	unsigned long long IBCStatus;
+	unsigned long long IBCCtrl;
+	unsigned long long ExtStatus;
+	unsigned long long ExtCtrl;
+	unsigned long long GPIOOut;
+	unsigned long long GPIOMask;
+	unsigned long long GPIOStatus;
+	unsigned long long GPIOClear;
+	unsigned long long RcvCtrl;
+	unsigned long long RcvBTHQP;
+	unsigned long long RcvHdrSize;
+	unsigned long long RcvHdrCnt;
+	unsigned long long RcvHdrEntSize;
+	unsigned long long RcvTIDBase;
+	unsigned long long RcvTIDCnt;
+	unsigned long long RcvEgrBase;
+	unsigned long long RcvEgrCnt;
+	unsigned long long RcvBufBase;
+	unsigned long long RcvBufSize;
+	unsigned long long RxIntMemBase;
+	unsigned long long RxIntMemSize;
+	unsigned long long RcvPartitionKey;
+	unsigned long long ReservedRcv[10];
+	unsigned long long SendCtrl;
+	unsigned long long SendPIOBufBase;
+	unsigned long long SendPIOSize;
+	unsigned long long SendPIOBufCnt;
+	unsigned long long SendPIOAvailAddr;
+	unsigned long long TxIntMemBase;
+	unsigned long long TxIntMemSize;
+	unsigned long long ReservedSend[9];
+	unsigned long long SendBufferError;
+	unsigned long long SendBufferErrorCONT1;
+	unsigned long long SendBufferErrorCONT2;
+	unsigned long long SendBufferErrorCONT3;
+	unsigned long long ReservedSBE[4];
+	unsigned long long RcvHdrAddr0;
+	unsigned long long RcvHdrAddr1;
+	unsigned long long RcvHdrAddr2;
+	unsigned long long RcvHdrAddr3;
+	unsigned long long RcvHdrAddr4;
+	unsigned long long RcvHdrAddr5;
+	unsigned long long RcvHdrAddr6;
+	unsigned long long RcvHdrAddr7;
+	unsigned long long RcvHdrAddr8;
+	unsigned long long ReservedRHA[7];
+	unsigned long long RcvHdrTailAddr0;
+	unsigned long long RcvHdrTailAddr1;
+	unsigned long long RcvHdrTailAddr2;
+	unsigned long long RcvHdrTailAddr3;
+	unsigned long long RcvHdrTailAddr4;
+	unsigned long long RcvHdrTailAddr5;
+	unsigned long long RcvHdrTailAddr6;
+	unsigned long long RcvHdrTailAddr7;
+	unsigned long long RcvHdrTailAddr8;
+	unsigned long long ReservedRHTA[7];
+	unsigned long long Sync;	/* Software only */
+	unsigned long long Dump;	/* Software only */
+	unsigned long long SimVer;	/* Software only */
+	unsigned long long ReservedSW[5];
+	unsigned long long SerdesConfig0;
+	unsigned long long SerdesConfig1;
+	unsigned long long SerdesStatus;
+	unsigned long long XGXSConfig;
+	unsigned long long ReservedSW2[4];
+};
+
+#define IPATH_KREG_OFFSET(field) (offsetof(struct \
+    _infinipath_do_not_use_kernel_regs, field) / sizeof(uint64_t))
+#define IPATH_CREG_OFFSET(field) (offsetof( \
+    struct infinipath_counters, field) / sizeof(uint64_t))
+
+ipath_kreg
+	kr_control = IPATH_KREG_OFFSET(Control),
+	kr_counterregbase = IPATH_KREG_OFFSET(CounterRegBase),
+	kr_debugport = IPATH_KREG_OFFSET(DebugPort),
+	kr_debugportselect = IPATH_KREG_OFFSET(DebugPortSelect),
+	kr_errorclear = IPATH_KREG_OFFSET(ErrorClear),
+	kr_errormask = IPATH_KREG_OFFSET(ErrorMask),
+	kr_errorstatus = IPATH_KREG_OFFSET(ErrorStatus),
+	kr_extctrl = IPATH_KREG_OFFSET(ExtCtrl),
+	kr_extstatus = IPATH_KREG_OFFSET(ExtStatus),
+	kr_gpio_clear = IPATH_KREG_OFFSET(GPIOClear),
+	kr_gpio_mask = IPATH_KREG_OFFSET(GPIOMask),
+	kr_gpio_out = IPATH_KREG_OFFSET(GPIOOut),
+	kr_gpio_status = IPATH_KREG_OFFSET(GPIOStatus),
+	kr_hwdiagctrl = IPATH_KREG_OFFSET(HwDiagCtrl),
+	kr_hwerrclear = IPATH_KREG_OFFSET(HwErrClear),
+	kr_hwerrmask = IPATH_KREG_OFFSET(HwErrMask),
+	kr_hwerrstatus = IPATH_KREG_OFFSET(HwErrStatus),
+	kr_ibcctrl = IPATH_KREG_OFFSET(IBCCtrl),
+	kr_ibcstatus = IPATH_KREG_OFFSET(IBCStatus),
+	kr_intblocked = IPATH_KREG_OFFSET(IntBlocked),
+	kr_intclear = IPATH_KREG_OFFSET(IntClear),
+	kr_interruptconfig = IPATH_KREG_OFFSET(InterruptConfig),
+	kr_intmask = IPATH_KREG_OFFSET(IntMask),
+	kr_intstatus = IPATH_KREG_OFFSET(IntStatus),
+	kr_mdio = IPATH_KREG_OFFSET(MDIO),
+	kr_pagealign = IPATH_KREG_OFFSET(PageAlign),
+	kr_partitionkey = IPATH_KREG_OFFSET(RcvPartitionKey),
+	kr_portcnt = IPATH_KREG_OFFSET(PortCnt),
+	kr_rcvbthqp = IPATH_KREG_OFFSET(RcvBTHQP),
+	kr_rcvbufbase = IPATH_KREG_OFFSET(RcvBufBase),
+	kr_rcvbufsize = IPATH_KREG_OFFSET(RcvBufSize),
+	kr_rcvctrl = IPATH_KREG_OFFSET(RcvCtrl),
+	kr_rcvegrbase = IPATH_KREG_OFFSET(RcvEgrBase),
+	kr_rcvegrcnt = IPATH_KREG_OFFSET(RcvEgrCnt),
+	kr_rcvhdrcnt = IPATH_KREG_OFFSET(RcvHdrCnt),
+	kr_rcvhdrentsize = IPATH_KREG_OFFSET(RcvHdrEntSize),
+	kr_rcvhdrsize = IPATH_KREG_OFFSET(RcvHdrSize),
+	kr_rcvintmembase = IPATH_KREG_OFFSET(RxIntMemBase),
+	kr_rcvintmemsize = IPATH_KREG_OFFSET(RxIntMemSize),
+	kr_rcvtidbase = IPATH_KREG_OFFSET(RcvTIDBase),
+	kr_rcvtidcnt = IPATH_KREG_OFFSET(RcvTIDCnt),
+	kr_revision = IPATH_KREG_OFFSET(Revision),
+	kr_scratch = IPATH_KREG_OFFSET(Scratch),
+	kr_sendbuffererror = IPATH_KREG_OFFSET(SendBufferError),
+	kr_sendbuffererror1 = IPATH_KREG_OFFSET(SendBufferErrorCONT1),
+	kr_sendbuffererror2 = IPATH_KREG_OFFSET(SendBufferErrorCONT2),
+	kr_sendbuffererror3 = IPATH_KREG_OFFSET(SendBufferErrorCONT3),
+	kr_sendctrl = IPATH_KREG_OFFSET(SendCtrl),
+	kr_sendpioavailaddr = IPATH_KREG_OFFSET(SendPIOAvailAddr),
+	kr_sendpiobufbase = IPATH_KREG_OFFSET(SendPIOBufBase),
+	kr_sendpiobufcnt = IPATH_KREG_OFFSET(SendPIOBufCnt),
+	kr_sendpiosize = IPATH_KREG_OFFSET(SendPIOSize),
+	kr_sendregbase = IPATH_KREG_OFFSET(SendRegBase),
+	kr_txintmembase = IPATH_KREG_OFFSET(TxIntMemBase),
+	kr_txintmemsize = IPATH_KREG_OFFSET(TxIntMemSize),
+	kr_userregbase = IPATH_KREG_OFFSET(UserRegBase),
+	kr_serdesconfig0 = IPATH_KREG_OFFSET(SerdesConfig0),
+	kr_serdesconfig1 = IPATH_KREG_OFFSET(SerdesConfig1),
+	kr_serdesstatus = IPATH_KREG_OFFSET(SerdesStatus),
+	kr_xgxsconfig = IPATH_KREG_OFFSET(XGXSConfig),
+	/*
+	 * last valid direct use register other than diag-only registers
+	 */
+	__kr_lastvaliddirect = IPATH_KREG_OFFSET(ReservedSW2[0]),
+	/* always invalid for initializing */
+	__kr_invalid = IPATH_KREG_OFFSET(ReservedSW2[0]) + 1,
+	/*
+	 * These should not be used directly via ipath_kget_kreg64(),
+	 * use them with ipath_kget_kreg64_port()
+	 */
+	kr_rcvhdraddr = IPATH_KREG_OFFSET(RcvHdrAddr0),	/* not for direct use */
+	/* not for direct use */
+	kr_rcvhdrtailaddr = IPATH_KREG_OFFSET(RcvHdrTailAddr0),
+	/* we define the full set for the diags, the kernel doesn't use them */
+	kr_rcvhdraddr1 = IPATH_KREG_OFFSET(RcvHdrAddr1),
+	kr_rcvhdraddr2 = IPATH_KREG_OFFSET(RcvHdrAddr2),
+	kr_rcvhdraddr3 = IPATH_KREG_OFFSET(RcvHdrAddr3),
+	kr_rcvhdraddr4 = IPATH_KREG_OFFSET(RcvHdrAddr4),
+	kr_rcvhdrtailaddr1 = IPATH_KREG_OFFSET(RcvHdrTailAddr1),
+	kr_rcvhdrtailaddr2 = IPATH_KREG_OFFSET(RcvHdrTailAddr2),
+	kr_rcvhdrtailaddr3 = IPATH_KREG_OFFSET(RcvHdrTailAddr3),
+	kr_rcvhdrtailaddr4 = IPATH_KREG_OFFSET(RcvHdrTailAddr4),
+	kr_rcvhdraddr5 = IPATH_KREG_OFFSET(RcvHdrAddr5),
+	kr_rcvhdraddr6 = IPATH_KREG_OFFSET(RcvHdrAddr6),
+	kr_rcvhdraddr7 = IPATH_KREG_OFFSET(RcvHdrAddr7),
+	kr_rcvhdraddr8 = IPATH_KREG_OFFSET(RcvHdrAddr8),
+	kr_rcvhdrtailaddr5 = IPATH_KREG_OFFSET(RcvHdrTailAddr5),
+	kr_rcvhdrtailaddr6 = IPATH_KREG_OFFSET(RcvHdrTailAddr6),
+	kr_rcvhdrtailaddr7 = IPATH_KREG_OFFSET(RcvHdrTailAddr7),
+	kr_rcvhdrtailaddr8 = IPATH_KREG_OFFSET(RcvHdrTailAddr8);
+
+/*
+ * first of the pioavail registers, the total number is
+ * (kr_sendpiobufcnt / 32); each buffer uses 2 bits
+ * More properly, it's:
+ *   (kr_sendpiobufcnt / ((sizeof(uint64_t)*BITS_PER_BYTE)/2))
+ */
+ipath_sreg sr_sendpioavail = 0;
+
+ipath_creg
+	cr_badformatcnt = IPATH_CREG_OFFSET(RxBadFormatCnt),
+	cr_erricrccnt = IPATH_CREG_OFFSET(RxICRCErrCnt),
+	cr_errlinkcnt = IPATH_CREG_OFFSET(RxLinkProblemCnt),
+	cr_errlpcrccnt = IPATH_CREG_OFFSET(RxLPCRCErrCnt),
+	cr_errpkey = IPATH_CREG_OFFSET(RxPKeyMismatchCnt),
+	cr_errrcvflowctrlcnt = IPATH_CREG_OFFSET(RxFlowCtrlErrCnt),
+	cr_err_rlencnt = IPATH_CREG_OFFSET(RxLenErrCnt),
+	cr_errslencnt = IPATH_CREG_OFFSET(TxLenErrCnt),
+	cr_errtidfull = IPATH_CREG_OFFSET(RxTIDFullErrCnt),
+	cr_errtidvalid = IPATH_CREG_OFFSET(RxTIDValidErrCnt),
+	cr_errvcrccnt = IPATH_CREG_OFFSET(RxVCRCErrCnt),
+	cr_ibstatuschange = IPATH_CREG_OFFSET(IBStatusChangeCnt),
+	/* calc from Reg_CounterRegBase + offset */
+	cr_intcnt = IPATH_CREG_OFFSET(LBIntCnt),
+	cr_invalidrlencnt = IPATH_CREG_OFFSET(RxMaxMinLenErrCnt),
+	cr_invalidslencnt = IPATH_CREG_OFFSET(TxMaxMinLenErrCnt),
+	cr_lbflowstallcnt = IPATH_CREG_OFFSET(LBFlowStallCnt),
+	cr_pktrcvcnt = IPATH_CREG_OFFSET(RxDataPktCnt),
+	cr_pktrcvflowctrlcnt = IPATH_CREG_OFFSET(RxFlowPktCnt),
+	cr_pktsendcnt = IPATH_CREG_OFFSET(TxDataPktCnt),
+	cr_pktsendflowcnt = IPATH_CREG_OFFSET(TxFlowPktCnt),
+	cr_portovflcnt = IPATH_CREG_OFFSET(RxP0HdrEgrOvflCnt),
+	cr_portovflcnt1 = IPATH_CREG_OFFSET(RxP1HdrEgrOvflCnt),
+	cr_portovflcnt2 = IPATH_CREG_OFFSET(RxP2HdrEgrOvflCnt),
+	cr_portovflcnt3 = IPATH_CREG_OFFSET(RxP3HdrEgrOvflCnt),
+	cr_portovflcnt4 = IPATH_CREG_OFFSET(RxP4HdrEgrOvflCnt),
+	cr_portovflcnt5 = IPATH_CREG_OFFSET(RxP5HdrEgrOvflCnt),
+	cr_portovflcnt6 = IPATH_CREG_OFFSET(RxP6HdrEgrOvflCnt),
+	cr_portovflcnt7 = IPATH_CREG_OFFSET(RxP7HdrEgrOvflCnt),
+	cr_portovflcnt8 = IPATH_CREG_OFFSET(RxP8HdrEgrOvflCnt),
+	cr_rcvebpcnt = IPATH_CREG_OFFSET(RxEBPCnt),
+	cr_rcvovflcnt = IPATH_CREG_OFFSET(RxBufOvflCnt),
+	cr_senddropped = IPATH_CREG_OFFSET(TxDroppedPktCnt),
+	cr_sendstallcnt = IPATH_CREG_OFFSET(TxFlowStallCnt),
+	cr_sendunderruncnt = IPATH_CREG_OFFSET(TxUnderrunCnt),
+	cr_wordrcvcnt = IPATH_CREG_OFFSET(RxDwordCnt),
+	cr_wordsendcnt = IPATH_CREG_OFFSET(TxDwordCnt),
+	cr_unsupvlcnt = IPATH_CREG_OFFSET(TxUnsupVLErrCnt),
+	cr_rxdroppktcnt = IPATH_CREG_OFFSET(RxDroppedPktCnt),
+	cr_iblinkerrrecovcnt = IPATH_CREG_OFFSET(IBLinkErrRecoveryCnt),
+	cr_iblinkdowncnt = IPATH_CREG_OFFSET(IBLinkDownedCnt),
+	cr_ibsymbolerrcnt = IPATH_CREG_OFFSET(IBSymbolErrCnt);
+
+/* kr_sendctrl bits */
+#define INFINIPATH_S_DISARMPIOBUF_MASK 0xFF
+
+/* kr_rcvctrl bits */
+#define INFINIPATH_R_PORTENABLE_MASK 0x1FF
+#define INFINIPATH_R_INTRAVAIL_MASK 0x1FF
+
+/* kr_intstatus, kr_intclear, kr_intmask bits */
+#define INFINIPATH_I_RCVURG_MASK 0x1FF
+#define INFINIPATH_I_RCVAVAIL_MASK 0x1FF
+
+/* kr_hwerrclear, kr_hwerrmask, kr_hwerrstatus, bits */
+#define INFINIPATH_HWE_HTCMEMPARITYERR_MASK 0x3FFFFFULL
+#define INFINIPATH_HWE_HTCLNKABYTE0CRCERR   0x0000000000800000ULL
+#define INFINIPATH_HWE_HTCLNKABYTE1CRCERR   0x0000000001000000ULL
+#define INFINIPATH_HWE_HTCLNKBBYTE0CRCERR   0x0000000002000000ULL
+#define INFINIPATH_HWE_HTCLNKBBYTE1CRCERR   0x0000000004000000ULL
+#define INFINIPATH_HWE_HTCMISCERR4        0x0000000008000000ULL
+#define INFINIPATH_HWE_HTCMISCERR5          0x0000000010000000ULL
+#define INFINIPATH_HWE_HTCMISCERR6          0x0000000020000000ULL
+#define INFINIPATH_HWE_HTCMISCERR7          0x0000000040000000ULL
+#define INFINIPATH_HWE_MEMBISTFAILED        0x0040000000000000ULL
+#define INFINIPATH_HWE_COREPLL_FBSLIP       0x0080000000000000ULL
+#define INFINIPATH_HWE_COREPLL_RFSLIP       0x0100000000000000ULL
+#define INFINIPATH_HWE_HTBPLL_FBSLIP        0x0200000000000000ULL
+#define INFINIPATH_HWE_HTBPLL_RFSLIP        0x0400000000000000ULL
+#define INFINIPATH_HWE_HTAPLL_FBSLIP        0x0800000000000000ULL
+#define INFINIPATH_HWE_HTAPLL_RFSLIP        0x1000000000000000ULL
+#define INFINIPATH_HWE_EXTSERDESPLLFAILED   0x2000000000000000ULL
+
+/* kr_hwdiagctrl bits */
+#define INFINIPATH_DC_NUMHTMEMS 22
+
+/* kr_extstatus bits */
+#define INFINIPATH_EXTS_FREQSEL 0x2
+#define INFINIPATH_EXTS_SERDESSEL 0x4
+#define INFINIPATH_EXTS_MEMBIST_ENDTEST     0x0000000000004000
+#define INFINIPATH_EXTS_MEMBIST_CORRECT     0x0000000000008000
+
+/* kr_extctrl bits */
+
+/*
+ * masks and bits that are different in different chips, or present only
+ * in one
+ */
+const uint32_t infinipath_i_rcvavail_mask = INFINIPATH_I_RCVAVAIL_MASK;
+const uint32_t infinipath_i_rcvurg_mask = INFINIPATH_I_RCVURG_MASK;
+const uint64_t infinipath_hwe_htcmemparityerr_mask =
+	INFINIPATH_HWE_HTCMEMPARITYERR_MASK;
+
+const uint64_t infinipath_hwe_spibdcmlockfailed_mask = 0ULL;
+const uint64_t infinipath_hwe_sphtdcmlockfailed_mask = 0ULL;
+const uint64_t infinipath_hwe_htcdcmlockfailed_mask = 0ULL;
+const uint64_t infinipath_hwe_htcdcmlockfailed_shift = 0ULL;
+const uint64_t infinipath_hwe_sphtdcmlockfailed_shift = 0ULL;
+const uint64_t infinipath_hwe_spibdcmlockfailed_shift = 0ULL;
+
+const uint64_t infinipath_hwe_htclnkabyte0crcerr =
+	INFINIPATH_HWE_HTCLNKABYTE0CRCERR;
+const uint64_t infinipath_hwe_htclnkabyte1crcerr =
+	INFINIPATH_HWE_HTCLNKABYTE1CRCERR;
+const uint64_t infinipath_hwe_htclnkbbyte0crcerr =
+	INFINIPATH_HWE_HTCLNKBBYTE0CRCERR;
+const uint64_t infinipath_hwe_htclnkbbyte1crcerr =
+	INFINIPATH_HWE_HTCLNKBBYTE1CRCERR;
+
+const uint64_t infinipath_c_bitsextant =
+	(INFINIPATH_C_FREEZEMODE | INFINIPATH_C_LINKENABLE);
+
+const uint64_t infinipath_s_bitsextant =
+	(INFINIPATH_S_ABORT | INFINIPATH_S_PIOINTBUFAVAIL |
+	 INFINIPATH_S_PIOBUFAVAILUPD | INFINIPATH_S_PIOENABLE |
+	 INFINIPATH_S_DISARM |
+	 (INFINIPATH_S_DISARMPIOBUF_MASK << INFINIPATH_S_DISARMPIOBUF_SHIFT));
+
+const uint64_t infinipath_r_bitsextant =
+	((INFINIPATH_R_PORTENABLE_MASK << INFINIPATH_R_PORTENABLE_SHIFT) |
+	 (INFINIPATH_R_INTRAVAIL_MASK << INFINIPATH_R_INTRAVAIL_SHIFT) |
+	 INFINIPATH_R_TAILUPD);
+
+const uint64_t infinipath_i_bitsextant =
+	((INFINIPATH_I_RCVURG_MASK << INFINIPATH_I_RCVURG_SHIFT) |
+	 (INFINIPATH_I_RCVAVAIL_MASK << INFINIPATH_I_RCVAVAIL_SHIFT) |
+	 INFINIPATH_I_ERROR | INFINIPATH_I_SPIOSENT |
+	 INFINIPATH_I_SPIOBUFAVAIL | INFINIPATH_I_GPIO);
+
+const uint64_t infinipath_e_bitsextant =
+	(INFINIPATH_E_RFORMATERR | INFINIPATH_E_RVCRC | INFINIPATH_E_RICRC |
+	 INFINIPATH_E_RMINPKTLEN | INFINIPATH_E_RMAXPKTLEN |
+	 INFINIPATH_E_RLONGPKTLEN | INFINIPATH_E_RSHORTPKTLEN |
+	 INFINIPATH_E_RUNEXPCHAR | INFINIPATH_E_RUNSUPVL | INFINIPATH_E_REBP |
+	 INFINIPATH_E_RIBFLOW | INFINIPATH_E_RBADVERSION |
+	 INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL |
+	 INFINIPATH_E_RBADTID | INFINIPATH_E_RHDRLEN |
+	 INFINIPATH_E_RHDR | INFINIPATH_E_RIBLOSTLINK |
+	 INFINIPATH_E_SMINPKTLEN | INFINIPATH_E_SMAXPKTLEN |
+	 INFINIPATH_E_SUNDERRUN | INFINIPATH_E_SPKTLEN |
+	 INFINIPATH_E_SDROPPEDSMPPKT | INFINIPATH_E_SDROPPEDDATAPKT |
+	 INFINIPATH_E_SPIOARMLAUNCH | INFINIPATH_E_SUNEXPERRPKTNUM |
+	 INFINIPATH_E_SUNSUPVL | INFINIPATH_E_IBSTATUSCHANGED |
+	 INFINIPATH_E_INVALIDADDR | INFINIPATH_E_RESET | INFINIPATH_E_HARDWARE);
+
+const uint64_t infinipath_hwe_bitsextant =
+	(INFINIPATH_HWE_HTCMEMPARITYERR_MASK <<
+	 INFINIPATH_HWE_HTCMEMPARITYERR_SHIFT) |
+	(INFINIPATH_HWE_TXEMEMPARITYERR_MASK <<
+	 INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT) |
+	(INFINIPATH_HWE_RXEMEMPARITYERR_MASK <<
+	 INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) |
+	INFINIPATH_HWE_HTCLNKABYTE0CRCERR |
+	INFINIPATH_HWE_HTCLNKABYTE1CRCERR | INFINIPATH_HWE_HTCLNKBBYTE0CRCERR |
+	INFINIPATH_HWE_HTCLNKBBYTE1CRCERR | INFINIPATH_HWE_HTCMISCERR4 |
+	INFINIPATH_HWE_HTCMISCERR5 | INFINIPATH_HWE_HTCMISCERR6 |
+	INFINIPATH_HWE_HTCMISCERR7 | INFINIPATH_HWE_HTCBUSTREQPARITYERR |
+	INFINIPATH_HWE_HTCBUSTRESPPARITYERR |
+	INFINIPATH_HWE_HTCBUSIREQPARITYERR |
+	INFINIPATH_HWE_RXDSYNCMEMPARITYERR | INFINIPATH_HWE_MEMBISTFAILED |
+	INFINIPATH_HWE_COREPLL_FBSLIP | INFINIPATH_HWE_COREPLL_RFSLIP |
+	INFINIPATH_HWE_HTBPLL_FBSLIP | INFINIPATH_HWE_HTBPLL_RFSLIP |
+	INFINIPATH_HWE_HTAPLL_FBSLIP | INFINIPATH_HWE_HTAPLL_RFSLIP |
+	INFINIPATH_HWE_EXTSERDESPLLFAILED |
+	INFINIPATH_HWE_IBCBUSTOSPCPARITYERR |
+	INFINIPATH_HWE_IBCBUSFRSPCPARITYERR;
+
+const uint64_t infinipath_dc_bitsextant =
+	(INFINIPATH_DC_FORCEHTCMEMPARITYERR_MASK <<
+	 INFINIPATH_DC_FORCEHTCMEMPARITYERR_SHIFT) |
+	(INFINIPATH_DC_FORCETXEMEMPARITYERR_MASK <<
+	 INFINIPATH_DC_FORCETXEMEMPARITYERR_SHIFT) |
+	(INFINIPATH_DC_FORCERXEMEMPARITYERR_MASK <<
+	 INFINIPATH_DC_FORCERXEMEMPARITYERR_SHIFT) |
+	INFINIPATH_DC_FORCEHTCBUSTREQPARITYERR |
+	INFINIPATH_DC_FORCEHTCBUSTRESPPARITYERR |
+	INFINIPATH_DC_FORCEHTCBUSIREQPARITYERR |
+	INFINIPATH_DC_FORCERXDSYNCMEMPARITYERR |
+	INFINIPATH_DC_COUNTERDISABLE | INFINIPATH_DC_COUNTERWREN |
+	INFINIPATH_DC_FORCEIBCBUSTOSPCPARITYERR |
+	INFINIPATH_DC_FORCEIBCBUSFRSPCPARITYERR;
+
+const uint64_t infinipath_ibcc_bitsextant =
+	(INFINIPATH_IBCC_FLOWCTRLPERIOD_MASK <<
+	 INFINIPATH_IBCC_FLOWCTRLPERIOD_SHIFT) |
+	(INFINIPATH_IBCC_FLOWCTRLWATERMARK_MASK <<
+	 INFINIPATH_IBCC_FLOWCTRLWATERMARK_SHIFT) |
+	(INFINIPATH_IBCC_LINKINITCMD_MASK <<
+	 INFINIPATH_IBCC_LINKINITCMD_SHIFT) |
+	(INFINIPATH_IBCC_LINKCMD_MASK << INFINIPATH_IBCC_LINKCMD_SHIFT) |
+	(INFINIPATH_IBCC_MAXPKTLEN_MASK << INFINIPATH_IBCC_MAXPKTLEN_SHIFT) |
+	(INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK <<
+	 INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) |
+	(INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK <<
+	 INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT) |
+	(INFINIPATH_IBCC_CREDITSCALE_MASK <<
+	 INFINIPATH_IBCC_CREDITSCALE_SHIFT) |
+	INFINIPATH_IBCC_LOOPBACK | INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE;
+
+const uint64_t infinipath_mdio_bitsextant =
+	(INFINIPATH_MDIO_CLKDIV_MASK << INFINIPATH_MDIO_CLKDIV_SHIFT) |
+	(INFINIPATH_MDIO_COMMAND_MASK << INFINIPATH_MDIO_COMMAND_SHIFT) |
+	(INFINIPATH_MDIO_DEVADDR_MASK << INFINIPATH_MDIO_DEVADDR_SHIFT) |
+	(INFINIPATH_MDIO_REGADDR_MASK << INFINIPATH_MDIO_REGADDR_SHIFT) |
+	(INFINIPATH_MDIO_DATA_MASK << INFINIPATH_MDIO_DATA_SHIFT) |
+	INFINIPATH_MDIO_CMDVALID | INFINIPATH_MDIO_RDDATAVALID;
+
+const uint64_t infinipath_ibcs_bitsextant =
+	(INFINIPATH_IBCS_LINKTRAININGSTATE_MASK <<
+	 INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) |
+	(INFINIPATH_IBCS_LINKSTATE_MASK << INFINIPATH_IBCS_LINKSTATE_SHIFT) |
+	INFINIPATH_IBCS_TXREADY | INFINIPATH_IBCS_TXCREDITOK;
+
+const uint64_t infinipath_extc_bitsextant =
+	(INFINIPATH_EXTC_GPIOINVERT_MASK << INFINIPATH_EXTC_GPIOINVERT_SHIFT) |
+	(INFINIPATH_EXTC_GPIOOE_MASK << INFINIPATH_EXTC_GPIOOE_SHIFT) |
+	INFINIPATH_EXTC_SERDESENABLE | INFINIPATH_EXTC_SERDESCONNECT |
+	INFINIPATH_EXTC_SERDESENTRUNKING | INFINIPATH_EXTC_SERDESDISRXFIFO |
+	INFINIPATH_EXTC_SERDESENPLPBK1 | INFINIPATH_EXTC_SERDESENPLPBK2 |
+	INFINIPATH_EXTC_SERDESENENCDEC | INFINIPATH_EXTC_LEDSECPORTGREENON |
+	INFINIPATH_EXTC_LEDSECPORTYELLOWON | INFINIPATH_EXTC_LEDPRIPORTGREENON |
+	INFINIPATH_EXTC_LEDPRIPORTYELLOWON | INFINIPATH_EXTC_LEDGBLOKGREENON |
+	INFINIPATH_EXTC_LEDGBLERRREDOFF;
+
+/*  Start of Documentation block for SerDes registers
+ *  serdes and xgxs register bits; not all have defines,
+ *  since I haven't yet needed them all, and I'm lazy.  Those that I needed
+ *  are in ipath_registers.h
+
+serdesConfig0Out  (R/W)
+                                        Default Value
+bit[3:0]        - ResetA/B/C/D          (4'b1111)
+bit[7:4]         -L1PwrdnA/B/C/D         (4'b0000)
+bit[11:8]       - RxIdleEnX             (4'b0000)
+bit[15:12]      - TxIdleEnX             (4'b0000)
+bit[19:16]      - RxDetectEnX           (4'b0000)
+bit[23:20]      - BeaconTxEnX           (4'b0000)
+bit[27:24]      - RxTermEnX             (4'b0000)
+bit[28]         - ResetPLL              (1'b0)
+bit[29]         -L2Pwrdn                (1'b0)
+bit[37:30]      - Offset[7:0]           (8'b00000000)
+bit[38]         -OffsetEn               (1'b0)
+bit[39]         -ParLBPK                (1'b0)
+bit[40]         -ParReset               (1'b0)
+bit[42:41]      - RefSel                (2'b10)
+bit[43]         - PW                    (1'b0)
+bit[47:44]      - LPBKA/B/C/D           (4'b0000)
+bit[49:48]      - ClkBufTermAdj         (2'b0)
+bit[51:50]      - RxTermAdj             (2'b0)
+bit[53:52]      - TxTermAdj             (2'b0)
+bit[55:54]      - RxEqCtl               (2'b0)
+bit[63:56]      - Reserved
+
+cce_wip_serdesConfig1Out[63:0]     (R/W)
+bit[3:0]        - HiDrvX                (4'b0000)
+bit[7:4]        - LoDrvX                (4'b0000)
+bit[12:11]      - DtxA[3:0]             (4'b0000)
+bit[15:12]      - DtxB[3:0]             (4'b0000)
+bit[19:16]      - DtxC[3:0]             (4'b0000)
+bit[23:20]      - DtxD[3:0]             (4'b0000)
+bit[27:24]      - DeqA[3:0]             (4'b0000)
+bit[31:28]      - DeqB[3:0]             (4'b0000)
+bit[35:32]      - DeqC[3:0]             (4'b0000)
+bit[39:36]      - DeqD[3:0]             (4'b0000)
+Framer interface, bits 40-59, not used
+bit[44:40]      - FmOffsetA[4:0]        (5'b00000)
+bit[49:45]      - FmOffsetB[4:0]        (5'b00000)
+bit[54:50]      - FmOffsetC[4:0]        (5'b00000)
+bit[59:55]      - FmOffsetD[4:0]        (5'b00000)
+bit[63:60]      - FmOffsetEnA/B/C/D     (4'b0000)
+
+SerdesStatus[63:0]      (RO)
+bit[3:0]        - TxIdleDetectA/B/C/D
+bit[7:4]        - RxDetectA/B/C/D
+bit[11:8]       - BeaconDetectA/B/C/D
+bit[63:12]      - Reserved
+
+XGXSConfigOut[63:0]
+bit[2:0]        - Resets, init to 1; bit 0 unused?
+bit[3]          - MDIO, select register bank for vendor specific register
+        (0x1e if set, else 0x1f); vendor-specific status in register 8
+        bits 0-3 lanes0-3 signal detect, 1 if detected
+        bits 4-7 lanes0-3 CTC fifo errors, 1 if detected (latched until read)
+bit[8:4]        - MDIO port address
+bit[18:9]       - lnk_sync_mask
+bit[22:19]      - polarity inv
+
+Documentation end */
+
+/*
+ *
+ * General specs:
+ *  ExtCtrl[63:48]   = EXTC_GPIOOE[15:0]
+ *  ExtCtrl[47:32]   = EXTC_GPIOInvert[15:0]
+ *  ExtStatus[63:48] = GpioIn[15:0]
+ *
+ * GPIO[1] = EEPROM_SDA
+ * GPIO[0] = EEPROM_SCL
+ */
+
+#define _IPATH_GPIO_SDA_NUM 1
+#define _IPATH_GPIO_SCL_NUM 0
+
+#define IPATH_GPIO_SDA \
+	(1UL << (_IPATH_GPIO_SDA_NUM+INFINIPATH_EXTC_GPIOOE_SHIFT))
+#define IPATH_GPIO_SCL \
+	(1UL << (_IPATH_GPIO_SCL_NUM+INFINIPATH_EXTC_GPIOOE_SHIFT))
+
+/*
+ * register bits for selecting i2c direction and values, used for I2C serial
+ * flash
+ */
+const uint16_t ipath_gpio_sda_num = _IPATH_GPIO_SDA_NUM;
+const uint16_t ipath_gpio_scl_num = _IPATH_GPIO_SCL_NUM;
+const uint64_t ipath_gpio_sda = IPATH_GPIO_SDA;
+const uint64_t ipath_gpio_scl = IPATH_GPIO_SCL;
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+
+/*
+ * This file contains all of the code that is specific to the InfiniPath
+ * HT-400 chip.
+ */
+
+/* we support up to 4 chips per system */
+const uint32_t infinipath_max = 4;
+struct ipath_devdata devdata[4];
+static const char *ipath_unit_names[4] = {
+	"infinipath0", "infinipath1", "infinipath2", "infinipath3"
+};
+
+const char *ipath_get_unit_name(int unit)
+{
+	return ipath_unit_names[unit];
+}
+
+static void ipath_check_htlink(ipath_type t);
+
+/*
+ * display hardware errors.  Use same msg buffer as regular errors to avoid
+ * excessive stack use.  Most hardware errors are catastrophic, but for
+ * right now, we'll print them and continue.
+ * We reuse the same message buffer as ipath_handle_errors() to avoid
+ * excessive stack usage.
+ */
+void ipath_handle_hwerrors(const ipath_type t, char *msg, int msgl)
+{
+	uint64_t hwerrs = ipath_kget_kreg64(t, kr_hwerrstatus);
+	uint32_t bits, ctrl;
+	int isfatal = 0;
+	char bitsmsg[64];
+
+	if (!hwerrs) {
+		_IPATH_VDBG("Called but no hardware errors set\n");
+		/*
+		 * better than printing cofusing messages
+		 * This seems to be related to clearing the crc error, or
+		 * the pll error during init.
+		 */
+		return;
+	} else if (hwerrs == -1LL) {
+		_IPATH_UNIT_ERROR(t,
+				  "Read of hardware error status failed (all bits set); ignoring\n");
+		return;
+	}
+	ipath_stats.sps_hwerrs++;
+
+	/*
+	 * clear the error, regardless of whether we continue or stop using
+	 * the chip.
+	 */
+	ipath_kput_kreg(t, kr_hwerrclear, hwerrs);
+
+	hwerrs &= devdata[t].ipath_hwerrmask;
+
+	/*
+	 * make sure we get this much out, unless told to be quiet,
+	 * or it's occurred within the last 5 seconds
+	 */
+	if ((hwerrs & ~devdata[t].ipath_lasthwerror) ||
+	    (infinipath_debug & __IPATH_VERBDBG))
+		_IPATH_INFO("Hardware error: hwerr=0x%llx (cleared)\n", hwerrs);
+	devdata[t].ipath_lasthwerror |= hwerrs;
+
+	if (hwerrs & ~infinipath_hwe_bitsextant)
+		_IPATH_UNIT_ERROR(t,
+				  "hwerror interrupt with unknown errors %llx set\n",
+				  hwerrs & ~infinipath_hwe_bitsextant);
+
+	ctrl = ipath_kget_kreg32(t, kr_control);
+	if (ctrl & INFINIPATH_C_FREEZEMODE) {
+		if (hwerrs) {
+			/*
+			 * if any set that we aren't ignoring
+			 * only make the complaint once, in case it's stuck or
+			 * recurring, and we get here multiple times
+			 */
+			if (devdata[t].ipath_flags & IPATH_INITTED) {
+				_IPATH_UNIT_ERROR(t,
+						  "Fatal Error (freezemode), no longer usable\n");
+				isfatal = 1;
+			}
+			*devdata[t].ipath_statusp &= ~IPATH_STATUS_IB_READY;
+			/* mark as having had error */
+			*devdata[t].ipath_statusp |= IPATH_STATUS_HWERROR;
+			/*
+			 * mark as not usable, at a minimum until driver
+			 * is reloaded, probably until reboot, since no
+			 * other reset is possible.
+			 */
+			devdata[t].ipath_flags &= ~IPATH_INITTED;
+		} else {
+			_IPATH_DBG
+			    ("Clearing freezemode on ignored hardware error\n");
+			ctrl &= ~INFINIPATH_C_FREEZEMODE;
+			ipath_kput_kreg(t, kr_control, ctrl);
+		}
+	}
+
+	*msg = '\0';
+
+	/*
+	 * may someday want to decode into which bits are which
+	 * functional area for parity errors, etc.
+	 */
+	if (hwerrs & (infinipath_hwe_htcmemparityerr_mask
+		      << INFINIPATH_HWE_HTCMEMPARITYERR_SHIFT)) {
+		bits = (uint32_t) ((hwerrs >>
+				    INFINIPATH_HWE_HTCMEMPARITYERR_SHIFT) &
+				   INFINIPATH_HWE_HTCMEMPARITYERR_MASK);
+		snprintf(bitsmsg, sizeof bitsmsg, "[HTC Parity Errs %x] ",
+			 bits);
+		strlcat(msg, bitsmsg, msgl);
+	}
+	if (hwerrs & (INFINIPATH_HWE_RXEMEMPARITYERR_MASK
+		      << INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT)) {
+		bits = (uint32_t) ((hwerrs >>
+				    INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) &
+				   INFINIPATH_HWE_RXEMEMPARITYERR_MASK);
+		snprintf(bitsmsg, sizeof bitsmsg, "[RXE Parity Errs %x] ",
+			 bits);
+		strlcat(msg, bitsmsg, msgl);
+	}
+	if (hwerrs & (INFINIPATH_HWE_TXEMEMPARITYERR_MASK
+		      << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT)) {
+		bits = (uint32_t) ((hwerrs >>
+				    INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT) &
+				   INFINIPATH_HWE_TXEMEMPARITYERR_MASK);
+		snprintf(bitsmsg, sizeof bitsmsg, "[TXE Parity Errs %x] ",
+			 bits);
+		strlcat(msg, bitsmsg, msgl);
+	}
+	if (hwerrs & INFINIPATH_HWE_IBCBUSTOSPCPARITYERR)
+		strlcat(msg, "[IB2IPATH Parity]", msgl);
+	if (hwerrs & INFINIPATH_HWE_IBCBUSFRSPCPARITYERR)
+		strlcat(msg, "[IPATH2IB Parity]", msgl);
+	if (hwerrs & INFINIPATH_HWE_HTCBUSIREQPARITYERR)
+		strlcat(msg, "[HTC Ireq Parity]", msgl);
+	if (hwerrs & INFINIPATH_HWE_HTCBUSTREQPARITYERR)
+		strlcat(msg, "[HTC Treq Parity]", msgl);
+	if (hwerrs & INFINIPATH_HWE_HTCBUSTRESPPARITYERR)
+		strlcat(msg, "[HTC Tresp Parity]", msgl);
+
+/* keep the code below somewhat more readonable; not used elsewhere */
+#define _IPATH_HTLINK0_CRCBITS (infinipath_hwe_htclnkabyte0crcerr | \
+        infinipath_hwe_htclnkabyte1crcerr)
+#define _IPATH_HTLINK1_CRCBITS (infinipath_hwe_htclnkbbyte0crcerr | \
+        infinipath_hwe_htclnkbbyte1crcerr)
+#define _IPATH_HTLANE0_CRCBITS (infinipath_hwe_htclnkabyte0crcerr | \
+        infinipath_hwe_htclnkbbyte0crcerr)
+#define _IPATH_HTLANE1_CRCBITS (infinipath_hwe_htclnkabyte1crcerr | \
+        infinipath_hwe_htclnkbbyte1crcerr)
+	if (hwerrs & (_IPATH_HTLINK0_CRCBITS | _IPATH_HTLINK1_CRCBITS)) {
+		char bitsmsg[64];
+		uint64_t crcbits = hwerrs &
+		    (_IPATH_HTLINK0_CRCBITS | _IPATH_HTLINK1_CRCBITS);
+		/* don't check if 8bit HT */
+		if (devdata[t].ipath_flags & IPATH_8BIT_IN_HT0)
+			crcbits &= ~infinipath_hwe_htclnkabyte1crcerr;
+		/* don't check if 8bit HT */
+		if (devdata[t].ipath_flags & IPATH_8BIT_IN_HT1)
+			crcbits &= ~infinipath_hwe_htclnkbbyte1crcerr;
+		/*
+		 * we'll want to ignore link errors on link that is
+		 * not in use, if any.  For now, complain about both
+		 */
+		if (crcbits) {
+			uint16_t ctrl0, ctrl1;
+			snprintf(bitsmsg, sizeof bitsmsg,
+				 "[HT%s lane %s CRC (%llx); ignore till reload]",
+				 !(crcbits & _IPATH_HTLINK1_CRCBITS) ?
+				 "0 (A)" : (!(crcbits & _IPATH_HTLINK0_CRCBITS)
+					    ? "1 (B)" : "0+1 (A+B)"),
+				 !(crcbits & _IPATH_HTLANE1_CRCBITS) ? "0"
+				 : (!(crcbits & _IPATH_HTLANE0_CRCBITS) ? "1" :
+				    "0+1"), crcbits);
+			strlcat(msg, bitsmsg, msgl);
+
+			/*
+			 * print extra info for debugging.
+			 * slave/primary config word 4, 8 (link control 0, 1)
+			 */
+
+			if (pci_read_config_word(devdata[t].pcidev,
+						 devdata[t].ipath_ht_slave_off +
+						 0x4, &ctrl0))
+				_IPATH_INFO
+				    ("Couldn't read linkctrl0 of slave/primary config block\n");
+			else if (!(ctrl0 & 1 << 6))	/* not if EOC bit set */
+				_IPATH_DBG("HT linkctrl0 0x%x%s%s\n", ctrl0,
+					   ((ctrl0 >> 8) & 7) ? " CRC" : "",
+					   ((ctrl0 >> 4) & 1) ? "linkfail" :
+					   "");
+			if (pci_read_config_word
+			    (devdata[t].pcidev,
+			     devdata[t].ipath_ht_slave_off + 0x8, &ctrl1))
+				_IPATH_INFO
+				    ("Couldn't read linkctrl1 of slave/primary config block\n");
+			else if (!(ctrl1 & 1 << 6))	/* not if EOC bit set */
+				_IPATH_DBG("HT linkctrl1 0x%x%s%s\n", ctrl1,
+					   ((ctrl1 >> 8) & 7) ? " CRC" : "",
+					   ((ctrl1 >> 4) & 1) ? "linkfail" :
+					   "");
+
+			/* disable until driver reloaded */
+			devdata[t].ipath_hwerrmask &= ~crcbits;
+			ipath_kput_kreg(t, kr_hwerrmask,
+					devdata[t].ipath_hwerrmask);
+			_IPATH_DBG("HT crc errs: %s\n", msg);
+		} else
+			_IPATH_DBG
+			    ("ignoring HT crc errors 0x%llx, not in use\n",
+			     hwerrs & (_IPATH_HTLINK0_CRCBITS |
+				       _IPATH_HTLINK1_CRCBITS));
+	}
+
+	if (hwerrs & INFINIPATH_HWE_HTCMISCERR5)
+		strlcat(msg, "[HT core Misc5]", msgl);
+	if (hwerrs & INFINIPATH_HWE_HTCMISCERR6)
+		strlcat(msg, "[HT core Misc6]", msgl);
+	if (hwerrs & INFINIPATH_HWE_HTCMISCERR7)
+		strlcat(msg, "[HT core Misc7]", msgl);
+	if (hwerrs & INFINIPATH_HWE_MEMBISTFAILED) {
+		strlcat(msg, "[Memory BIST test failed, HT-400 unusable]",
+			msgl);
+		/* ignore from now on, so disable until driver reloaded */
+		devdata[t].ipath_hwerrmask &= ~INFINIPATH_HWE_MEMBISTFAILED;
+		ipath_kput_kreg(t, kr_hwerrmask, devdata[t].ipath_hwerrmask);
+	}
+#define _IPATH_PLL_FAIL (INFINIPATH_HWE_COREPLL_FBSLIP | \
+    INFINIPATH_HWE_COREPLL_RFSLIP | \
+    INFINIPATH_HWE_HTBPLL_FBSLIP | \
+    INFINIPATH_HWE_HTBPLL_RFSLIP | \
+    INFINIPATH_HWE_HTAPLL_FBSLIP | \
+    INFINIPATH_HWE_HTAPLL_RFSLIP)
+
+	if (hwerrs & _IPATH_PLL_FAIL) {
+		snprintf(bitsmsg, sizeof bitsmsg,
+			 "[PLL failed (%llx), HT-400 unusable]",
+			 hwerrs & _IPATH_PLL_FAIL);
+		strlcat(msg, bitsmsg, msgl);
+		/* ignore from now on, so disable until driver reloaded */
+		devdata[t].ipath_hwerrmask &= ~(hwerrs & _IPATH_PLL_FAIL);
+		ipath_kput_kreg(t, kr_hwerrmask, devdata[t].ipath_hwerrmask);
+	}
+
+	if (hwerrs & INFINIPATH_HWE_EXTSERDESPLLFAILED) {
+		/*
+		 * If it occurs, it is left masked since the eternal interface
+		 * is unused
+		 */
+		devdata[t].ipath_hwerrmask &=
+		    ~INFINIPATH_HWE_EXTSERDESPLLFAILED;
+		ipath_kput_kreg(t, kr_hwerrmask, devdata[t].ipath_hwerrmask);
+	}
+
+	if (hwerrs & INFINIPATH_HWE_RXDSYNCMEMPARITYERR)
+		strlcat(msg, "[Rx Dsync]", msgl);
+	if (hwerrs & INFINIPATH_HWE_SERDESPLLFAILED)
+		strlcat(msg, "[SerDes PLL]", msgl);
+
+	_IPATH_UNIT_ERROR(t, "%s hardware error\n", msg);
+	if (isfatal && (!ipath_diags_enabled)) {
+		if (devdata[t].ipath_freezemsg) {
+			/*
+			 * for proc status file ; if no trailing } is copied, we'll know
+			 * it was truncated.
+			 */
+			snprintf(devdata[t].ipath_freezemsg,
+				 devdata[t].ipath_freezelen, "{%s}", msg);
+		}
+	}
+}
+
+/* fill in the board name, based on the board revision register */
+void ipath_ht_get_boardname(const ipath_type t, char *name, size_t namelen)
+{
+	char *n = NULL;
+	uint8_t boardrev = devdata[t].ipath_boardrev;
+
+	switch (boardrev) {
+	case 4:		/* Ponderosa is one of the bringup boards */
+		n = "Ponderosa";
+		break;
+	case 5:		/* HT-460 original production board */
+		n = "InfiniPath_HT-460";
+		break;
+	case 7:		/* HT-460 small form factor production board */
+		n = "InfiniPath_HT-465";
+		break;
+	case 6:
+		n = "OEM_Board_3";
+		break;
+	case 8:
+		n = "LS/X-1";
+		break;
+	case 9:		/* Comstock bringup test board */
+		n = "Comstock";
+		break;
+	case 10:
+		n = "OEM_Board_2";
+		break;
+	case 11:
+		n = "HT-470";
+		break;
+	default:		/* don't know, just print the number */
+		_IPATH_ERROR("Don't yet know about board with ID %u\n",
+			     boardrev);
+		snprintf(name, namelen, "UnknownBoardRev%u", boardrev);
+		break;
+	}
+	if (n)
+		snprintf(name, namelen, "%s", n);
+}
+
+int ipath_validate_rev(struct ipath_devdata * dd)
+{
+	if (dd->ipath_majrev != 3 || dd->ipath_minrev != 2) {
+		/*
+		 * This version of the driver only supports the HT-400
+		 * Rev 3.2
+		 */
+		_IPATH_UNIT_ERROR(IPATH_UNIT(dd),
+				  "Unsupported HT-400 revision %u.%u!\n",
+				  dd->ipath_majrev, dd->ipath_minrev);
+		return 1;
+	}
+	if (dd->ipath_htspeed != 800)
+		_IPATH_UNIT_ERROR(IPATH_UNIT(dd),
+				  "Incorrectly configured for HT @ %uMHz\n",
+				  dd->ipath_htspeed);
+	if (dd->ipath_boardrev == 7 || dd->ipath_boardrev == 11 ||
+		dd->ipath_boardrev == 6)
+		dd->ipath_flags |= IPATH_GPIO_INTR;
+	else if (dd->ipath_boardrev == 8)  { /* LS/X-1 */
+		uint64_t val;
+		val = ipath_kget_kreg64(dd->ipath_pd[0]->port_unit, kr_extstatus);
+		if (val & INFINIPATH_EXTS_SERDESSEL) {  /* hardware disabled */
+			/* This means that the chip is hardware disabled, and will
+			 * not be able to bring up the link, in any case.  We special
+			 * case this and abort early, to avoid later messages.  We
+			 * also set the DISABLED status bit
+			 */
+			_IPATH_DBG("Unit %u is hardware-disabled\n",
+				dd->ipath_pd[0]->port_unit);
+			*dd->ipath_statusp |= IPATH_STATUS_DISABLED;
+			return 2; /* this value is handled differently */
+		}
+	}
+	return 0;
+}
+
+static void ipath_check_htlink(ipath_type t)
+{
+	uint8_t linkerr, link_off, i;
+
+	for (i = 0; i < 2; i++) {
+		link_off = devdata[t].ipath_ht_slave_off + i * 4 + 0xd;
+		if (pci_read_config_byte(devdata[t].pcidev, link_off, &linkerr))
+			_IPATH_INFO
+			    ("Couldn't read linkerror%d of HT slave/primary block\n",
+			     i);
+		else if (linkerr & 0xf0) {
+			_IPATH_VDBG("HT linkerr%d bits 0x%x set, clearing\n",
+				    linkerr >> 4, i);
+			/*
+			 * writing the linkerr bits that are set should
+			 * clear them
+			 */
+			if (pci_write_config_byte
+			    (devdata[t].pcidev, link_off, linkerr))
+				_IPATH_DBG
+				    ("Failed write to clear HT linkerror%d\n",
+				     i);
+			if (pci_read_config_byte
+			    (devdata[t].pcidev, link_off, &linkerr))
+				_IPATH_INFO
+				    ("Couldn't reread linkerror%d of HT slave/primary block\n",
+				     i);
+			else if (linkerr & 0xf0)
+				_IPATH_INFO
+				    ("HT linkerror%d bits 0x%x couldn't be cleared\n",
+				     i, linkerr >> 4);
+		}
+	}
+}
+
+/*
+ * now that we have finished initializing everything that might reasonably
+ * cause a hardware error, and cleared those errors bits as they occur,
+ * we can enable hardware errors in the mask (potentially enabling
+ * freeze mode), and enable hardware errors as errors (along with
+ * everything else) in errormask
+ */
+void ipath_clear_init_hwerrs(ipath_type t)
+{
+	uint64_t val, extsval;
+
+	extsval = ipath_kget_kreg64(t, kr_extstatus);
+
+	if (!(extsval & INFINIPATH_EXTS_MEMBIST_ENDTEST))
+		_IPATH_UNIT_ERROR(t, "MemBIST did not complete!\n");
+
+	ipath_check_htlink(t);
+
+	/* barring bugs, all hwerrors become interrupts, which can */
+	val = -1LL;
+	/* don't look at crc lane1 if 8 bit */
+	if (devdata[t].ipath_flags & IPATH_8BIT_IN_HT0)
+		val &= ~infinipath_hwe_htclnkabyte1crcerr;
+	/* don't look at crc lane1 if 8 bit */
+	if (devdata[t].ipath_flags & IPATH_8BIT_IN_HT1)
+		val &= ~infinipath_hwe_htclnkbbyte1crcerr;
+
+	/*
+	 * disable RXDSYNCMEMPARITY because external serdes is unused,
+	 * and therefore the logic will never be used or initialized,
+	 * and uninitialized state will normally result in this error
+	 * being asserted.  Similarly for the external serdess pll
+	 * lock signal.
+	 */
+	val &=
+	    ~(INFINIPATH_HWE_EXTSERDESPLLFAILED |
+	      INFINIPATH_HWE_RXDSYNCMEMPARITYERR);
+
+	/*
+	 * Disable MISCERR4 because of an inversion in the HT core
+	 * logic checking for errors that cause this bit to be set.
+	 * The errata can also cause the protocol error bit to be set
+	 * in the HT config space linkerror register(s).
+	 */
+	val &= ~INFINIPATH_HWE_HTCMISCERR4;
+
+	/*
+	 * PLL ignored because MDIO interface has a logic problem for reads,
+	 * on Comstock and Ponderosa.  BRINGUP
+	 */
+	if (devdata[t].ipath_boardrev == 4 || devdata[t].ipath_boardrev == 9)
+		val &= ~INFINIPATH_HWE_EXTSERDESPLLFAILED;	/* BRINGUP */
+	devdata[t].ipath_hwerrmask = val;
+}
+
+/* bring up the serdes */
+int ipath_bringup_serdes(ipath_type t)
+{
+	uint64_t val, config1;
+	int ret = 0, change = 0;
+
+	_IPATH_DBG("Trying to bringup serdes\n");
+
+	if (ipath_kget_kreg64(t, kr_hwerrstatus) &
+	    INFINIPATH_HWE_SERDESPLLFAILED) {
+		_IPATH_DBG
+		    ("At start, serdes PLL failed bit set in hwerrstatus, clearing and continuing\n");
+		ipath_kput_kreg(t, kr_hwerrclear,
+				INFINIPATH_HWE_SERDESPLLFAILED);
+	}
+
+	val = ipath_kget_kreg64(t, kr_serdesconfig0);
+	config1 = ipath_kget_kreg64(t, kr_serdesconfig1);
+
+	_IPATH_VDBG
+	    ("Initial serdes status is config0=%llx config1=%llx, sstatus=%llx xgxs %llx\n",
+	     val, config1, ipath_kget_kreg64(t, kr_serdesstatus),
+	     ipath_kget_kreg64(t, kr_xgxsconfig));
+
+	/* force reset on */
+	val |=
+	    INFINIPATH_SERDC0_RESET_PLL /* | INFINIPATH_SERDC0_RESET_MASK */ ;
+	ipath_kput_kreg(t, kr_serdesconfig0, val);
+	udelay(15);		/* need pll reset set at least for a bit */
+
+	if (val & INFINIPATH_SERDC0_RESET_PLL) {
+		uint64_t val2 = val &= ~INFINIPATH_SERDC0_RESET_PLL;
+		/* set lane resets, and tx idle, during pll reset */
+		val2 |= INFINIPATH_SERDC0_RESET_MASK | INFINIPATH_SERDC0_TXIDLE;
+		_IPATH_VDBG("Clearing serdes PLL reset (writing %llx)\n", val2);
+		ipath_kput_kreg(t, kr_serdesconfig0, val2);
+		/* be sure chip saw it */
+		val = ipath_kget_kreg64(t, kr_scratch);
+		/*
+		 * need pll reset clear at least 11 usec before lane resets
+		 * cleared; give it a few more
+		 */
+		udelay(15);
+		val = val2;	/* for check below */
+	}
+
+	if (val & (INFINIPATH_SERDC0_RESET_PLL | INFINIPATH_SERDC0_RESET_MASK
+		   | INFINIPATH_SERDC0_TXIDLE)) {
+		val &=
+		    ~(INFINIPATH_SERDC0_RESET_PLL | INFINIPATH_SERDC0_RESET_MASK
+		      | INFINIPATH_SERDC0_TXIDLE);
+		ipath_kput_kreg(t, kr_serdesconfig0, val);	/* clear them */
+	}
+
+	val = ipath_kget_kreg64(t, kr_xgxsconfig);
+	if (((val >> INFINIPATH_XGXS_MDIOADDR_SHIFT) &
+	     INFINIPATH_XGXS_MDIOADDR_MASK) != 3) {
+		val &=
+		    ~(INFINIPATH_XGXS_MDIOADDR_MASK <<
+		      INFINIPATH_XGXS_MDIOADDR_SHIFT);
+		/* we use address 3 */
+		val |= 3ULL << INFINIPATH_XGXS_MDIOADDR_SHIFT;
+		change = 1;
+	}
+	if (val & INFINIPATH_XGXS_RESET) {	/* normally true after boot */
+		val &= ~INFINIPATH_XGXS_RESET;
+		change = 1;
+	}
+	if (change)
+		ipath_kput_kreg(t, kr_xgxsconfig, val);
+
+	val = ipath_kget_kreg64(t, kr_serdesconfig0);
+
+	config1 &= ~0x0ffffffff00ULL;	/* clear current and de-emphasis bits */
+	config1 |= 0x00000000000ULL;	/* set current to 20ma */
+	config1 |= 0x0cccc000000ULL;	/* set de-emphasis to -5.68dB */
+	ipath_kput_kreg(t, kr_serdesconfig1, config1);
+
+	_IPATH_VDBG
+	    ("After setup: serdes status is config0=%llx config1=%llx, sstatus=%llx xgxs %llx\n",
+	     val, config1, ipath_kget_kreg64(t, kr_serdesstatus),
+	     ipath_kget_kreg64(t, kr_xgxsconfig));
+
+	if ((!ipath_waitfor_mdio_cmdready(t))) {
+		ipath_kput_kreg(t, kr_mdio, IPATH_MDIO_REQ(IPATH_MDIO_CMD_READ,
+							   31,
+							   IPATH_MDIO_CTRL_XGXS_REG_8,
+							   0));
+		if (ipath_waitfor_complete
+		    (t, kr_mdio, IPATH_MDIO_DATAVALID, &val))
+			_IPATH_DBG
+			    ("Never got MDIO data for XGXS status read\n");
+		else
+			_IPATH_VDBG("MDIO Read reg8, 'bank' 31 %x\n",
+				    (uint32_t) val);
+	} else
+		_IPATH_DBG("Never got MDIO cmdready for XGXS status read\n");
+
+	return ret;		/* for now, say we always succeeded */
+}
+
+/* set serdes to txidle; driver is being unloaded */
+void ipath_quiet_serdes(const ipath_type t)
+{
+	uint64_t val = ipath_kget_kreg64(t, kr_serdesconfig0);
+
+	val |= INFINIPATH_SERDC0_TXIDLE;
+	_IPATH_DBG("Setting TxIdleEn on serdes (config0 = %llx)\n", val);
+	ipath_kput_kreg(t, kr_serdesconfig0, val);
+}
+
+EXPORT_SYMBOL(ipath_get_unit_name);
+
diff -r e8af3873b0d9 -r 5e9b0b7876e2 drivers/infiniband/hw/ipath/ipath_i2c.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_i2c.c	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,473 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/*
+ * InfiniPath I2C Driver for a serial flash.  Not a generic i2c
+ * interface.  Requires software bitbanging, with readbacks from chip
+ * to ensure timing (simple udelay is not enough).   Specialized enough
+ * that using the standard kernel i2c bitbanging interface appears as
+ * though it would make the code longer and harder to maintain, rather
+ * than simpler.
+ * Intended to work with parts similar to Atmel AT24C01 (a 1Kbit part,
+ * that uses no programmable address bits, with address 1010000b).
+ */
+
+typedef enum i2c_line_type_e {
+	i2c_line_scl = 0,
+	i2c_line_sda
+} ipath_i2c_type;
+
+typedef enum i2c_line_state_e {
+	i2c_line_low = 0,
+	i2c_line_high
+} ipath_i2c_state;
+
+#define READ_CMD 1
+#define WRITE_CMD 0
+
+static int ipath_eeprom_init;
+
+/*
+ * The gpioval manipulation really should be protected by spinlocks
+ * or be converted to use atomic operations (unfortunately, atomic.h
+ * doesn't cover 64 bit ops for some of them).
+ */
+
+int i2c_gpio_set(ipath_type dev, ipath_i2c_type line,
+		 ipath_i2c_state new_line_state);
+int i2c_gpio_get(ipath_type dev, ipath_i2c_type line,
+		 ipath_i2c_state * curr_statep);
+
+/*
+ * returns 0 if the line was set to the new state successfully, non-zero
+ * on error.
+ */
+int i2c_gpio_set(ipath_type dev, ipath_i2c_type line,
+		 ipath_i2c_state new_line_state)
+{
+	uint64_t read_val, write_val, mask, *gpioval;
+
+	gpioval = &devdata[dev].ipath_gpio_out;
+	read_val = ipath_kget_kreg64(dev, kr_extctrl);
+	if (line == i2c_line_scl)
+		mask = ipath_gpio_scl;
+	else
+		mask = ipath_gpio_sda;
+
+	if (new_line_state == i2c_line_high)
+		/* tri-state the output rather than force high */
+		write_val = read_val & ~mask;
+	else
+		/* config line to be an output */
+		write_val = read_val | mask;
+	ipath_kput_kreg(dev, kr_extctrl, write_val);
+
+	/* set high and verify */
+	if (new_line_state == i2c_line_high)
+		write_val = 0x1UL;
+	else
+		write_val = 0x0UL;
+
+	if (line == i2c_line_scl) {
+		write_val <<= ipath_gpio_scl_num;
+		*gpioval = *gpioval & ~(1UL << ipath_gpio_scl_num);
+		*gpioval |= write_val;
+	} else {
+		write_val <<= ipath_gpio_sda_num;
+		*gpioval = *gpioval & ~(1UL << ipath_gpio_sda_num);
+		*gpioval |= write_val;
+	}
+	ipath_kput_kreg(dev, kr_gpio_out, *gpioval);
+
+	return 0;
+}
+
+/*
+ * returns 0 if the line was set to the new state successfully, non-zero
+ * on error.  curr_state is not set on error.
+ */
+int i2c_gpio_get(ipath_type dev, ipath_i2c_type line,
+		 ipath_i2c_state * curr_statep)
+{
+	uint64_t read_val, write_val, mask;
+
+	/* check args */
+	if (curr_statep == NULL)
+		return 1;
+
+	read_val = ipath_kget_kreg64(dev, kr_extctrl);
+	/* config line to be an input */
+	if (line == i2c_line_scl)
+		mask = ipath_gpio_scl;
+	else
+		mask = ipath_gpio_sda;
+	write_val = read_val & ~mask;
+	ipath_kput_kreg(dev, kr_extctrl, write_val);
+	read_val = ipath_kget_kreg64(dev, kr_extstatus);
+
+	if (read_val & mask)
+		*curr_statep = i2c_line_high;
+	else
+		*curr_statep = i2c_line_low;
+
+	return 0;
+}
+
+/*
+ * would prefer to not inline this, to avoid code bloat, and simplify debugging
+ * But when compiling against 2.6.10 kernel tree, it gets an error, so
+ * not for now.
+ */
+static void ipath_i2c_delay(ipath_type, int);
+
+/*
+ * we use this instead of udelay directly, so we can make sure
+ * that previous register writes have been flushed all the way
+ * to the chip.  Since we are delaying anyway, the cost doesn't
+ * hurt, and makes the bit twiddling more regular
+ * If delay is negative, we'll do the chip read, to be sure write made it
+ * to our chip, but won't do udelay()
+ */
+static void ipath_i2c_delay(ipath_type dev, int dtime)
+{
+	/*
+	 * This needs to be volatile, so that the compiler doesn't
+	 * optimize away the read to the device's mapped memory.
+	 */
+	volatile uint32_t read_val;
+	if (!dtime)
+		return;
+	read_val = ipath_kget_kreg32(dev, kr_scratch);
+	if (--dtime > 0)	/* register read takes about .5 usec, itself */
+		udelay(dtime);
+}
+
+static void ipath_scl_out(ipath_type dev, uint8_t bit, int delay)
+{
+	i2c_gpio_set(dev, i2c_line_scl, bit ? i2c_line_high : i2c_line_low);
+
+	ipath_i2c_delay(dev, delay);
+}
+
+static void ipath_sda_out(ipath_type dev, uint8_t bit, int delay)
+{
+	i2c_gpio_set(dev, i2c_line_sda, bit ? i2c_line_high : i2c_line_low);
+
+	ipath_i2c_delay(dev, delay);
+}
+
+static uint8_t ipath_sda_in(ipath_type dev, int delay)
+{
+	ipath_i2c_state bit;
+
+	if (i2c_gpio_get(dev, i2c_line_sda, &bit))
+		_IPATH_DBG("get bit failed!\n");
+
+	ipath_i2c_delay(dev, delay);
+
+	return bit == i2c_line_high ? 1U : 0;
+}
+
+/* see if ack following write is true */
+static int ipath_i2c_ackrcv(ipath_type dev)
+{
+	uint8_t ack_received;
+
+	/* AT ENTRY SCL = LOW */
+	/* change direction, ignore data */
+	ack_received = ipath_sda_in(dev, 1);
+	ipath_scl_out(dev, i2c_line_high, 1);
+	ack_received = ipath_sda_in(dev, 1) == 0;
+	ipath_scl_out(dev, i2c_line_low, 1);
+	return ack_received;
+}
+
+/*
+ * write a byte, one bit at a time.  Returns 0 if we got the following
+ * ack, otherwise 1
+ */
+static int ipath_wr_byte(ipath_type dev, uint8_t data)
+{
+	int bit_cntr;
+	uint8_t bit;
+
+	for (bit_cntr = 7; bit_cntr >= 0; bit_cntr--) {
+		bit = (data >> bit_cntr) & 1;
+		ipath_sda_out(dev, bit, 1);
+		ipath_scl_out(dev, i2c_line_high, 1);
+		ipath_scl_out(dev, i2c_line_low, 1);
+	}
+	if (!ipath_i2c_ackrcv(dev))
+		return 1;
+	return 0;
+}
+
+static void send_ack(ipath_type dev)
+{
+	ipath_sda_out(dev, i2c_line_low, 1);
+	ipath_scl_out(dev, i2c_line_high, 1);
+	ipath_scl_out(dev, i2c_line_low, 1);
+	ipath_sda_out(dev, i2c_line_high, 1);
+}
+
+/*
+ *      ipath_i2c_startcmd - Transmit the start condition, followed by
+ *      address/cmd
+ *      (both clock/data high, clock high, data low while clock is high)
+ */
+static int ipath_i2c_startcmd(ipath_type dev, uint8_t offset_dir)
+{
+	int res;
+
+	/* issue start sequence */
+	ipath_sda_out(dev, i2c_line_high, 1);
+	ipath_scl_out(dev, i2c_line_high, 1);
+	ipath_sda_out(dev, i2c_line_low, 1);
+	ipath_scl_out(dev, i2c_line_low, 1);
+
+	/* issue length and direction byte */
+	res = ipath_wr_byte(dev, offset_dir);
+
+	if (res)
+		_IPATH_VDBG("No ack to complete start\n");
+	return res;
+}
+
+/*
+ *      stop_cmd - Transmit the stop condition
+ *      (both clock/data low, clock high, data high while clock is high)
+ */
+static void stop_cmd(ipath_type dev)
+{
+	ipath_scl_out(dev, i2c_line_low, 1);
+	ipath_sda_out(dev, i2c_line_low, 1);
+	ipath_scl_out(dev, i2c_line_high, 1);
+	ipath_sda_out(dev, i2c_line_high, 3);
+}
+
+/*
+ *  ipath_eeprom_reset - reset I2C communication.
+ *
+ *  eeprom: Atmel AT24C01
+ *
+ */
+
+static int ipath_eeprom_reset(ipath_type dev)
+{
+	int clock_cycles_left = 9;
+	uint64_t *gpioval = &devdata[dev].ipath_gpio_out;
+
+	ipath_eeprom_init = 1;
+	*gpioval = ipath_kget_kreg64(dev, kr_gpio_out);
+	_IPATH_VDBG("Resetting i2c flash; initial gpioout reg is %llx\n",
+		    *gpioval);
+
+	/*
+	 * This is to get the i2c into a known state, by first going low,
+	 * then tristate sda (and then tristate scl as first thing in loop)
+	 */
+	ipath_scl_out(dev, i2c_line_low, 1);
+	ipath_sda_out(dev, i2c_line_high, 1);
+
+	while (clock_cycles_left--) {
+		ipath_scl_out(dev, i2c_line_high, 1);
+
+		if (ipath_sda_in(dev, 0)) {
+			ipath_sda_out(dev, i2c_line_low, 1);
+			ipath_scl_out(dev, i2c_line_low, 1);
+			return 0;
+		}
+
+		ipath_scl_out(dev, i2c_line_low, 1);
+	}
+
+	return 1;
+}
+
+/*
+ *      ipath_eeprom_read - Receives x # byte from the eeprom via I2C.
+ *
+ *  eeprom: Atmel AT24C01
+ *
+ */
+
+int ipath_eeprom_read(ipath_type dev, uint8_t eeprom_offset, void *buffer,
+		      int len)
+{
+	/* compiler complains unless initialized */
+	uint8_t single_byte = 0;
+	int bit_cntr;
+
+	if (!ipath_eeprom_init)
+		ipath_eeprom_reset(dev);
+
+	eeprom_offset = (eeprom_offset << 1) | READ_CMD;
+
+	if (ipath_i2c_startcmd(dev, eeprom_offset)) {
+		_IPATH_DBG("Failed startcmd\n");
+		stop_cmd(dev);
+		return 1;
+	}
+
+	/*
+	 * flash keeps clocking data out as long as we ack, automatically
+	 * incrementing the address.
+	 */
+	while (len-- > 0) {
+		/* get data */
+		single_byte = 0;
+		for (bit_cntr = 8; bit_cntr; bit_cntr--) {
+			uint8_t bit;
+			ipath_scl_out(dev, i2c_line_high, 1);
+			bit = ipath_sda_in(dev, 0);
+			single_byte |= bit << (bit_cntr - 1);
+			ipath_scl_out(dev, i2c_line_low, 1);
+		}
+
+		/* send ack if not the last byte */
+		if (len)
+			send_ack(dev);
+
+		*((uint8_t *) buffer) = single_byte;
+		(uint8_t *) buffer++;
+	}
+
+	stop_cmd(dev);
+
+	return 0;
+}
+
+/*
+ *  ipath_eeprom_write - writes data to the eeprom via I2C.
+ *
+*/
+int ipath_eeprom_write(ipath_type dev, uint8_t eeprom_offset, void *buffer,
+		       int len)
+{
+	uint8_t single_byte;
+	int sub_len;
+	uint8_t *bp = buffer;
+	int max_wait_time, i;
+
+	if (!ipath_eeprom_init)
+		ipath_eeprom_reset(dev);
+
+	while (len > 0) {
+		if (ipath_i2c_startcmd(dev, (eeprom_offset << 1) | WRITE_CMD)) {
+			_IPATH_DBG("Failed to start cmd offset %u\n",
+				   eeprom_offset);
+			goto failed_write;
+		}
+
+		sub_len = min(len, 4);
+		eeprom_offset += sub_len;
+		len -= sub_len;
+
+		for (i = 0; i < sub_len; i++) {
+			if (ipath_wr_byte(dev, *bp++)) {
+				_IPATH_DBG
+				    ("no ack after byte %u/%u (%u total remain)\n",
+				     i, sub_len, len + sub_len - i);
+				goto failed_write;
+			}
+		}
+
+		stop_cmd(dev);
+
+		/*
+		 * wait for write complete by waiting for a successful
+		 * read (the chip replies with a zero after the write
+		 * cmd completes, and before it writes to the flash.
+		 * The startcmd for the read will fail the ack until
+		 * the writes have completed.   We do this inline to avoid
+		 * the debug prints that are in the real read routine
+		 * if the startcmd fails.
+		 */
+		max_wait_time = 100;
+		while (ipath_i2c_startcmd(dev, READ_CMD)) {
+			stop_cmd(dev);
+			if (!--max_wait_time) {
+				_IPATH_DBG
+				    ("Did not get successful read to complete write\n");
+				goto failed_write;
+			}
+		}
+		/* now read the zero byte */
+		for (i = single_byte = 0; i < 8; i++) {
+			uint8_t bit;
+			ipath_scl_out(dev, i2c_line_high, 1);
+			bit = ipath_sda_in(dev, 0);
+			ipath_scl_out(dev, i2c_line_low, 1);
+			single_byte <<= 1;
+			single_byte |= bit;
+		}
+		stop_cmd(dev);
+	}
+
+	return 0;
+
+failed_write:
+	stop_cmd(dev);
+	return 1;
+}
+
+uint8_t ipath_flash_csum(struct ipath_flash * ifp, int adjust)
+{
+	uint8_t *ip = (uint8_t *) ifp;
+	uint8_t csum = 0, len;
+
+	for (len = 0; len < ifp->if_length; len++)
+		csum += *ip++;
+	csum -= ifp->if_csum;
+	csum = ~csum;
+	if (adjust)
+		ifp->if_csum = csum;
+	return csum;
+}
diff -r e8af3873b0d9 -r 5e9b0b7876e2 drivers/infiniband/hw/ipath/ipath_lib.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_lib.c	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,90 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+/*
+ * This is library code for the driver, similar to what's in libinfinipath for
+ * usermode code.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include "ipath_kernel.h"
+
+unsigned infinipath_debug = __IPATH_INFO;
+
+uint32_t _ipath_pico_per_cycle;	/* always present, for now */
+
+/*
+ * This isn't perfect, but it's close enough for timing work. We want this
+ * to work on systems where the cycle counter isn't the same as the clock
+ * frequency.  The one msec spin is OK, since we execute this only once
+ * when first loaded.  We don't use CURRENT_TIME because on some systems
+ * it only has jiffy resolution; we just assume udelay is well calibrated
+ * and that we aren't likely to be rescheduled.  Do it multiple times,
+ * with a yield in between, to try to make sure we get the "true minimum"
+ * value.
+ * _ipath_pico_per_cycle isn't going to lead to completely accurate
+ * conversions from timestamps to nanoseconds, but it's close enough
+ * for our purposes, which is mainly to allow people to show events with
+ * nsecs or usecs if desired, rather than cycles.
+ */
+void ipath_init_picotime(void)
+{
+	int i;
+	u_int64_t ts, te, delta = -1ULL;
+
+	for (i = 0; i < 5; i++) {
+		ts = get_cycles();
+		udelay(250);
+		te = get_cycles();
+		if ((te - ts) < delta)
+			delta = te - ts;
+		yield();
+	}
+	_ipath_pico_per_cycle = 250000000 / delta;
+}
diff -r e8af3873b0d9 -r 5e9b0b7876e2 drivers/infiniband/hw/ipath/ipath_upages.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_upages.c	Wed Dec 28 14:19:43 2005 -0800
@@ -0,0 +1,144 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#include <stddef.h>
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+
+#include <asm/page.h>
+#include <asm/io.h>
+
+#include "ipath_kernel.h"
+
+/*
+ * Our version of the kernel mlock function.  This function is no longer
+ * exposed, so we need to do it ourselves.  It takes a given start page
+ * (page aligned user virtual address) and pins it and the following specified
+ * number of pages.
+ * For now, num_pages is always 1, but that will probably change at some
+ * point (because caller is doing expected sends on a single virtually
+ * contiguous buffer, so we can do all pages at once).
+ */
+int ipath_get_upages(unsigned long start_page, size_t num_pages, struct page **p)
+{
+	int n;
+
+	_IPATH_VDBG("pin %lx pages from vaddr %lx\n", num_pages, start_page);
+	down_read(&current->mm->mmap_sem);
+	n = get_user_pages(current, current->mm, start_page, num_pages, 1, 1,
+			   p, NULL);
+	up_read(&current->mm->mmap_sem);
+	if (n != num_pages) {
+		_IPATH_INFO
+		    ("get_user_pages (0x%lx pages starting at 0x%lx failed with %d\n",
+		     num_pages, start_page, n);
+		if (n < 0)	/* it's an errno */
+			return n;
+		/*
+		 * We may have gotten some pages, so unlock those.
+		 * ipath_putpages() correctly handles n==0
+		 */
+		ipath_putpages(n, p);
+		return -ENOMEM;	/* no way to know actual error */
+	}
+
+	return 0;
+}
+
+/*
+ * this is similar to ipath_get_upages, but it's always one page, and we mark
+ * the page as locked for i/o, and shared.  This is used for the user process
+ * page that contains the destination address for the rcvhdrq tail update,
+ * so we need to have the vma.  If we don't do this, the page can be taken
+ * away from us on fork, even if the child never touches it, and then
+ * the user process never sees the tail register updates.
+ */
+int ipath_get_upages_nocopy(unsigned long start_page, struct page **p)
+{
+	int n;
+	struct vm_area_struct *vm = NULL;
+
+	down_read(&current->mm->mmap_sem);
+	n = get_user_pages(current, current->mm, start_page, 1, 1, 1, p, &vm);
+	up_read(&current->mm->mmap_sem);
+	if (n != 1) {
+		_IPATH_INFO("get_user_pages for 0x%lx failed with %d\n",
+			    start_page, n);
+		if (n < 0)	/* it's an errno */
+			return n;
+		/*
+		 * If we ever ask for more than a single page, we will have to
+		 * free the pages (if any) that we did get, via ipath_get_upages()
+		 * or put_page() directly.
+		 */
+		return -ENOMEM;	/* no way to know actual error */
+	}
+	vm->vm_flags |= VM_SHM | VM_LOCKED;
+
+	return 0;
+}
+
+/*
+ * Unpins the start page (a page aligned full user virtual address, not a
+ * page number) and pins it and the following specified number of pages.
+ */
+void ipath_putpages(size_t num_pages, struct page **p)
+{
+	int i;
+
+	for (i = 0; i < num_pages; i++) {
+		_IPATH_MMDBG("%u/%lu put_page %p\n", i, num_pages, p[i]);
+		set_page_dirty_lock(p[i]);
+		put_page(p[i]);
+	}
+}
+
+/*
+ * This routine frees up all the allocations made in this file; it's a nop
+ * now, but I'm leaving it in case we go back to a more sophisticated
+ * implementation later.
+ */
+void ipath_upages_cleanup(struct ipath_portdata * pd)
+{
+}
