Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVFUXHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVFUXHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVFUXGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:06:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36546 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262410AbVFUXDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:03:35 -0400
Date: Tue, 21 Jun 2005 19:03:23 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Fix vesafb/mtrr scaling problem.
Message-ID: <20050621230322.GA19949@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vesafb will do really silly things like..

mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,4000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,2000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,1000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,800000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,400000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,200000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,100000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,80000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,40000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,20000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,10000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,8000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,4000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,2000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,1000 old: write-back new: write-combining
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x800  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x400  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x200  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x100  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x80  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x40  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x20  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x10  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x8  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x4  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x2  base: 0xe0000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x1  base: 0xe0000000

Stop scaling down at PAGE_SIZE.
Also fix up some broken indentation.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/drivers/video/vesafb.c~	2005-06-21 18:55:59.000000000 -0400
+++ linux-2.6.12/drivers/video/vesafb.c	2005-06-21 18:57:26.000000000 -0400
@@ -389,10 +389,11 @@ static int __init vesafb_probe(struct de
 		int temp_size = size_total;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
-                	temp_size &= (temp_size - 1);
-                        
-                /* Try and find a power of two to add */
-		while (temp_size && mtrr_add(vesafb_fix.smem_start, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
+			temp_size &= (temp_size - 1);
+
+		/* Try and find a power of two to add */
+		while (temp_size > PAGE_SIZE &&
+			mtrr_add(vesafb_fix.smem_start, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
 			temp_size >>= 1;
 		}
 	}
