Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRGCUuw>; Tue, 3 Jul 2001 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266007AbRGCUum>; Tue, 3 Jul 2001 16:50:42 -0400
Received: from [209.21.47.229] ([209.21.47.229]:32528 "EHLO
	therouter.routefree.com") by vger.kernel.org with ESMTP
	id <S266006AbRGCUub>; Tue, 3 Jul 2001 16:50:31 -0400
Message-ID: <034101c10401$feec9340$b300000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: <linux-kernel@vger.kernel.org>
Cc: <paulus@linuxcare.com.au>
Subject: [PATCH] ppp_generic.c - kfree(ppp) called twice, kernel 2.4.0
Date: Tue, 3 Jul 2001 13:50:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In ppp_destroy_interface(), there is a chance that kfree(ppp) is called
twice, causing a kernel oops when ppp is opened again.  I was able to cause
this by running PPPOE, and killing -9 pppd and pppoe-daemon with one kill
command.  By doing this, the closing of ppp->dev causes a
ppp_disconnect_channel(), which calls kfree(ppp) assuming the ppp unit is
dead.  But destroy_interface() hasn't finished, and it tries to kfree(ppp)
also.  I simply moved the closing of the device to after the channels == 0
check.  Anyways, follows is the patch.  Please cc comments to
eli@routefree.com.

thanks,
Eli Chen


--- ppp_generic.c 2001/02/21 00:53:01 1.1.1.2
+++ ppp_generic.c 2001/07/03 20:37:22
@@ -2268,13 +2268,6 @@
  ppp->dev = 0;
  ppp_unlock(ppp);

- if (dev) {
-  rtnl_lock();
-  dev_close(dev);
-  unregister_netdevice(dev);
-  rtnl_unlock();
- }
-
  /*
   * We can't acquire any new channels (since we have the
   * all_ppp_lock) so if n_channels is 0, we can free the
@@ -2283,6 +2276,13 @@
   */
  if (ppp->n_channels == 0)
   kfree(ppp);
+
+ if (dev) {
+  rtnl_lock();
+  dev_close(dev);
+  unregister_netdevice(dev);
+  rtnl_unlock();
+ }

  spin_unlock(&all_ppp_lock);
 }


