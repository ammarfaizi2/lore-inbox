Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWFRVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWFRVXL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 17:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFRVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 17:23:11 -0400
Received: from mailfe03.tele2.fr ([212.247.154.76]:26565 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751101AbWFRVXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 17:23:10 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Sun, 18 Jun 2006 23:23:03 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There's a long-standing issue in init=/bin/sh mode: pressing control-C
doesn't send a SIGINT to programs running on the console. The incurred
typical pitfall is if one runs ping without a -c option... no way to
stop it!

This is because no session is set up by the kernel, and shells don't
start sessions on their own, so that no session (hence no controlling
tty) is set up.

The attached patch sets such session and controlling tty up, which fixes
the issue. The unfortunate effect is that init might be killed if one
presses control-C very fast after its start.

Samuel

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- linux-2.6.17-orig/init/main.c	2006-06-18 19:22:40.000000000 +0200
+++ linux-2.6.17-perso/init/main.c	2006-06-18 23:00:00.000000000 +0200
@@ -703,9 +703,13 @@
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
+	sys_setsid();
+
 	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
 
+	sys_ioctl(0, TIOCSCTTY, 1);
+
 	(void) sys_dup(0);
 	(void) sys_dup(0);
 

--lrZ03NoBR/3+SXJZ--
