Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293089AbSCJQoE>; Sun, 10 Mar 2002 11:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293091AbSCJQn6>; Sun, 10 Mar 2002 11:43:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:49610 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S293089AbSCJQnp>;
	Sun, 10 Mar 2002 11:43:45 -0500
Date: Sun, 10 Mar 2002 17:43:43 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203101643.RAA02302@harpo.it.uu.se>
To: paulus@samba.org
Subject: [PATCH] 2.5.6 PPP deflate breakage on UP
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.5.6, PPP deflate isn't compiled correctly if CONFIG_SMP
is off: the macros local_bh_enable() and local_bh_disable() aren't
expanded and instead turn into references to undefined functions.
The problem is that <linux/smp_lock.h> is insufficient in UP configs.

The patch below adds an #include <linux/interrupt.h> which works
around this. I'm not sure about <linux/smp_lock.h>: it really doesn't
look appropriate for the locking primitives being used in ppp_deflate.c.

/Mikael

--- linux-2.5.6/drivers/net/ppp_deflate.c.~1~	Sat Mar  9 12:53:13 2002
+++ linux-2.5.6/drivers/net/ppp_deflate.c	Sun Mar 10 14:32:04 2002
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 
 #include <linux/ppp_defs.h>
