Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUHYPNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUHYPNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHYPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:13:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:14301 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267669AbUHYPNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:13:16 -0400
Date: Wed, 25 Aug 2004 17:11:06 +0200
From: Olaf Dabrunz <od@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [Patch] TIOCCONS security
Message-ID: <20040825151106.GA21687@suse.de>
Mail-Followup-To: Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the ioctl TIOCCONS allows any user to redirect console output to another
tty. This allows anyone to suppress messages to the console at will.

AFAIK nowadays not many programs write to /dev/console, except for start
scripts and the kernel (printk() above console log level).

Still, I believe that administrators and operators would not like any
user to be able to hijack messages that were written to the console.

The only user of TIOCCONS that I am aware of is bootlogd/blogd, which
runs as root. Please comment if there are other users.

Is there any reason why normal users should be able to use TIOCCONS?

Otherwise I would suggest to restrict access to root (CAP_SYS_ADMIN),
e.g. with this patch.

--- drivers/char/tty_io.c.orig	2004-08-25 12:51:17.000000000 +0200
+++ drivers/char/tty_io.c	2004-08-25 17:05:15.097068780 +0200
@@ -1566,10 +1566,10 @@
 
 static int tioccons(struct file *file)
 {
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	if (file->f_op->write == redirected_tty_write) {
 		struct file *f;
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		spin_lock(&redirect_lock);
 		f = redirect;
 		redirect = NULL;

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux AG, Nürnberg

