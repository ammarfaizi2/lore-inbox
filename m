Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSG2ICK>; Mon, 29 Jul 2002 04:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSG2ICK>; Mon, 29 Jul 2002 04:02:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313125AbSG2ICI>;
	Mon, 29 Jul 2002 04:02:08 -0400
Message-ID: <3D44F94D.E6F949AE@zip.com.au>
Date: Mon, 29 Jul 2002 01:14:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: util-linux@math.uio.no
CC: lkml <linux-kernel@vger.kernel.org>
Subject: kernel profiler in 2.5.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel profiler broke quite some time ago.  It's actually
a problem with readprofile(8).   It doesn't like the weak
symbols in System.map:

c011fb04 T notifier_call_chain
c011fb44 T register_reboot_notifier
c011fb5c T unregister_reboot_notifier
c011fb74 T sys_ni_syscall
c011fb74 W sys_acct
c011fb74 W sys_quotactl
c011fb80 t proc_sel
c011fc28 T sys_setpriority

Here's a quick fix.  There are probably smarter ways...

--- sys-utils/readprofile.c.orig	Mon Jul 29 00:58:46 2002
+++ sys-utils/readprofile.c	Mon Jul 29 00:59:27 2002
@@ -267,7 +267,8 @@
 		/* ignore any LEADING (before a '[tT]' symbol is found)
 		   Absolute symbols */
 		if (*mode == 'A' && total == 0) continue;
-		if (*mode!='T' && *mode!='t') break;/* only text is profiled */
+		if (*mode!='T' && *mode!='t' && *mode!='w' && *mode != 'W')
+			break;/* only text is profiled */
 
 		if (indx >= len / sizeof(*buf)) {
 			fprintf(stderr, _("%s: profile address out of range. "


And now HZ has been set to 1000, the resolution is awfully
good.  The `-M' multiplier thing we added is overkill now.


-
