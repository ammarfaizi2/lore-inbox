Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbRGTSnc>; Fri, 20 Jul 2001 14:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbRGTSnX>; Fri, 20 Jul 2001 14:43:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23337 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S267076AbRGTSnK>; Fri, 20 Jul 2001 14:43:10 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Gardiner <kiwiunix@ihug.co.nz>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Re: MTD compiling error
In-Reply-To: <01072012460800.09910@kiwiunix.ihug.co.nz>
	<27335.995623038@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jul 2001 12:37:22 -0600
In-Reply-To: <27335.995623038@redhat.com>
Message-ID: <m1r8vb1m71.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David Woodhouse <dwmw2@infradead.org> writes:

> kiwiunix@ihug.co.nz said:
> > /usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: `do_softirq' undeclared
> (first use in this function)

Dave this isn't a sufficient fix.  In particular amd_flash.c has problems,
if you only patch cfi.h.  The problem is local_bh_enable by way of
do_unlock_bh.  Or in particular the changes to asm-i386/softirq.h 

The following should fix every case the changes to softirq.h broke.  I would
love to include linux/interrupt.h but that isn't currently possible.

Eric

--- linux-2.4.6/include/asm-i386/softirq.h	Thu Jul 19 15:33:26 2001
+++ linux-2.4.6.eb1.1/include/asm-i386/softirq.h	Thu Jul 19 17:19:04 2001
@@ -4,6 +4,12 @@
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 
+/* FIXME getting the declaraion for do_softirq from interrupt.h is an
+ * include nightmare, this needs to be fixed instead of declaring
+ * do_softirq directly.
+ */
+extern asmlinkage void do_softirq(void);
+
 #define __cpu_bh_enable(cpu) \
 		do { barrier(); local_bh_count(cpu)--; } while (0)
 #define cpu_bh_disable(cpu) \

