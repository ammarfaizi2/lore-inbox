Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTJIK4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTJIK4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:56:16 -0400
Received: from [213.78.110.92] ([213.78.110.92]:1665 "HELO stockwith.co.uk")
	by vger.kernel.org with SMTP id S261996AbTJIKvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:51:41 -0400
From: Chris Lingard <chris@ukpost.com>
To: hpa@zytor.com
Subject: 2.4.22 init/do_mounts.c Bug when booting a devfs CD
Date: Thu, 9 Oct 2003 11:51:37 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_52Th/5ciwsSS1FR"
Message-Id: <200310091151.38016.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_52Th/5ciwsSS1FR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hope I have the right person;  you may be interested in this.

I boot a CD using initrd; the RAMDISK uses devfs within the linuxrc script
to pivot_root/chroot as in the documentation.  In the documentation it
is suggested that root=/dev/rd/0  is used, if using devfs.

A boot using root=/dev/ram0 works fine, root=/dev/rd/0 shows a bug
in init/do_mounts.c, in void prepare_namespace(void)

The test:
if (initrd_load() && ROOT_DEV != MKDEV(RAMDISK_MAJOR, 0))
is true, and handle_initrd() is wrongly called.  This is a bug, (I assume
that this code is to relinquish the original boot).  The call that is used
is at the end of main.c where linuxrc is called instead of /sbin/init.

This is because rd/0 is not in root_dev_names; a patch is attached to fix
this.

Strangly enough, it still boots, despite linuxrc being called twice :-)

An alternative would be to change the documentation of initrd, so
that only root=/dev/ram0 is mentioned, despite using devfs.

Chris Lingard

--Boundary-00=_52Th/5ciwsSS1FR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.4.22-rd0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4.22-rd0.patch"

diff -Naur linux-2.4.22.old/init/do_mounts.c linux-2.4.22/init/do_mounts.c
--- linux-2.4.22.old/init/do_mounts.c	2003-09-10 12:18:55.000000000 +0100
+++ linux-2.4.22/init/do_mounts.c	2003-09-23 12:46:36.000000000 +0100
@@ -227,6 +227,11 @@
 	{ "ataraid/d13p",0x72D0 },
 	{ "ataraid/d14p",0x72E0 },
 	{ "ataraid/d15p",0x72F0 },
+#ifdef CONFIG_BLK_DEV_RAM
+#ifdef CONFIG_BLK_DEV_INITRD
+        { "rd/0",     0x0100 },
+#endif
+#endif
         { "rd/c0d0p",0x3000 },
         { "rd/c0d0p1",0x3001 },
         { "rd/c0d0p2",0x3002 },

--Boundary-00=_52Th/5ciwsSS1FR--
