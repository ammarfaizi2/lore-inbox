Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbTGJDXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268896AbTGJDXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:23:52 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:60934 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S268894AbTGJDXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:23:49 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>, Daniel Ritz <daniel.ritz@gmx.ch>
Subject: 2.5.74-mm3 yenta-socket oops back
Date: Thu, 10 Jul 2003 11:27:30 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200307060039.34263.daniel.ritz@gmx.ch> <20030706231551.B16820@flint.arm.linux.org.uk>
In-Reply-To: <20030706231551.B16820@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101127.32590.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.74-mm3 yenta-socket oopsed on the first boot at the same spot. 

I have successfully used both patches below with -mm1.

Regards
Michael

On Monday 07 July 2003 06:15, Russell King wrote:

> michael, can you try this one?

Daniel's patch:

--- 1.50/drivers/pcmcia/cs.c    Mon Jun 30 22:22:30 2003
+++ edited/cs.c Sat Jul  5 23:58:07 2003
@@ -338,13 +338,13 @@
        socket->erase_busy.next = socket->erase_busy.prev = &socket->erase_busy;
        INIT_LIST_HEAD(&socket->cis_cache);
        spin_lock_init(&socket->lock);
-
-       init_socket(socket);
-
        init_completion(&socket->thread_done);
        init_waitqueue_head(&socket->thread_wait);
        init_MUTEX(&socket->skt_sem);
        spin_lock_init(&socket->thread_lock);
+
+       init_socket(socket);
+
        ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
        if (ret < 0)
                return ret;

and my patch (may apply with some offset, which I'm about to check
into bk anyway):

--- linux/drivers/pcmcia/cs.c.old       Fri Jul  4 10:21:50 2003
+++ linux/drivers/pcmcia/cs.c   Sun Jul  6 23:04:10 2003
@@ -870,11 +870,13 @@
 
 void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
 {
-       spin_lock(&s->thread_lock);
-       s->thread_events |= events;
-       spin_unlock(&s->thread_lock);
+       if (s->thread) {
+               spin_lock(&s->thread_lock);
+               s->thread_events |= events;
+               spin_unlock(&s->thread_lock);
 
-       wake_up(&s->thread_wait);
+               wake_up(&s->thread_wait);
+       }
 } /* pcmcia_parse_events */

-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

