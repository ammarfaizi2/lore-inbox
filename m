Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWENBsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWENBsq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 21:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWENBsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 21:48:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:58256 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932263AbWENBsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 21:48:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bImxJj2SgmNqoA+o2qfxZ+Uaysuk60XEZrzJwSIqp5tyzNJ6X5lsyFOg5Dkidb8wBTtBqNmpi9Nb7Z4DBTwJeOP0JoPpPNlAmhAFPC952t8dhZvA58MUqPO3TYVyjkLKQlBZFG5kVJ6tqETOz8yK3PrIxq6YVx0Rh9N24ryPjCc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Date: Sun, 14 May 2006 03:49:35 +0200
User-Agent: KMail/1.9.1
Cc: Moxa Technologies <support@moxa.com.tw>, Alan Cox <alan@redhat.com>,
       Martin Mares <mj@ucw.cz>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140349.36122.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If mxser_write() gets called with a NULL 'tty' pointer, then the initial
assignment of tty->driver_data to info will explode.
'tty' is tested for NULL at the beginning of the function, but at that 
point it is too late.
Fix the problem by only dereferencing tty after it has been tested.

In mxser_put_char() there's the same problem with the same fix.

This should fix coverity bugs #770 && #771 .

In addition to the above, I've removed several pointless casts.

Due to lack of hardware, the patch is compile tested only.

Please consider for inclusion.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/mxser.c |   62 +++++++++++++++++++++++++++------------------------
 1 files changed, 34 insertions(+), 28 deletions(-)


--- linux-2.6.17-rc4-git2-orig/drivers/char/mxser.c	2006-05-13 21:28:25.000000000 +0200
+++ linux-2.6.17-rc4-git2/drivers/char/mxser.c	2006-05-14 03:41:22.000000000 +0200
@@ -877,7 +877,7 @@ static int mxser_init(void)
 
 static void mxser_do_softint(void *private_)
 {
-	struct mxser_struct *info = (struct mxser_struct *) private_;
+	struct mxser_struct *info = private_;
 	struct tty_struct *tty;
 
 	tty = info->tty;
@@ -972,8 +972,7 @@ static int mxser_open(struct tty_struct 
  */
 static void mxser_close(struct tty_struct *tty, struct file *filp)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
-
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long timeout;
 	unsigned long flags;
 	struct tty_ldisc *ld;
@@ -1078,11 +1077,15 @@ static void mxser_close(struct tty_struc
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	int c, total = 0;
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info;
 	unsigned long flags;
 
-	if (!tty || !info->xmit_buf)
-		return (0);
+	if (!tty)
+		return 0;
+
+	info = tty->driver_data;
+	if (!info->xmit_buf)
+		return 0;
 
 	while (1) {
 		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1, SERIAL_XMIT_SIZE - info->xmit_head));
@@ -1114,10 +1117,14 @@ static int mxser_write(struct tty_struct
 
 static void mxser_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info;
 	unsigned long flags;
 
-	if (!tty || !info->xmit_buf)
+	if (!tty)
+		return;
+
+	info = tty->driver_data;
+	if (!info->xmit_buf)
 		return;
 
 	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1)
@@ -1141,7 +1148,7 @@ static void mxser_put_char(struct tty_st
 
 static void mxser_flush_chars(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (info->xmit_cnt <= 0 || tty->stopped || !info->xmit_buf || (tty->hw_stopped && (info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)))
@@ -1157,7 +1164,7 @@ static void mxser_flush_chars(struct tty
 
 static int mxser_write_room(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	int ret;
 
 	ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
@@ -1168,13 +1175,13 @@ static int mxser_write_room(struct tty_s
 
 static int mxser_chars_in_buffer(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	return info->xmit_cnt;
 }
 
 static void mxser_flush_buffer(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	char fcr;
 	unsigned long flags;
 
@@ -1197,7 +1204,7 @@ static void mxser_flush_buffer(struct tt
 
 static int mxser_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	int retval;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct __user *p_cuser;
@@ -1581,13 +1588,11 @@ static int mxser_ioctl_special(unsigned 
 
 static void mxser_stoprx(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
 
-
 	info->ldisc_stop_rx = 1;
 	if (I_IXOFF(tty)) {
-
 		//MX_LOCK(&info->slock);
 		// following add by Victor Yu. 09-02-2002
 		if (info->IsMoxaMustChipFlag) {
@@ -1615,7 +1620,7 @@ static void mxser_stoprx(struct tty_stru
 
 static void mxser_startrx(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
 
 	info->ldisc_stop_rx = 0;
@@ -1656,8 +1661,9 @@ static void mxser_startrx(struct tty_str
  */
 static void mxser_throttle(struct tty_struct *tty)
 {
-	//struct mxser_struct *info = (struct mxser_struct *)tty->driver_data;
+	//struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
+
 	//MX_LOCK(&info->slock);
 	mxser_stoprx(tty);
 	//MX_UNLOCK(&info->slock);
@@ -1665,8 +1671,9 @@ static void mxser_throttle(struct tty_st
 
 static void mxser_unthrottle(struct tty_struct *tty)
 {
-	//struct mxser_struct *info = (struct mxser_struct *)tty->driver_data;
+	//struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
+
 	//MX_LOCK(&info->slock);
 	mxser_startrx(tty);
 	//MX_UNLOCK(&info->slock);
@@ -1674,7 +1681,7 @@ static void mxser_unthrottle(struct tty_
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if ((tty->termios->c_cflag != old_termios->c_cflag) || (RELEVANT_IFLAG(tty->termios->c_iflag) != RELEVANT_IFLAG(old_termios->c_iflag))) {
@@ -1711,7 +1718,7 @@ static void mxser_set_termios(struct tty
  */
 static void mxser_stop(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1724,7 +1731,7 @@ static void mxser_stop(struct tty_struct
 
 static void mxser_start(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1740,7 +1747,7 @@ static void mxser_start(struct tty_struc
  */
 static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
@@ -1803,7 +1810,7 @@ static void mxser_wait_until_sent(struct
  */
 void mxser_hangup(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 
 	mxser_flush_buffer(tty);
 	mxser_shutdown(info);
@@ -1821,7 +1828,7 @@ void mxser_hangup(struct tty_struct *tty
  */
 static void mxser_rs_break(struct tty_struct *tty, int break_state)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -2886,7 +2893,7 @@ static void mxser_send_break(struct mxse
 
 static int mxser_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned char control, status;
 	unsigned long flags;
 
@@ -2909,10 +2916,9 @@ static int mxser_tiocmget(struct tty_str
 
 static int mxser_tiocmset(struct tty_struct *tty, struct file *file, unsigned int set, unsigned int clear)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-
 	if (tty->index == MXSER_PORTS)
 		return -ENOIOCTLCMD;
 	if (tty->flags & (1 << TTY_IO_ERROR))



