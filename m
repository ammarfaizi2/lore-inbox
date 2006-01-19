Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWASReL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWASReL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWASReL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:34:11 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:28059
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751275AbWASReK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:34:10 -0500
Subject: Re: pppd oopses current linu's git tree on disconnect
From: Paul Fulghum <paulkf@microgate.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060119010601.f259bb32.diegocg@gmail.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 11:33:59 -0600
Message-Id: <1137692039.3279.1.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 01:06 +0100, Diego Calleja wrote:
> I got this on my log files (56k serial modem, pentium 3 smp machine, the
> machine didn't hang, in fact I could connect again to send this bug
> report). If needed, here's the dmesg: http://www.terra.es/personal/diegocg/dmesg
> and .config: http://www.terra.es/personal/diegocg/.config. I've never seen
> this so I assumed it could be a problem with the "TTY layer buffering revamp"

Can you try the attached patch please?
Does this occur frequently?

Thanks

-- 
Paul Fulghum
Microgate Systems, Ltd
--- linux-2.6.16-rc1/include/linux/tty_flip.h	2006-01-19 10:18:49.000000000 -0600
+++ linux-2.6.16-rc1-mg/include/linux/tty_flip.h	2006-01-19 10:20:50.000000000 -0600
@@ -16,13 +16,23 @@ extern int tty_prepare_flip_string_flags
 _INLINE_ int tty_insert_flip_char(struct tty_struct *tty,
 				   unsigned char ch, char flag)
 {
-	struct tty_buffer *tb = tty->buf.tail;
+	struct tty_buffer *tb;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&tty->read_lock, flags);
+
+	tb = tty->buf.tail;
 	if (tb && tb->used < tb->size) {
 		tb->flag_buf_ptr[tb->used] = flag;
 		tb->char_buf_ptr[tb->used++] = ch;
+		spin_unlock_irqrestore(&tty->read_lock, flags);
 		return 1;
 	}
-	return tty_insert_flip_string_flags(tty, &ch, &flag, 1);
+	rc = tty_insert_flip_string_flags(tty, &ch, &flag, 1);
+
+	spin_unlock_irqrestore(&tty->read_lock, flags);
+	return rc;
 }
 
 _INLINE_ void tty_schedule_flip(struct tty_struct *tty)


