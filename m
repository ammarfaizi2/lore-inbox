Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbTDFKj6 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbTDFKj6 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:39:58 -0400
Received: from dp.samba.org ([66.70.73.150]:45238 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262908AbTDFKj5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 06:39:57 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.1605.850281.508104@nanango.paulus.ozlabs.org>
Date: Sun, 6 Apr 2003 20:49:41 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix mdelay
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mdelay macro uses a variable called `msec'.  The effect of this is
that the statements msec = 1; mdelay(msec); will spin for an
indeterminate length of time, because you end up with a statement like
this:

	({unsigned long msec=(msec); while (msec--) udelay(1000);}))

and the msec in that statement is uninitialized.  This actually bit me
in sound/ppc/awacs.c.  The patch below changes the name of the loop
variable to __ms, which will hopefully have a lower chance of a
collision.

Please apply.

Paul.

diff -urN linux-2.5/include/linux/delay.h pmac-2.5/include/linux/delay.h
--- linux-2.5/include/linux/delay.h	2003-02-19 18:57:10.000000000 +1100
+++ pmac-2.5/include/linux/delay.h	2003-04-06 18:58:10.000000000 +1000
@@ -31,7 +31,7 @@
 #else
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
-	({unsigned long msec=(n); while (msec--) udelay(1000);}))
+	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
 #endif
 
 #ifndef ndelay
