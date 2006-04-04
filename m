Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWDCX7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWDCX7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWDCX7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:51 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:40375 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964903AbWDCX7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:46 -0400
Date: Tue, 4 Apr 2006 02:00:26 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/13] isdn4linux: Siemens Gigaset drivers - elliminate from_user argument
Message-ID: <gigaset307x.2006.04.04.001.8@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch elliminates the from_user argument from a debugging
function, thus easing the job of sparse. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c   |    2 +-
 drivers/isdn/gigaset/bas-gigaset.c |    2 +-
 drivers/isdn/gigaset/common.c      |   30 +++++++-----------------------
 drivers/isdn/gigaset/gigaset.h     |    2 +-
 drivers/isdn/gigaset/interface.c   |    7 ++++---
 drivers/isdn/gigaset/isocdata.c    |    4 ++--
 drivers/isdn/gigaset/usb-gigaset.c |    4 ++--
 7 files changed, 18 insertions(+), 33 deletions(-)

--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:42:34.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:43:01.000000000 +0200
@@ -154,7 +154,7 @@ enum debuglevel { /* up to 24 bits (atom
 #endif
 
 void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
-			size_t len, const unsigned char *buf, int from_user);
+			size_t len, const unsigned char *buf);
 
 /* connection state */
 #define ZSAU_NONE			0
--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/common.c	2006-04-02 18:42:34.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/common.c	2006-04-02 18:43:01.000000000 +0200
@@ -79,50 +79,34 @@ __u8 gigaset_invtab[256] = {
 EXPORT_SYMBOL_GPL(gigaset_invtab);
 
 void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
-			size_t len, const unsigned char *buf, int from_user)
+			size_t len, const unsigned char *buf)
 {
 	unsigned char outbuf[80];
-	unsigned char inbuf[80 - 1];
 	unsigned char c;
-	size_t numin;
-	const unsigned char *in;
 	size_t space = sizeof outbuf - 1;
 	unsigned char *out = outbuf;
+	size_t numin = len;
 
-	if (!from_user) {
-		in = buf;
-		numin = len;
-	} else {
-		numin = len < sizeof inbuf ? len : sizeof inbuf;
-		in = inbuf;
-		if (copy_from_user(inbuf, (const unsigned char __user *) buf,
-				   numin)) {
-			gig_dbg(level, "%s (%u bytes) - copy_from_user failed",
-				msg, (unsigned) len);
-			return;
-		}
-	}
-
-	while (numin-- > 0) {
+	while (numin--) {
 		c = *buf++;
 		if (c == '~' || c == '^' || c == '\\') {
-			if (space-- <= 0)
+			if (!space--)
 				break;
 			*out++ = '\\';
 		}
 		if (c & 0x80) {
-			if (space-- <= 0)
+			if (!space--)
 				break;
 			*out++ = '~';
 			c ^= 0x80;
 		}
 		if (c < 0x20 || c == 0x7f) {
-			if (space-- <= 0)
+			if (!space--)
 				break;
 			*out++ = '^';
 			c ^= 0x40;
 		}
-		if (space-- <= 0)
+		if (!space--)
 			break;
 		*out++ = c;
 	}
--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/interface.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/interface.c	2006-04-02 18:43:01.000000000 +0200
@@ -246,8 +246,6 @@ static int if_ioctl(struct tty_struct *t
 			break;
 		case GIGASET_BRKCHARS:
 			//FIXME test if MS_LOCKED
-			gigaset_dbg_buffer(DEBUG_IF, "GIGASET_BRKCHARS",
-					   6, (const unsigned char *) arg, 1);
 			if (!atomic_read(&cs->connected)) {
 				gig_dbg(DEBUG_ANY,
 				    "can't communicate with unplugged device");
@@ -257,8 +255,11 @@ static int if_ioctl(struct tty_struct *t
 			retval = copy_from_user(&buf,
 					(const unsigned char __user *) arg, 6)
 				? -EFAULT : 0;
-			if (retval >= 0)
+			if (retval >= 0) {
+				gigaset_dbg_buffer(DEBUG_IF, "GIGASET_BRKCHARS",
+						6, (const unsigned char *) arg);
 				retval = cs->ops->brkchars(cs, buf);
+			}
 			break;
 		case GIGASET_VERSION:
 			retval = copy_from_user(version,
--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:42:01.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:43:01.000000000 +0200
@@ -1756,7 +1756,7 @@ static int gigaset_write_cmd(struct card
 
 	gigaset_dbg_buffer(atomic_read(&cs->mstate) != MS_LOCKED ?
 			     DEBUG_TRANSCMD : DEBUG_LOCKCMD,
-			   "CMD Transmit", len, buf, 0);
+			   "CMD Transmit", len, buf);
 
 	if (unlikely(!atomic_read(&cs->connected))) {
 		err("%s: disconnected", __func__);
--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:42:01.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:43:01.000000000 +0200
@@ -957,11 +957,11 @@ void gigaset_isoc_input(struct inbuf_t *
 
 		if (atomic_read(&cs->mstate) == MS_LOCKED) {
 			gigaset_dbg_buffer(DEBUG_LOCKCMD, "received response",
-					   numbytes, src, 0);
+					   numbytes, src);
 			gigaset_if_receive(inbuf->cs, src, numbytes);
 		} else {
 			gigaset_dbg_buffer(DEBUG_CMD, "received response",
-					   numbytes, src, 0);
+					   numbytes, src);
 			cmd_loop(src, numbytes, inbuf);
 		}
 
--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:42:01.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:43:04.000000000 +0200
@@ -500,7 +500,7 @@ static int gigaset_write_cmd(struct card
 
 	gigaset_dbg_buffer(atomic_read(&cs->mstate) != MS_LOCKED ?
 			     DEBUG_TRANSCMD : DEBUG_LOCKCMD,
-			   "CMD Transmit", len, buf, 0);
+			   "CMD Transmit", len, buf);
 
 	if (!atomic_read(&cs->connected)) {
 		err("%s: not connected", __func__);
@@ -559,7 +559,7 @@ static int gigaset_brkchars(struct cards
 #ifdef CONFIG_GIGASET_UNDOCREQ
 	struct usb_device *udev = cs->hw.usb->udev;
 
-	gigaset_dbg_buffer(DEBUG_USBREQ, "brkchars", 6, buf, 0);
+	gigaset_dbg_buffer(DEBUG_USBREQ, "brkchars", 6, buf);
 	memcpy(cs->hw.usb->bchars, buf, 6);
 	return usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x19, 0x41,
 			       0, 0, &buf, 6, 2000);
--- linux-2.6.16-gig-uninline/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:42:01.000000000 +0200
+++ linux-2.6.16-gig-from_user/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:43:01.000000000 +0200
@@ -98,7 +98,7 @@ static inline int lock_loop(unsigned cha
 	struct cardstate *cs = inbuf->cs;
 
 	gigaset_dbg_buffer(DEBUG_LOCKCMD, "received response",
-			   numbytes, src, 0);
+			   numbytes, src);
 	gigaset_if_receive(cs, src, numbytes);
 
 	return numbytes;
