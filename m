Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUHKSSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUHKSSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268154AbUHKSR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:17:59 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:36424 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268139AbUHKSQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:16:45 -0400
Message-ID: <e7963922040811111655dc228e@mail.gmail.com>
Date: Wed, 11 Aug 2004 20:16:44 +0200
From: Stefan Schweizer <sschweizer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for ALSA AC'97 Init not working in post 2.6.7 mm-kernels
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that my soundcad stopped working in the mm-kernels after 2.6.7.
The kernel log produces this message:

AC'97 0 does not respond - RESET

I grepped for it in the mm-patch and reverted the mm-changes there,
that fixed it for me.
I do not know what the change in the code is useful for but it breaks
my soundcard
Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
driver snd-intel8x0

My Revert-fix-patch:
--- linux-2.6.8-rc4-mm1/sound/pci/ac97/ac97_codec.c.orig       
2004-08-11 20:07:12.359531728 +0200
+++ linux-2.6.8-rc4-mm1/sound/pci/ac97/ac97_codec.c     2004-08-11
20:07:24.743649056 +0200
@@ -1891,14 +1891,8 @@
                bus->ops->wait(ac97);
        else {
                udelay(50);
-               if (ac97->scaps & AC97_SCAP_SKIP_AUDIO)
-                       err = ac97_reset_wait(ac97, HZ/2, 1);
-               else {
-                       err = ac97_reset_wait(ac97, HZ/2, 0);
-                       if (err < 0)
-                               err = ac97_reset_wait(ac97, 0, 1);
-               }
-               if (err < 0) {
+               if (ac97_reset_wait(ac97, HZ/2, 0) < 0 &&
+                   ac97_reset_wait(ac97, HZ/2, 1) < 0) {
                        snd_printk(KERN_WARNING "AC'97 %d does not
respond - RESET\n", ac97->num);
                        /* proceed anyway - it's often non-critical */
                }
