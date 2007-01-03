Return-Path: <linux-kernel-owner+w=401wt.eu-S1754917AbXACIBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbXACIBN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 03:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755001AbXACIBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 03:01:13 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:39743 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbXACIBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 03:01:12 -0500
Date: Wed, 3 Jan 2007 00:01:01 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: [rfc] [patch 2/2] spin_lock_irq: Enable interrupts while spinning -- x86_64 implementation
Message-ID: <20070103080101.GB3789@localhost.localdomain>
References: <20070103075923.GA3789@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103075923.GA3789@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement interrupt enabling while spinning for lock for spin_lock_irq

Signed-off by: Pravin B. Shelar <pravin.shelar@calsoftinc.com>
Signed-off by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.20-rc1/include/asm-x86_64/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-x86_64/spinlock.h	2006-12-28 17:18:32.142775000 -0800
+++ linux-2.6.20-rc1/include/asm-x86_64/spinlock.h	2006-12-29 14:05:04.012954000 -0800
@@ -63,7 +63,21 @@ static inline void __raw_spin_lock_flags
 		"5:\n\t"
 		: "+m" (lock->slock) : "r" ((unsigned)flags) : "memory");
 }
-#define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
+static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
+{
+	asm volatile(
+		"\n1:\t"
+		LOCK_PREFIX " ; decl %0\n\t"
+		"jns 2f\n"
+		"sti\n"		/* Enable interrupts during spin */
+		"3:\n"
+		"rep;nop\n\t"
+		"cmpl $0,%0\n\t"
+		"jle 3b\n\t"
+		"cli\n"
+		"jmp 1b\n"
+		"2:\t" : "+m" (lock->slock) : : "memory");
+}
 #endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
