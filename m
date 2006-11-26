Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967036AbWKZGVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967036AbWKZGVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 01:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967304AbWKZGVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 01:21:40 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:46721 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S967036AbWKZGVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 01:21:39 -0500
Date: Sun, 26 Nov 2006 01:14:22 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems
  to implicate xfs
To: David Chinner <dgc@sgi.com>
Cc: "xfs-masters@oss.sgi.com" <xfs-masters@oss.sgi.com>,
       "xfs@oss.sgi.com" <xfs@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
Message-ID: <200611260118_MC3-1-D2E7-B327@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061124005528.GF11034@melbourne.sgi.com>

On Fri, 24 Nov 2006 11:55:28 +1100, David Chinner wrote:

> Also, that means that while XFS is apparently only using <1500 bytes
> of stack through this path according to the static stack checker
> tool, there's more than 2k of extra stack usage that the tool is not
> telling me about. i.e. XFS and whatever is above/below it should
> have a full 4k to work with. I'd really like to know where that
> extra stack space is being used....

You could try applying the (untested) patch below and booting with
the parameter "kstack=2048", then regenerate the problem stack
traces. This should give you a complete raw stack dump in addition
to the call trace for each overflow.

(Output could get very large, so maybe adding a counter and stopping
after ~100 events might also be a good idea.)

--- 2.6.19-rc6-32smp.orig/arch/i386/kernel/irq.c
+++ 2.6.19-rc6-32smp/arch/i386/kernel/irq.c
@@ -80,7 +80,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 		if (unlikely(esp < (sizeof(struct thread_info) + STACK_WARN))) {
 			printk("do_IRQ: stack overflow: %ld\n",
 				esp - sizeof(struct thread_info));
-			dump_stack();
+			show_stack();
 		}
 	}
 #endif
-- 
Chuck
"Even supernovas have their duller moments."
