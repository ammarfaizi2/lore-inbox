Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTKLGQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 01:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTKLGQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 01:16:04 -0500
Received: from 34-177.unigate.net.tw ([202.3.177.34]:11167 "HELO
	ali.ali.com.tw") by vger.kernel.org with SMTP id S261787AbTKLGQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 01:16:00 -0500
Subject: [PATCH] update for ALi5455 Audio Driver for 2.4.20
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes R5.0 (Intl) 30 March 1999
Message-ID: <OF347800BA.593B8268-ON48256DDC.0021B651@LocalDomain>
From: wei_ni@ali.com.tw
Date: Wed, 12 Nov 2003 14:19:43 +0800
X-MIMETrack: Serialize by Router on TWALINS2/ALI_TPE/ACER(Release 5.0.8 |June 18, 2001) at
 2003/11/12 02:10:42 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

We resolve the bugs in ALi5455 audio driver.

Best regards,

Ni wei
http://www.ali.com.tw

Information about update:
Updated files:      ali5455.c
Location:      drivers/sound
Driver Version:     0.02ac
Kernel Version:     2.4.20

patchfile for ali5455.c:
---------------------------------------------------------------------------------
--- ali5455.c.orig  2003-11-12 10:14:05.000000000 +0800
+++ ali5455.c  2003-11-12 10:48:26.000000000 +0800
@@ -1253,17 +1253,15 @@
 {
     struct dmabuf *dmabuf = &state->dmabuf;
     int free;
-    ali_update_ptr(state);
-    // catch underruns during playback
+
     if (dmabuf->count < 0) {
          dmabuf->count = 0;
          dmabuf->swptr = dmabuf->hwptr;
     }
-    free = dmabuf->dmasize - dmabuf->count;
-    free -= (dmabuf->hwptr % dmabuf->fragsize);
-    if (free < 0)
-         return (0);
-    return (free);
+    free = dmabuf->dmasize - dmabuf->swptr;
+    if ((dmabuf->count + free) > dmabuf->dmasize)
+         free = dmabuf->dmasize - dmabuf->count;
+    return free;
 }

 static inline int ali_get_available_read_data(struct
@@ -1859,6 +1857,7 @@
                  NOTHING we can do to prevent it. */

               /* FIXME - do timeout handling here !! */
+              schedule_timeout(tmo >= 2 ? tmo : 2);

               if (signal_pending(current)) {
                    if (!ret)
@@ -1959,7 +1958,7 @@
     if (size > (PAGE_SIZE << dmabuf->buforder))
          goto out;
     ret = -EAGAIN;
-    if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
size, vma->vm_page_prot))
+    if (remap_page_range(vma,vma->vm_start, virt_to_phys(dmabuf->rawbuf),
size, vma->vm_page_prot))
          goto out;
     dmabuf->mapped = 1;
     dmabuf->trigger = 0;

Ni Wei
2003-11-12

