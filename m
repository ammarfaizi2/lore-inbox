Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWHZPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWHZPwB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWHZPwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 11:52:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60422 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422654AbWHZPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 11:52:00 -0400
Date: Sat, 26 Aug 2006 17:51:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16.28
Message-ID: <20060826155159.GJ4765@stusta.de>
References: <200608261023_MC3-1-C96A-6EC3@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608261023_MC3-1-C96A-6EC3@compuserve.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 10:20:43AM -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060826003639.GA4765@stusta.de>
> 
> On Sat, 26 Aug 2006 02:36:39 +0200, Adrian Bunk wrote:
> 
> > Location:
> > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
> 
> Could you post the incremental patch as a reply like Greg does?

After Michaels reminder I've put it at ftp.kernel.org .

> And are you going to apply Paul Fulghum's tty patch?  Without it
> I get solid lockup on pppd disconnect about once a month.

I've still many patches (including parts of four 2.6.17 releases) to 
review and I wasn't yet there.

Paul, can you ACK that this patch is OK for 2.6.16?

> Chuck

cu
Adrian



Subject: tty serialize flush_to_ldisc

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
