Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWBGV1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWBGV1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWBGV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:27:36 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:15837
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964870AbWBGV1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:27:35 -0500
Subject: Re: [PATCH] new tty buffering locking fix
From: Paul Fulghum <paulkf@microgate.com>
To: Olaf Hering <olh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207171111.GA15912@suse.de>
References: <200602032312.k13NCbWb012991@hera.kernel.org>
	 <20060207123450.GA854@suse.de>
	 <1139329302.3019.14.camel@amdx2.microgate.com>
	 <20060207171111.GA15912@suse.de>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 15:27:24 -0600
Message-Id: <1139347644.3174.16.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf:

Try this patch and let me know how it works.
(it is against 2.6.16-rc2-git1)

This change prevents claiming a partially filled
buffer if it has already been committed by the
driver calling a tty scheduling function, but not
yet processed by the tty layer.

Individual drivers can no longer stall committed
data by calling any of the tty buffering functions.
(example: calling tty_buffer_request_room
and not immediately adding receive data with an
associated tty scheduling call)

This remains relatively efficient. 
1. partially filled active buffer can be reused
2. already allocated empty buffer can be reused

Thanks,
Paul


--- linux-2.6.16-rc2/drivers/char/tty_io.c	2006-02-07 13:18:40.000000000 -0600
+++ b/drivers/char/tty_io.c	2006-02-07 13:46:28.000000000 -0600
@@ -324,8 +324,14 @@ int tty_buffer_request_room(struct tty_s
 	   remove this conditional if its worth it. This would be invisible
 	   to the callers */
 	if ((b = tty->buf.tail) != NULL) {
-		left = b->size - b->used;
-		b->active = 1;
+		if (!b->active) {
+			if (!b->used) {
+				left = b->size;
+				b->active = 1;
+			} else
+				left = 0;
+		} else
+			left = b->size - b->used;
 	} else
 		left = 0;
 


