Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWFUU7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWFUU7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWFUU7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:59:34 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:48871 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030280AbWFUU7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:59:33 -0400
Date: Wed, 21 Jun 2006 22:59:32 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm 1/6] cpu_relax(): interrupt.h
Message-ID: <20060621205932.GA22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add cpu_relax() to tasklet_unlock_wait() loop.


I kept barrier() since it is said to still be required, in various older
postings.
Took care of kernel style formatting.

Tested on 2.6.17-mm1.


This is the first patch within a set, which aims to improve P4 HT performance
a bit:
these SMT CPUs want a rep nop (pause) (as done by cpu_relax()) when
busy-polling, in order to free pipeline resources for the SMT CPU sibling.

During I/O polling cpu_relax() will help for non-P4 CPUs, too (reduce
power consumption there).

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/include/linux/interrupt.h linux-2.6.17-mm1.my/include/linux/interrupt.h
--- linux-2.6.17-mm1.orig/include/linux/interrupt.h	2006-06-21 14:28:19.000000000 +0200
+++ linux-2.6.17-mm1.my/include/linux/interrupt.h	2006-06-21 21:34:12.000000000 +0200
@@ -227,7 +227,10 @@
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		barrier();
+		cpu_relax();
+	}
 }
 #else
 #define tasklet_trylock(t) 1
