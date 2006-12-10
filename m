Return-Path: <linux-kernel-owner+w=401wt.eu-S1762586AbWLJU5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762586AbWLJU5L (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762594AbWLJU5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:57:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:65093 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762592AbWLJU5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:57:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=uBxXHr/mjYUR926jLTTLe/NDzTowlL1eQZ/+L6k0VFc/hmnepNR7ftZyUxqNrd9YCkqOJJ/qSSJPNBey1atDrcwx/+Al50J/EQT9GysPLBQM1X3uu7MpS8IBuwfGjamG3XfD2JUSfeuSHz6xdRUEC2EpsBuL1TGkCUBQp+5GUg0=
Date: Sun, 10 Dec 2006 12:56:55 -0800
To: linux-kernel@vger.kernel.org
Subject: [patch] tty_io.c balance tty_ldisc_ref()
Message-ID: <20061210205655.GA4062@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
From: dcarpenter <error27@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tty_ldisc_deref() should only be called when 
tty_ldisc_ref() succeeds otherwise it triggers a BUG().
There's already a function tty_ldisc_flush() that flushes
properly.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 4044c86..bf6699b 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3335,18 +3335,13 @@ #else
 	int session;
 	int		i;
 	struct file	*filp;
-	struct tty_ldisc *disc;
 	struct fdtable *fdt;
 	
 	if (!tty)
 		return;
 	session = tty->session;
 	
-	/* We don't want an ldisc switch during this */
-	disc = tty_ldisc_ref(tty);
-	if (disc && disc->flush_buffer)
-		disc->flush_buffer(tty);
-	tty_ldisc_deref(disc);
+	tty_ldisc_flush(tty);
 
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
