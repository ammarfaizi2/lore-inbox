Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTGFWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTGFWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:01:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50700 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263897AbTGFWBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:01:21 -0400
Date: Sun, 6 Jul 2003 23:15:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: mflt1@micrologica.com.hk, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
Message-ID: <20030706231551.B16820@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	mflt1@micrologica.com.hk,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200307060039.34263.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307060039.34263.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Sun, Jul 06, 2003 at 12:39:34AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 12:39:34AM +0200, Daniel Ritz wrote:
> problem is that an interrupt arrives before socket->thread_wait is
> initialized so we crash in __wake_up_common. i think source of the
> interrupt is socket_init called before the initialization. but an
> interrupt can still arrive before...

I suspect that even with your patch below, there is the posibility
to receive an unintentional call into pcmcia_parse_events() from some
socket drivers.  The all round better fix is to make pcmcia_parse_events()
ignore socket change events until the socket thread is up and running.

Nevertheless, the patch looks correct, so I am still interested in
whether your patch helps solve Michael's problem.

> michael, can you try this one?

Daniel's patch:

--- 1.50/drivers/pcmcia/cs.c	Mon Jun 30 22:22:30 2003
+++ edited/cs.c	Sat Jul  5 23:58:07 2003
@@ -338,13 +338,13 @@
 	socket->erase_busy.next = socket->erase_busy.prev = &socket->erase_busy;
 	INIT_LIST_HEAD(&socket->cis_cache);
 	spin_lock_init(&socket->lock);
-
-	init_socket(socket);
-
 	init_completion(&socket->thread_done);
 	init_waitqueue_head(&socket->thread_wait);
 	init_MUTEX(&socket->skt_sem);
 	spin_lock_init(&socket->thread_lock);
+
+	init_socket(socket);
+
 	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
 	if (ret < 0)
 		return ret;

and my patch (may apply with some offset, which I'm about to check
into bk anyway):

--- linux/drivers/pcmcia/cs.c.old	Fri Jul  4 10:21:50 2003
+++ linux/drivers/pcmcia/cs.c	Sun Jul  6 23:04:10 2003
@@ -870,11 +870,13 @@
 
 void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
 {
-	spin_lock(&s->thread_lock);
-	s->thread_events |= events;
-	spin_unlock(&s->thread_lock);
+	if (s->thread) {
+		spin_lock(&s->thread_lock);
+		s->thread_events |= events;
+		spin_unlock(&s->thread_lock);
 
-	wake_up(&s->thread_wait);
+		wake_up(&s->thread_wait);
+	}
 } /* pcmcia_parse_events */
 
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

