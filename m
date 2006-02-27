Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWB0G00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWB0G00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWB0GZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:25:40 -0500
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:992 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751557AbWB0GZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:25:14 -0500
Date: Mon, 27 Feb 2006 07:23:10 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 3/7] isdn4linux: Siemens Gigaset drivers - subsystem interfaces
Message-ID: <gigaset307x.2006.02.27.001.3@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch adds the isdn4linux, tty, and sysfs interfaces to the gigaset
module.
The isdn4linux subsystem interface handles requests from and notifications
to the isdn4linux subsystem.
The tty interface provides direct access to the AT command set of the
Gigaset devices.
The sysfs interface provides access to status information and operation
mode settings of the Gigaset devices. If the drivers are built with the
debugging option it also allows to change the amount of debugging output
on the fly.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/i4l.c       |  575 +++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/interface.c |  719 +++++++++++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/proc.c      |   77 ++++
 include/linux/gigaset_dev.h      |   32 +
 4 files changed, 1403 insertions(+)

--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/i4l.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/i4l.c	2006-02-26 01:22:39.000000000 +0100
@@ -0,0 +1,575 @@
+/*
+ * Stuff used by all variants of the driver
+ *
+ * Copyright (c) 2001 by Stefan Eilers (Eilers.Stefan@epost.de),
+ *                       Hansjoerg Lipp (hjlipp@web.de),
+ *                       Tilman Schmidt (tilman@imap.cc).
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
+
+/* == Handling of I4L IO =====================================================*/
+
+/* writebuf_from_LL
+ * called by LL to transmit data on an open channel
+ * inserts the buffer data into the send queue and starts the transmission
+ * Note that this operation must not sleep!
+ * When the buffer is processed completely, gigaset_skb_sent() should be called.
+ * parameters:
+ *	driverID	driver ID as assigned by LL
+ *	channel		channel number
+ *	ack		if != 0 LL wants to be notified on completion via
+ *			statcallb(ISDN_STAT_BSENT)
+ *	skb		skb containing data to send
+ * return value:
+ *	number of accepted bytes
+ *	0 if temporarily unable to accept data (out of buffer space)
+ *	<0 on error (eg. -EINVAL)
+ */
+static int writebuf_from_LL(int driverID, int channel, int ack,
+			    struct sk_buff *skb)
+{
+	struct cardstate *cs;
+	struct bc_state *bcs;
+	unsigned len;
+	unsigned skblen;
+
+	if (!(cs = gigaset_get_cs_by_id(driverID))) {
+		err("%s: invalid driver ID (%d)", __func__, driverID);
+		return -ENODEV;
+	}
+	if (channel < 0 || channel >= cs->channels) {
+		err("%s: invalid channel ID (%d)", __func__, channel);
+		return -ENODEV;
+	}
+	bcs = &cs->bcs[channel];
+	len = skb->len;
+
+	gig_dbg(DEBUG_LLDATA,
+		"Receiving data from LL (id: %d, ch: %d, ack: %d, sz: %d)",
+		driverID, channel, ack, len);
+
+	if (!atomic_read(&cs->connected)) {
+		err("%s: disconnected", __func__);
+		return -ENODEV;
+	}
+
+	if (!len) {
+		if (ack)
+			notice("%s: not ACKing empty packet", __func__);
+		return 0;
+	}
+	if (len > MAX_BUF_SIZE) {
+		err("%s: packet too large (%d bytes)", __func__, len);
+		return -EINVAL;
+	}
+
+	skblen = ack ? len : 0;
+	skb->head[0] = skblen & 0xff;
+	skb->head[1] = skblen >> 8;
+	gig_dbg(DEBUG_MCMD, "skb: len=%u, skblen=%u: %02x %02x",
+		len, skblen, (unsigned) skb->head[0], (unsigned) skb->head[1]);
+
+	/* pass to device-specific module */
+	return cs->ops->send_skb(bcs, skb);
+}
+
+void gigaset_skb_sent(struct bc_state *bcs, struct sk_buff *skb)
+{
+	unsigned len;
+	isdn_ctrl response;
+
+	++bcs->trans_up;
+
+	if (skb->len)
+		dev_warn(bcs->cs->dev, "%s: skb->len==%d\n",
+			 __func__, skb->len);
+
+	len = (unsigned char) skb->head[0] |
+	      (unsigned) (unsigned char) skb->head[1] << 8;
+	if (len) {
+		gig_dbg(DEBUG_MCMD, "ACKing to LL (id: %d, ch: %d, sz: %u)",
+			bcs->cs->myid, bcs->channel, len);
+
+		response.driver = bcs->cs->myid;
+		response.command = ISDN_STAT_BSENT;
+		response.arg = bcs->channel;
+		response.parm.length = len;
+		bcs->cs->iif.statcallb(&response);
+	}
+}
+EXPORT_SYMBOL_GPL(gigaset_skb_sent);
+
+/* This function will be called by LL to send commands
+ * NOTE: LL ignores the returned value, for commands other than ISDN_CMD_IOCTL,
+ * so don't put too much effort into it.
+ */
+static int command_from_LL(isdn_ctrl *cntrl)
+{
+	struct cardstate *cs = gigaset_get_cs_by_id(cntrl->driver);
+	//isdn_ctrl response;
+	//unsigned long flags;
+	struct bc_state *bcs;
+	int retval = 0;
+	struct setup_parm *sp;
+
+	gigaset_debugdrivers();
+
+	//FIXME "remove test for &connected"
+	if ((!cs || !atomic_read(&cs->connected))) {
+		warn("LL tried to access unknown device with nr. %d",
+		     cntrl->driver);
+		return -ENODEV;
+	}
+
+	switch (cntrl->command) {
+	case ISDN_CMD_IOCTL:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_IOCTL (driver: %d, arg: %ld)",
+			cntrl->driver, cntrl->arg);
+
+		warn("ISDN_CMD_IOCTL is not supported.");
+		return -EINVAL;
+
+	case ISDN_CMD_DIAL:
+		gig_dbg(DEBUG_ANY,
+			"ISDN_CMD_DIAL (driver: %d, ch: %ld, "
+			"phone: %s, ownmsn: %s, si1: %d, si2: %d)",
+			cntrl->driver, cntrl->arg,
+			cntrl->parm.setup.phone, cntrl->parm.setup.eazmsn,
+			cntrl->parm.setup.si1, cntrl->parm.setup.si2);
+
+		if (cntrl->arg >= cs->channels) {
+			err("ISDN_CMD_DIAL: invalid channel (%d)",
+			    (int) cntrl->arg);
+			return -EINVAL;
+		}
+
+		bcs = cs->bcs + cntrl->arg;
+
+		if (!gigaset_get_channel(bcs)) {
+			err("ISDN_CMD_DIAL: channel not free");
+			return -EBUSY;
+		}
+
+		sp = kmalloc(sizeof *sp, GFP_ATOMIC);
+		if (!sp) {
+			gigaset_free_channel(bcs);
+			err("ISDN_CMD_DIAL: out of memory");
+			return -ENOMEM;
+		}
+		*sp = cntrl->parm.setup;
+
+		if (!gigaset_add_event(cs, &bcs->at_state, EV_DIAL, sp,
+				       atomic_read(&bcs->at_state.seq_index),
+				       NULL)) {
+			//FIXME what should we do?
+			kfree(sp);
+			gigaset_free_channel(bcs);
+			return -ENOMEM;
+		}
+
+		gig_dbg(DEBUG_CMD, "scheduling DIAL");
+		gigaset_schedule_event(cs);
+		break;
+	case ISDN_CMD_ACCEPTD: //FIXME
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_ACCEPTD");
+
+		if (cntrl->arg >= cs->channels) {
+			err("ISDN_CMD_ACCEPTD: invalid channel (%d)",
+			    (int) cntrl->arg);
+			return -EINVAL;
+		}
+
+		if (!gigaset_add_event(cs, &cs->bcs[cntrl->arg].at_state,
+				       EV_ACCEPT, NULL, 0, NULL)) {
+			//FIXME what should we do?
+			return -ENOMEM;
+		}
+
+		gig_dbg(DEBUG_CMD, "scheduling ACCEPT");
+		gigaset_schedule_event(cs);
+
+		break;
+	case ISDN_CMD_ACCEPTB:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_ACCEPTB");
+		break;
+	case ISDN_CMD_HANGUP:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_HANGUP (ch: %d)",
+			(int) cntrl->arg);
+
+		if (cntrl->arg >= cs->channels) {
+			err("ISDN_CMD_HANGUP: invalid channel (%u)",
+			    (unsigned) cntrl->arg);
+			return -EINVAL;
+		}
+
+		if (!gigaset_add_event(cs, &cs->bcs[cntrl->arg].at_state,
+				       EV_HUP, NULL, 0, NULL)) {
+			//FIXME what should we do?
+			return -ENOMEM;
+		}
+
+		gig_dbg(DEBUG_CMD, "scheduling HUP");
+		gigaset_schedule_event(cs);
+
+		break;
+	case ISDN_CMD_CLREAZ: /* Do not signal incoming signals */ //FIXME
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_CLREAZ");
+		break;
+	case ISDN_CMD_SETEAZ: /* Signal incoming calls for given MSN */ //FIXME
+		gig_dbg(DEBUG_ANY,
+			"ISDN_CMD_SETEAZ (id: %d, ch: %ld, number: %s)",
+			cntrl->driver, cntrl->arg, cntrl->parm.num);
+		break;
+	case ISDN_CMD_SETL2: /* Set L2 to given protocol */
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_SETL2 (ch: %ld, proto: %lx)",
+			cntrl->arg & 0xff, (cntrl->arg >> 8));
+
+		if ((cntrl->arg & 0xff) >= cs->channels) {
+			err("ISDN_CMD_SETL2: invalid channel (%u)",
+			    (unsigned) cntrl->arg & 0xff);
+			return -EINVAL;
+		}
+
+		if (!gigaset_add_event(cs, &cs->bcs[cntrl->arg & 0xff].at_state,
+				       EV_PROTO_L2, NULL, cntrl->arg >> 8,
+				       NULL)) {
+			//FIXME what should we do?
+			return -ENOMEM;
+		}
+
+		gig_dbg(DEBUG_CMD, "scheduling PROTO_L2");
+		gigaset_schedule_event(cs);
+		break;
+	case ISDN_CMD_SETL3: /* Set L3 to given protocol */
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_SETL3 (ch: %ld, proto: %lx)",
+			cntrl->arg & 0xff, (cntrl->arg >> 8));
+
+		if ((cntrl->arg & 0xff) >= cs->channels) {
+			err("ISDN_CMD_SETL3: invalid channel (%u)",
+			    (unsigned) cntrl->arg & 0xff);
+			return -EINVAL;
+		}
+
+		if (cntrl->arg >> 8 != ISDN_PROTO_L3_TRANS) {
+			err("ISDN_CMD_SETL3: invalid protocol %lu",
+			    cntrl->arg >> 8);
+			return -EINVAL;
+		}
+
+		break;
+	case ISDN_CMD_PROCEED:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_PROCEED"); //FIXME
+		break;
+	case ISDN_CMD_ALERT:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_ALERT"); //FIXME
+		if (cntrl->arg >= cs->channels) {
+			err("ISDN_CMD_ALERT: invalid channel (%d)",
+			    (int) cntrl->arg);
+			return -EINVAL;
+		}
+		//bcs = cs->bcs + cntrl->arg;
+		//bcs->proto2 = -1;
+		// FIXME
+		break;
+	case ISDN_CMD_REDIR:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_REDIR"); //FIXME
+		break;
+	case ISDN_CMD_PROT_IO:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_PROT_IO");
+		break;
+	case ISDN_CMD_FAXCMD:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_FAXCMD");
+		break;
+	case ISDN_CMD_GETL2:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_GETL2");
+		break;
+	case ISDN_CMD_GETL3:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_GETL3");
+		break;
+	case ISDN_CMD_GETEAZ:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_GETEAZ");
+		break;
+	case ISDN_CMD_SETSIL:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_SETSIL");
+		break;
+	case ISDN_CMD_GETSIL:
+		gig_dbg(DEBUG_ANY, "ISDN_CMD_GETSIL");
+		break;
+	default:
+		err("unknown command %d from LL", cntrl->command);
+		return -EINVAL;
+	}
+
+	return retval;
+}
+
+void gigaset_i4l_cmd(struct cardstate *cs, int cmd)
+{
+	isdn_ctrl command;
+
+	command.driver = cs->myid;
+	command.command = cmd;
+	command.arg = 0;
+	cs->iif.statcallb(&command);
+}
+
+void gigaset_i4l_channel_cmd(struct bc_state *bcs, int cmd)
+{
+	isdn_ctrl command;
+
+	command.driver = bcs->cs->myid;
+	command.command = cmd;
+	command.arg = bcs->channel;
+	bcs->cs->iif.statcallb(&command);
+}
+
+int gigaset_isdn_setup_dial(struct at_state_t *at_state, void *data)
+{
+	struct bc_state *bcs = at_state->bcs;
+	unsigned proto;
+	const char *bc;
+	size_t length[AT_NUM];
+	size_t l;
+	int i;
+	struct setup_parm *sp = data;
+
+	switch (bcs->proto2) {
+	case ISDN_PROTO_L2_HDLC:
+		proto = 1; /* 0: Bitsynchron, 1: HDLC, 2: voice */
+		break;
+	case ISDN_PROTO_L2_TRANS:
+		proto = 2; /* 0: Bitsynchron, 1: HDLC, 2: voice */
+		break;
+	default:
+		dev_err(bcs->cs->dev, "%s: invalid L2 protocol: %u\n",
+			__func__, bcs->proto2);
+		return -EINVAL;
+	}
+
+	switch (sp->si1) {
+	case 1:		/* audio */
+		bc = "9090A3";	/* 3.1 kHz audio, A-law */
+		break;
+	case 7:		/* data */
+	default:	/* hope the app knows what it is doing */
+		bc = "8890";	/* unrestricted digital information */
+	}
+	//FIXME add missing si1 values from 1TR6, inspect si2, set HLC/LLC
+
+	length[AT_DIAL ] = 1 + strlen(sp->phone) + 1 + 1;
+	l = strlen(sp->eazmsn);
+	length[AT_MSN  ] = l ? 6 + l + 1 + 1 : 0;
+	length[AT_BC   ] = 5 + strlen(bc) + 1 + 1;
+	length[AT_PROTO] = 6 + 1 + 1 + 1; /* proto: 1 character */
+	length[AT_ISO  ] = 6 + 1 + 1 + 1; /* channel: 1 character */
+	length[AT_TYPE ] = 6 + 1 + 1 + 1; /* call type: 1 character */
+	length[AT_HLC  ] = 0;
+
+	for (i = 0; i < AT_NUM; ++i) {
+		kfree(bcs->commands[i]);
+		bcs->commands[i] = NULL;
+		if (length[i] &&
+		    !(bcs->commands[i] = kmalloc(length[i], GFP_ATOMIC))) {
+			dev_err(bcs->cs->dev, "out of memory\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* type = 1: extern, 0: intern, 2: recall, 3: door, 4: centrex */
+	if (sp->phone[0] == '*' && sp->phone[1] == '*') {
+		/* internal call: translate ** prefix to CTP value */
+		snprintf(bcs->commands[AT_DIAL], length[AT_DIAL],
+			 "D%s\r", sp->phone+2);
+		strncpy(bcs->commands[AT_TYPE], "^SCTP=0\r", length[AT_TYPE]);
+	} else {
+		snprintf(bcs->commands[AT_DIAL], length[AT_DIAL],
+			 "D%s\r", sp->phone);
+		strncpy(bcs->commands[AT_TYPE], "^SCTP=1\r", length[AT_TYPE]);
+	}
+
+	if (bcs->commands[AT_MSN])
+		snprintf(bcs->commands[AT_MSN], length[AT_MSN],
+			 "^SMSN=%s\r", sp->eazmsn);
+	snprintf(bcs->commands[AT_BC   ], length[AT_BC   ],
+		 "^SBC=%s\r", bc);
+	snprintf(bcs->commands[AT_PROTO], length[AT_PROTO],
+		 "^SBPR=%u\r", proto);
+	snprintf(bcs->commands[AT_ISO  ], length[AT_ISO  ],
+		 "^SISO=%u\r", (unsigned)bcs->channel + 1);
+
+	return 0;
+}
+
+int gigaset_isdn_setup_accept(struct at_state_t *at_state)
+{
+	unsigned proto;
+	size_t length[AT_NUM];
+	int i;
+	struct bc_state *bcs = at_state->bcs;
+
+	switch (bcs->proto2) {
+	case ISDN_PROTO_L2_HDLC:
+		proto = 1; /* 0: Bitsynchron, 1: HDLC, 2: voice */
+		break;
+	case ISDN_PROTO_L2_TRANS:
+		proto = 2; /* 0: Bitsynchron, 1: HDLC, 2: voice */
+		break;
+	default:
+		dev_err(at_state->cs->dev, "%s: invalid protocol: %u\n",
+			__func__, bcs->proto2);
+		return -EINVAL;
+	}
+
+	length[AT_DIAL ] = 0;
+	length[AT_MSN  ] = 0;
+	length[AT_BC   ] = 0;
+	length[AT_PROTO] = 6 + 1 + 1 + 1; /* proto: 1 character */
+	length[AT_ISO  ] = 6 + 1 + 1 + 1; /* channel: 1 character */
+	length[AT_TYPE ] = 0;
+	length[AT_HLC  ] = 0;
+
+	for (i = 0; i < AT_NUM; ++i) {
+		kfree(bcs->commands[i]);
+		bcs->commands[i] = NULL;
+		if (length[i] &&
+		    !(bcs->commands[i] = kmalloc(length[i], GFP_ATOMIC))) {
+			dev_err(at_state->cs->dev, "out of memory\n");
+			return -ENOMEM;
+		}
+	}
+
+	snprintf(bcs->commands[AT_PROTO], length[AT_PROTO],
+		 "^SBPR=%u\r", proto);
+	snprintf(bcs->commands[AT_ISO  ], length[AT_ISO  ],
+		 "^SISO=%u\r", (unsigned) bcs->channel + 1);
+
+	return 0;
+}
+
+int gigaset_isdn_icall(struct at_state_t *at_state)
+{
+	struct cardstate *cs = at_state->cs;
+	struct bc_state *bcs = at_state->bcs;
+	isdn_ctrl response;
+	int retval;
+
+	/* fill ICALL structure */
+	response.parm.setup.si1 = 0;	/* default: unknown */
+	response.parm.setup.si2 = 0;
+	response.parm.setup.screen = 0;	//FIXME how to set these?
+	response.parm.setup.plan = 0;
+	if (!at_state->str_var[STR_ZBC]) {
+		/* no BC (internal call): assume speech, A-law */
+		response.parm.setup.si1 = 1;
+	} else if (!strcmp(at_state->str_var[STR_ZBC], "8890")) {
+		/* unrestricted digital information */
+		response.parm.setup.si1 = 7;
+	} else if (!strcmp(at_state->str_var[STR_ZBC], "8090A3")) {
+		/* speech, A-law */
+		response.parm.setup.si1 = 1;
+	} else if (!strcmp(at_state->str_var[STR_ZBC], "9090A3")) {
+		/* 3,1 kHz audio, A-law */
+		response.parm.setup.si1 = 1;
+		response.parm.setup.si2 = 2;
+	} else {
+		dev_warn(cs->dev, "RING ignored - unsupported BC %s\n",
+		     at_state->str_var[STR_ZBC]);
+		return ICALL_IGNORE;
+	}
+	if (at_state->str_var[STR_NMBR]) {
+		strncpy(response.parm.setup.phone, at_state->str_var[STR_NMBR],
+			sizeof response.parm.setup.phone - 1);
+		response.parm.setup.phone[sizeof response.parm.setup.phone - 1] = 0;
+	} else
+		response.parm.setup.phone[0] = 0;
+	if (at_state->str_var[STR_ZCPN]) {
+		strncpy(response.parm.setup.eazmsn, at_state->str_var[STR_ZCPN],
+			sizeof response.parm.setup.eazmsn - 1);
+		response.parm.setup.eazmsn[sizeof response.parm.setup.eazmsn - 1] = 0;
+	} else
+		response.parm.setup.eazmsn[0] = 0;
+
+	if (!bcs) {
+		dev_notice(cs->dev, "no channel for incoming call\n");
+		response.command = ISDN_STAT_ICALLW;
+		response.arg = 0; //FIXME
+	} else {
+		gig_dbg(DEBUG_CMD, "Sending ICALL");
+		response.command = ISDN_STAT_ICALL;
+		response.arg = bcs->channel; //FIXME
+	}
+	response.driver = cs->myid;
+	retval = cs->iif.statcallb(&response);
+	gig_dbg(DEBUG_CMD, "Response: %d", retval);
+	switch (retval) {
+	case 0:	/* no takers */
+		return ICALL_IGNORE;
+	case 1:	/* alerting */
+		bcs->chstate |= CHS_NOTIFY_LL;
+		return ICALL_ACCEPT;
+	case 2:	/* reject */
+		return ICALL_REJECT;
+	case 3:	/* incomplete */
+		dev_warn(cs->dev,
+		       "LL requested unsupported feature: Incomplete Number\n");
+		return ICALL_IGNORE;
+	case 4:	/* proceeding */
+		/* Gigaset will send ALERTING anyway.
+		 * There doesn't seem to be a way to avoid this.
+		 */
+		return ICALL_ACCEPT;
+	case 5:	/* deflect */
+		dev_warn(cs->dev,
+			 "LL requested unsupported feature: Call Deflection\n");
+		return ICALL_IGNORE;
+	default:
+		dev_err(cs->dev, "LL error %d on ICALL\n", retval);
+		return ICALL_IGNORE;
+	}
+}
+
+/* Set Callback function pointer */
+int gigaset_register_to_LL(struct cardstate *cs, const char *isdnid)
+{
+	isdn_if *iif = &cs->iif;
+
+	gig_dbg(DEBUG_ANY, "Register driver capabilities to LL");
+
+	//iif->id[sizeof(iif->id) - 1]=0;
+	//strncpy(iif->id, isdnid, sizeof(iif->id) - 1);
+	if (snprintf(iif->id, sizeof iif->id, "%s_%u", isdnid, cs->minor_index)
+	    >= sizeof iif->id)
+		return -ENOMEM; //FIXME EINVAL/...??
+
+	iif->owner = THIS_MODULE;
+	iif->channels = cs->channels;
+	iif->maxbufsize = MAX_BUF_SIZE;
+	iif->features = ISDN_FEATURE_L2_TRANS |
+		ISDN_FEATURE_L2_HDLC |
+#ifdef GIG_X75
+		ISDN_FEATURE_L2_X75I |
+#endif
+		ISDN_FEATURE_L3_TRANS |
+		ISDN_FEATURE_P_EURO;
+	iif->hl_hdrlen = HW_HDR_LEN;		/* Area for storing ack */
+	iif->command = command_from_LL;
+	iif->writebuf_skb = writebuf_from_LL;
+	iif->writecmd = NULL;			/* Don't support isdnctrl */
+	iif->readstat = NULL;			/* Don't support isdnctrl */
+	iif->rcvcallb_skb = NULL;		/* Will be set by LL */
+	iif->statcallb = NULL;			/* Will be set by LL */
+
+	if (!register_isdn(iif))
+		return 0;
+
+	cs->myid = iif->channels;		/* Set my device id */
+	return 1;
+}
--- linux-2.6.16-rc4.orig/include/linux/gigaset_dev.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/include/linux/gigaset_dev.h	2006-02-26 14:36:45.000000000 +0100
@@ -0,0 +1,32 @@
+/*
+ * interface to user space for the gigaset driver
+ *
+ * Copyright (c) 2004 by Hansjoerg Lipp <hjlipp@web.de>
+ *
+ * =====================================================================
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License as
+ *    published by the Free Software Foundation; either version 2 of
+ *    the License, or (at your option) any later version.
+ * =====================================================================
+ * Version: $Id: gigaset_dev.h,v 1.4.4.4 2005/11/21 22:28:09 hjlipp Exp $
+ * =====================================================================
+ */
+
+#ifndef GIGASET_INTERFACE_H
+#define GIGASET_INTERFACE_H
+
+#include <linux/ioctl.h>
+
+#define GIGASET_IOCTL 0x47
+
+#define GIGVER_DRIVER 0
+#define GIGVER_COMPAT 1
+#define GIGVER_FWBASE 2
+
+#define GIGASET_REDIR    _IOWR (GIGASET_IOCTL, 0, int)
+#define GIGASET_CONFIG   _IOWR (GIGASET_IOCTL, 1, int)
+#define GIGASET_BRKCHARS _IOW  (GIGASET_IOCTL, 2, unsigned char[6]) //FIXME [6] okay?
+#define GIGASET_VERSION  _IOWR (GIGASET_IOCTL, 3, unsigned[4])
+
+#endif
--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/interface.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/interface.c	2006-02-24 00:19:28.000000000 +0100
@@ -0,0 +1,719 @@
+/*
+ * interface to user space for the gigaset driver
+ *
+ * Copyright (c) 2004 by Hansjoerg Lipp <hjlipp@web.de>
+ *
+ * =====================================================================
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License as
+ *    published by the Free Software Foundation; either version 2 of
+ *    the License, or (at your option) any later version.
+ * =====================================================================
+ */
+
+#include "gigaset.h"
+#include <linux/gigaset_dev.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+/*** our ioctls ***/
+
+static int if_lock(struct cardstate *cs, int *arg)
+{
+	int cmd = *arg;
+
+	gig_dbg(DEBUG_IF, "%u: if_lock (%d)", cs->minor_index, cmd);
+
+	if (cmd > 1)
+		return -EINVAL;
+
+	if (cmd < 0) {
+		*arg = atomic_read(&cs->mstate) == MS_LOCKED; //FIXME remove?
+		return 0;
+	}
+
+	if (!cmd && atomic_read(&cs->mstate) == MS_LOCKED
+	    && atomic_read(&cs->connected)) {
+		cs->ops->set_modem_ctrl(cs, 0, TIOCM_DTR|TIOCM_RTS);
+		cs->ops->baud_rate(cs, B115200);
+		cs->ops->set_line_ctrl(cs, CS8);
+		cs->control_state = TIOCM_DTR|TIOCM_RTS;
+	}
+
+	cs->waiting = 1;
+	if (!gigaset_add_event(cs, &cs->at_state, EV_IF_LOCK,
+			       NULL, cmd, NULL)) {
+		cs->waiting = 0;
+		return -ENOMEM;
+	}
+
+	gig_dbg(DEBUG_CMD, "scheduling IF_LOCK");
+	gigaset_schedule_event(cs);
+
+	wait_event(cs->waitqueue, !cs->waiting);
+
+	if (cs->cmd_result >= 0) {
+		*arg = cs->cmd_result;
+		return 0;
+	}
+
+	return cs->cmd_result;
+}
+
+static int if_version(struct cardstate *cs, unsigned arg[4])
+{
+	static const unsigned version[4] = GIG_VERSION;
+	static const unsigned compat[4] = GIG_COMPAT;
+	unsigned cmd = arg[0];
+
+	gig_dbg(DEBUG_IF, "%u: if_version (%d)", cs->minor_index, cmd);
+
+	switch (cmd) {
+	case GIGVER_DRIVER:
+		memcpy(arg, version, sizeof version);
+		return 0;
+	case GIGVER_COMPAT:
+		memcpy(arg, compat, sizeof compat);
+		return 0;
+	case GIGVER_FWBASE:
+		cs->waiting = 1;
+		if (!gigaset_add_event(cs, &cs->at_state, EV_IF_VER,
+				       NULL, 0, arg)) {
+			cs->waiting = 0;
+			return -ENOMEM;
+		}
+
+		gig_dbg(DEBUG_CMD, "scheduling IF_VER");
+		gigaset_schedule_event(cs);
+
+		wait_event(cs->waitqueue, !cs->waiting);
+
+		if (cs->cmd_result >= 0)
+			return 0;
+
+		return cs->cmd_result;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int if_config(struct cardstate *cs, int *arg)
+{
+	gig_dbg(DEBUG_IF, "%u: if_config (%d)", cs->minor_index, *arg);
+
+	if (*arg != 1)
+		return -EINVAL;
+
+	if (atomic_read(&cs->mstate) != MS_LOCKED)
+		return -EBUSY;
+
+	*arg = 0;
+	return gigaset_enterconfigmode(cs);
+}
+
+/*** the terminal driver ***/
+/* stolen from usbserial and some other tty drivers */
+
+static int  if_open(struct tty_struct *tty, struct file *filp);
+static void if_close(struct tty_struct *tty, struct file *filp);
+static int  if_ioctl(struct tty_struct *tty, struct file *file,
+		     unsigned int cmd, unsigned long arg);
+static int  if_write_room(struct tty_struct *tty);
+static int  if_chars_in_buffer(struct tty_struct *tty);
+static void if_throttle(struct tty_struct *tty);
+static void if_unthrottle(struct tty_struct *tty);
+static void if_set_termios(struct tty_struct *tty, struct termios *old);
+static int  if_tiocmget(struct tty_struct *tty, struct file *file);
+static int  if_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear);
+static int  if_write(struct tty_struct *tty,
+		     const unsigned char *buf, int count);
+
+static struct tty_operations if_ops = {
+	.open =			if_open,
+	.close =		if_close,
+	.ioctl =		if_ioctl,
+	.write =		if_write,
+	.write_room =		if_write_room,
+	.chars_in_buffer =	if_chars_in_buffer,
+	.set_termios =		if_set_termios,
+	.throttle =		if_throttle,
+	.unthrottle =		if_unthrottle,
+#if 0
+	.break_ctl =		serial_break,
+#endif
+	.tiocmget =		if_tiocmget,
+	.tiocmset =		if_tiocmset,
+};
+
+static int if_open(struct tty_struct *tty, struct file *filp)
+{
+	struct cardstate *cs;
+	unsigned long flags;
+
+	gig_dbg(DEBUG_IF, "%d+%d: %s()",
+		tty->driver->minor_start, tty->index, __func__);
+
+	tty->driver_data = NULL;
+
+	cs = gigaset_get_cs_by_tty(tty);
+	if (!cs)
+		return -ENODEV;
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+	tty->driver_data = cs;
+
+	++cs->open_count;
+
+	if (cs->open_count == 1) {
+		spin_lock_irqsave(&cs->lock, flags);
+		cs->tty = tty;
+		spin_unlock_irqrestore(&cs->lock, flags);
+		tty->low_latency = 1; //FIXME test
+	}
+
+	up(&cs->sem);
+	return 0;
+}
+
+static void if_close(struct tty_struct *tty, struct file *filp)
+{
+	struct cardstate *cs;
+	unsigned long flags;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	down(&cs->sem);
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else {
+		if (!--cs->open_count) {
+			spin_lock_irqsave(&cs->lock, flags);
+			cs->tty = NULL;
+			spin_unlock_irqrestore(&cs->lock, flags);
+		}
+	}
+
+	up(&cs->sem);
+}
+
+static int if_ioctl(struct tty_struct *tty, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct cardstate *cs;
+	int retval = -ENODEV;
+	int int_arg;
+	unsigned char buf[6];
+	unsigned version[4];
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return -ENODEV;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s(0x%x)", cs->minor_index, __func__, cmd);
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else {
+		retval = 0;
+		switch (cmd) {
+		case GIGASET_REDIR:
+			retval = get_user(int_arg, (int __user *) arg);
+			if (retval >= 0)
+				retval = if_lock(cs, &int_arg);
+			if (retval >= 0)
+				retval = put_user(int_arg, (int __user *) arg);
+			break;
+		case GIGASET_CONFIG:
+			retval = get_user(int_arg, (int __user *) arg);
+			if (retval >= 0)
+				retval = if_config(cs, &int_arg);
+			if (retval >= 0)
+				retval = put_user(int_arg, (int __user *) arg);
+			break;
+		case GIGASET_BRKCHARS:
+			//FIXME test if MS_LOCKED
+			gigaset_dbg_buffer(DEBUG_IF, "GIGASET_BRKCHARS",
+					   6, (const unsigned char *) arg, 1);
+			if (!atomic_read(&cs->connected)) {
+				gig_dbg(DEBUG_ANY,
+				    "can't communicate with unplugged device");
+				retval = -ENODEV;
+				break;
+			}
+			retval = copy_from_user(&buf,
+					(const unsigned char __user *) arg, 6)
+				? -EFAULT : 0;
+			if (retval >= 0)
+				retval = cs->ops->brkchars(cs, buf);
+			break;
+		case GIGASET_VERSION:
+			retval = copy_from_user(version,
+					(unsigned __user *) arg, sizeof version)
+				? -EFAULT : 0;
+			if (retval >= 0)
+				retval = if_version(cs, version);
+			if (retval >= 0)
+				retval = copy_to_user((unsigned __user *) arg,
+						      version, sizeof version)
+					? -EFAULT : 0;
+			break;
+		default:
+			gig_dbg(DEBUG_ANY, "%s: arg not supported - 0x%04x",
+				__func__, cmd);
+			retval = -ENOIOCTLCMD;
+		}
+	}
+
+	up(&cs->sem);
+
+	return retval;
+}
+
+static int if_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct cardstate *cs;
+	int retval;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return -ENODEV;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	// FIXME read from device?
+	retval = cs->control_state & (TIOCM_RTS|TIOCM_DTR);
+
+	up(&cs->sem);
+
+	return retval;
+}
+
+static int if_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
+{
+	struct cardstate *cs;
+	int retval;
+	unsigned mc;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return -ENODEV;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s(0x%x, 0x%x)",
+		cs->minor_index, __func__, set, clear);
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	if (!atomic_read(&cs->connected)) {
+		gig_dbg(DEBUG_ANY, "can't communicate with unplugged device");
+		retval = -ENODEV;
+	} else {
+		mc = (cs->control_state | set) & ~clear & (TIOCM_RTS|TIOCM_DTR);
+		retval = cs->ops->set_modem_ctrl(cs, cs->control_state, mc);
+		cs->control_state = mc;
+	}
+
+	up(&cs->sem);
+
+	return retval;
+}
+
+static int if_write(struct tty_struct *tty, const unsigned char *buf, int count)
+{
+	struct cardstate *cs;
+	int retval = -ENODEV;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return -ENODEV;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else if (atomic_read(&cs->mstate) != MS_LOCKED) {
+		warn("can't write to unlocked device");
+		retval = -EBUSY;
+	} else if (!atomic_read(&cs->connected)) {
+		gig_dbg(DEBUG_ANY, "can't write to unplugged device");
+		retval = -EBUSY; //FIXME
+	} else {
+		retval = cs->ops->write_cmd(cs, buf, count,
+					    &cs->if_wake_tasklet);
+	}
+
+	up(&cs->sem);
+
+	return retval;
+}
+
+static int if_write_room(struct tty_struct *tty)
+{
+	struct cardstate *cs;
+	int retval = -ENODEV;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return -ENODEV;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else if (atomic_read(&cs->mstate) != MS_LOCKED) {
+		warn("can't write to unlocked device");
+		retval = -EBUSY; //FIXME
+	} else if (!atomic_read(&cs->connected)) {
+		gig_dbg(DEBUG_ANY, "can't write to unplugged device");
+		retval = -EBUSY; //FIXME
+	} else
+		retval = cs->ops->write_room(cs);
+
+	up(&cs->sem);
+
+	return retval;
+}
+
+static int if_chars_in_buffer(struct tty_struct *tty)
+{
+	struct cardstate *cs;
+	int retval = -ENODEV;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return -ENODEV;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else if (atomic_read(&cs->mstate) != MS_LOCKED) {
+		warn("can't write to unlocked device");
+		retval = -EBUSY;
+	} else if (!atomic_read(&cs->connected)) {
+		gig_dbg(DEBUG_ANY, "can't write to unplugged device");
+		retval = -EBUSY; //FIXME
+	} else
+		retval = cs->ops->chars_in_buffer(cs);
+
+	up(&cs->sem);
+
+	return retval;
+}
+
+static void if_throttle(struct tty_struct *tty)
+{
+	struct cardstate *cs;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	down(&cs->sem);
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else {
+		//FIXME
+	}
+
+	up(&cs->sem);
+}
+
+static void if_unthrottle(struct tty_struct *tty)
+{
+	struct cardstate *cs;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	down(&cs->sem);
+
+	if (!cs->open_count)
+		warn("%s: device not opened", __func__);
+	else {
+		//FIXME
+	}
+
+	up(&cs->sem);
+}
+
+static void if_set_termios(struct tty_struct *tty, struct termios *old)
+{
+	struct cardstate *cs;
+	unsigned int iflag;
+	unsigned int cflag;
+	unsigned int old_cflag;
+	unsigned int control_state, new_state;
+
+	cs = (struct cardstate *) tty->driver_data;
+	if (!cs) {
+		err("cs==NULL in %s", __func__);
+		return;
+	}
+
+	gig_dbg(DEBUG_IF, "%u: %s()", cs->minor_index, __func__);
+
+	down(&cs->sem);
+
+	if (!cs->open_count) {
+		warn("%s: device not opened", __func__);
+		goto out;
+	}
+
+	if (!atomic_read(&cs->connected)) {
+		gig_dbg(DEBUG_ANY, "can't communicate with unplugged device");
+		goto out;
+	}
+
+	// stolen from mct_u232.c
+	iflag = tty->termios->c_iflag;
+	cflag = tty->termios->c_cflag;
+	old_cflag = old ? old->c_cflag : cflag; //FIXME?
+	gig_dbg(DEBUG_IF, "%u: iflag %x cflag %x old %x",
+		cs->minor_index, iflag, cflag, old_cflag);
+
+	/* get a local copy of the current port settings */
+	control_state = cs->control_state;
+
+	/*
+	 * Update baud rate.
+	 * Do not attempt to cache old rates and skip settings,
+	 * disconnects screw such tricks up completely.
+	 * Premature optimization is the root of all evil.
+	 */
+
+	/* reassert DTR and (maybe) RTS on transition from B0 */
+	if ((old_cflag & CBAUD) == B0) {
+		new_state = control_state | TIOCM_DTR;
+		/* don't set RTS if using hardware flow control */
+		if (!(old_cflag & CRTSCTS))
+			new_state |= TIOCM_RTS;
+		gig_dbg(DEBUG_IF, "%u: from B0 - set DTR%s",
+			cs->minor_index,
+			(new_state & TIOCM_RTS) ? " only" : "/RTS");
+		cs->ops->set_modem_ctrl(cs, control_state, new_state);
+		control_state = new_state;
+	}
+
+	cs->ops->baud_rate(cs, cflag & CBAUD);
+
+	if ((cflag & CBAUD) == B0) {
+		/* Drop RTS and DTR */
+		gig_dbg(DEBUG_IF, "%u: to B0 - drop DTR/RTS", cs->minor_index);
+		new_state = control_state & ~(TIOCM_DTR | TIOCM_RTS);
+		cs->ops->set_modem_ctrl(cs, control_state, new_state);
+		control_state = new_state;
+	}
+
+	/*
+	 * Update line control register (LCR)
+	 */
+
+	cs->ops->set_line_ctrl(cs, cflag);
+
+#if 0
+	//FIXME this hangs M101 [ts 2005-03-09]
+	//FIXME do we need this?
+	/*
+	 * Set flow control: well, I do not really now how to handle DTR/RTS.
+	 * Just do what we have seen with SniffUSB on Win98.
+	 */
+	/* Drop DTR/RTS if no flow control otherwise assert */
+	gig_dbg(DEBUG_IF, "%u: control_state %x",
+		cs->minor_index, control_state);
+	new_state = control_state;
+	if ((iflag & IXOFF) || (iflag & IXON) || (cflag & CRTSCTS))
+		new_state |= TIOCM_DTR | TIOCM_RTS;
+	else
+		new_state &= ~(TIOCM_DTR | TIOCM_RTS);
+	if (new_state != control_state) {
+		gig_dbg(DEBUG_IF, "%u: new_state %x",
+			cs->minor_index, new_state);
+		gigaset_set_modem_ctrl(cs, control_state, new_state);
+		control_state = new_state;
+	}
+#endif
+
+	/* save off the modified port settings */
+	cs->control_state = control_state;
+
+out:
+	up(&cs->sem);
+}
+
+
+/* wakeup tasklet for the write operation */
+static void if_wake(unsigned long data)
+{
+	struct cardstate *cs = (struct cardstate *) data;
+	struct tty_struct *tty;
+
+	tty = cs->tty;
+	if (!tty)
+		return;
+
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+	    tty->ldisc.write_wakeup) {
+		gig_dbg(DEBUG_IF, "write wakeup call");
+		tty->ldisc.write_wakeup(tty);
+	}
+
+	wake_up_interruptible(&tty->write_wait);
+}
+
+/*** interface to common ***/
+
+void gigaset_if_init(struct cardstate *cs)
+{
+	struct gigaset_driver *drv;
+
+	drv = cs->driver;
+	if (!drv->have_tty)
+		return;
+
+	tasklet_init(&cs->if_wake_tasklet, &if_wake, (unsigned long) cs);
+	tty_register_device(drv->tty, cs->minor_index, NULL);
+}
+
+void gigaset_if_free(struct cardstate *cs)
+{
+	struct gigaset_driver *drv;
+
+	drv = cs->driver;
+	if (!drv->have_tty)
+		return;
+
+	tasklet_disable(&cs->if_wake_tasklet);
+	tasklet_kill(&cs->if_wake_tasklet);
+	tty_unregister_device(drv->tty, cs->minor_index);
+}
+
+void gigaset_if_receive(struct cardstate *cs,
+			unsigned char *buffer, size_t len)
+{
+	unsigned long flags;
+	struct tty_struct *tty;
+
+	spin_lock_irqsave(&cs->lock, flags);
+	if ((tty = cs->tty) == NULL)
+		gig_dbg(DEBUG_ANY, "receive on closed device");
+	else {
+		tty_buffer_request_room(tty, len);
+		tty_insert_flip_string(tty, buffer, len);
+		tty_flip_buffer_push(tty);
+	}
+	spin_unlock_irqrestore(&cs->lock, flags);
+}
+EXPORT_SYMBOL_GPL(gigaset_if_receive);
+
+/* gigaset_if_initdriver
+ * Initialize tty interface.
+ * parameters:
+ *	drv		Driver
+ *	procname	Name of the driver (e.g. for /proc/tty/drivers)
+ *	devname		Name of the device files (prefix without minor number)
+ *	devfsname	Devfs name of the device files without %d
+ */
+void gigaset_if_initdriver(struct gigaset_driver *drv, const char *procname,
+			   const char *devname, const char *devfsname)
+{
+	unsigned minors = drv->minors;
+	int ret;
+	struct tty_driver *tty;
+
+	drv->have_tty = 0;
+
+	if ((drv->tty = alloc_tty_driver(minors)) == NULL)
+		goto enomem;
+	tty = drv->tty;
+
+	tty->magic =		TTY_DRIVER_MAGIC,
+	tty->major =		GIG_MAJOR,
+	tty->type =		TTY_DRIVER_TYPE_SERIAL,
+	tty->subtype =		SERIAL_TYPE_NORMAL,
+	tty->flags =		TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS,
+
+	tty->driver_name =	procname;
+	tty->name =		devname;
+	tty->minor_start =	drv->minor;
+	tty->num =		drv->minors;
+
+	tty->owner =		THIS_MODULE;
+	tty->devfs_name =	devfsname;
+
+	tty->init_termios          = tty_std_termios; //FIXME
+	tty->init_termios.c_cflag  = B9600 | CS8 | CREAD | HUPCL | CLOCAL; //FIXME
+	tty_set_operations(tty, &if_ops);
+
+	ret = tty_register_driver(tty);
+	if (ret < 0) {
+		warn("failed to register tty driver (error %d)", ret);
+		goto error;
+	}
+	gig_dbg(DEBUG_IF, "tty driver initialized");
+	drv->have_tty = 1;
+	return;
+
+enomem:
+	warn("could not allocate tty structures");
+error:
+	if (drv->tty)
+		put_tty_driver(drv->tty);
+}
+
+void gigaset_if_freedriver(struct gigaset_driver *drv)
+{
+	if (!drv->have_tty)
+		return;
+
+	drv->have_tty = 0;
+	tty_unregister_driver(drv->tty);
+	put_tty_driver(drv->tty);
+}
--- linux-2.6.16-rc4.orig/drivers/isdn/gigaset/proc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/isdn/gigaset/proc.c	2006-02-24 00:19:28.000000000 +0100
@@ -0,0 +1,77 @@
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
+
+static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct cardstate *cs = usb_get_intfdata(intf);
+	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode));
+}
+
+static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct cardstate *cs = usb_get_intfdata(intf);
+	long int value;
+	char *end;
+
+	value = simple_strtol(buf, &end, 0);
+	while (*end)
+		if (!isspace(*end++))
+			return -EINVAL;
+	if (value < 0 || value > 1)
+			return -EINVAL;
+
+	if (down_interruptible(&cs->sem))
+		return -ERESTARTSYS; // FIXME -EINTR?
+
+	cs->waiting = 1;
+	if (!gigaset_add_event(cs, &cs->at_state, EV_PROC_CIDMODE,
+			       NULL, value, NULL)) {
+		cs->waiting = 0;
+		up(&cs->sem);
+		return -ENOMEM;
+	}
+
+	gig_dbg(DEBUG_CMD, "scheduling PROC_CIDMODE");
+	gigaset_schedule_event(cs);
+
+	wait_event(cs->waitqueue, !cs->waiting);
+
+	up(&cs->sem);
+
+	return count;
+}
+
+static DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
+
+/* free sysfs for device */
+void gigaset_free_dev_sysfs(struct cardstate *cs)
+{
+	gig_dbg(DEBUG_INIT, "removing sysfs entries");
+	device_remove_file(cs->dev, &dev_attr_cidmode);
+}
+
+/* initialize sysfs for device */
+void gigaset_init_dev_sysfs(struct cardstate *cs)
+{
+	gig_dbg(DEBUG_INIT, "setting up sysfs");
+	device_create_file(cs->dev, &dev_attr_cidmode);
+}
