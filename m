Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272619AbTG1BnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272231AbTG1Blv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 21:41:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:56364 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S272619AbTG1Bkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:40:33 -0400
Date: Sun, 27 Jul 2003 21:55:45 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Chris Heath <chris@heathens.co.nz>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 problem
Message-ID: <20030727215545.A21295@devserv.devel.redhat.com>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz> <20030727020621.A11637@devserv.devel.redhat.com> <20030727104726.GA1313@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030727104726.GA1313@win.tue.nl>; from aebr@win.tue.nl on Sun, Jul 27, 2003 at 12:47:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 27 Jul 2003 12:47:26 +0200
> From: Andries Brouwer <aebr@win.tue.nl>

> So the culprit is the failing of atkbd_probe().
> It does a ATKBD_CMD_GETID, but gets no answer, then a
> ATKBD_CMD_SETLEDS, and that command fails.

I see the light now. Somehow I imagined that atkbd code does not call
the ->open for the port. Now it all falls into place. Everything works
with a bigger timeout.

Thanks a lot, Andries & Chris!

-- Pete

diff -urN -X dontdiff linux-2.6.0-test1-bk2/drivers/input/keyboard/atkbd.c linux-2.6.0-test1-bk2-nip/drivers/input/keyboard/atkbd.c
--- linux-2.6.0-test1-bk2/drivers/input/keyboard/atkbd.c	2003-07-13 20:37:15.000000000 -0700
+++ linux-2.6.0-test1-bk2-nip/drivers/input/keyboard/atkbd.c	2003-07-27 15:20:35.000000000 -0700
@@ -214,7 +214,7 @@
 
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
-	int timeout = 10000; /* 100 msec */
+	int timeout = 20000; /* 200 msec */
 	atkbd->ack = 0;
 
 #ifdef ATKBD_DEBUG
