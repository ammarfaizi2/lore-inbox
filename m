Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUD3UvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUD3UvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbUD3UpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:45:12 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:22977 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265171AbUD3Uin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:38:43 -0400
From: Duncan Sands <baldrick@free.fr>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: usbcore.ko linkage problem on x86_64
Date: Fri, 30 Apr 2004 22:38:40 +0200
User-Agent: KMail/1.5.4
References: <200404301812.10676.rjwysocki@sisk.pl>
In-Reply-To: <200404301812.10676.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404302238.40347.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There seems to be a linkage problem with the usbcore.ko module in the
> 2.6.6-rc2-mm2 and 2.6.6-rc3-mm1 kernels.  Namely, I get this message:
>
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.6-rc3-mm1;
> fi WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/usb/core/usbcore.ko
> needs unknown symbol destroy_all_async
>
> after "make modules_install".  AFAICS, it does not occur for the 2.6.6-rc2
> kernel.

Hi RJW, does this help?  (I also got rid of the unused ld2 while I
was there).

All the best,

Duncan.

 devio.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Fri Apr 30 23:36:25 2004
+++ b/drivers/usb/core/devio.c	Fri Apr 30 23:36:25 2004
@@ -165,31 +165,6 @@
 	return ret;
 }
 
-extern inline unsigned int ld2(unsigned int x)
-{
-        unsigned int r = 0;
-        
-        if (x >= 0x10000) {
-                x >>= 16;
-                r += 16;
-        }
-        if (x >= 0x100) {
-                x >>= 8;
-                r += 8;
-        }
-        if (x >= 0x10) {
-                x >>= 4;
-                r += 4;
-        }
-        if (x >= 4) {
-                x >>= 2;
-                r += 2;
-        }
-        if (x >= 2)
-                r++;
-        return r;
-}
-
 /*
  * async list handling
  */
@@ -219,7 +194,7 @@
         kfree(as);
 }
 
-extern __inline__ void async_newpending(struct async *as)
+static inline void async_newpending(struct async *as)
 {
         struct dev_state *ps = as->ps;
         unsigned long flags;
@@ -229,7 +204,7 @@
         spin_unlock_irqrestore(&ps->lock, flags);
 }
 
-extern __inline__ void async_removepending(struct async *as)
+static inline void async_removepending(struct async *as)
 {
         struct dev_state *ps = as->ps;
         unsigned long flags;
@@ -239,7 +214,7 @@
         spin_unlock_irqrestore(&ps->lock, flags);
 }
 
-extern __inline__ struct async *async_getcompleted(struct dev_state *ps)
+static inline struct async *async_getcompleted(struct dev_state *ps)
 {
         unsigned long flags;
         struct async *as = NULL;
@@ -253,7 +228,7 @@
         return as;
 }
 
-extern __inline__ struct async *async_getpending(struct dev_state *ps, void __user *userurb)
+static inline struct async *async_getpending(struct dev_state *ps, void __user *userurb)
 {
         unsigned long flags;
         struct async *as;
@@ -321,7 +296,7 @@
 	destroy_async(ps, &hitlist);
 }
 
-extern __inline__ void destroy_all_async(struct dev_state *ps)
+static inline void destroy_all_async(struct dev_state *ps)
 {
 	        destroy_async(ps, &ps->async_pending);
 }
