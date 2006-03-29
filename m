Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWC2ArX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWC2ArX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWC2ArX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:47:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51611 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750714AbWC2ArW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:47:22 -0500
Date: Tue, 28 Mar 2006 16:47:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <200603290027.k2T0R7g32314@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603281644270.16702@schroedinger.engr.sgi.com>
References: <200603290027.k2T0R7g32314@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Chen, Kenneth W wrote:

> Why not make unlock_buffer use test_and_clear_bit()?  Utilizing it's implied
> full memory fence and throw away the return value?  OK, OK, this is obscured.
> Then introduce clear_bit_memory_fence API or some sort.

Only for IA64's sake? Better clean up the bitops as you suggested earlier. 
The open ended acquires there leaves a weird feeling.

Something like this? (builds fine not tested yet)



Fix up the bitops for ia64.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.16.orig/include/asm-ia64/bitops.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/include/asm-ia64/bitops.h	2006-03-28 16:35:51.000000000 -0800
@@ -38,13 +38,14 @@ set_bit (int nr, volatile void *addr)
 	volatile __u32 *m;
 	CMPXCHG_BUGCHECK_DECL
 
+	/* Volatile load = acq */
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = 1 << (nr & 31);
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old | bit;
-	} while (cmpxchg_acq(m, old, new) != old);
+	} while (cmpxchg_rel(m, old, new) != old);
 }
 
 /**
@@ -65,7 +66,7 @@ __set_bit (int nr, volatile void *addr)
 /*
  * clear_bit() has "acquire" semantics.
  */
-#define smp_mb__before_clear_bit()	smp_mb()
+#define smp_mb__before_clear_bit()	do { /* skip */; } while (0)
 #define smp_mb__after_clear_bit()	do { /* skip */; } while (0)
 
 /**
@@ -85,13 +86,14 @@ clear_bit (int nr, volatile void *addr)
 	volatile __u32 *m;
 	CMPXCHG_BUGCHECK_DECL
 
+	/* Volatile load = acq */
 	m = (volatile __u32 *) addr + (nr >> 5);
 	mask = ~(1 << (nr & 31));
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old & mask;
-	} while (cmpxchg_acq(m, old, new) != old);
+	} while (cmpxchg_rel(m, old, new) != old);
 }
 
 /**
@@ -121,13 +123,14 @@ change_bit (int nr, volatile void *addr)
 	volatile __u32 *m;
 	CMPXCHG_BUGCHECK_DECL
 
+	/* Volatile load = acq */
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = (1 << (nr & 31));
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old ^ bit;
-	} while (cmpxchg_acq(m, old, new) != old);
+	} while (cmpxchg_rel(m, old, new) != old);
 }
 
 /**
@@ -160,13 +163,14 @@ test_and_set_bit (int nr, volatile void 
 	volatile __u32 *m;
 	CMPXCHG_BUGCHECK_DECL
 
+	/* Volatile load = acq */
 	m = (volatile __u32 *) addr + (nr >> 5);
 	bit = 1 << (nr & 31);
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old | bit;
-	} while (cmpxchg_acq(m, old, new) != old);
+	} while (cmpxchg_rel(m, old, new) != old);
 	return (old & bit) != 0;
 }
 
@@ -205,13 +209,14 @@ test_and_clear_bit (int nr, volatile voi
 	volatile __u32 *m;
 	CMPXCHG_BUGCHECK_DECL
 
+	/* Volatile load = acq */
 	m = (volatile __u32 *) addr + (nr >> 5);
 	mask = ~(1 << (nr & 31));
 	do {
 		CMPXCHG_BUGCHECK(m);
 		old = *m;
 		new = old & mask;
-	} while (cmpxchg_acq(m, old, new) != old);
+	} while (cmpxchg_rel(m, old, new) != old);
 	return (old & ~mask) != 0;
 }
 
