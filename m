Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTDJDZ4 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 23:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTDJDZz (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 23:25:55 -0400
Received: from [202.109.126.231] ([202.109.126.231]:37165 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id S263884AbTDJDZy (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 23:25:54 -0400
Message-ID: <3E94E6EA.5CF533A2@mic.com.tw>
Date: Thu, 10 Apr 2003 11:37:14 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [rfc][patch]: fix handler race in HDIO_DRIVE_RESET path for 2.5.67-ac1
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net> <1048514373.25136.4.camel@irongate.swansea.linux.org.uk> <20030324180125.2606b046.alex@ssi.bg> <1048527607.25655.18.camel@irongate.swansea.linux.org.uk> <3E8BDC10.D0195D71@mic.com.tw> <20030403071620.GJ2072@suse.de> <3E8BF293.2CC30C1F@mic.com.tw>
Content-Type: multipart/mixed;
 boundary="------------6B8585142F17A95670C95165"
X-OriginalArrivalTime: 10 Apr 2003 03:33:22.0687 (UTC) FILETIME=[F00F80F0:01C2FF11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B8585142F17A95670C95165
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
    I found there's another 50 msec wait needed after the
first reset poll handler return to avoid the handler race.
but I can't find out reason why.

regards
rain.w

--------------6B8585142F17A95670C95165
Content-Type: text/plain; charset=us-ascii;
 name="ide.c.diff.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide.c.diff.2"

--- /usr/src/linux-2.5.67-ac1/drivers/ide/ide.c	Wed Apr  9 11:31:40 2003
+++ ide.c	Wed Apr  9 13:31:18 2003
@@ -1608,6 +1608,10 @@
 			HWGROUP(drive)->busy = 1;
 			spin_unlock_irqrestore(&ide_lock, flags);
 			(void) ide_do_reset(drive);
+
+			/* wait for another 50ms */
+			mdelay(50);
+
 			if (drive->suspend_reset) {
 /*
  *				APM WAKE UP todo !!

--------------6B8585142F17A95670C95165--

