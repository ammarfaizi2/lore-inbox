Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWC1D7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWC1D7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWC1D7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:59:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34183 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750839AbWC1D7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:59:07 -0500
Date: Mon, 27 Mar 2006 19:59:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: nickpiggin@yahoo.com.au, Zoltan.Menyhart@free.fr,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Fix unlock_buffer() to work the same way as bit_unlock()
Message-ID: <Pine.LNX.4.64.0603271953150.7469@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently unlock_buffer() contains a smb_mb__after_clear_bit() which is 
weird because bit_spin_unlock() uses smb_mb__before_clear_bit():

>From include/linux/bit_spinlock.h:

static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
{
        smp_mb__before_clear_bit();
        clear_bit(bitnum, addr);
        preempt_enable();
        __release(bitlock);
}

For most architectures there is no difference because both
smp_mb__after_clear_bit() and smp_mb__before_clear_bit() are both
memory barriers and clear_buffer_locked() is an atomic operation.
However, they differ under IA64.

Note that this potential race has never been seen under IA64. It was 
discovered by inspection by Zoltan Menyhart <Zoltan.Menyhart@free.fr>. 

Regardless if this is a true race or not, I think the unlock sequence 
needs to be the same for bit locks and unlock_buffer(). Maybe 
unlock_buffer and lock_buffer better use bit spinlock operations?

Change unlock_buffer() to work the same way as bit_spin_unlock.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2006-03-27 14:09:54.000000000 -0800
+++ linux-2.6/fs/buffer.c	2006-03-27 19:40:32.000000000 -0800
@@ -78,8 +78,8 @@ EXPORT_SYMBOL(__lock_buffer);
 
 void fastcall unlock_buffer(struct buffer_head *bh)
 {
+	smp_mb__before_clear_bit();
 	clear_buffer_locked(bh);
-	smp_mb__after_clear_bit();
 	wake_up_bit(&bh->b_state, BH_Lock);
 }
 
