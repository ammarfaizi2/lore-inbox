Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWDDABa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWDDABa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWDCX7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:54 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:29879 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964896AbWDCX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:40 -0400
Date: Tue, 4 Apr 2006 02:00:26 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/13] isdn4linux: Siemens Gigaset drivers - uninline
Message-ID: <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch uninlines a function which was slightly too big to warrant
inlining. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/common.c  |   41 ++++++++++++++++++++++++++++++++++++++++
 drivers/isdn/gigaset/gigaset.h |   42 +----------------------------------------
 2 files changed, 43 insertions(+), 40 deletions(-)

--- linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:42:01.000000000 +0200
+++ linux-2.6.16-gig-uninline/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:42:34.000000000 +0200
@@ -902,47 +902,9 @@ static inline void gigaset_rcv_error(str
 /* bitwise byte inversion table */
 extern __u8 gigaset_invtab[];	/* in common.c */
 
-
 /* append received bytes to inbuf */
-static inline int gigaset_fill_inbuf(struct inbuf_t *inbuf,
-				     const unsigned char *src,
-				     unsigned numbytes)
-{
-	unsigned n, head, tail, bytesleft;
-
-	gig_dbg(DEBUG_INTR, "received %u bytes", numbytes);
-
-	if (!numbytes)
-		return 0;
-
-	bytesleft = numbytes;
-	tail = atomic_read(&inbuf->tail);
-	head = atomic_read(&inbuf->head);
-	gig_dbg(DEBUG_INTR, "buffer state: %u -> %u", head, tail);
-
-	while (bytesleft) {
-		if (head > tail)
-			n = head - 1 - tail;
-		else if (head == 0)
-			n = (RBUFSIZE-1) - tail;
-		else
-			n = RBUFSIZE - tail;
-		if (!n) {
-			dev_err(inbuf->cs->dev,
-				"buffer overflow (%u bytes lost)", bytesleft);
-			break;
-		}
-		if (n > bytesleft)
-			n = bytesleft;
-		memcpy(inbuf->data + tail, src, n);
-		bytesleft -= n;
-		tail = (tail + n) % RBUFSIZE;
-		src += n;
-	}
-	gig_dbg(DEBUG_INTR, "setting tail to %u", tail);
-	atomic_set(&inbuf->tail, tail);
-	return numbytes != bytesleft;
-}
+int gigaset_fill_inbuf(struct inbuf_t *inbuf, const unsigned char *src,
+		       unsigned numbytes);
 
 /* ===========================================================================
  *  Functions implemented in interface.c
--- linux-2.6.16-gig-ifnull/drivers/isdn/gigaset/common.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-uninline/drivers/isdn/gigaset/common.c	2006-04-02 18:42:34.000000000 +0200
@@ -521,6 +521,47 @@ static void gigaset_inbuf_init(struct in
 	inbuf->inputstate = inputstate;
 }
 
+/* append received bytes to inbuf */
+int gigaset_fill_inbuf(struct inbuf_t *inbuf, const unsigned char *src,
+		       unsigned numbytes)
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
+EXPORT_SYMBOL_GPL(gigaset_fill_inbuf);
+
 /* Initialize the b-channel structure */
 static struct bc_state *gigaset_initbcs(struct bc_state *bcs,
 					struct cardstate *cs, int channel)
