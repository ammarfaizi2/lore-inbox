Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135310AbRDLUJO>; Thu, 12 Apr 2001 16:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135311AbRDLUJE>; Thu, 12 Apr 2001 16:09:04 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:31243 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S135310AbRDLUIu>; Thu, 12 Apr 2001 16:08:50 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Christoph Hellwig <hch@ns.caldera.de>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A2C.006EA2DE.00@smtpnotes.altec.com>
Date: Thu, 12 Apr 2001 15:08:28 -0500
Subject: Re: badly punctuated parameter list in `#define' (2.4.3-ac5 and 2
	.4.4 -pre2)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig <hch@ns.caldera.de> wrote:

>So the /* old gcc */ part should probably be enabled based on a define for the

>old compiler.  The right ifdef seems to be:

>
>  #if __GNUC__ == 2 && __GNUC_MINOR__ < 95
>
>Could you test it this way?

Yes, that works for me.  Is this the sort of thing you had in mind?

Wayne


--- include/asm-i386/rwsem.h.old   Thu Apr 12 14:50:08 2001
+++ include/asm-i386/rwsem.h  Thu Apr 12 14:54:14 2001
@@ -20,18 +20,24 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>

+#if __GNUC__ == 2 && __GNUC_MINOR__ < 95
+
+/* old gcc */
 #if RWSEM_DEBUG
-#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); }
while(0)
+#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); }
while(0)
 #else
-#define rwsemdebug(FMT,...)
+#define rwsemdebug(FMT, ARGS...)
 #endif

-/* old gcc */
+#else
+
 #if RWSEM_DEBUG
-//#define rwsemdebug(FMT, ARGS...) do { if (sem->debug) printk(FMT,##ARGS); }
while(0)
+#define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); }
while(0)
 #else
-//#define rwsemdebug(FMT, ARGS...)
+#define rwsemdebug(FMT,...)
 #endif
+
+#endif /* __GNUC__ == 2 && __GNUC_MINOR__ < 95 */

 #ifdef CONFIG_X86_XADD
 #include <asm/rwsem-xadd.h> /* use XADD based semaphores if possible */


