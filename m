Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWDDACq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWDDACq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWDDAC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:02:29 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:10935 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964892AbWDCX7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:32 -0400
Date: Tue, 4 Apr 2006 02:00:26 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/13] isdn4linux: Siemens Gigaset drivers - remove IFNULL macros
Message-ID: <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch removes the IFNULL debugging macros from the Gigaset
drivers. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c   |   27 +----
 drivers/isdn/gigaset/bas-gigaset.c |  174 ++++++-------------------------------
 drivers/isdn/gigaset/ev-layer.c    |   30 ------
 drivers/isdn/gigaset/gigaset.h     |   27 -----
 drivers/isdn/gigaset/isocdata.c    |   14 --
 drivers/isdn/gigaset/usb-gigaset.c |   27 -----
 6 files changed, 43 insertions(+), 256 deletions(-)

--- linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:41:27.000000000 +0200
+++ linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:42:01.000000000 +0200
@@ -72,33 +72,6 @@
 
 #define MAXACT 3
 
-#define IFNULL(a) \
-	if (unlikely(!(a)))
-
-#define IFNULLRET(a) \
-	if (unlikely(!(a))) { \
-		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
-		return; \
-	}
-
-#define IFNULLRETVAL(a,b) \
-	if (unlikely(!(a))) { \
-		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
-		return (b); \
-	}
-
-#define IFNULLCONT(a) \
-	if (unlikely(!(a))) { \
-		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
-		continue; \
-	}
-
-#define IFNULLGOTO(a,b) \
-	if (unlikely(!(a))) { \
-		err("%s==NULL at %s:%d!", #a, __FILE__, __LINE__); \
-		goto b; \
-	}
-
 extern int gigaset_debuglevel;	/* "needs" cast to (enum debuglevel) */
 
 /* any combination of these can be given with the 'debug=' parameter to insmod,
--- linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/ev-layer.c	2006-04-02 18:42:01.000000000 +0200
@@ -442,8 +442,6 @@ static int isdn_getnum(char *p)
 {
 	int v = -1;
 
-	IFNULLRETVAL(p, -1);
-
 	gig_dbg(DEBUG_TRANSCMD, "string: %s", p);
 
 	while (*p >= '0' && *p <= '9')
@@ -461,8 +459,6 @@ static int isdn_gethex(char *p)
 	int v = 0;
 	int c;
 
-	IFNULLRETVAL(p, -1);
-
 	gig_dbg(DEBUG_TRANSCMD, "string: %s", p);
 
 	if (!*p)
@@ -532,8 +528,6 @@ void gigaset_handle_modem_response(struc
 	int cid;
 	int rawstring;
 
-	IFNULLRET(cs);
-
 	len = cs->cbytes;
 	if (!len) {
 		/* ignore additional LFs/CRs (M10x config mode or cx100) */
@@ -737,14 +731,8 @@ EXPORT_SYMBOL_GPL(gigaset_handle_modem_r
 static void disconnect(struct at_state_t **at_state_p)
 {
 	unsigned long flags;
-	struct bc_state *bcs;
-	struct cardstate *cs;
-
-	IFNULLRET(at_state_p);
-	IFNULLRET(*at_state_p);
-	bcs = (*at_state_p)->bcs;
-	cs = (*at_state_p)->cs;
-	IFNULLRET(cs);
+	struct bc_state *bcs = (*at_state_p)->bcs;
+	struct cardstate *cs = (*at_state_p)->cs;
 
 	new_index(&(*at_state_p)->seq_index, MAX_SEQ_INDEX);
 
@@ -912,9 +900,6 @@ static struct at_state_t *at_state_from_
 
 static void bchannel_down(struct bc_state *bcs)
 {
-	IFNULLRET(bcs);
-	IFNULLRET(bcs->cs);
-
 	if (bcs->chstate & CHS_B_UP) {
 		bcs->chstate &= ~CHS_B_UP;
 		gigaset_i4l_channel_cmd(bcs, ISDN_STAT_BHUP);
@@ -932,8 +917,6 @@ static void bchannel_down(struct bc_stat
 
 static void bchannel_up(struct bc_state *bcs)
 {
-	IFNULLRET(bcs);
-
 	if (!(bcs->chstate & CHS_D_UP)) {
 		dev_notice(bcs->cs->dev, "%s: D channel not up\n", __func__);
 		bcs->chstate |= CHS_D_UP;
@@ -1607,9 +1590,6 @@ static void process_event(struct cardsta
 	int curact;
 	unsigned long flags;
 
-	IFNULLRET(cs);
-	IFNULLRET(ev);
-
 	if (ev->cid >= 0) {
 		at_state = at_state_from_cid(cs, ev->cid);
 		if (!at_state) {
@@ -1634,7 +1614,6 @@ static void process_event(struct cardsta
 
 	/* Setting the pointer to the dial array */
 	rep = at_state->replystruct;
-	IFNULLRET(rep);
 
 	if (ev->type == EV_TIMEOUT) {
 		if (ev->parameter != atomic_read(&at_state->timer_index)
@@ -1746,8 +1725,6 @@ static void process_command_flags(struct
 	int i;
 	int sequence;
 
-	IFNULLRET(cs);
-
 	atomic_set(&cs->commands_pending, 0);
 
 	if (cs->cur_at_seq) {
@@ -1968,9 +1945,6 @@ void gigaset_handle_event(unsigned long 
 {
 	struct cardstate *cs = (struct cardstate *) data;
 
-	IFNULLRET(cs);
-	IFNULLRET(cs->inbuf);
-
 	/* handle incoming data on control/common channel */
 	if (atomic_read(&cs->inbuf->head) != atomic_read(&cs->inbuf->tail)) {
 		gig_dbg(DEBUG_INTR, "processing new data");
--- linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:41:27.000000000 +0200
+++ linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:42:01.000000000 +0200
@@ -205,7 +205,6 @@ static inline void dump_urb(enum debugle
 {
 #ifdef CONFIG_GIGASET_DEBUG
 	int i;
-	IFNULLRET(tag);
 	gig_dbg(level, "%s urb(0x%08lx)->{", tag, (unsigned long) urb);
 	if (urb) {
 		gig_dbg(level,
@@ -309,8 +308,6 @@ static void check_pending(struct bas_car
 {
 	unsigned long flags;
 
-	IFNULLRET(ucs);
-
 	spin_lock_irqsave(&ucs->lock, flags);
 	switch (ucs->pending) {
 	case 0:
@@ -366,13 +363,9 @@ static void check_pending(struct bas_car
 static void cmd_in_timeout(unsigned long data)
 {
 	struct cardstate *cs = (struct cardstate *) data;
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	unsigned long flags;
 
-	IFNULLRET(cs);
-	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
-
 	spin_lock_irqsave(&cs->lock, flags);
 	if (unlikely(!atomic_read(&cs->connected))) {
 		gig_dbg(DEBUG_USBREQ, "%s: disconnected", __func__);
@@ -406,14 +399,9 @@ static void read_ctrl_callback(struct ur
  */
 static int atread_submit(struct cardstate *cs, int timeout)
 {
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	int ret;
 
-	IFNULLRETVAL(cs, -EINVAL);
-	ucs = cs->hw.bas;
-	IFNULLRETVAL(ucs, -EINVAL);
-	IFNULLRETVAL(ucs->urb_cmd_in, -EINVAL);
-
 	gig_dbg(DEBUG_USBREQ, "-------> HD_READ_ATMESSAGE (%d)",
 		ucs->rcvbuf_size);
 
@@ -479,20 +467,14 @@ inline static void update_basstate(struc
  */
 static void read_int_callback(struct urb *urb, struct pt_regs *regs)
 {
-	struct cardstate *cs;
-	struct bas_cardstate *ucs;
+	struct cardstate *cs = urb->context;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	struct bc_state *bcs;
 	unsigned long flags;
 	int status;
 	unsigned l;
 	int channel;
 
-	IFNULLRET(urb);
-	cs = (struct cardstate *) urb->context;
-	IFNULLRET(cs);
-	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
-
 	if (unlikely(!atomic_read(&cs->connected))) {
 		warn("%s: disconnected", __func__);
 		return;
@@ -638,20 +620,12 @@ resubmit:
  */
 static void read_ctrl_callback(struct urb *urb, struct pt_regs *regs)
 {
-	struct cardstate *cs;
-	struct bas_cardstate *ucs;
+	struct inbuf_t *inbuf = urb->context;
+	struct cardstate *cs = inbuf->cs;
+	struct bas_cardstate *ucs = cs->hw.bas;
+	int have_data = 0;
 	unsigned numbytes;
 	unsigned long flags;
-	struct inbuf_t *inbuf;
-	int have_data = 0;
-
-	IFNULLRET(urb);
-	inbuf = (struct inbuf_t *) urb->context;
-	IFNULLRET(inbuf);
-	cs = inbuf->cs;
-	IFNULLRET(cs);
-	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
 
 	spin_lock_irqsave(&cs->lock, flags);
 	if (unlikely(!atomic_read(&cs->connected))) {
@@ -747,10 +721,6 @@ static void read_iso_callback(struct urb
 	unsigned long flags;
 	int i, rc;
 
-	IFNULLRET(urb);
-	IFNULLRET(urb->context);
-	IFNULLRET(cardstate);
-
 	/* status codes not worth bothering the tasklet with */
 	if (unlikely(urb->status == -ENOENT || urb->status == -ECONNRESET ||
 		     urb->status == -EINPROGRESS)) {
@@ -759,9 +729,8 @@ static void read_iso_callback(struct urb
 		return;
 	}
 
-	bcs = (struct bc_state *) urb->context;
+	bcs = urb->context;
 	ubc = bcs->hw.bas;
-	IFNULLRET(ubc);
 
 	spin_lock_irqsave(&ubc->isoinlock, flags);
 	if (likely(ubc->isoindone == NULL)) {
@@ -813,10 +782,6 @@ static void write_iso_callback(struct ur
 	struct bas_bc_state *ubc;
 	unsigned long flags;
 
-	IFNULLRET(urb);
-	IFNULLRET(urb->context);
-	IFNULLRET(cardstate);
-
 	/* status codes not worth bothering the tasklet with */
 	if (unlikely(urb->status == -ENOENT || urb->status == -ECONNRESET ||
 		     urb->status == -EINPROGRESS)) {
@@ -826,10 +791,8 @@ static void write_iso_callback(struct ur
 	}
 
 	/* pass URB context to tasklet */
-	ucx = (struct isow_urbctx_t *) urb->context;
-	IFNULLRET(ucx->bcs);
+	ucx = urb->context;
 	ubc = ucx->bcs->hw.bas;
-	IFNULLRET(ubc);
 
 	spin_lock_irqsave(&ubc->isooutlock, flags);
 	ubc->isooutovfl = ubc->isooutdone;
@@ -848,15 +811,11 @@ static void write_iso_callback(struct ur
  */
 static int starturbs(struct bc_state *bcs)
 {
+	struct bas_bc_state *ubc = bcs->hw.bas;
 	struct urb *urb;
-	struct bas_bc_state *ubc;
 	int j, k;
 	int rc;
 
-	IFNULLRETVAL(bcs, -EFAULT);
-	ubc = bcs->hw.bas;
-	IFNULLRETVAL(ubc, -EFAULT);
-
 	/* initialize L2 reception */
 	if (bcs->proto2 == ISDN_PROTO_L2_HDLC)
 		bcs->inputstate |= INS_flag_hunt;
@@ -955,8 +914,6 @@ static void stopurbs(struct bas_bc_state
 {
 	int k, rc;
 
-	IFNULLRET(ubc);
-
 	atomic_set(&ubc->running, 0);
 
 	for (k = 0; k < BAS_INURBS; ++k) {
@@ -988,18 +945,11 @@ static void stopurbs(struct bas_bc_state
  */
 static int submit_iso_write_urb(struct isow_urbctx_t *ucx)
 {
-	struct urb *urb;
-	struct bas_bc_state *ubc;
+	struct urb *urb = ucx->urb;
+	struct bas_bc_state *ubc = ucx->bcs->hw.bas;
 	struct usb_iso_packet_descriptor *ifd;
 	int corrbytes, nframe, rc;
 
-	IFNULLRETVAL(ucx, -EFAULT);
-	urb = ucx->urb;
-	IFNULLRETVAL(urb, -EFAULT);
-	IFNULLRETVAL(ucx->bcs, -EFAULT);
-	ubc = ucx->bcs->hw.bas;
-	IFNULLRETVAL(ubc, -EFAULT);
-
 	/* urb->dev is clobbered by USB subsystem */
 	urb->dev = ucx->bcs->cs->hw.bas->udev;
 	urb->transfer_flags = URB_ISO_ASAP;
@@ -1065,9 +1015,9 @@ static int submit_iso_write_urb(struct i
  */
 static void write_iso_tasklet(unsigned long data)
 {
-	struct bc_state *bcs;
-	struct bas_bc_state *ubc;
-	struct cardstate *cs;
+	struct bc_state *bcs = (struct bc_state *) data;
+	struct bas_bc_state *ubc = bcs->hw.bas;
+	struct cardstate *cs = bcs->cs;
 	struct isow_urbctx_t *done, *next, *ovfl;
 	struct urb *urb;
 	struct usb_iso_packet_descriptor *ifd;
@@ -1077,13 +1027,6 @@ static void write_iso_tasklet(unsigned l
 	struct sk_buff *skb;
 	int len;
 
-	bcs = (struct bc_state *) data;
-	IFNULLRET(bcs);
-	ubc = bcs->hw.bas;
-	IFNULLRET(ubc);
-	cs = bcs->cs;
-	IFNULLRET(cs);
-
 	/* loop while completed URBs arrive in time */
 	for (;;) {
 		if (unlikely(!atomic_read(&cs->connected))) {
@@ -1237,21 +1180,14 @@ static void write_iso_tasklet(unsigned l
  */
 static void read_iso_tasklet(unsigned long data)
 {
-	struct bc_state *bcs;
-	struct bas_bc_state *ubc;
-	struct cardstate *cs;
+	struct bc_state *bcs = (struct bc_state *) data;
+	struct bas_bc_state *ubc = bcs->hw.bas;
+	struct cardstate *cs = bcs->cs;
 	struct urb *urb;
 	char *rcvbuf;
 	unsigned long flags;
 	int totleft, numbytes, offset, frame, rc;
 
-	bcs = (struct bc_state *) data;
-	IFNULLRET(bcs);
-	ubc = bcs->hw.bas;
-	IFNULLRET(ubc);
-	cs = bcs->cs;
-	IFNULLRET(cs);
-
 	/* loop while more completed URBs arrive in the meantime */
 	for (;;) {
 		if (unlikely(!atomic_read(&cs->connected))) {
@@ -1383,15 +1319,10 @@ static void read_iso_tasklet(unsigned lo
 static void req_timeout(unsigned long data)
 {
 	struct bc_state *bcs = (struct bc_state *) data;
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = bcs->cs->hw.bas;
 	int pending;
 	unsigned long flags;
 
-	IFNULLRET(bcs);
-	IFNULLRET(bcs->cs);
-	ucs = bcs->cs->hw.bas;
-	IFNULLRET(ucs);
-
 	check_pending(ucs);
 
 	spin_lock_irqsave(&ucs->lock, flags);
@@ -1441,14 +1372,9 @@ static void req_timeout(unsigned long da
  */
 static void write_ctrl_callback(struct urb *urb, struct pt_regs *regs)
 {
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = urb->context;
 	unsigned long flags;
 
-	IFNULLRET(urb);
-	IFNULLRET(urb->context);
-	IFNULLRET(cardstate);
-
-	ucs = (struct bas_cardstate *) urb->context;
 	spin_lock_irqsave(&ucs->lock, flags);
 	if (urb->status && ucs->pending) {
 		dev_err(&ucs->interface->dev,
@@ -1482,16 +1408,10 @@ static void write_ctrl_callback(struct u
  */
 static int req_submit(struct bc_state *bcs, int req, int val, int timeout)
 {
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = bcs->cs->hw.bas;
 	int ret;
 	unsigned long flags;
 
-	IFNULLRETVAL(bcs, -EINVAL);
-	IFNULLRETVAL(bcs->cs, -EINVAL);
-	ucs = bcs->cs->hw.bas;
-	IFNULLRETVAL(ucs, -EINVAL);
-	IFNULLRETVAL(ucs->urb_ctrl, -EINVAL);
-
 	gig_dbg(DEBUG_USBREQ, "-------> 0x%02x (%d)", req, val);
 
 	spin_lock_irqsave(&ucs->lock, flags);
@@ -1551,8 +1471,6 @@ static int gigaset_init_bchannel(struct 
 {
 	int req, ret;
 
-	IFNULLRETVAL(bcs, -EINVAL);
-
 	if ((ret = starturbs(bcs)) < 0) {
 		dev_err(bcs->cs->dev,
 			"could not start isochronous I/O for channel %d\n",
@@ -1585,8 +1503,6 @@ static int gigaset_close_bchannel(struct
 {
 	int req, ret;
 
-	IFNULLRETVAL(bcs, -EINVAL);
-
 	if (!(atomic_read(&bcs->cs->hw.bas->basstate) &
 	      (bcs->channel ? BS_B2OPEN : BS_B1OPEN))) {
 		/* channel not running: just signal common.c */
@@ -1613,11 +1529,7 @@ static int gigaset_close_bchannel(struct
  */
 static void complete_cb(struct cardstate *cs)
 {
-	struct cmdbuf_t *cb;
-
-	IFNULLRET(cs);
-	cb = cs->cmdbuf;
-	IFNULLRET(cb);
+	struct cmdbuf_t *cb = cs->cmdbuf;
 
 	/* unqueue completed buffer */
 	cs->cmdbytes -= cs->curlen;
@@ -1649,15 +1561,9 @@ static int atwrite_submit(struct cardsta
  */
 static void write_command_callback(struct urb *urb, struct pt_regs *regs)
 {
-	struct cardstate *cs;
+	struct cardstate *cs = urb->context;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	unsigned long flags;
-	struct bas_cardstate *ucs;
-
-	IFNULLRET(urb);
-	cs = (struct cardstate *) urb->context;
-	IFNULLRET(cs);
-	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
 
 	/* check status */
 	switch (urb->status) {
@@ -1709,11 +1615,7 @@ static void write_command_callback(struc
 static void atrdy_timeout(unsigned long data)
 {
 	struct cardstate *cs = (struct cardstate *) data;
-	struct bas_cardstate *ucs;
-
-	IFNULLRET(cs);
-	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
+	struct bas_cardstate *ucs = cs->hw.bas;
 
 	dev_warn(cs->dev, "timeout waiting for HD_READY_SEND_ATDATA\n");
 
@@ -1736,14 +1638,9 @@ static void atrdy_timeout(unsigned long 
  */
 static int atwrite_submit(struct cardstate *cs, unsigned char *buf, int len)
 {
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	int ret;
 
-	IFNULLRETVAL(cs, -EFAULT);
-	ucs = cs->hw.bas;
-	IFNULLRETVAL(ucs, -EFAULT);
-	IFNULLRETVAL(ucs->urb_cmd_out, -EFAULT);
-
 	gig_dbg(DEBUG_USBREQ, "-------> HD_WRITE_ATMESSAGE (%d)", len);
 
 	if (ucs->urb_cmd_out->status == -EINPROGRESS) {
@@ -1795,15 +1692,11 @@ static int atwrite_submit(struct cardsta
 static int start_cbsend(struct cardstate *cs)
 {
 	struct cmdbuf_t *cb;
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	unsigned long flags;
 	int rc;
 	int retval = 0;
 
-	IFNULLRETVAL(cs, -EFAULT);
-	ucs = cs->hw.bas;
-	IFNULLRETVAL(ucs, -EFAULT);
-
 	/* check if AT channel is open */
 	if (!(atomic_read(&ucs->basstate) & BS_ATOPEN)) {
 		gig_dbg(DEBUG_TRANSCMD|DEBUG_LOCKCMD, "AT channel not open");
@@ -2084,17 +1977,12 @@ static int gigaset_initcshw(struct cards
  */
 static void freeurbs(struct cardstate *cs)
 {
-	struct bas_cardstate *ucs;
+	struct bas_cardstate *ucs = cs->hw.bas;
 	struct bas_bc_state *ubc;
 	int i, j;
 
-	IFNULLRET(cs);
-	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
-
 	for (j = 0; j < 2; ++j) {
 		ubc = cs->bcs[j].hw.bas;
-		IFNULLCONT(ubc);
 		for (i = 0; i < BAS_OUTURBS; ++i)
 			if (ubc->isoouturbs[i].urb) {
 				usb_kill_urb(ubc->isoouturbs[i].urb);
@@ -2160,8 +2048,6 @@ static int gigaset_probe(struct usb_inte
 	int i, j;
 	int ret;
 
-	IFNULLRETVAL(udev, -ENODEV);
-
 	gig_dbg(DEBUG_ANY,
 		"%s: Check if device matches .. (Vendor: 0x%x, Product: 0x%x)",
 		__func__, le16_to_cpu(udev->descriptor.idVendor),
@@ -2314,9 +2200,7 @@ static void gigaset_disconnect(struct us
 
 	cs = usb_get_intfdata(interface);
 
-	IFNULLRET(cs);
 	ucs = cs->hw.bas;
-	IFNULLRET(ucs);
 
 	dev_info(cs->dev, "disconnecting Gigaset base\n");
 	gigaset_stop(cs);
--- linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:42:01.000000000 +0200
@@ -247,8 +247,6 @@ static inline void dump_bytes(enum debug
 	static char dbgline[3 * 32 + 1];
 	static const char hexdigit[] = "0123456789abcdef";
 	int i = 0;
-	IFNULLRET(tag);
-	IFNULLRET(bytes);
 	while (count-- > 0) {
 		if (i > sizeof(dbgline) - 4) {
 			dbgline[i] = '\0';
@@ -663,14 +661,10 @@ static unsigned char bitcounts[256] = {
 static inline void hdlc_unpack(unsigned char *src, unsigned count,
 			       struct bc_state *bcs)
 {
-	struct bas_bc_state *ubc;
+	struct bas_bc_state *ubc = bcs->hw.bas;
 	int inputstate;
 	unsigned seqlen, inbyte, inbits;
 
-	IFNULLRET(bcs);
-	ubc = bcs->hw.bas;
-	IFNULLRET(ubc);
-
 	/* load previous state:
 	 * inputstate = set of flag bits:
 	 * - INS_flag_hunt: no complete opening flag received since connection setup or last abort
@@ -995,11 +989,7 @@ void gigaset_isoc_input(struct inbuf_t *
  */
 int gigaset_isoc_send_skb(struct bc_state *bcs, struct sk_buff *skb)
 {
-	int len;
-
-	IFNULLRETVAL(bcs, -EFAULT);
-	IFNULLRETVAL(skb, -EFAULT);
-	len = skb->len;
+	int len = skb->len;
 
 	skb_queue_tail(&bcs->squeue, skb);
 	gig_dbg(DEBUG_ISO, "%s: skb queued, qlen=%d",
--- linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:41:29.000000000 +0200
+++ linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:42:01.000000000 +0200
@@ -365,18 +365,12 @@ static void gigaset_modem_fill(unsigned 
  */
 static void gigaset_read_int_callback(struct urb *urb, struct pt_regs *regs)
 {
+	struct inbuf_t *inbuf = urb->context;
+	struct cardstate *cs = inbuf->cs;
 	int resubmit = 0;
 	int r;
-	struct cardstate *cs;
 	unsigned numbytes;
 	unsigned char *src;
-	struct inbuf_t *inbuf;
-
-	IFNULLRET(urb);
-	inbuf = (struct inbuf_t *) urb->context;
-	IFNULLRET(inbuf);
-	cs = inbuf->cs;
-	IFNULLRET(cs);
 
 	if (!atomic_read(&cs->connected)) {
 		err("%s: disconnected", __func__);
@@ -421,9 +415,8 @@ static void gigaset_read_int_callback(st
 /* This callback routine is called when data was transmitted to the device. */
 static void gigaset_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
 {
-	struct cardstate *cs = (struct cardstate *) urb->context;
+	struct cardstate *cs = urb->context;
 
-	IFNULLRET(cs);
 #ifdef CONFIG_GIGASET_DEBUG
 	if (!atomic_read(&cs->connected)) {
 		err("%s: not connected", __func__);
@@ -632,20 +625,13 @@ static int gigaset_initcshw(struct cards
 /* Send data from current skb to the device. */
 static int write_modem(struct cardstate *cs)
 {
-	int ret;
+	int ret = 0;
 	int count;
 	struct bc_state *bcs = &cs->bcs[0]; /* only one channel */
 	struct usb_cardstate *ucs = cs->hw.usb;
 
-	IFNULLRETVAL(bcs->tx_skb, -EINVAL);
-
 	gig_dbg(DEBUG_WRITE, "len: %d...", bcs->tx_skb->len);
 
-	ret = -ENODEV;
-	IFNULLGOTO(ucs->bulk_out_buffer, error);
-	IFNULLGOTO(ucs->bulk_out_urb, error);
-	ret = 0;
-
 	if (!bcs->tx_skb->len) {
 		dev_kfree_skb_any(bcs->tx_skb);
 		bcs->tx_skb = NULL;
@@ -683,11 +669,6 @@ static int write_modem(struct cardstate 
 	}
 
 	return ret;
-error:
-	dev_kfree_skb_any(bcs->tx_skb);
-	bcs->tx_skb = NULL;
-	return ret;
-
 }
 
 static int gigaset_probe(struct usb_interface *interface,
--- linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:42:01.000000000 +0200
@@ -117,20 +117,14 @@ static inline int hdlc_loop(unsigned cha
 {
 	struct cardstate *cs = inbuf->cs;
 	struct bc_state *bcs = inbuf->bcs;
-	int inputstate;
-	__u16 fcs;
-	struct sk_buff *skb;
+	int inputstate = bcs->inputstate;
+	__u16 fcs = bcs->fcs;
+	struct sk_buff *skb = bcs->skb;
 	unsigned char error;
 	struct sk_buff *compskb;
 	int startbytes = numbytes;
 	int l;
 
-	IFNULLRETVAL(bcs, numbytes);
-	inputstate = bcs->inputstate;
-	fcs = bcs->fcs;
-	skb = bcs->skb;
-	IFNULLRETVAL(skb, numbytes);
-
 	if (unlikely(inputstate & INS_byte_stuff)) {
 		inputstate &= ~INS_byte_stuff;
 		goto byte_stuff;
@@ -292,15 +286,10 @@ static inline int iraw_loop(unsigned cha
 {
 	struct cardstate *cs = inbuf->cs;
 	struct bc_state *bcs = inbuf->bcs;
-	int inputstate;
-	struct sk_buff *skb;
+	int inputstate = bcs->inputstate;
+	struct sk_buff *skb = bcs->skb;
 	int startbytes = numbytes;
 
-	IFNULLRETVAL(bcs, numbytes);
-	inputstate = bcs->inputstate;
-	skb = bcs->skb;
-	IFNULLRETVAL(skb, numbytes);
-
 	for (;;) {
 		/* add character */
 		inputstate |= INS_have_data;
@@ -577,11 +566,7 @@ static struct sk_buff *iraw_encode(struc
  */
 int gigaset_m10x_send_skb(struct bc_state *bcs, struct sk_buff *skb)
 {
-	unsigned len;
-
-	IFNULLRETVAL(bcs, -EFAULT);
-	IFNULLRETVAL(skb, -EFAULT);
-	len = skb->len;
+	unsigned len = skb->len;
 
 	if (bcs->proto2 == ISDN_PROTO_L2_HDLC)
 		skb = HDLC_Encode(skb, HW_HDR_LEN, 0);
