Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWAaQt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWAaQt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWAaQt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:49:57 -0500
Received: from science.horizon.com ([192.35.100.1]:29230 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751228AbWAaQt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:49:56 -0500
Date: 31 Jan 2006 11:49:49 -0500
Message-ID: <20060131164949.3365.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       mita@miraclelinux.com
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an extremely well-known technique.  You can see a similar version
that uses a multiply for the last few steps at
http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
whch refers to 
"Software Optimization Guide for AMD Athlon 64 and Opteron Processors"
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25112.PDF

It's section 8.6, "Efficient Implementation of Population-Count Function
in 32-bit Mode", pages 179-180.

It uses the name that I am more familiar with, "popcunt" (population count),
although "Hamming weight" also makes sense.

Anyway, the proof of correctness proceeds as follows:

	b = a - ((a >> 1) & 0x55555555);
	c = (b & 0x33333333) + ((b >> 2) & 0x33333333);
	d = (c + (c >> 4)) & 0x0f0f0f0f;
#if SLOW_MULTIPLY
	e = d + (d >> 8)
	f = e + (e >> 16);
	return f & 63;
#else
	/* Useful if multiply takes at most 4 cycles */
	return (d * 0x01010101) >> 24;
#endif

The input value a can be thought of as 32 1-bit fields each holding
their own hamming weight.  Now look at it as 16 2-bit fields.
Each 2-bit field a1..a0 has the value 2*a1 + a0.  This can be converted
into the hamming weight of the 2-bit field a1+a0 by subtracting a1.

That's what the (a >> 1) & mask subtraction does.  Since there can be no
borrows, you can just do it all at once.

Enumerating the 4 possible cases:

0b00 = 0  ->  0 - 0 = 0
0b01 = 1  ->  1 - 0 = 1
0b10 = 2  ->  2 - 1 = 1
0b11 = 3  ->  3 - 1 = 2


The next step consists of breaking up b (made of 16 2-bir fields) into
even and odd halves and adding them into 4-bit fields.  Since the largest
possible sum is 2+2 = 4, which will not fit into a 4-bit field, the 2-bit
fields have to be masked before they are added.


After this point, the masking can be delayed.  Each 4-bit field holds
a population count from 0..4, taking at most 3 bits.  These numbers can
be added without overflowing a 4-bit field, so we can compute
c + (c >> 4), and only then mask off the unwanted bits.


This produces d, a number of 4 8-bit fields, each in the range 0..8.
>From this point, we can shift and add d multiple times without overflowing
an 8-bit field, and only do a final mask at the end.

The number to mask with has to be at least 63 (so that 32 on't be truncated),
but can also be 128 or 255.  The x86 has a special encoding for signed
immediate byte values -128..127, so the value of 255 is slower.  On
other processors, a special "sign extend byte" instruction might be faster.


On a processor with fast integer multiplies (Athlon but not P4), you can
reduce the final few serially dependent instructions to a single integer
multiply.  Consider d to be 3 8-bit values d3, d2, d1 and d0, each in the
range 0..8.  The multiply forms the partial products:

           d3 d2 d1 d0
        d3 d2 d1 d0
     d3 d2 d1 d0
+ d3 d2 d1 d0
----------------------
           e3 e2 e1 e0

Where e3 = d3 + d2 + d1 + d0.   e2, e1 and e0 obviously cannot generate
any carries.
