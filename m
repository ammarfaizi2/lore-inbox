Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTJNRMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJNRMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:12:47 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:48788
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262374AbTJNRMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:12:45 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: parport_pc not releasing all ioports on 2.6.0-test7-bk3
Message-Id: <E1A9Siy-0001gV-00@penngrove.fdns.net>
Date: Tue, 14 Oct 2003 10:12:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If 'parport_pc' is compile as a module, it fails to properly return certain
ioport resources after being removed.

    Debian GNU/Linux testing/unstable tvr-vaio tty1

    tvr-vaio login: root
    Password:
    Last login: Tue Oct 14 08:26:30 2003 on tty1
    Linux tvr-vaio 2.6.0-test7-bk3 #23 Sun Oct 12 15:42:38 PDT 2003 i686 GNU/Linux
    You have new mail.
    tvr-vaio:~# cat /proc/ioports > /tmp/ioports1
    tvr-vaio:~# modprobe parport_pc
    parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
    parport0: irq 7 detected
    tvr-vaio:~# cat /proc/ioports > /tmp/ioports2
    tvr-vaio:~# rmmod parport_pc
    tvr-vaio:~# cat /proc/ioports > /tmp/ioports3
    tvr-vaio:~# diff /tmp/ioports{1,2}
    12a13,14
    > 0378-037a : parport0
    > 037b-037f : parport0
    tvr-vaio:~# diff /tmp/ioports{2,3}
    13,14c13
    < 0378-037a : parport0
    < 037b-037f : parport0
    ---
    > 037b-037f : kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk&#65533;q&#65533;,Z$S&#65533;&#65533;&#65533;&#65533;$K6&#65533;{
    tvr-vaio:~# cat > /tmp/console.log

Additional details on http://bugzilla.kernel.org/show_bug.cgi?id=1356 :

    'dmesg'	    http://bugzilla.kernel.org/attachment.cgi?id=1056
    .config	    http://bugzilla.kernel.org/attachment.cgi?id=1057
    /tmp/ioports2   http://bugzilla.kernel.org/attachment.cgi?id=1058

Please write if you would like additional information.

			       -- JM

P.S.  Does the following patch fix this properly??
-------------------------------------------------------------------------------
--- drivers/parport/parport_pc.c.orig	2003-10-08 12:24:51.000000000 -0700
+++ drivers/parport/parport_pc.c	2003-10-14 10:05:25.000000000 -0700
@@ -2358,7 +2358,11 @@
 		release_region(base_hi, 3);
 		ECR_res = NULL;
 	}
-
+	/* Likewise for EEP ports */
+	if (EPP_res && (p->modes & PARPORT_MODE_EPP) == 0) {
+		release_region(base+3, 5);
+		EPP_res = NULL;
+	}
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_pc_interrupt,
 				 0, p->name, p)) {
===============================================================================
