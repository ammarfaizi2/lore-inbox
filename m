Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVFVRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVFVRQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFVRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:15:27 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:42459 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261746AbVFVRIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:08:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=o1SUHKXI0YiHwDBr3pcmXdHyyaSYwPEKrxhTpumXjijQS6paNk6yVbSkfsbUBzl7zKS6iFnHOR9Ycl68es+xm870TP/9WsXcPRYcEtBpBA5H4X6mIg+4puCyhHGklol/487Y3sZVUuNDMygBFNdmFsiAFafJENu9IUQTgexdb7U=
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Fwd: Fix vesafb/mtrr scaling problem.
Date: Wed, 22 Jun 2005 21:13:57 +0400
User-Agent: KMail/1.7.2
To: Alessandro <alezzandro@gmail.com>
Cc: Sebastian Kaergel <mailing@wodkahexe.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222113.57390.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro, please test this patch and report back if it fixes your problem.

 ----------  Forwarded Message  ----------

Subject: Fix vesafb/mtrr scaling problem.
Date: Wednesday 22 June 2005 03:03
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org


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
