Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWHDFqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWHDFqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWHDFpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:45:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:26032 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030271AbWHDFpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:45:22 -0400
Date: Thu, 3 Aug 2006 22:40:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/23] tty serialize flush_to_ldisc
Message-ID: <20060804054045.GV769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tty-serialize-flush_to_ldisc.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Paul Fulghum <paulkf@microgate.com>

Serialize processing of tty buffers in flush_to_ldisc
to fix (very rare) corruption of tty buffer free list
on SMP systems.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/char/tty_io.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- linux-2.6.17.7.orig/drivers/char/tty_io.c
+++ linux-2.6.17.7/drivers/char/tty_io.c
@@ -2776,7 +2776,7 @@ static void flush_to_ldisc(void *private
 	struct tty_struct *tty = (struct tty_struct *) private_;
 	unsigned long 	flags;
 	struct tty_ldisc *disc;
-	struct tty_buffer *tbuf;
+	struct tty_buffer *tbuf, *head;
 	int count;
 	char *char_buf;
 	unsigned char *flag_buf;
@@ -2793,7 +2793,9 @@ static void flush_to_ldisc(void *private
 		goto out;
 	}
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	while((tbuf = tty->buf.head) != NULL) {
+	head = tty->buf.head;
+	tty->buf.head = NULL;
+	while((tbuf = head) != NULL) {
 		while ((count = tbuf->commit - tbuf->read) != 0) {
 			char_buf = tbuf->char_buf_ptr + tbuf->read;
 			flag_buf = tbuf->flag_buf_ptr + tbuf->read;
@@ -2802,10 +2804,12 @@ static void flush_to_ldisc(void *private
 			disc->receive_buf(tty, char_buf, flag_buf, count);
 			spin_lock_irqsave(&tty->buf.lock, flags);
 		}
-		if (tbuf->active)
+		if (tbuf->active) {
+			tty->buf.head = head;
 			break;
-		tty->buf.head = tbuf->next;
-		if (tty->buf.head == NULL)
+		}
+		head = tbuf->next;
+		if (head == NULL)
 			tty->buf.tail = NULL;
 		tty_buffer_free(tty, tbuf);
 	}

--
