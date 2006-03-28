Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWC1XsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWC1XsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWC1XsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:48:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4247 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964843AbWC1XsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:48:23 -0500
Date: Tue, 28 Mar 2006 15:48:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
cc: Zoltan Menyhart <Zoltan.Menyhart@free.fr>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <4429ADBC.50507@free.fr>
Message-ID: <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
References: <200603281853.k2SIrGg28290@unix-os.sc.intel.com> <4429ADBC.50507@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Zoltan Menyhart wrote:

> Why not to use separate bit operations for different purposes?
> 
> - e.g. "test_and_set_bit_N_acquire()" for lock acquisition
> - "test_and_set_bit()", "clear_bit()" as they are today
> - "release_N_clear_bit()"...
> 

That would force IA64 specifics onto all other architectures.

Could we simply define these smb_mb__*_clear_bit to be noops
and then make the atomic bit ops to have full barriers? That would satisfy 
Nick's objections.

Index: linux-2.6.16/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.16.orig/include/asm-ia64/bitops.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/include/asm-ia64/bitops.h	2006-03-28 15:45:08.000000000 -0800
@@ -45,6 +45,7 @@
 		old = *m;
 		new = old | bit;
 	} while (cmpxchg_acq(m, old, new) != old);
+	smb_mb();
 }
 
 /**
@@ -65,7 +66,7 @@
 /*
  * clear_bit() has "acquire" semantics.
  */
-#define smp_mb__before_clear_bit()	smp_mb()
+#define smp_mb__before_clear_bit()	do { } while (0)
 #define smp_mb__after_clear_bit()	do { /* skip */; } while (0)
 
 /**
@@ -92,6 +93,7 @@
 		old = *m;
 		new = old & mask;
 	} while (cmpxchg_acq(m, old, new) != old);
+	smp_mb();
 }
 
 /**
@@ -128,6 +130,7 @@
 		old = *m;
 		new = old ^ bit;
 	} while (cmpxchg_acq(m, old, new) != old);
+	smp_mb();
 }
 
 /**
@@ -167,6 +170,7 @@
 		old = *m;
 		new = old | bit;
 	} while (cmpxchg_acq(m, old, new) != old);
+	smp_mb();
 	return (old & bit) != 0;
 }
 
@@ -212,6 +216,7 @@
 		old = *m;
 		new = old & mask;
 	} while (cmpxchg_acq(m, old, new) != old);
+	smp_mb();
 	return (old & ~mask) != 0;
 }
 
@@ -257,6 +262,7 @@
 		old = *m;
 		new = old ^ bit;
 	} while (cmpxchg_acq(m, old, new) != old);
+	smp_mb();
 	return (old & bit) != 0;
 }
 
