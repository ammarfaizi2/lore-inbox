Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbTILVMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTILVMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:12:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62366 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261883AbTILVME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:12:04 -0400
Message-ID: <3F623696.1080703@pobox.com>
Date: Fri, 12 Sep 2003 17:11:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ifdown/ifup bug
Content-Type: multipart/mixed;
 boundary="------------090302040002090106050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090302040002090106050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

If you haven't gotten this patch from somebody else, please make sure 
this is applied.  It fixes a bug I introduced in -pre3 when moving some 
helpers from tg3 to netdevice.h.

	Jeff



--------------090302040002090106050308
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Fri Sep 12 17:10:03 2003
+++ b/net/core/dev.c	Fri Sep 12 17:10:03 2003
@@ -851,7 +851,11 @@
 	 * engine, but this requires more changes in devices. */
 
 	smp_mb__after_clear_bit(); /* Commit netif_running(). */
-	netif_poll_disable(dev);
+	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
+		/* No hurry. */
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(1);
+	}
 
 	/*
 	 *	Call the device specific close. This cannot fail.

--------------090302040002090106050308--

