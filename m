Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVFAU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFAU26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFAU2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:28:44 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:32421 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261183AbVFAUJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:09:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=0948p8eHRF8mn5gba0CnG7HAJzp+u87iq9VwujV8ipBm6+HTO0fo0Q+1JOdDgCHhFjnkOKh2vqn5UeWSDXVu4lh12qsEw0ZYQZmBdfaeI5C9korbBkZMOf2KmDK8FEXlzQtXstKXOm9oMeDB4ewmUiBTJkHAVBmErGl7aXuU0Vg=  ;
Message-ID: <429E1606.9090908@yahoo.com>
Date: Wed, 01 Jun 2005 13:09:42 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@lst.de>
Subject: [ANNOUNCE 3/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator:
 common-iscsi-headers.patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	common-iscsi-headers.patch - common header files:
	- iscsi_if.h (user/kernel #defines and user/kernel events);
	- iscsi_proto.h (RFC3720 #defines and types);
	- scsi_transport_iscsi.h (transport API, transport #defines and types).

	Signed-off-by: Alex Aizman <itn780@yahoo.com>
	Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>
	Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

Index: include/scsi/iscsi_if.h
===================================================================
--- /dev/null  (tree:7570fde464d579ce455c865f07a613e967e9396c)
+++ uncommitted/include/scsi/iscsi_if.h  (mode:100644 sha1:be1bc792ab181f83c95536505e87468c7604777a)
@@ -0,0 +1,245 @@
+/*
+ * iSCSI User/Kernel Shares (Defines, Constants, Protocol definitions, etc)
+ *
+ * Copyright (C) 2005 Dmitry Yusupov
+ * Copyright (C) 2005 Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_IF_H
+#define ISCSI_IF_H
+
+#include <scsi/iscsi_proto.h>
+
+#define UEVENT_BASE			10
+#define KEVENT_BASE			100
+#define ISCSI_ERR_BASE			1000
+
+enum iscsi_uevent_e {
+	ISCSI_UEVENT_UNKNOWN		= 0,
+
+	/* down events */
+	ISCSI_UEVENT_CREATE_SESSION	= UEVENT_BASE + 1,
+	ISCSI_UEVENT_DESTROY_SESSION	= UEVENT_BASE + 2,
+	ISCSI_UEVENT_CREATE_CONN	= UEVENT_BASE + 3,
+	ISCSI_UEVENT_DESTROY_CONN	= UEVENT_BASE + 4,
+	ISCSI_UEVENT_BIND_CONN		= UEVENT_BASE + 5,
+	ISCSI_UEVENT_SET_PARAM		= UEVENT_BASE + 6,
+	ISCSI_UEVENT_START_CONN		= UEVENT_BASE + 7,
+	ISCSI_UEVENT_STOP_CONN		= UEVENT_BASE + 8,
+	ISCSI_UEVENT_SEND_PDU		= UEVENT_BASE + 9,
+	ISCSI_UEVENT_GET_STATS		= UEVENT_BASE + 10,
+	ISCSI_UEVENT_GET_PARAM		= UEVENT_BASE + 11,
+
+	/* up events */
+	ISCSI_KEVENT_RECV_PDU		= KEVENT_BASE + 1,
+	ISCSI_KEVENT_CONN_ERROR		= KEVENT_BASE + 2,
+	ISCSI_KEVENT_IF_ERROR		= KEVENT_BASE + 3,
+};
+
+struct iscsi_uevent {
+	uint32_t type; /* k/u events type */
+	uint32_t iferror; /* carries interface or resource errors */
+	uint64_t transport_handle;
+
+	union {
+		/* messages u -> k */
+		struct msg_create_session {
+			uint32_t	initial_cmdsn;
+		} c_session;
+		struct msg_destroy_session {
+			uint64_t	session_handle;
+			uint32_t	sid;
+		} d_session;
+		struct msg_create_conn {
+			uint64_t	session_handle;
+			uint32_t	cid;
+			uint32_t	sid;
+		} c_conn;
+		struct msg_bind_conn {
+			uint64_t	session_handle;
+			uint64_t	conn_handle;
+			uint32_t	transport_fd;
+			uint32_t	is_leading;
+		} b_conn;
+		struct msg_destroy_conn {
+			uint64_t	conn_handle;
+			uint32_t	cid;
+		} d_conn;
+		struct msg_send_pdu {
+			uint32_t	hdr_size;
+			uint32_t	data_size;
+			uint64_t	conn_handle;
+		} send_pdu;
+		struct msg_set_param {
+			uint64_t	conn_handle;
+			uint32_t	param; /* enum iscsi_param */
+			uint32_t	value;
+		} set_param;
+		struct msg_start_conn {
+			uint64_t	conn_handle;
+		} start_conn;
+		struct msg_stop_conn {
+			uint64_t	conn_handle;
+			uint32_t	flag;
+		} stop_conn;
+		struct msg_get_stats {
+			uint64_t	conn_handle;
+		} get_stats;
+	} u;
+	union {
+		/* messages k -> u */
+		uint64_t		handle;
+		int			retcode;
+		struct msg_create_session_ret {
+			uint64_t	session_handle;
+			uint32_t	sid;
+		} c_session_ret;
+		struct msg_recv_req {
+			uint64_t	recv_handle;
+			uint64_t	conn_handle;
+		} recv_req;
+		struct msg_conn_error {
+			uint64_t	conn_handle;
+			uint32_t	error; /* enum iscsi_err */
+		} connerror;
+	} r;
+} __attribute__ ((aligned (sizeof(uint64_t))));
+
+/*
+ * Common error codes
+ */
+enum iscsi_err {
+	ISCSI_OK			= 0,
+
+	ISCSI_ERR_DATASN		= ISCSI_ERR_BASE + 1,
+	ISCSI_ERR_DATA_OFFSET		= ISCSI_ERR_BASE + 2,
+	ISCSI_ERR_MAX_CMDSN		= ISCSI_ERR_BASE + 3,
+	ISCSI_ERR_EXP_CMDSN		= ISCSI_ERR_BASE + 4,
+	ISCSI_ERR_BAD_OPCODE		= ISCSI_ERR_BASE + 5,
+	ISCSI_ERR_DATALEN		= ISCSI_ERR_BASE + 6,
+	ISCSI_ERR_AHSLEN		= ISCSI_ERR_BASE + 7,
+	ISCSI_ERR_PROTO			= ISCSI_ERR_BASE + 8,
+	ISCSI_ERR_LUN			= ISCSI_ERR_BASE + 9,
+	ISCSI_ERR_BAD_ITT		= ISCSI_ERR_BASE + 10,
+	ISCSI_ERR_CONN_FAILED		= ISCSI_ERR_BASE + 11,
+	ISCSI_ERR_R2TSN			= ISCSI_ERR_BASE + 12,
+	ISCSI_ERR_SESSION_FAILED	= ISCSI_ERR_BASE + 13,
+	ISCSI_ERR_HDR_DGST		= ISCSI_ERR_BASE + 14,
+	ISCSI_ERR_DATA_DGST		= ISCSI_ERR_BASE + 15,
+	ISCSI_ERR_PARAM_NOT_FOUND	= ISCSI_ERR_BASE + 16
+};
+
+/*
+ * iSCSI Parameters (RFC3720)
+ */
+enum iscsi_param {
+	ISCSI_PARAM_MAX_RECV_DLENGTH	= 0,
+	ISCSI_PARAM_MAX_XMIT_DLENGTH	= 1,
+	ISCSI_PARAM_HDRDGST_EN		= 2,
+	ISCSI_PARAM_DATADGST_EN		= 3,
+	ISCSI_PARAM_INITIAL_R2T_EN	= 4,
+	ISCSI_PARAM_MAX_R2T		= 5,
+	ISCSI_PARAM_IMM_DATA_EN		= 6,
+	ISCSI_PARAM_FIRST_BURST		= 7,
+	ISCSI_PARAM_MAX_BURST		= 8,
+	ISCSI_PARAM_PDU_INORDER_EN	= 9,
+	ISCSI_PARAM_DATASEQ_INORDER_EN	= 10,
+	ISCSI_PARAM_ERL			= 11,
+	ISCSI_PARAM_IFMARKER_EN		= 12,
+	ISCSI_PARAM_OFMARKER_EN		= 13,
+};
+#define ISCSI_PARAM_MAX			14
+
+typedef uint64_t iscsi_sessionh_t;	/* iSCSI Data-Path session handle */
+typedef uint64_t iscsi_connh_t;		/* iSCSI Data-Path connection handle */
+
+#define iscsi_ptr(_handle) ((void*)(unsigned long)_handle)
+#define iscsi_handle(_ptr) ((uint64_t)(unsigned long)_ptr)
+#define iscsi_hostdata(_hostdata) ((void*)_hostdata + sizeof(unsigned long))
+
+/*
+ * These flags presents iSCSI Data-Path capabilities.
+ */
+#define CAP_RECOVERY_L0		0x1
+#define CAP_RECOVERY_L1		0x2
+#define CAP_RECOVERY_L2		0x4
+#define CAP_MULTI_R2T		0x8
+#define CAP_HDRDGST		0x10
+#define CAP_DATADGST		0x20
+#define CAP_MULTI_CONN		0x40
+#define CAP_TEXT_NEGO		0x80
+#define CAP_MARKERS		0x100
+
+/*
+ * These flags describes reason of stop_conn() call
+ */
+#define STOP_CONN_TERM		0x1
+#define STOP_CONN_SUSPEND	0x2
+#define STOP_CONN_RECOVER	0x3
+
+#define ISCSI_STATS_CUSTOM_MAX		32
+#define ISCSI_STATS_CUSTOM_DESC_MAX	64
+struct iscsi_stats_custom {
+	char desc[ISCSI_STATS_CUSTOM_DESC_MAX];
+	uint64_t value;
+};
+
+/*
+ * struct iscsi_stats - iSCSI Statistics (iSCSI MIB)
+ *
+ * Note: this structure contains counters collected on per-connection basis.
+ */
+struct iscsi_stats {
+	/* octets */
+	uint64_t txdata_octets;
+	uint64_t rxdata_octets;
+
+	/* xmit pdus */
+	uint32_t noptx_pdus;
+	uint32_t scsicmd_pdus;
+	uint32_t tmfcmd_pdus;
+	uint32_t login_pdus;
+	uint32_t text_pdus;
+	uint32_t dataout_pdus;
+	uint32_t logout_pdus;
+	uint32_t snack_pdus;
+
+	/* recv pdus */
+	uint32_t noprx_pdus;
+	uint32_t scsirsp_pdus;
+	uint32_t tmfrsp_pdus;
+	uint32_t textrsp_pdus;
+	uint32_t datain_pdus;
+	uint32_t logoutrsp_pdus;
+	uint32_t r2t_pdus;
+	uint32_t async_pdus;
+	uint32_t rjt_pdus;
+
+	/* errors */
+	uint32_t digest_err;
+	uint32_t timeout_err;
+
+	/*
+	 * iSCSI Custom Statistics support, i.e. Transport could
+	 * extend existing MIB statistics with its own specific statistics
+	 * up to ISCSI_STATS_CUSTOM_MAX
+	 */
+	uint32_t custom_length;
+	struct iscsi_stats_custom custom[0]
+		__attribute__ ((aligned (sizeof(uint64_t))));
+};
+
+#endif
Index: include/scsi/iscsi_proto.h
===================================================================
--- /dev/null  (tree:7570fde464d579ce455c865f07a613e967e9396c)
+++ uncommitted/include/scsi/iscsi_proto.h  (mode:100644 sha1:6c08551c79f5ef903e11a14a8b6def7070792a56)
@@ -0,0 +1,566 @@
+/*
+ * RFC 3720 (iSCSI) protocol data types
+ *
+ * Copyright (C) 2005 Dmitry Yusupov
+ * Copyright (C) 2005 Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_PROTO_H
+#define ISCSI_PROTO_H
+
+#define ISCSI_VERSION_STR	"0.3"
+#define ISCSI_DATE_STR		"22-Apr-2005"
+#define ISCSI_DRAFT20_VERSION	0x00
+
+/* default iSCSI listen port for incoming connections */
+#define ISCSI_LISTEN_PORT	3260
+
+/* Padding word length */
+#define PAD_WORD_LEN		4
+
+/*
+ * useful common(control and data pathes) macro
+ */
+#define ntoh24(p) (((p)[0] << 16) | ((p)[1] << 8) | ((p)[2]))
+#define hton24(p, v) { \
+        p[0] = (((v) >> 16) & 0xFF); \
+        p[1] = (((v) >> 8) & 0xFF); \
+        p[2] = ((v) & 0xFF); \
+}
+#define zero_data(p) {p[0]=0;p[1]=0;p[2]=0;}
+
+/*
+ * iSCSI Template Message Header
+ */
+struct iscsi_hdr {
+	uint8_t		opcode;
+	uint8_t		flags;		/* Final bit */
+	uint8_t		rsvd2[2];
+	uint8_t		hlength;	/* AHSs total length */
+	uint8_t		dlength[3];	/* Data length */
+	uint8_t		lun[8];
+	__be32		itt;		/* Initiator Task Tag */
+	__be32		ttt;		/* Target Task Tag */
+	__be32		statsn;
+	__be32		exp_statsn;
+	uint8_t		other[16];
+};
+
+/************************* RFC 3720 Begin *****************************/
+
+#define ISCSI_RESERVED_TAG		0xffffffff
+
+/* Opcode encoding bits */
+#define ISCSI_OP_RETRY			0x80
+#define ISCSI_OP_IMMEDIATE		0x40
+#define ISCSI_OPCODE_MASK		0x3F
+
+/* Initiator Opcode values */
+#define ISCSI_OP_NOOP_OUT		0x00
+#define ISCSI_OP_SCSI_CMD		0x01
+#define ISCSI_OP_SCSI_TMFUNC		0x02
+#define ISCSI_OP_LOGIN			0x03
+#define ISCSI_OP_TEXT			0x04
+#define ISCSI_OP_SCSI_DATA_OUT		0x05
+#define ISCSI_OP_LOGOUT			0x06
+#define ISCSI_OP_SNACK			0x10
+
+/* Target Opcode values */
+#define ISCSI_OP_NOOP_IN		0x20
+#define ISCSI_OP_SCSI_CMD_RSP		0x21
+#define ISCSI_OP_SCSI_TMFUNC_RSP	0x22
+#define ISCSI_OP_LOGIN_RSP		0x23
+#define ISCSI_OP_TEXT_RSP		0x24
+#define ISCSI_OP_SCSI_DATA_IN		0x25
+#define ISCSI_OP_LOGOUT_RSP		0x26
+#define ISCSI_OP_R2T			0x31
+#define ISCSI_OP_ASYNC_EVENT		0x32
+#define ISCSI_OP_REJECT			0x3f
+
+/* iSCSI PDU Header */
+struct iscsi_cmd {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2;
+	uint8_t cmdrn;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	__be32 itt;	/* Initiator Task Tag */
+	__be32 data_length;
+	__be32 cmdsn;
+	__be32 exp_statsn;
+	uint8_t cdb[16];	/* SCSI Command Block */
+	/* Additional Data (Command Dependent) */
+};
+
+/* Command PDU flags */
+#define ISCSI_FLAG_CMD_FINAL		0x80
+#define ISCSI_FLAG_CMD_READ		0x40
+#define ISCSI_FLAG_CMD_WRITE		0x20
+#define ISCSI_FLAG_CMD_ATTR_MASK	0x07	/* 3 bits */
+
+/* SCSI Command Attribute values */
+#define ISCSI_ATTR_UNTAGGED		0
+#define ISCSI_ATTR_SIMPLE		1
+#define ISCSI_ATTR_ORDERED		2
+#define ISCSI_ATTR_HEAD_OF_QUEUE	3
+#define ISCSI_ATTR_ACA			4
+
+/* SCSI Response Header */
+struct iscsi_cmd_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t response;
+	uint8_t cmd_status;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	rsvd1;
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	__be32	exp_datasn;
+	__be32	bi_residual_count;
+	__be32	residual_count;
+	/* Response or Sense Data (optional) */
+};
+
+/* Command Response PDU flags */
+#define ISCSI_FLAG_CMD_BIDI_OVERFLOW	0x10
+#define ISCSI_FLAG_CMD_BIDI_UNDERFLOW	0x08
+#define ISCSI_FLAG_CMD_OVERFLOW		0x04
+#define ISCSI_FLAG_CMD_UNDERFLOW	0x02
+
+/* iSCSI Status values. Valid if Rsp Selector bit is not set */
+#define ISCSI_STATUS_CMD_COMPLETED	0
+#define ISCSI_STATUS_TARGET_FAILURE	1
+#define ISCSI_STATUS_SUBSYS_FAILURE	2
+
+/* Asynchronous Event Header */
+struct iscsi_async {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	uint8_t rsvd4[8];
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	uint8_t async_event;
+	uint8_t async_vcode;
+	__be16	param1;
+	__be16	param2;
+	__be16	param3;
+	uint8_t rsvd5[4];
+};
+
+/* iSCSI Event Codes */
+#define ISCSI_ASYNC_MSG_SCSI_EVENT			0
+#define ISCSI_ASYNC_MSG_REQUEST_LOGOUT			1
+#define ISCSI_ASYNC_MSG_DROPPING_CONNECTION		2
+#define ISCSI_ASYNC_MSG_DROPPING_ALL_CONNECTIONS	3
+#define ISCSI_ASYNC_MSG_PARAM_NEGOTIATION		4
+#define ISCSI_ASYNC_MSG_VENDOR_SPECIFIC			255
+
+/* NOP-Out Message */
+struct iscsi_nopout {
+	uint8_t opcode;
+	uint8_t flags;
+	__be16	rsvd2;
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	ttt;	/* Target Transfer Tag */
+	__be32	cmdsn;
+	__be32	exp_statsn;
+	uint8_t rsvd4[16];
+};
+
+/* NOP-In Message */
+struct iscsi_nopin {
+	uint8_t opcode;
+	uint8_t flags;
+	__be16	rsvd2;
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	ttt;	/* Target Transfer Tag */
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	uint8_t rsvd4[12];
+};
+
+/* SCSI Task Management Message Header */
+struct iscsi_tm {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd1[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	rtt;	/* Reference Task Tag */
+	__be32	cmdsn;
+	__be32	exp_statsn;
+	__be32	refcmdsn;
+	__be32	exp_datasn;
+	uint8_t rsvd2[8];
+};
+
+#define ISCSI_FLAG_TASK_MGMT_FUNCTION_MASK	0x7F
+
+/* Function values */
+#define ISCSI_TM_FUNC_ABORT_TASK		1
+#define ISCSI_TM_FUNC_ABORT_TASK_SET		2
+#define ISCSI_TM_FUNC_CLEAR_ACA			3
+#define ISCSI_TM_FUNC_CLEAR_TASK_SET		4
+#define ISCSI_TM_FUNC_LOGICAL_UNIT_RESET	5
+#define ISCSI_TM_FUNC_TARGET_WARM_RESET		6
+#define ISCSI_TM_FUNC_TARGET_COLD_RESET		7
+#define ISCSI_TM_FUNC_TASK_REASSIGN		8
+
+/* SCSI Task Management Response Header */
+struct iscsi_tm_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t response;	/* see Response values below */
+	uint8_t qualifier;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd2[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	rtt;	/* Reference Task Tag */
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	uint8_t rsvd3[12];
+};
+
+/* Response values */
+#define SCSI_TCP_TM_RESP_COMPLETE	0x00
+#define SCSI_TCP_TM_RESP_NO_TASK	0x01
+#define SCSI_TCP_TM_RESP_NO_LUN		0x02
+#define SCSI_TCP_TM_RESP_TASK_ALLEGIANT	0x03
+#define SCSI_TCP_TM_RESP_NO_FAILOVER	0x04
+#define SCSI_TCP_TM_RESP_NOT_SUPPORTED	0x05
+#define SCSI_TCP_TM_RESP_AUTH_FAILED	0x06
+#define SCSI_TCP_TM_RESP_REJECTED	0xff
+
+/* Ready To Transfer Header */
+struct iscsi_r2t_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t	hlength;
+	uint8_t	dlength[3];
+	uint8_t lun[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	ttt;	/* Target Transfer Tag */
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	__be32	r2tsn;
+	__be32	data_offset;
+	__be32	data_length;
+};
+
+/* SCSI Data Hdr */
+struct iscsi_data {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	__be32	itt;
+	__be32	ttt;
+	__be32	rsvd4;
+	__be32	exp_statsn;
+	__be32	rsvd5;
+	__be32	datasn;
+	__be32	offset;
+	__be32	rsvd6;
+	/* Payload */
+};
+
+/* SCSI Data Response Hdr */
+struct iscsi_data_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2;
+	uint8_t cmd_status;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t lun[8];
+	__be32	itt;
+	__be32	ttt;
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	__be32	datasn;
+	__be32	offset;
+	__be32	residual_count;
+};
+
+/* Data Response PDU flags */
+#define ISCSI_FLAG_DATA_ACK		0x40
+#define ISCSI_FLAG_DATA_OVERFLOW	0x04
+#define ISCSI_FLAG_DATA_UNDERFLOW	0x02
+#define ISCSI_FLAG_DATA_STATUS		0x01
+
+/* Text Header */
+struct iscsi_text {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd4[8];
+	__be32	itt;
+	__be32	ttt;
+	__be32	cmdsn;
+	__be32	exp_statsn;
+	uint8_t rsvd5[16];
+	/* Text - key=value pairs */
+};
+
+#define ISCSI_FLAG_TEXT_CONTINUE	0x40
+
+/* Text Response Header */
+struct iscsi_text_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd4[8];
+	__be32	itt;
+	__be32	ttt;
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	uint8_t rsvd5[12];
+	/* Text Response - key:value pairs */
+};
+
+/* Login Header */
+struct iscsi_login {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t max_version;	/* Max. version supported */
+	uint8_t min_version;	/* Min. version supported */
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t isid[6];	/* Initiator Session ID */
+	__be16	tsih;	/* Target Session Handle */
+	__be32	itt;	/* Initiator Task Tag */
+	__be16	cid;
+	__be16	rsvd3;
+	__be32	cmdsn;
+	__be32	exp_statsn;
+	uint8_t rsvd5[16];
+};
+
+/* Login PDU flags */
+#define ISCSI_FLAG_LOGIN_TRANSIT		0x80
+#define ISCSI_FLAG_LOGIN_CONTINUE		0x40
+#define ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK	0x0C	/* 2 bits */
+#define ISCSI_FLAG_LOGIN_NEXT_STAGE_MASK	0x03	/* 2 bits */
+
+#define ISCSI_LOGIN_CURRENT_STAGE(flags) \
+	((flags & ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK) >> 2)
+#define ISCSI_LOGIN_NEXT_STAGE(flags) \
+	(flags & ISCSI_FLAG_LOGIN_NEXT_STAGE_MASK)
+
+/* Login Response Header */
+struct iscsi_login_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t max_version;	/* Max. version supported */
+	uint8_t active_version;	/* Active version */
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t isid[6];	/* Initiator Session ID */
+	__be16	tsih;	/* Target Session Handle */
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	rsvd3;
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	uint8_t status_class;	/* see Login RSP ststus classes below */
+	uint8_t status_detail;	/* see Login RSP Status details below */
+	uint8_t rsvd4[10];
+};
+
+/* Login stage (phase) codes for CSG, NSG */
+#define ISCSI_INITIAL_LOGIN_STAGE		-1
+#define ISCSI_SECURITY_NEGOTIATION_STAGE	0
+#define ISCSI_OP_PARMS_NEGOTIATION_STAGE	1
+#define ISCSI_FULL_FEATURE_PHASE		3
+
+/* Login Status response classes */
+#define ISCSI_STATUS_CLS_SUCCESS		0x00
+#define ISCSI_STATUS_CLS_REDIRECT		0x01
+#define ISCSI_STATUS_CLS_INITIATOR_ERR		0x02
+#define ISCSI_STATUS_CLS_TARGET_ERR		0x03
+
+/* Login Status response detail codes */
+/* Class-0 (Success) */
+#define ISCSI_LOGIN_STATUS_ACCEPT		0x00
+
+/* Class-1 (Redirection) */
+#define ISCSI_LOGIN_STATUS_TGT_MOVED_TEMP	0x01
+#define ISCSI_LOGIN_STATUS_TGT_MOVED_PERM	0x02
+
+/* Class-2 (Initiator Error) */
+#define ISCSI_LOGIN_STATUS_INIT_ERR		0x00
+#define ISCSI_LOGIN_STATUS_AUTH_FAILED		0x01
+#define ISCSI_LOGIN_STATUS_TGT_FORBIDDEN	0x02
+#define ISCSI_LOGIN_STATUS_TGT_NOT_FOUND	0x03
+#define ISCSI_LOGIN_STATUS_TGT_REMOVED		0x04
+#define ISCSI_LOGIN_STATUS_NO_VERSION		0x05
+#define ISCSI_LOGIN_STATUS_ISID_ERROR		0x06
+#define ISCSI_LOGIN_STATUS_MISSING_FIELDS	0x07
+#define ISCSI_LOGIN_STATUS_CONN_ADD_FAILED	0x08
+#define ISCSI_LOGIN_STATUS_NO_SESSION_TYPE	0x09
+#define ISCSI_LOGIN_STATUS_NO_SESSION		0x0a
+#define ISCSI_LOGIN_STATUS_INVALID_REQUEST	0x0b
+
+/* Class-3 (Target Error) */
+#define ISCSI_LOGIN_STATUS_TARGET_ERROR		0x00
+#define ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE	0x01
+#define ISCSI_LOGIN_STATUS_NO_RESOURCES		0x02
+
+/* Logout Header */
+struct iscsi_logout {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd1[2];
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd2[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be16	cid;
+	uint8_t rsvd3[2];
+	__be32	cmdsn;
+	__be32	exp_statsn;
+	uint8_t rsvd4[16];
+};
+
+/* Logout PDU flags */
+#define ISCSI_FLAG_LOGOUT_REASON_MASK	0x7F
+
+/* logout reason_code values */
+
+#define ISCSI_LOGOUT_REASON_CLOSE_SESSION	0
+#define ISCSI_LOGOUT_REASON_CLOSE_CONNECTION	1
+#define ISCSI_LOGOUT_REASON_RECOVERY		2
+#define ISCSI_LOGOUT_REASON_AEN_REQUEST		3
+
+/* Logout Response Header */
+struct iscsi_logout_rsp {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t response;	/* see Logout response values below */
+	uint8_t rsvd2;
+	uint8_t hlength;
+	uint8_t dlength[3];
+	uint8_t rsvd3[8];
+	__be32	itt;	/* Initiator Task Tag */
+	__be32	rsvd4;
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	__be32	rsvd5;
+	__be16	t2wait;
+	__be16	t2retain;
+	__be32	rsvd6;
+};
+
+/* logout response status values */
+
+#define ISCSI_LOGOUT_SUCCESS			0
+#define ISCSI_LOGOUT_CID_NOT_FOUND		1
+#define ISCSI_LOGOUT_RECOVERY_UNSUPPORTED	2
+#define ISCSI_LOGOUT_CLEANUP_FAILED		3
+
+/* SNACK Header */
+struct iscsi_snack {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t rsvd2[14];
+	__be32	itt;
+	__be32	begrun;
+	__be32	runlength;
+	__be32	exp_statsn;
+	__be32	rsvd3;
+	__be32	exp_datasn;
+	uint8_t rsvd6[8];
+};
+
+/* SNACK PDU flags */
+#define ISCSI_FLAG_SNACK_TYPE_MASK	0x0F	/* 4 bits */
+
+/* Reject Message Header */
+struct iscsi_reject {
+	uint8_t opcode;
+	uint8_t flags;
+	uint8_t reason;
+	uint8_t rsvd2;
+	uint8_t rsvd3;
+	uint8_t dlength[3];
+	uint8_t rsvd4[16];
+	__be32	statsn;
+	__be32	exp_cmdsn;
+	__be32	max_cmdsn;
+	__be32	datasn;
+	uint8_t rsvd5[8];
+	/* Text - Rejected hdr */
+};
+
+/* Reason for Reject */
+#define CMD_BEFORE_LOGIN	1
+#define DATA_DIGEST_ERROR	2
+#define DATA_SNACK_REJECT	3
+#define ISCSI_PROTOCOL_ERROR	4
+#define CMD_NOT_SUPPORTED	5
+#define IMM_CMD_REJECT		6
+#define TASK_IN_PROGRESS	7
+#define INVALID_SNACK		8
+#define BOOKMARK_REJECTED	9
+#define BOOKMARK_NO_RESOURCES	10
+#define NEGOTIATION_RESET	11
+
+/* Max. number of Key=Value pairs in a text message */
+#define MAX_KEY_VALUE_PAIRS	8192
+
+/* maximum length for text keys/values */
+#define KEY_MAXLEN		64
+#define VALUE_MAXLEN		255
+#define TARGET_NAME_MAXLEN	VALUE_MAXLEN
+
+#define DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH	8192
+
+/************************* RFC 3720 End *****************************/
+
+#endif /* ISCSI_PROTO_H */
Index: include/scsi/scsi_transport_iscsi.h
===================================================================
--- 7570fde464d579ce455c865f07a613e967e9396c/include/scsi/scsi_transport_iscsi.h  (mode:100644 sha1:1b26a6c0aa2a248502ae61e59d1f206466c9ab32)
+++ uncommitted/include/scsi/scsi_transport_iscsi.h  (mode:100644)
@@ -1,8 +1,10 @@
-/* 
+/*
  * iSCSI transport class definitions
  *
  * Copyright (C) IBM Corporation, 2004
- * Copyright (C) Mike Christie, 2004
+ * Copyright (C) Mike Christie, 2004 - 2005
+ * Copyright (C) Dmitry Yusupov, 2004 - 2005
+ * Copyright (C) Alex Aizman, 2004 - 2005
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -21,158 +23,68 @@
 #ifndef SCSI_TRANSPORT_ISCSI_H
 #define SCSI_TRANSPORT_ISCSI_H
 
-#include <linux/config.h>
-#include <linux/in6.h>
-#include <linux/in.h>
-
-struct scsi_transport_template;
+#include <scsi/iscsi_if.h>
 
-struct iscsi_class_session {
-	uint8_t isid[6];
-	uint16_t tsih;
-	int header_digest;		/* 1 CRC32, 0 None */
-	int data_digest;		/* 1 CRC32, 0 None */
-	uint16_t tpgt;
-	union {
-		struct in6_addr sin6_addr;
-		struct in_addr sin_addr;
-	} u;
-	sa_family_t addr_type;		/* must be AF_INET or AF_INET6 */
-	uint16_t port;			/* must be in network byte order */
-	int initial_r2t;		/* 1 Yes, 0 No */
-	int immediate_data;		/* 1 Yes, 0 No */
-	uint32_t max_recv_data_segment_len;
-	uint32_t max_burst_len;
-	uint32_t first_burst_len;
-	uint16_t def_time2wait;
-	uint16_t def_time2retain;
-	uint16_t max_outstanding_r2t;
-	int data_pdu_in_order;		/* 1 Yes, 0 No */
-	int data_sequence_in_order;	/* 1 Yes, 0 No */
-	int erl;
+/**
+ * struct iscsi_transport - iSCSI Transport template
+ *
+ * @name:		transport name
+ * @caps:		iSCSI Data-Path capabilities
+ * @create_session:	create new iSCSI session object
+ * @destroy_session:	destroy existing iSCSI session object
+ * @create_conn:	create new iSCSI connection
+ * @bind_conn:		associate this connection with existing iSCSI session
+ *			and specified transport descriptor
+ * @destroy_conn:	destroy inactive iSCSI connection
+ * @set_param:		set iSCSI Data-Path operational parameter
+ * @start_conn:		set connection to be operational
+ * @stop_conn:		suspend/recover/terminate connection
+ * @send_pdu:		send iSCSI PDU, Login, Logout, NOP-Out, Reject, Text.
+ *
+ * Template API provided by iSCSI Transport
+ */
+struct iscsi_transport {
+	struct module *owner;
+	char *name;
+	unsigned int caps;
+	struct scsi_host_template *host_template;
+	int hostdata_size;
+	int max_lun;
+	unsigned int max_conn;
+	unsigned int max_cmd_len;
+	iscsi_sessionh_t (*create_session) (uint32_t initial_cmdsn,
+					    struct Scsi_Host *shost);
+	void (*destroy_session) (iscsi_sessionh_t session);
+	iscsi_connh_t (*create_conn) (iscsi_sessionh_t session, uint32_t cid);
+	int (*bind_conn) (iscsi_sessionh_t session, iscsi_connh_t conn,
+			  uint32_t transport_fd, int is_leading);
+	int (*start_conn) (iscsi_connh_t conn);
+	void (*stop_conn) (iscsi_connh_t conn, int flag);
+	void (*destroy_conn) (iscsi_connh_t conn);
+	int (*set_param) (iscsi_connh_t conn, enum iscsi_param param,
+			  uint32_t value);
+	int (*get_param) (iscsi_connh_t conn, enum iscsi_param param,
+			  uint32_t *value);
+	int (*send_pdu) (iscsi_connh_t conn, struct iscsi_hdr *hdr,
+			 char *data, uint32_t data_size);
+	void (*get_stats) (iscsi_connh_t conn, struct iscsi_stats *stats);
+	/*
+	 * transport class private data
+	 */
+	struct scsi_transport_template *scsi_transport;
 };
 
 /*
- * accessor macros
+ * transport registration upcalls
  */
-#define iscsi_isid(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->isid)
-#define iscsi_tsih(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->tsih)
-#define iscsi_header_digest(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->header_digest)
-#define iscsi_data_digest(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->data_digest)
-#define iscsi_port(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->port)
-#define iscsi_addr_type(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->addr_type)
-#define iscsi_sin_addr(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->u.sin_addr)
-#define iscsi_sin6_addr(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->u.sin6_addr)
-#define iscsi_tpgt(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->tpgt)
-#define iscsi_initial_r2t(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->initial_r2t)
-#define iscsi_immediate_data(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->immediate_data)
-#define iscsi_max_recv_data_segment_len(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->max_recv_data_segment_len)
-#define iscsi_max_burst_len(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->max_burst_len)
-#define iscsi_first_burst_len(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->first_burst_len)
-#define iscsi_def_time2wait(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->def_time2wait)
-#define iscsi_def_time2retain(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->def_time2retain)
-#define iscsi_max_outstanding_r2t(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->max_outstanding_r2t)
-#define iscsi_data_pdu_in_order(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->data_pdu_in_order)
-#define iscsi_data_sequence_in_order(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->data_sequence_in_order)
-#define iscsi_erl(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->erl)
+extern int iscsi_register_transport(struct iscsi_transport *tt);
+extern int iscsi_unregister_transport(struct iscsi_transport *tt);
 
 /*
- * The functions by which the transport class and the driver communicate
+ * control plane upcalls
  */
-struct iscsi_function_template {
-	/*
-	 * target attrs
-	 */
-	void (*get_isid)(struct scsi_target *);
-	void (*get_tsih)(struct scsi_target *);
-	void (*get_header_digest)(struct scsi_target *);
-	void (*get_data_digest)(struct scsi_target *);
-	void (*get_port)(struct scsi_target *);
-	void (*get_tpgt)(struct scsi_target *);
-	/*
-	 * In get_ip_address the lld must set the address and
-	 * the address type
-	 */
-	void (*get_ip_address)(struct scsi_target *);
-	/*
-	 * The lld should snprintf the name or alias to the buffer
-	 */
-	ssize_t (*get_target_name)(struct scsi_target *, char *, ssize_t);
-	ssize_t (*get_target_alias)(struct scsi_target *, char *, ssize_t);
-	void (*get_initial_r2t)(struct scsi_target *);
-	void (*get_immediate_data)(struct scsi_target *);
-	void (*get_max_recv_data_segment_len)(struct scsi_target *);
-	void (*get_max_burst_len)(struct scsi_target *);
-	void (*get_first_burst_len)(struct scsi_target *);
-	void (*get_def_time2wait)(struct scsi_target *);
-	void (*get_def_time2retain)(struct scsi_target *);
-	void (*get_max_outstanding_r2t)(struct scsi_target *);
-	void (*get_data_pdu_in_order)(struct scsi_target *);
-	void (*get_data_sequence_in_order)(struct scsi_target *);
-	void (*get_erl)(struct scsi_target *);
-
-	/*
-	 * host atts
-	 */
-
-	/*
-	 * The lld should snprintf the name or alias to the buffer
-	 */
-	ssize_t (*get_initiator_alias)(struct Scsi_Host *, char *, ssize_t);
-	ssize_t (*get_initiator_name)(struct Scsi_Host *, char *, ssize_t);
-	/*
-	 * The driver sets these to tell the transport class it
-	 * wants the attributes displayed in sysfs.  If the show_ flag
-	 * is not set, the attribute will be private to the transport
-	 * class. We could probably just test if a get_ fn was set
-	 * since we only use the values for sysfs but this is how
-	 * fc does it too.
-	 */
-	unsigned long show_isid:1;
-	unsigned long show_tsih:1;
-	unsigned long show_header_digest:1;
-	unsigned long show_data_digest:1;
-	unsigned long show_port:1;
-	unsigned long show_tpgt:1;
-	unsigned long show_ip_address:1;
-	unsigned long show_target_name:1;
-	unsigned long show_target_alias:1;
-	unsigned long show_initial_r2t:1;
-	unsigned long show_immediate_data:1;
-	unsigned long show_max_recv_data_segment_len:1;
-	unsigned long show_max_burst_len:1;
-	unsigned long show_first_burst_len:1;
-	unsigned long show_def_time2wait:1;
-	unsigned long show_def_time2retain:1;
-	unsigned long show_max_outstanding_r2t:1;
-	unsigned long show_data_pdu_in_order:1;
-	unsigned long show_data_sequence_in_order:1;
-	unsigned long show_erl:1;
-	unsigned long show_initiator_name:1;
-	unsigned long show_initiator_alias:1;
-};
-
-struct scsi_transport_template *iscsi_attach_transport(struct iscsi_function_template *);
-void iscsi_release_transport(struct scsi_transport_template *);
+extern void iscsi_conn_error(iscsi_connh_t conn, enum iscsi_err error);
+extern int iscsi_recv_pdu(iscsi_connh_t conn, struct iscsi_hdr *hdr,
+			  char *data, uint32_t data_size);
 
 #endif



