Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbRGPAtn>; Sun, 15 Jul 2001 20:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbRGPAtf>; Sun, 15 Jul 2001 20:49:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22656 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267163AbRGPAt1>;
	Sun, 15 Jul 2001 20:49:27 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15186.14872.117342.143216@pizda.ninka.net>
Date: Sun, 15 Jul 2001 17:49:28 -0700 (PDT)
To: David Ford <david@blue-labs.org>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac4
In-Reply-To: <3B52335C.7040005@blue-labs.org>
In-Reply-To: <20010716004933.A18030@lightning.swansea.linux.org.uk>
	<3B52335C.7040005@blue-labs.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Ford writes:
 > Have you reviewed the patch I posted yesterday regarding net_dev_init() 
 > and double lock in sch_teql.c?
 > 
 > net_dev_init() is originally called in genhd.c, I don't see as it's 
 > necessary to call it again.

It is called early if a device initialization occurs before
the genhd.c call, which is entirely possibly particularly on s390.
Your change would break s390* ports.

I sent the correct fix to Linus last night, which is:

--- net/core/dev.c.~1~	Mon Jul  9 22:19:33 2001
+++ net/core/dev.c	Sat Jul 14 17:25:51 2001
@@ -2654,10 +2654,6 @@
 	if (!dev_boot_phase)
 		return 0;
 
-#ifdef CONFIG_NET_SCHED
-	pktsched_init();
-#endif
-
 #ifdef CONFIG_NET_DIVERT
 	dv_init();
 #endif /* CONFIG_NET_DIVERT */
@@ -2771,6 +2767,10 @@
 
 	dst_init();
 	dev_mcast_init();
+
+#ifdef CONFIG_NET_SCHED
+	pktsched_init();
+#endif
 
 	/*
 	 *	Initialise network devices

