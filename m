Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVHMAsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVHMAsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 20:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVHMAsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 20:48:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14587 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750836AbVHMAsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 20:48:08 -0400
Message-ID: <42FD42C1.6040009@mvista.com>
Date: Fri, 12 Aug 2005 17:45:53 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] eliminte NMI entry/ exit code
Content-Type: multipart/mixed;
 boundary="------------000805030702000009090001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------000805030702000009090001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The NMI entry and exit code fiddles with bits in the preempt count.  If 
an NMI happens while some other code is doing the same, bits will be 
lost.  This patch removes this modify code from the NMI path till we can 
come up with something better.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------000805030702000009090001
Content-Type: text/plain;
 name="fix-nmi-enter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-nmi-enter.patch"

Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
Type: Defect Fix 

Description:

    Modifying a word from NMI code runs the very real risk of loosing
    either then new or the old bits.  Remember, we can not prevent an
    NMI interrupt from ANYWHERE, inparticular between the read and the
    write of a read modify write sequence.

    This patch removes the update of the preempt count from the NMI
    path.

Signed-off-by: George Anzinger<george@mvista.com>

 hardirq.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc/include/linux/hardirq.h
===================================================================
--- linux-2.6.13-rc.orig/include/linux/hardirq.h
+++ linux-2.6.13-rc/include/linux/hardirq.h
@@ -98,9 +98,12 @@ extern void synchronize_irq(unsigned int
 #else
 # define synchronize_irq(irq)	barrier()
 #endif
-
-#define nmi_enter()		irq_enter()
-#define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
+/*
+ * Re think these.  NMI _must_not_ share data words with non-nmi code
+ * Meanwhile, just do a no-op.
+ */
+#define nmi_enter()	/*	irq_enter()  */
+#define nmi_exit()	/*	sub_preempt_count(HARDIRQ_OFFSET) */
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 static inline void account_user_vtime(struct task_struct *tsk)

--------------000805030702000009090001--
