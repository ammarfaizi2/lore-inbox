Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUHEV0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUHEV0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUHEV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:26:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12688 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267953AbUHEUq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:46:59 -0400
Date: Thu, 5 Aug 2004 17:06:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de, akpm@osdl.org
Subject: [PATCH] x86 bitops.h commentary on instruction reordering
Message-ID: <20040805200622.GA17324@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Back when we were discussing the need for a memory barrier in sync_page(), 
it came to me (thanks Andrea!) that the bit operations can be perfectly 
reordered on architectures other than x86. 

I think the commentary on i386 bitops.h is misleading, its worth 
to note that that these operations are not guaranteed not to be 
reordered on different architectures. 

clear_bit() already does that:

 * clear_bit() is atomic and may not be reordered.  However, it does
 * not contain a memory barrier, so if it is used for locking purposes,
 * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
 * in order to ensure changes are visible on other processors.

What you think of the following


--- a/include/asm-i386/bitops.h.orig	2004-08-05 17:35:40.639336160 -0300
+++ b/include/asm-i386/bitops.h	2004-08-05 17:35:12.486616024 -0300
@@ -30,7 +30,12 @@
  * @addr: the address to start counting from
  *
  * This function is atomic and may not be reordered.  See __set_bit()
- * if you do not require the atomic guarantees.
+ * if you do not require the atomic guarantees. 
+ * 
+ * Note: there are no guarantees that this function will not be reordered 
+ * on non x86 architectures, so if you are writting portable code, 
+ * make sure not to rely on its reordering guarantees.
+ * 
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
@@ -109,7 +114,8 @@ static inline void __change_bit(int nr, 
  * @nr: Bit to change
  * @addr: Address to start counting from
  *
- * change_bit() is atomic and may not be reordered.
+ * change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
@@ -127,6 +133,7 @@ static inline void change_bit(int nr, vo
  * @addr: Address to count from
  *
  * This operation is atomic and cannot be reordered.  
+ * It may be reordered on other architectures than x86.
  * It also implies a memory barrier.
  */
 static inline int test_and_set_bit(int nr, volatile unsigned long * addr)
@@ -165,7 +172,8 @@ static inline int __test_and_set_bit(int
  * @nr: Bit to clear
  * @addr: Address to count from
  *
- * This operation is atomic and cannot be reordered.  
+ * This operation is atomic and cannot be reordered. 
+ * It can be reorderdered on other architectures other than x86.
  * It also implies a memory barrier.
  */
 static inline int test_and_clear_bit(int nr, volatile unsigned long * addr)
