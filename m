Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWEZP3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWEZP3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWEZP3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:29:24 -0400
Received: from rrcs-67-52-50-206.west.biz.rr.com ([67.52.50.206]:63870 "HELO
	out-smtp.licor.com") by vger.kernel.org with SMTP id S1750881AbWEZP3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:29:24 -0400
Subject: memcpy_toio on i386 using byte writes even when n%2==0
From: Chris Lesiak <chris.lesiak@licor.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Lesiak <chris.lesiak@licor.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 10:29:22 -0500
Message-Id: <1148657362.4376.77.camel@emerson.licor.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a driver for a custom PCI card on the i386 architecture.
The card uses a PLX9030 pci bridge to link an FPGA to the PCI bus using
a 16 bit bus.  I found that something broke when moving from 2.6.10 to
2.6.17-rc4.  In the driver, I use memcpy_toio to write 14 bytes to a
memory region in the FPGA.

To copy the 14 bytes, 2.6.10 does three 32 bit writes followed by one 16
bit write.  2.6.10 does three 32 bit writes followed by two 8 bit write.

The PLX9030 breaks the 32 bit writes into 16 bit writes for its local
bus just fine.  The problem is that my board doesn't handle byte
enables.  It was assumed that if all memory transfers were a multiple of
2 bytes, then byte accesses wouldn't be used.  This is no longer true in
2.6.7-rc4.

I've solved the problem by padding to 16 bytes, but should this be
considered a bug in the kernel?

Both kernels use __memcpy to implement memcpy_toio.  Here is the
relevent code from <asm-i386/string.h>

The 2.6.10 version:

static inline void * __memcpy(void * to, const void * from, size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
        "rep ; movsl\n\t"
        "testb $2,%b4\n\t"
        "je 1f\n\t"
        "movsw\n"
        "1:\ttestb $1,%b4\n\t"
        "je 2f\n\t"
        "movsb\n"
        "2:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        :"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
        : "memory");
return (to);
}

The 2.6.17-rc4 version:

static __always_inline void * __memcpy(void * to, const void * from,
size_t n)
{
int d0, d1, d2;
__asm__ __volatile__(
        "rep ; movsl\n\t"
        "movl %4,%%ecx\n\t"
        "andl $3,%%ecx\n\t"
#if 1   /* want to pay 2 byte penalty for a chance to skip microcoded
rep? */
        "jz 1f\n\t"
#endif
        "rep ; movsb\n\t"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
        : "memory");
return (to);
}

-- 
Chris Lesiak
chris.lesiak@licor.com

