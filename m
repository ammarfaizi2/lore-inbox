Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbSKDSrI>; Mon, 4 Nov 2002 13:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbSKDSrH>; Mon, 4 Nov 2002 13:47:07 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:908 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262621AbSKDSrG>; Mon, 4 Nov 2002 13:47:06 -0500
From: Erich Focht <efocht@ess.nec.de>
To: David Mosberger <davidm@hpl.hp.com>
Subject: O(1) scheduler fix for 2.5-ia64
Date: Mon, 4 Nov 2002 19:53:07 +0100
User-Agent: KMail/1.4.1
Cc: "linux-ia64" <linux-ia64@linuxia64.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_J4F2COX2VVUOJ7Q6FZ8W"
Message-Id: <200211041953.07209.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_J4F2COX2VVUOJ7Q6FZ8W
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi David,

this problem is wellknown and I actually thought that it was
solved. But it looks like the complex prepare_arch_switch()
etc. macros didn't make it into the 2.5 kernels for IA64. They are
needed on IA64 because we have to release the runqueue lock during
context switch. This is similar to sparc64. Thanks to John Hawks for
noticing this.

Please include this into your kernel tree.

Regards,
Erich

--------------Boundary-00=_J4F2COX2VVUOJ7Q6FZ8W
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="O1_switch_fix-2.5.45.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="O1_switch_fix-2.5.45.patch"

diff -urNp linux-2.5.45-ia64/include/asm-ia64/system.h linux-2.5.45-ia64-o1fix/include/asm-ia64/system.h
--- linux-2.5.45-ia64/include/asm-ia64/system.h	Mon Nov  4 19:31:52 2002
+++ linux-2.5.45-ia64-o1fix/include/asm-ia64/system.h	Mon Nov  4 19:46:35 2002
@@ -432,6 +432,18 @@ extern void ia64_load_extra (struct task
 } while (0)
 #endif
 
+#define prepare_arch_switch(rq, next)		\
+do {	spin_lock(&(next)->switch_lock);	\
+	spin_unlock(&(rq)->lock);		\
+} while (0)
+
+#define finish_arch_switch(rq, prev)		\
+do {	spin_unlock_irq(&(prev)->switch_lock);	\
+} while (0)
+
+#define task_running(rq, p) \
+	((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */

--------------Boundary-00=_J4F2COX2VVUOJ7Q6FZ8W--

