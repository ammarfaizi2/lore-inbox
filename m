Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUAaFup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 00:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUAaFup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 00:50:45 -0500
Received: from terminus.zytor.com ([63.209.29.3]:10635 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261875AbUAaFum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 00:50:42 -0500
Message-ID: <401B421F.4060104@zytor.com>
Date: Fri, 30 Jan 2004 21:50:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, michael@mvdavid.com
Subject: Re: raid6 badness
References: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org.suse.lists.linux.kernel>	<bvf2vl$6pr$1@terminus.zytor.com.suse.lists.linux.kernel> <p73ad44n7ig.fsf@verdi.suse.de>
In-Reply-To: <p73ad44n7ig.fsf@verdi.suse.de>
Content-Type: multipart/mixed;
 boundary="------------040908030705090009080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908030705090009080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>I don't know what would cause the stack to be misaligned, however.
> 
> x86-64 kernel doesn't guarantee the stack to be 16 byte aligned
> (although it usually is). If you need 16 byte alignment you have 
> to align yourself.
> 

OK, that's unfortunate... per our discussion I really think this is a 
bug, since the compiler still does 16-byte alignment, and thus we're 
taking the cost without the benefit.

I'll send in the attached patch for now, but at some point I'd like to 
fix this.  Unfortunately I still don't have an x86-64 machine that I can 
actually compile and install kernels on; I only have access to an x86-64 
userspace, so I'm a bit limited in what I can test.

Michael: Perhaps you could apply this patch and test it out for me?

	-hpa

--------------040908030705090009080600
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/drivers/md/raid6x86.h,v
retrieving revision 1.3
diff -u -r1.3 raid6x86.h
--- linux-2.5/drivers/md/raid6x86.h	22 Jan 2004 16:15:09 -0000	1.3
+++ linux-2.5/drivers/md/raid6x86.h	31 Jan 2004 05:41:49 -0000
@@ -32,18 +32,20 @@
 /* N.B.: For SSE we only save %xmm0-%xmm7 even for x86-64, since
    the code doesn't know about the additional x86-64 registers */
 typedef struct {
-	unsigned int sarea[8*4];
-	unsigned int cr0;
+	unsigned int sarea[8*4+2];
+	unsigned long cr0;
 } raid6_sse_save_t __attribute__((aligned(16)));
 
 /* This is for x86-64-specific code which uses all 16 XMM registers */
 typedef struct {
-	unsigned int sarea[16*4];
+	unsigned int sarea[16*4+2];
 	unsigned long cr0;
 } raid6_sse16_save_t __attribute__((aligned(16)));
 
-/* On x86-64 the stack is 16-byte aligned */
-#define SAREA(x) (x->sarea)
+/* On x86-64 the stack *SHOULD* be 16-byte aligned, but currently this
+   is buggy in the kernel and it's only 8-byte aligned in places, so
+   we need to do this anyway.  Sigh. */
+#define SAREA(x) ((unsigned int *)((((unsigned long)&(x)->sarea)+15) & ~15))
 
 #else /* __i386__ */
 
@@ -60,6 +62,7 @@
 	unsigned long cr0;
 } raid6_sse_save_t;
 
+/* Find the 16-byte aligned save area */
 #define SAREA(x) ((unsigned int *)((((unsigned long)&(x)->sarea)+15) & ~15))
 
 #endif

--------------040908030705090009080600--
