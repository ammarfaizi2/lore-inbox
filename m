Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbTLQWAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbTLQWAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:00:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:58790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264583AbTLQWAo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:00:44 -0500
Date: Wed, 17 Dec 2003 14:01:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <aradorlinux@yahoo.es>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.0-test11-mm1
Message-Id: <20031217140139.1ae616b4.akpm@osdl.org>
In-Reply-To: <20031217192225.58842400.aradorlinux@yahoo.es>
References: <20031217014350.028460b2.akpm@osdl.org>
	<20031217192225.58842400.aradorlinux@yahoo.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García <aradorlinux@yahoo.es> wrote:
>
> local_bh_enable() was called in hard irq context.   This is probably a bug
> Call Trace:
>  [<c0127b96>] local_bh_enable+0x96/0xa0
>  [<e08fc4d8>] ppp_asynctty_receive+0x78/0xd0 [ppp_async]
>  [<c01cec6c>] flush_to_ldisc+0xdc/0x130
>  [<c01ecc17>] receive_chars+0x227/0x240
>  [<c01eccd5>] transmit_chars+0xa5/0xe0
>  [<c01ecf7c>] serial8250_interrupt+0x12c/0x130
>  [<c010c9f9>] handle_IRQ_event+0x49/0x80
>  [<c010cdc8>] do_IRQ+0xb8/0x180
>  [<c02ca760>] common_interrupt+0x18/0x20


ppp_asynctty_receive() is called from hard IRQ context and hence may not use
spin_unlock_bh().  The patch converts ppp to use an IRQ-safe spinlock.


 25-akpm/drivers/net/ppp_async.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -puN drivers/net/ppp_async.c~ppp-locking-fix drivers/net/ppp_async.c
--- 25/drivers/net/ppp_async.c~ppp-locking-fix	Wed Dec 17 13:57:33 2003
+++ 25-akpm/drivers/net/ppp_async.c	Wed Dec 17 13:58:27 2003
@@ -321,12 +321,13 @@ ppp_asynctty_receive(struct tty_struct *
 		  char *flags, int count)
 {
 	struct asyncppp *ap = ap_get(tty);
+	unsigned long flags;
 
 	if (ap == 0)
 		return;
-	spin_lock_bh(&ap->recv_lock);
+	spin_lock_irqsave(&ap->recv_lock, flags);
 	ppp_async_input(ap, buf, flags, count);
-	spin_unlock_bh(&ap->recv_lock);
+	spin_unlock_irqrestore(&ap->recv_lock, flags);
 	ap_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
 	    && tty->driver->unthrottle)
@@ -396,9 +397,9 @@ ppp_async_ioctl(struct ppp_channel *chan
 		if (get_user(val, (int *) arg))
 			break;
 		ap->flags = val & ~SC_RCV_BITS;
-		spin_lock_bh(&ap->recv_lock);
+		spin_lock_irq(&ap->recv_lock);
 		ap->rbits = val & SC_RCV_BITS;
-		spin_unlock_bh(&ap->recv_lock);
+		spin_unlock_irq(&ap->recv_lock);
 		err = 0;
 		break;
 

_

