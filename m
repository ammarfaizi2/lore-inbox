Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUCTAkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 19:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbUCTAkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 19:40:25 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:27801 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263183AbUCTAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 19:40:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Fast 64-bit atomic writes (SSE?)
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 19 Mar 2004 16:39:17 -0800
Message-ID: <874qskl5ca.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm trying to find the best (fastest) way to write a 64-bit
quantity atomically to a device (on i386).  Taking a spinlock around
two 32-bit accesses seems to be rather expensive.  I'm mostly
concerned about newish CPUs, so I'm willing to use SSE or SSE2
instructions (of course falling back to a slower locked path if the
kernel is built for an old CPU).

I guess I have two questions, a general one and a specific one.

General question:
  What's the best way to do this?

Specific question:
  I've come up with the below function.  However, you may notice that
I'm forced to use movdqu (instead of movdqa, which is presumably
faster).  This is because even with the __attribute__((aligned(16))),
my xmmsave array is not guaranteed to be aligned to 16 bytes.  I could
just allocate 31 bytes for xmmsave and align it to 16 bytes by hand,
but that seems a little ugly.  Is there some magic I'm missing?

Thanks,
  Roland

static inline void mywrite64(u32 *val, void *dest)
{
        u8 xmmsave[16] __attribute__((aligned(16)));

/* The #ifs are a hack to deal with 2.4 kernels without preempt. */
#if CONFIG_PREEMPT
        preempt_disable();
#endif

        /* We use movdqu for the moment, because even
           __attribute__((aligned(16))) doesn't seem to guarantee
           xmmsave is aligned to a 16 byte boundary. */
        __asm__ __volatile__ (
                "movdqu %%xmm0,(%0); \n\t"
                "movq   (%1),%%xmm0; \n\t"
                "movq   %%xmm0,(%2); \n\t"
                "movdqu (%0),%%xmm0; \n\t"
                :
                : "r" (xmmsave), "r" (val), "r" (dest)
                : "memory" );

#if CONFIG_PREEMPT
        preempt_enable();
#endif
}
