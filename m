Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTIPJr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTIPJr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:47:58 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:43662 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261820AbTIPJr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:47:56 -0400
Message-ID: <3F66DC50.5040806@ii.net>
Date: Tue, 16 Sep 2003 17:48:00 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Yu Chen <dychen@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] bttv-risc.c (was: Re: [CHECKER] 32 Memory Leaks on Error
 Paths)
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Content-Type: multipart/mixed;
 boundary="------------020505020709090304060409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020505020709090304060409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Yu Chen wrote:
> Hi All,
[snip]
> ---------------------------------------------------------
> 
> [FILE:  2.6.0-test5/drivers/media/video/bttv-risc.c]
> [FUNC:  bttv_risc_overlay]
> [LINES: 214-223]
> [VAR:   skips]
>  209:	struct btcx_skiplist *skips;
>  210:	u32 *rp,ri,ra;
>  211:	u32 addr;
>  212:
>  213:	/* skip list for window clipping */
> START -->
>  214:	if (NULL == (skips = kmalloc(sizeof(*skips) * ov->nclips,GFP_KERNEL)))
>  215:		return -ENOMEM;
>  216:	
>  217:	/* estimate risc mem: worst case is (clip+1) * lines instructions
>  218:	   + sync + jump (all 2 dwords) */
>  219:	instructions  = (ov->nclips + 1) *
>  220:		((skip_even || skip_odd) ? ov->w.height>>1 :  ov->w.height);
>  221:	instructions += 2;
>  222:	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
> END -->
>  223:		return rc;
>  224:
>  225:	/* sync instruction */
>  226:	rp = risc->cpu;
>  227:	*(rp++) = cpu_to_le32(BT848_RISC_SYNC|BT848_FIFO_STATUS_FM1);
>  228:	*(rp++) = cpu_to_le32(0);
> ---------------------------------------------------------
> 

Correct?



--------------020505020709090304060409
Content-Type: text/plain;
 name="bttv-risc_memleak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bttv-risc_memleak.diff"

--- linux-2.6.0-test5.old/drivers/media/video/bttv-risc.c	2003-08-23 07:55:44.000000000 +0800
+++ linux-2.6.0-test5.new/drivers/media/video/bttv-risc.c	2003-09-16 16:48:37.000000000 +0800
@@ -219,8 +219,10 @@
 	instructions  = (ov->nclips + 1) *
 		((skip_even || skip_odd) ? ov->w.height>>1 :  ov->w.height);
 	instructions += 2;
-	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
+	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0) {
+		kfree(skips);
 		return rc;
+	}
 
 	/* sync instruction */
 	rp = risc->cpu;

--------------020505020709090304060409--

