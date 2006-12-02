Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162781AbWLBEj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162781AbWLBEj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162782AbWLBEj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:39:26 -0500
Received: from mta16.mail.adelphia.net ([68.168.78.211]:34293 "EHLO
	mta16.adelphia.net") by vger.kernel.org with ESMTP id S1162781AbWLBEjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:39:23 -0500
Date: Fri, 1 Dec 2006 22:39:21 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Rocky Craig <rocky.craig@hp.com>
Subject: [PATCH 11/12] IPMI: Fix BT long busy
Message-ID: <20061202043921.GG30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IPMI BT subdriver has been patched to survive "long busy"
timeouts seen during firmware upgrades and resets.  The patch
never returns the HOSED state, synthesizes response messages with
meaningful completion codes, and recovers gracefully when the
hardware finishes the long busy.  The subdriver now issues a "Get BT
Capabilities" command and properly uses those results.
More informative completion codes are returned on error from
transaction starts; this logic was propogated to the KCS and
SMIC subdrivers.  Finally, indent and other style quirks were
normalized.

Signed-off-by: Rocky Craig <rocky.craig@hp.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_bt_sm.c
@@ -33,11 +33,13 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-static int bt_debug = 0x00;	/* Production value 0, see following flags */
+#define BT_DEBUG_OFF	0	/* Used in production */
+#define BT_DEBUG_ENABLE	1	/* Generic messages */
+#define BT_DEBUG_MSG	2	/* Prints all request/response buffers */
+#define BT_DEBUG_STATES	4	/* Verbose look at state changes */
+
+static int bt_debug = BT_DEBUG_OFF;
 
-#define	BT_DEBUG_ENABLE	1
-#define BT_DEBUG_MSG	2
-#define BT_DEBUG_STATES	4
 module_param(bt_debug, int, 0644);
 MODULE_PARM_DESC(bt_debug, "debug bitmask, 1=enable, 2=messages, 4=states");
 
@@ -47,38 +49,54 @@ MODULE_PARM_DESC(bt_debug, "debug bitmas
    Since the Open IPMI architecture is single-message oriented at this
    stage, the queue depth of BT is of no concern. */
 
-#define BT_NORMAL_TIMEOUT	5000000	/* seconds in microseconds */
-#define BT_RETRY_LIMIT		2
-#define BT_RESET_DELAY		6000000	/* 6 seconds after warm reset */
+#define BT_NORMAL_TIMEOUT	5	/* seconds */
+#define BT_NORMAL_RETRY_LIMIT	2
+#define BT_RESET_DELAY		6	/* seconds after warm reset */
+
+/* States are written in chronological order and usually cover
+   multiple rows of the state table discussion in the IPMI spec. */
 
 enum bt_states {
-	BT_STATE_IDLE,
+	BT_STATE_IDLE = 0,	/* Order is critical in this list */
 	BT_STATE_XACTION_START,
 	BT_STATE_WRITE_BYTES,
-	BT_STATE_WRITE_END,
 	BT_STATE_WRITE_CONSUME,
-	BT_STATE_B2H_WAIT,
-	BT_STATE_READ_END,
-	BT_STATE_RESET1,		/* These must come last */
+	BT_STATE_READ_WAIT,
+	BT_STATE_CLEAR_B2H,
+	BT_STATE_READ_BYTES,
+	BT_STATE_RESET1,	/* These must come last */
 	BT_STATE_RESET2,
 	BT_STATE_RESET3,
 	BT_STATE_RESTART,
-	BT_STATE_HOSED
+	BT_STATE_PRINTME,
+	BT_STATE_CAPABILITIES_BEGIN,
+	BT_STATE_CAPABILITIES_END,
+	BT_STATE_LONG_BUSY	/* BT doesn't get hosed :-) */
 };
 
+/* Macros seen at the end of state "case" blocks.  They help with legibility
+   and debugging. */
+
+#define BT_STATE_CHANGE(X,Y) { bt->state = X; return Y; }
+
+#define BT_SI_SM_RETURN(Y)   { last_printed = BT_STATE_PRINTME; return Y; }
+
 struct si_sm_data {
 	enum bt_states	state;
-	enum bt_states	last_state;	/* assist printing and resets */
 	unsigned char	seq;		/* BT sequence number */
 	struct si_sm_io	*io;
-        unsigned char	write_data[IPMI_MAX_MSG_LENGTH];
-        int		write_count;
-        unsigned char	read_data[IPMI_MAX_MSG_LENGTH];
-        int		read_count;
-        int		truncated;
-        long		timeout;
-        unsigned int	error_retries;	/* end of "common" fields */
+	unsigned char	write_data[IPMI_MAX_MSG_LENGTH];
+	int		write_count;
+	unsigned char	read_data[IPMI_MAX_MSG_LENGTH];
+	int		read_count;
+	int		truncated;
+	long		timeout;	/* microseconds countdown */
+	int		error_retries;	/* end of "common" fields */
 	int		nonzero_status;	/* hung BMCs stay all 0 */
+	enum bt_states	complete;	/* to divert the state machine */
+	int		BT_CAP_outreqs;
+	long		BT_CAP_req2rsp;
+	int		BT_CAP_retries;	/* Recommended retries */
 };
 
 #define BT_CLR_WR_PTR	0x01	/* See IPMI 1.5 table 11.6.4 */
@@ -111,86 +129,118 @@ struct si_sm_data {
 static char *state2txt(unsigned char state)
 {
 	switch (state) {
-		case BT_STATE_IDLE:		return("IDLE");
-		case BT_STATE_XACTION_START:	return("XACTION");
-		case BT_STATE_WRITE_BYTES:	return("WR_BYTES");
-		case BT_STATE_WRITE_END:	return("WR_END");
-		case BT_STATE_WRITE_CONSUME:	return("WR_CONSUME");
-		case BT_STATE_B2H_WAIT:		return("B2H_WAIT");
-		case BT_STATE_READ_END:		return("RD_END");
-		case BT_STATE_RESET1:		return("RESET1");
-		case BT_STATE_RESET2:		return("RESET2");
-		case BT_STATE_RESET3:		return("RESET3");
-		case BT_STATE_RESTART:		return("RESTART");
-		case BT_STATE_HOSED:		return("HOSED");
+	case BT_STATE_IDLE:		return("IDLE");
+	case BT_STATE_XACTION_START:	return("XACTION");
+	case BT_STATE_WRITE_BYTES:	return("WR_BYTES");
+	case BT_STATE_WRITE_CONSUME:	return("WR_CONSUME");
+	case BT_STATE_READ_WAIT:	return("RD_WAIT");
+	case BT_STATE_CLEAR_B2H:	return("CLEAR_B2H");
+	case BT_STATE_READ_BYTES:	return("RD_BYTES");
+	case BT_STATE_RESET1:		return("RESET1");
+	case BT_STATE_RESET2:		return("RESET2");
+	case BT_STATE_RESET3:		return("RESET3");
+	case BT_STATE_RESTART:		return("RESTART");
+	case BT_STATE_LONG_BUSY:	return("LONG_BUSY");
+	case BT_STATE_CAPABILITIES_BEGIN: return("CAP_BEGIN");
+	case BT_STATE_CAPABILITIES_END:	return("CAP_END");
 	}
 	return("BAD STATE");
 }
 #define STATE2TXT state2txt(bt->state)
 
-static char *status2txt(unsigned char status, char *buf)
+static char *status2txt(unsigned char status)
 {
+	/*
+	 * This cannot be called by two threads at the same time and
+	 * the buffer is always consumed immediately, so the static is
+	 * safe to use.
+	 */
+	static char buf[40];
+
 	strcpy(buf, "[ ");
-	if (status & BT_B_BUSY) strcat(buf, "B_BUSY ");
-	if (status & BT_H_BUSY) strcat(buf, "H_BUSY ");
-	if (status & BT_OEM0) strcat(buf, "OEM0 ");
-	if (status & BT_SMS_ATN) strcat(buf, "SMS ");
-	if (status & BT_B2H_ATN) strcat(buf, "B2H ");
-	if (status & BT_H2B_ATN) strcat(buf, "H2B ");
+	if (status & BT_B_BUSY)
+		strcat(buf, "B_BUSY ");
+	if (status & BT_H_BUSY)
+		strcat(buf, "H_BUSY ");
+	if (status & BT_OEM0)
+		strcat(buf, "OEM0 ");
+	if (status & BT_SMS_ATN)
+		strcat(buf, "SMS ");
+	if (status & BT_B2H_ATN)
+		strcat(buf, "B2H ");
+	if (status & BT_H2B_ATN)
+		strcat(buf, "H2B ");
 	strcat(buf, "]");
 	return buf;
 }
-#define STATUS2TXT(buf) status2txt(status, buf)
+#define STATUS2TXT status2txt(status)
+
+/* called externally at insmod time, and internally on cleanup */
 
-/* This will be called from within this module on a hosed condition */
-#define FIRST_SEQ	0
 static unsigned int bt_init_data(struct si_sm_data *bt, struct si_sm_io *io)
 {
-	bt->state = BT_STATE_IDLE;
-	bt->last_state = BT_STATE_IDLE;
-	bt->seq = FIRST_SEQ;
-	bt->io = io;
-	bt->write_count = 0;
-	bt->read_count = 0;
-	bt->error_retries = 0;
-	bt->nonzero_status = 0;
-	bt->truncated = 0;
-	bt->timeout = BT_NORMAL_TIMEOUT;
+	memset(bt, 0, sizeof(struct si_sm_data));
+	if (bt->io != io) {		/* external: one-time only things */
+		bt->io = io;
+		bt->seq = 0;
+	}
+	bt->state = BT_STATE_IDLE;	/* start here */
+	bt->complete = BT_STATE_IDLE;	/* end here */
+	bt->BT_CAP_req2rsp = BT_NORMAL_TIMEOUT * 1000000;
+	bt->BT_CAP_retries = BT_NORMAL_RETRY_LIMIT;
+	/* BT_CAP_outreqs == zero is a flag to read BT Capabilities */
 	return 3; /* We claim 3 bytes of space; ought to check SPMI table */
 }
 
+/* Jam a completion code (probably an error) into a response */
+
+static void force_result(struct si_sm_data *bt, unsigned char completion_code)
+{
+	bt->read_data[0] = 4;				/* # following bytes */
+	bt->read_data[1] = bt->write_data[1] | 4;	/* Odd NetFn/LUN */
+	bt->read_data[2] = bt->write_data[2];		/* seq (ignored) */
+	bt->read_data[3] = bt->write_data[3];		/* Command */
+	bt->read_data[4] = completion_code;
+	bt->read_count = 5;
+}
+
+/* The upper state machine starts here */
+
 static int bt_start_transaction(struct si_sm_data *bt,
 				unsigned char *data,
 				unsigned int size)
 {
 	unsigned int i;
 
-	if ((size < 2) || (size > (IPMI_MAX_MSG_LENGTH - 2)))
-	       return -1;
+	if (size < 2)
+		return IPMI_REQ_LEN_INVALID_ERR;
+	if (size > IPMI_MAX_MSG_LENGTH)
+		return IPMI_REQ_LEN_EXCEEDED_ERR;
+
+	if (bt->state == BT_STATE_LONG_BUSY)
+		return IPMI_NODE_BUSY_ERR;
 
-	if ((bt->state != BT_STATE_IDLE) && (bt->state != BT_STATE_HOSED))
-		return -2;
+	if (bt->state != BT_STATE_IDLE)
+		return IPMI_NOT_IN_MY_STATE_ERR;
 
 	if (bt_debug & BT_DEBUG_MSG) {
-    		printk(KERN_WARNING "+++++++++++++++++++++++++++++++++++++\n");
-		printk(KERN_WARNING "BT: write seq=0x%02X:", bt->seq);
+		printk(KERN_WARNING "BT: +++++++++++++++++ New command\n");
+		printk(KERN_WARNING "BT: NetFn/LUN CMD [%d data]:", size - 2);
 		for (i = 0; i < size; i ++)
-		       printk (" %02x", data[i]);
+			printk (" %02x", data[i]);
 		printk("\n");
 	}
 	bt->write_data[0] = size + 1;	/* all data plus seq byte */
 	bt->write_data[1] = *data;	/* NetFn/LUN */
-	bt->write_data[2] = bt->seq;
+	bt->write_data[2] = bt->seq++;
 	memcpy(bt->write_data + 3, data + 1, size - 1);
 	bt->write_count = size + 2;
-
 	bt->error_retries = 0;
 	bt->nonzero_status = 0;
-	bt->read_count = 0;
 	bt->truncated = 0;
 	bt->state = BT_STATE_XACTION_START;
-	bt->last_state = BT_STATE_IDLE;
-	bt->timeout = BT_NORMAL_TIMEOUT;
+	bt->timeout = bt->BT_CAP_req2rsp;
+	force_result(bt, IPMI_ERR_UNSPECIFIED);
 	return 0;
 }
 
@@ -198,38 +248,30 @@ static int bt_start_transaction(struct s
    it calls this.  Strip out the length and seq bytes. */
 
 static int bt_get_result(struct si_sm_data *bt,
-			   unsigned char *data,
-			   unsigned int length)
+			 unsigned char *data,
+			 unsigned int length)
 {
 	int i, msg_len;
 
 	msg_len = bt->read_count - 2;		/* account for length & seq */
-	/* Always NetFn, Cmd, cCode */
 	if (msg_len < 3 || msg_len > IPMI_MAX_MSG_LENGTH) {
-		printk(KERN_DEBUG "BT results: bad msg_len = %d\n", msg_len);
-		data[0] = bt->write_data[1] | 0x4;	/* Kludge a response */
-		data[1] = bt->write_data[3];
-		data[2] = IPMI_ERR_UNSPECIFIED;
+		force_result(bt, IPMI_ERR_UNSPECIFIED);
 		msg_len = 3;
-	} else {
-		data[0] = bt->read_data[1];
-		data[1] = bt->read_data[3];
-		if (length < msg_len)
-		       bt->truncated = 1;
-		if (bt->truncated) {	/* can be set in read_all_bytes() */
-			data[2] = IPMI_ERR_MSG_TRUNCATED;
-			msg_len = 3;
-		} else
-		       memcpy(data + 2, bt->read_data + 4, msg_len - 2);
+	}
+	data[0] = bt->read_data[1];
+	data[1] = bt->read_data[3];
+	if (length < msg_len || bt->truncated) {
+		data[2] = IPMI_ERR_MSG_TRUNCATED;
+		msg_len = 3;
+	} else
+		memcpy(data + 2, bt->read_data + 4, msg_len - 2);
 
-		if (bt_debug & BT_DEBUG_MSG) {
-			printk (KERN_WARNING "BT: res (raw)");
-			for (i = 0; i < msg_len; i++)
-			       printk(" %02x", data[i]);
-			printk ("\n");
-		}
+	if (bt_debug & BT_DEBUG_MSG) {
+		printk (KERN_WARNING "BT: result %d bytes:", msg_len);
+		for (i = 0; i < msg_len; i++)
+			printk(" %02x", data[i]);
+		printk ("\n");
 	}
-	bt->read_count = 0;	/* paranoia */
 	return msg_len;
 }
 
@@ -238,22 +280,40 @@ static int bt_get_result(struct si_sm_da
 
 static void reset_flags(struct si_sm_data *bt)
 {
+	if (bt_debug)
+		printk(KERN_WARNING "IPMI BT: flag reset %s\n",
+					status2txt(BT_STATUS));
 	if (BT_STATUS & BT_H_BUSY)
-	       BT_CONTROL(BT_H_BUSY);
-	if (BT_STATUS & BT_B_BUSY)
-	       BT_CONTROL(BT_B_BUSY);
-	BT_CONTROL(BT_CLR_WR_PTR);
-	BT_CONTROL(BT_SMS_ATN);
-
-	if (BT_STATUS & BT_B2H_ATN) {
-		int i;
-		BT_CONTROL(BT_H_BUSY);
-		BT_CONTROL(BT_B2H_ATN);
-		BT_CONTROL(BT_CLR_RD_PTR);
-		for (i = 0; i < IPMI_MAX_MSG_LENGTH + 2; i++)
-		       BMC2HOST;
-		BT_CONTROL(BT_H_BUSY);
-	}
+		BT_CONTROL(BT_H_BUSY);	/* force clear */
+	BT_CONTROL(BT_CLR_WR_PTR);	/* always reset */
+	BT_CONTROL(BT_SMS_ATN);		/* always clear */
+	BT_INTMASK_W(BT_BMC_HWRST);
+}
+
+/* Get rid of an unwanted/stale response.  This should only be needed for
+   BMCs that support multiple outstanding requests. */
+
+static void drain_BMC2HOST(struct si_sm_data *bt)
+{
+	int i, size;
+
+	if (!(BT_STATUS & BT_B2H_ATN)) 	/* Not signalling a response */
+		return;
+
+	BT_CONTROL(BT_H_BUSY);		/* now set */
+	BT_CONTROL(BT_B2H_ATN);		/* always clear */
+	BT_STATUS;			/* pause */
+	BT_CONTROL(BT_B2H_ATN);		/* some BMCs are stubborn */
+	BT_CONTROL(BT_CLR_RD_PTR);	/* always reset */
+	if (bt_debug)
+		printk(KERN_WARNING "IPMI BT: stale response %s; ",
+			status2txt(BT_STATUS));
+	size = BMC2HOST;
+	for (i = 0; i < size ; i++)
+		BMC2HOST;
+	BT_CONTROL(BT_H_BUSY);		/* now clear */
+	if (bt_debug)
+		printk("drained %d bytes\n", size + 1);
 }
 
 static inline void write_all_bytes(struct si_sm_data *bt)
@@ -261,201 +321,256 @@ static inline void write_all_bytes(struc
 	int i;
 
 	if (bt_debug & BT_DEBUG_MSG) {
-    		printk(KERN_WARNING "BT: write %d bytes seq=0x%02X",
+		printk(KERN_WARNING "BT: write %d bytes seq=0x%02X",
 			bt->write_count, bt->seq);
 		for (i = 0; i < bt->write_count; i++)
 			printk (" %02x", bt->write_data[i]);
 		printk ("\n");
 	}
 	for (i = 0; i < bt->write_count; i++)
-	       HOST2BMC(bt->write_data[i]);
+		HOST2BMC(bt->write_data[i]);
 }
 
 static inline int read_all_bytes(struct si_sm_data *bt)
 {
 	unsigned char i;
 
+	/* length is "framing info", minimum = 4: NetFn, Seq, Cmd, cCode.
+	   Keep layout of first four bytes aligned with write_data[] */
+
 	bt->read_data[0] = BMC2HOST;
 	bt->read_count = bt->read_data[0];
-	if (bt_debug & BT_DEBUG_MSG)
-    		printk(KERN_WARNING "BT: read %d bytes:", bt->read_count);
 
-	/* minimum: length, NetFn, Seq, Cmd, cCode == 5 total, or 4 more
-	   following the length byte. */
 	if (bt->read_count < 4 || bt->read_count >= IPMI_MAX_MSG_LENGTH) {
 		if (bt_debug & BT_DEBUG_MSG)
-			printk("bad length %d\n", bt->read_count);
+			printk(KERN_WARNING "BT: bad raw rsp len=%d\n",
+				bt->read_count);
 		bt->truncated = 1;
 		return 1;	/* let next XACTION START clean it up */
 	}
 	for (i = 1; i <= bt->read_count; i++)
-	       bt->read_data[i] = BMC2HOST;
-	bt->read_count++;	/* account for the length byte */
+		bt->read_data[i] = BMC2HOST;
+	bt->read_count++;	/* Account internally for length byte */
 
 	if (bt_debug & BT_DEBUG_MSG) {
-	    	for (i = 0; i < bt->read_count; i++)
+		int max = bt->read_count;
+
+		printk(KERN_WARNING "BT: got %d bytes seq=0x%02X",
+			max, bt->read_data[2]);
+		if (max > 16)
+			max = 16;
+		for (i = 0; i < max; i++)
 			printk (" %02x", bt->read_data[i]);
-	    	printk ("\n");
+		printk ("%s\n", bt->read_count == max ? "" : " ...");
 	}
-	if (bt->seq != bt->write_data[2])	/* idiot check */
-		printk(KERN_DEBUG "BT: internal error: sequence mismatch\n");
 
-	/* per the spec, the (NetFn, Seq, Cmd) tuples should match */
-	if ((bt->read_data[3] == bt->write_data[3]) &&		/* Cmd */
-        	(bt->read_data[2] == bt->write_data[2]) &&	/* Sequence */
-        	((bt->read_data[1] & 0xF8) == (bt->write_data[1] & 0xF8)))
+	/* per the spec, the (NetFn[1], Seq[2], Cmd[3]) tuples must match */
+	if ((bt->read_data[3] == bt->write_data[3]) &&
+	    (bt->read_data[2] == bt->write_data[2]) &&
+	    ((bt->read_data[1] & 0xF8) == (bt->write_data[1] & 0xF8)))
 			return 1;
 
 	if (bt_debug & BT_DEBUG_MSG)
-	       printk(KERN_WARNING "BT: bad packet: "
+		printk(KERN_WARNING "IPMI BT: bad packet: "
 		"want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n",
-		bt->write_data[1], bt->write_data[2], bt->write_data[3],
+		bt->write_data[1] | 0x04, bt->write_data[2], bt->write_data[3],
 		bt->read_data[1],  bt->read_data[2],  bt->read_data[3]);
 	return 0;
 }
 
-/* Modifies bt->state appropriately, need to get into the bt_event() switch */
+/* Restart if retries are left, or return an error completion code */
 
-static void error_recovery(struct si_sm_data *bt, char *reason)
+static enum si_sm_result error_recovery(struct si_sm_data *bt,
+					unsigned char status,
+					unsigned char cCode)
 {
-	unsigned char status;
-	char buf[40]; /* For getting status */
+	char *reason;
 
-	bt->timeout = BT_NORMAL_TIMEOUT; /* various places want to retry */
+	bt->timeout = bt->BT_CAP_req2rsp;
 
-	status = BT_STATUS;
-	printk(KERN_DEBUG "BT: %s in %s %s\n", reason, STATE2TXT,
-	       STATUS2TXT(buf));
+	switch (cCode) {
+	case IPMI_TIMEOUT_ERR:
+		reason = "timeout";
+		break;
+	default:
+		reason = "internal error";
+		break;
+	}
+
+	printk(KERN_WARNING "IPMI BT: %s in %s %s ", 	/* open-ended line */
+		reason, STATE2TXT, STATUS2TXT);
 
+	/* Per the IPMI spec, retries are based on the sequence number
+	   known only to this module, so manage a restart here. */
 	(bt->error_retries)++;
-	if (bt->error_retries > BT_RETRY_LIMIT) {
-		printk(KERN_DEBUG "retry limit (%d) exceeded\n", BT_RETRY_LIMIT);
-		bt->state = BT_STATE_HOSED;
-		if (!bt->nonzero_status)
-			printk(KERN_ERR "IPMI: BT stuck, try power cycle\n");
-		else if (bt->error_retries <= BT_RETRY_LIMIT + 1) {
-			printk(KERN_DEBUG "IPMI: BT reset (takes 5 secs)\n");
-        		bt->state = BT_STATE_RESET1;
-		}
-	return;
+	if (bt->error_retries < bt->BT_CAP_retries) {
+		printk("%d retries left\n",
+			bt->BT_CAP_retries - bt->error_retries);
+		bt->state = BT_STATE_RESTART;
+		return SI_SM_CALL_WITHOUT_DELAY;
 	}
 
-	/* Sometimes the BMC queues get in an "off-by-one" state...*/
-	if ((bt->state == BT_STATE_B2H_WAIT) && (status & BT_B2H_ATN)) {
-    		printk(KERN_DEBUG "retry B2H_WAIT\n");
-		return;
+	printk("failed %d retries, sending error response\n",
+		bt->BT_CAP_retries);
+	if (!bt->nonzero_status)
+		printk(KERN_ERR "IPMI BT: stuck, try power cycle\n");
+
+	/* this is most likely during insmod */
+	else if (bt->seq <= (unsigned char)(bt->BT_CAP_retries & 0xFF)) {
+		printk(KERN_WARNING "IPMI: BT reset (takes 5 secs)\n");
+		bt->state = BT_STATE_RESET1;
+		return SI_SM_CALL_WITHOUT_DELAY;
 	}
 
-	printk(KERN_DEBUG "restart command\n");
-	bt->state = BT_STATE_RESTART;
+	/* Concoct a useful error message, set up the next state, and
+	   be done with this sequence. */
+
+	bt->state = BT_STATE_IDLE;
+	switch (cCode) {
+	case IPMI_TIMEOUT_ERR:
+		if (status & BT_B_BUSY) {
+			cCode = IPMI_NODE_BUSY_ERR;
+			bt->state = BT_STATE_LONG_BUSY;
+		}
+		break;
+	default:
+		break;
+	}
+	force_result(bt, cCode);
+	return SI_SM_TRANSACTION_COMPLETE;
 }
 
-/* Check the status and (possibly) advance the BT state machine.  The
-   default return is SI_SM_CALL_WITH_DELAY. */
+/* Check status and (usually) take action and change this state machine. */
 
 static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 {
-	unsigned char status;
-	char buf[40]; /* For getting status */
+	unsigned char status, BT_CAP[8];
+	static enum bt_states last_printed = BT_STATE_PRINTME;
 	int i;
 
 	status = BT_STATUS;
 	bt->nonzero_status |= status;
-
-	if ((bt_debug & BT_DEBUG_STATES) && (bt->state != bt->last_state))
+	if ((bt_debug & BT_DEBUG_STATES) && (bt->state != last_printed)) {
 		printk(KERN_WARNING "BT: %s %s TO=%ld - %ld \n",
 			STATE2TXT,
-			STATUS2TXT(buf),
+			STATUS2TXT,
 			bt->timeout,
 			time);
-	bt->last_state = bt->state;
+		last_printed = bt->state;
+	}
 
-	if (bt->state == BT_STATE_HOSED)
-	       return SI_SM_HOSED;
+	/* Commands that time out may still (eventually) provide a response.
+	   This stale response will get in the way of a new response so remove
+	   it if possible (hopefully during IDLE).  Even if it comes up later
+	   it will be rejected by its (now-forgotten) seq number. */
+
+	if ((bt->state < BT_STATE_WRITE_BYTES) && (status & BT_B2H_ATN)) {
+		drain_BMC2HOST(bt);
+		BT_SI_SM_RETURN(SI_SM_CALL_WITH_DELAY);
+	}
 
-	if (bt->state != BT_STATE_IDLE) {	/* do timeout test */
+	if ((bt->state != BT_STATE_IDLE) &&
+	    (bt->state <  BT_STATE_PRINTME)) {		/* check timeout */
 		bt->timeout -= time;
-		if ((bt->timeout < 0) && (bt->state < BT_STATE_RESET1)) {
-			error_recovery(bt, "timed out");
-			return SI_SM_CALL_WITHOUT_DELAY;
-		}
+		if ((bt->timeout < 0) && (bt->state < BT_STATE_RESET1))
+			return error_recovery(bt,
+					      status,
+					      IPMI_TIMEOUT_ERR);
 	}
 
 	switch (bt->state) {
 
-    	case BT_STATE_IDLE:	/* check for asynchronous messages */
+	/* Idle state first checks for asynchronous messages from another
+	   channel, then does some opportunistic housekeeping. */
+
+	case BT_STATE_IDLE:
 		if (status & BT_SMS_ATN) {
 			BT_CONTROL(BT_SMS_ATN);	/* clear it */
 			return SI_SM_ATTN;
 		}
-		return SI_SM_IDLE;
 
-	case BT_STATE_XACTION_START:
-		if (status & BT_H_BUSY) {
+		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
 			BT_CONTROL(BT_H_BUSY);
-			break;
-		}
-    		if (status & BT_B2H_ATN)
-		       break;
-		bt->state = BT_STATE_WRITE_BYTES;
-		return SI_SM_CALL_WITHOUT_DELAY;	/* for logging */
 
-	case BT_STATE_WRITE_BYTES:
+		/* Read BT capabilities if it hasn't been done yet */
+		if (!bt->BT_CAP_outreqs)
+			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
+					SI_SM_CALL_WITHOUT_DELAY);
+		bt->timeout = bt->BT_CAP_req2rsp;
+		BT_SI_SM_RETURN(SI_SM_IDLE);
+
+	case BT_STATE_XACTION_START:
 		if (status & (BT_B_BUSY | BT_H2B_ATN))
-		       break;
+			BT_SI_SM_RETURN(SI_SM_CALL_WITH_DELAY);
+		if (BT_STATUS & BT_H_BUSY)
+			BT_CONTROL(BT_H_BUSY);	/* force clear */
+		BT_STATE_CHANGE(BT_STATE_WRITE_BYTES,
+				SI_SM_CALL_WITHOUT_DELAY);
+
+	case BT_STATE_WRITE_BYTES:
+		if (status & BT_H_BUSY)
+			BT_CONTROL(BT_H_BUSY);	/* clear */
 		BT_CONTROL(BT_CLR_WR_PTR);
 		write_all_bytes(bt);
-		BT_CONTROL(BT_H2B_ATN);	/* clears too fast to catch? */
-		bt->state = BT_STATE_WRITE_CONSUME;
-		return SI_SM_CALL_WITHOUT_DELAY; /* it MIGHT sail through */
-
-	case BT_STATE_WRITE_CONSUME: /* BMCs usually blow right thru here */
-        	if (status & (BT_H2B_ATN | BT_B_BUSY))
-		       break;
-		bt->state = BT_STATE_B2H_WAIT;
-		/* fall through with status */
-
-	/* Stay in BT_STATE_B2H_WAIT until a packet matches.  However, spinning
-	   hard here, constantly reading status, seems to hold off the
-	   generation of B2H_ATN so ALWAYS return CALL_WITH_DELAY. */
-
-	case BT_STATE_B2H_WAIT:
-    		if (!(status & BT_B2H_ATN))
-		       break;
-
-		/* Assume ordered, uncached writes: no need to wait */
-		if (!(status & BT_H_BUSY))
-		       BT_CONTROL(BT_H_BUSY); /* set */
-		BT_CONTROL(BT_B2H_ATN);		/* clear it, ACK to the BMC */
-		BT_CONTROL(BT_CLR_RD_PTR);	/* reset the queue */
-		i = read_all_bytes(bt);
-		BT_CONTROL(BT_H_BUSY);		/* clear */
-		if (!i)				/* Try this state again */
-		       break;
-		bt->state = BT_STATE_READ_END;
-		return SI_SM_CALL_WITHOUT_DELAY;	/* for logging */
-
-    	case BT_STATE_READ_END:
-
-		/* I could wait on BT_H_BUSY to go clear for a truly clean
-		   exit.  However, this is already done in XACTION_START
-		   and the (possible) extra loop/status/possible wait affects
-		   performance.  So, as long as it works, just ignore H_BUSY */
+		BT_CONTROL(BT_H2B_ATN);	/* can clear too fast to catch */
+		BT_STATE_CHANGE(BT_STATE_WRITE_CONSUME,
+				SI_SM_CALL_WITHOUT_DELAY);
 
-#ifdef MAKE_THIS_TRUE_IF_NECESSARY
+	case BT_STATE_WRITE_CONSUME:
+		if (status & (BT_B_BUSY | BT_H2B_ATN))
+			BT_SI_SM_RETURN(SI_SM_CALL_WITH_DELAY);
+		BT_STATE_CHANGE(BT_STATE_READ_WAIT,
+				SI_SM_CALL_WITHOUT_DELAY);
+
+	/* Spinning hard can suppress B2H_ATN and force a timeout */
+
+	case BT_STATE_READ_WAIT:
+		if (!(status & BT_B2H_ATN))
+			BT_SI_SM_RETURN(SI_SM_CALL_WITH_DELAY);
+		BT_CONTROL(BT_H_BUSY);		/* set */
+
+		/* Uncached, ordered writes should just proceeed serially but
+		   some BMCs don't clear B2H_ATN with one hit.  Fast-path a
+		   workaround without too much penalty to the general case. */
+
+		BT_CONTROL(BT_B2H_ATN);		/* clear it to ACK the BMC */
+		BT_STATE_CHANGE(BT_STATE_CLEAR_B2H,
+				SI_SM_CALL_WITHOUT_DELAY);
+
+	case BT_STATE_CLEAR_B2H:
+		if (status & BT_B2H_ATN) {	/* keep hitting it */
+			BT_CONTROL(BT_B2H_ATN);
+			BT_SI_SM_RETURN(SI_SM_CALL_WITH_DELAY);
+		}
+		BT_STATE_CHANGE(BT_STATE_READ_BYTES,
+				SI_SM_CALL_WITHOUT_DELAY);
 
-		if (status & BT_H_BUSY)
-		       break;
-#endif
-		bt->seq++;
-		bt->state = BT_STATE_IDLE;
-		return SI_SM_TRANSACTION_COMPLETE;
+	case BT_STATE_READ_BYTES:
+		if (!(status & BT_H_BUSY))	/* check in case of retry */
+			BT_CONTROL(BT_H_BUSY);
+		BT_CONTROL(BT_CLR_RD_PTR);	/* start of BMC2HOST buffer */
+		i = read_all_bytes(bt);		/* true == packet seq match */
+		BT_CONTROL(BT_H_BUSY);		/* NOW clear */
+		if (!i) 			/* Not my message */
+			BT_STATE_CHANGE(BT_STATE_READ_WAIT,
+					SI_SM_CALL_WITHOUT_DELAY);
+		bt->state = bt->complete;
+		return bt->state == BT_STATE_IDLE ?	/* where to next? */
+			SI_SM_TRANSACTION_COMPLETE :	/* normal */
+			SI_SM_CALL_WITHOUT_DELAY;	/* Startup magic */
+
+	case BT_STATE_LONG_BUSY:	/* For example: after FW update */
+		if (!(status & BT_B_BUSY)) {
+			reset_flags(bt);	/* next state is now IDLE */
+			bt_init_data(bt, bt->io);
+		}
+		return SI_SM_CALL_WITH_DELAY;	/* No repeat printing */
 
 	case BT_STATE_RESET1:
-    		reset_flags(bt);
-    		bt->timeout = BT_RESET_DELAY;
-		bt->state = BT_STATE_RESET2;
-		break;
+		reset_flags(bt);
+		drain_BMC2HOST(bt);
+		BT_STATE_CHANGE(BT_STATE_RESET2,
+				SI_SM_CALL_WITH_DELAY);
 
 	case BT_STATE_RESET2:		/* Send a soft reset */
 		BT_CONTROL(BT_CLR_WR_PTR);
@@ -464,29 +579,59 @@ static enum si_sm_result bt_event(struct
 		HOST2BMC(42);		/* Sequence number */
 		HOST2BMC(3);		/* Cmd == Soft reset */
 		BT_CONTROL(BT_H2B_ATN);
-		bt->state = BT_STATE_RESET3;
-		break;
+		bt->timeout = BT_RESET_DELAY * 1000000;
+		BT_STATE_CHANGE(BT_STATE_RESET3,
+				SI_SM_CALL_WITH_DELAY);
 
-	case BT_STATE_RESET3:
+	case BT_STATE_RESET3:		/* Hold off everything for a bit */
 		if (bt->timeout > 0)
-		       return SI_SM_CALL_WITH_DELAY;
-		bt->state = BT_STATE_RESTART;	/* printk in debug modes */
-		break;
+			return SI_SM_CALL_WITH_DELAY;
+		drain_BMC2HOST(bt);
+		BT_STATE_CHANGE(BT_STATE_RESTART,
+				SI_SM_CALL_WITH_DELAY);
 
-	case BT_STATE_RESTART:		/* don't reset retries! */
-		reset_flags(bt);
-		bt->write_data[2] = ++bt->seq;
+	case BT_STATE_RESTART:		/* don't reset retries or seq! */
 		bt->read_count = 0;
 		bt->nonzero_status = 0;
-		bt->timeout = BT_NORMAL_TIMEOUT;
-		bt->state = BT_STATE_XACTION_START;
-		break;
-
-	default:	/* HOSED is supposed to be caught much earlier */
-		error_recovery(bt, "internal logic error");
-		break;
-  	}
-  	return SI_SM_CALL_WITH_DELAY;
+		bt->timeout = bt->BT_CAP_req2rsp;
+		BT_STATE_CHANGE(BT_STATE_XACTION_START,
+				SI_SM_CALL_WITH_DELAY);
+
+	/* Get BT Capabilities, using timing of upper level state machine.
+	   Set outreqs to prevent infinite loop on timeout. */
+	case BT_STATE_CAPABILITIES_BEGIN:
+		bt->BT_CAP_outreqs = 1;
+		{
+			unsigned char GetBT_CAP[] = { 0x18, 0x36 };
+			bt->state = BT_STATE_IDLE;
+			bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
+		}
+		bt->complete = BT_STATE_CAPABILITIES_END;
+		BT_STATE_CHANGE(BT_STATE_XACTION_START,
+				SI_SM_CALL_WITH_DELAY);
+
+	case BT_STATE_CAPABILITIES_END:
+		i = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
+		bt_init_data(bt, bt->io);
+		if ((i == 8) && !BT_CAP[2]) {
+			bt->BT_CAP_outreqs = BT_CAP[3];
+			bt->BT_CAP_req2rsp = BT_CAP[6] * 1000000;
+			bt->BT_CAP_retries = BT_CAP[7];
+		} else
+			printk(KERN_WARNING "IPMI BT: using default values\n");
+		if (!bt->BT_CAP_outreqs)
+			bt->BT_CAP_outreqs = 1;
+		printk(KERN_WARNING "IPMI BT: req2rsp=%ld secs retries=%d\n",
+			bt->BT_CAP_req2rsp / 1000000L, bt->BT_CAP_retries);
+		bt->timeout = bt->BT_CAP_req2rsp;
+		return SI_SM_CALL_WITHOUT_DELAY;
+
+	default:	/* should never occur */
+		return error_recovery(bt,
+				      status,
+				      IPMI_ERR_UNSPECIFIED);
+	}
+	return SI_SM_CALL_WITH_DELAY;
 }
 
 static int bt_detect(struct si_sm_data *bt)
@@ -497,7 +642,7 @@ static int bt_detect(struct si_sm_data *
 	   test that first.  The calling routine uses negative logic. */
 
 	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF))
-	       return 1;
+		return 1;
 	reset_flags(bt);
 	return 0;
 }
@@ -513,11 +658,11 @@ static int bt_size(void)
 
 struct si_sm_handlers bt_smi_handlers =
 {
-	.init_data         = bt_init_data,
-	.start_transaction = bt_start_transaction,
-	.get_result        = bt_get_result,
-	.event             = bt_event,
-	.detect            = bt_detect,
-	.cleanup           = bt_cleanup,
-	.size              = bt_size,
+	.init_data		= bt_init_data,
+	.start_transaction	= bt_start_transaction,
+	.get_result		= bt_get_result,
+	.event			= bt_event,
+	.detect			= bt_detect,
+	.cleanup		= bt_cleanup,
+	.size			= bt_size,
 };
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_kcs_sm.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -261,12 +261,14 @@ static int start_kcs_transaction(struct 
 {
 	unsigned int i;
 
-	if ((size < 2) || (size > MAX_KCS_WRITE_SIZE)) {
-		return -1;
-	}
-	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
-		return -2;
-	}
+	if (size < 2)
+		return IPMI_REQ_LEN_INVALID_ERR;
+	if (size > MAX_KCS_WRITE_SIZE)
+		return IPMI_REQ_LEN_EXCEEDED_ERR;
+
+	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED))
+		return IPMI_NOT_IN_MY_STATE_ERR;
+
 	if (kcs_debug & KCS_DEBUG_MSG) {
 		printk(KERN_DEBUG "start_kcs_transaction -");
 		for (i = 0; i < size; i ++) {
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -247,14 +247,18 @@ static void deliver_recv_msg(struct smi_
 	spin_lock(&(smi_info->si_lock));
 }
 
-static void return_hosed_msg(struct smi_info *smi_info)
+static void return_hosed_msg(struct smi_info *smi_info, int cCode)
 {
 	struct ipmi_smi_msg *msg = smi_info->curr_msg;
 
+	if (cCode < 0 || cCode > IPMI_ERR_UNSPECIFIED)
+		cCode = IPMI_ERR_UNSPECIFIED;
+	/* else use it as is */
+
 	/* Make it a reponse */
 	msg->rsp[0] = msg->data[0] | 4;
 	msg->rsp[1] = msg->data[1];
-	msg->rsp[2] = IPMI_ERR_UNSPECIFIED;
+	msg->rsp[2] = cCode;
 	msg->rsp_size = 3;
 
 	smi_info->curr_msg = NULL;
@@ -305,7 +309,7 @@ static enum si_sm_result start_next_msg(
 			smi_info->curr_msg->data,
 			smi_info->curr_msg->data_size);
 		if (err) {
-			return_hosed_msg(smi_info);
+			return_hosed_msg(smi_info, err);
 		}
 
 		rv = SI_SM_CALL_WITHOUT_DELAY;
@@ -647,7 +651,7 @@ static enum si_sm_result smi_event_handl
 			/* If we were handling a user message, format
                            a response to send to the upper layer to
                            tell it about the error. */
-			return_hosed_msg(smi_info);
+			return_hosed_msg(smi_info, IPMI_ERR_UNSPECIFIED);
 		}
 		si_sm_result = smi_info->handlers->event(smi_info->si_sm, 0);
 	}
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_smic_sm.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_smic_sm.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_smic_sm.c
@@ -141,12 +141,14 @@ static int start_smic_transaction(struct
 {
 	unsigned int i;
 
-	if ((size < 2) || (size > MAX_SMIC_WRITE_SIZE)) {
-		return -1;
-	}
-	if ((smic->state != SMIC_IDLE) && (smic->state != SMIC_HOSED)) {
-		return -2;
-	}
+	if (size < 2)
+		return IPMI_REQ_LEN_INVALID_ERR;
+	if (size > MAX_SMIC_WRITE_SIZE)
+		return IPMI_REQ_LEN_EXCEEDED_ERR;
+
+	if ((smic->state != SMIC_IDLE) && (smic->state != SMIC_HOSED))
+		return IPMI_NOT_IN_MY_STATE_ERR;
+
 	if (smic_debug & SMIC_DEBUG_MSG) {
 		printk(KERN_INFO "start_smic_transaction -");
 		for (i = 0; i < size; i ++) {
Index: linux-2.6.19-rc6/include/linux/ipmi_msgdefs.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/ipmi_msgdefs.h
+++ linux-2.6.19-rc6/include/linux/ipmi_msgdefs.h
@@ -71,14 +71,18 @@
 /* The BT interface on high-end HP systems supports up to 255 bytes in
  * one transfer.  Its "virtual" BMC supports some commands that are longer
  * than 128 bytes.  Use the full 256, plus NetFn/LUN, Cmd, cCode, plus
- * some overhead.  It would be nice to base this on the "BT Capabilities"
- * but that's too hard to propagate to the rest of the driver. */
+ * some overhead; it's not worth the effort to dynamically size this based
+ * on the results of the "Get BT Capabilities" command. */
 #define IPMI_MAX_MSG_LENGTH	272	/* multiple of 16 */
 
 #define IPMI_CC_NO_ERROR		0x00
 #define IPMI_NODE_BUSY_ERR		0xc0
 #define IPMI_INVALID_COMMAND_ERR	0xc1
+#define IPMI_TIMEOUT_ERR		0xc3
 #define IPMI_ERR_MSG_TRUNCATED		0xc6
+#define IPMI_REQ_LEN_INVALID_ERR	0xc7
+#define IPMI_REQ_LEN_EXCEEDED_ERR	0xc8
+#define IPMI_NOT_IN_MY_STATE_ERR	0xd5	/* IPMI 2.0 */
 #define IPMI_LOST_ARBITRATION_ERR	0x81
 #define IPMI_BUS_ERR			0x82
 #define IPMI_NAK_ON_WRITE_ERR		0x83
