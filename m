Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271359AbTHDC2L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 22:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTHDC2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 22:28:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:34765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271359AbTHDC2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 22:28:09 -0400
Date: Sun, 3 Aug 2003 19:29:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: do_div considered harmful
Message-Id: <20030803192919.0d7d881c.akpm@osdl.org>
In-Reply-To: <UTC200308040203.h7423rv14876.aeb@smtp.cwi.nl>
References: <UTC200308040203.h7423rv14876.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Writing this ide capacity patch an hour ago or so
> I split off a helper sectors_to_MB() since Erik's recent
> patch uses this also.
> Now that I compare, he wrote
> 	nativeMb = do_div(nativeMb, 1000000);
> to divide nativeMb by 1000000.
> Similarly, I find in fs/cifs/inode.c
> 	inode->i_blocks = do_div(findData.NumOfBytes, inode->i_blksize);

This should be

	int blocksize = 1 << inode->i_blkbits;

	inode->i_blocks = (findData.NumOfBytes + blocksize - 1)
				>> inode->i_blkbits;
				

and inode.i_blksize should probably be removed from the kernel.

> So, it seems natural to expect that do_div() gives the quotient.
> But it gives the remainder.
> (Strange, Erik showed correct output.)
> 
> Since the semantics of this object are very unlike that of a C function,
> I wonder whether we should write DO_DIV instead, or DO_DIV_AND_REM
> to show that a remainder is returned.

Sometimes the slash-star operator comes in handy.


--- 25/include/asm-i386/div64.h~do_div-comment	2003-08-03 19:20:58.000000000 -0700
+++ 25-akpm/include/asm-i386/div64.h	2003-08-03 19:21:11.000000000 -0700
@@ -1,6 +1,16 @@
 #ifndef __I386_DIV64
 #define __I386_DIV64
 
+/*
+ * The semantics of do_div() are:
+ *
+ * uint32_t do_div(uint64_t *n, uint32_t base)
+ * {
+ * 	uint32_t remainder = *n % base;
+ * 	*n = *n / base;
+ * 	return remainder;
+ * }
+ */
 #define do_div(n,base) ({ \
 	unsigned long __upper, __low, __high, __mod; \
 	asm("":"=a" (__low), "=d" (__high):"A" (n)); \

_

