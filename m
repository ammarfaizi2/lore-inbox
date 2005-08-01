Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVHACCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVHACCO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 22:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVHACCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 22:02:14 -0400
Received: from science.horizon.com ([192.35.100.1]:9522 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261893AbVHACAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 22:00:09 -0400
Date: 31 Jul 2005 22:00:04 -0400
Message-ID: <20050801020004.6965.qmail@science.horizon.com>
From: linux@horizon.com
To: richard@rsk.demon.co.uk
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do the work)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> static inline int new_find_first_bit(const unsigned long *b, unsigned size)
> {
> 	int x = 0;
> 	do {
> 		unsigned long v = *b++;
> 		if (v)
> 			return __ffs(v) + x;
> 		if (x >= size)
> 			break;
> 		x += 32;
> 	} while (1);
> 	return x;
> }

Wait a minute... suppose that size == 32 and the bitmap is one word of all
zeros.  Dynamic execution will overflow the buffer:

 	int x = 0;
 		unsigned long v = *b++;	/* Zero */

 		if (v)			/* False, v == 0 */
 		if (x >= size)		/* False, 0 < 32 */
 		x += 32;
 	} while (1);
 		unsigned long v = *b++;	/* Buffer overflow */
 		if (v)			/* Random value, suppose non-zero */
			return __ffs(v) + x;	/* >= 32 */

That should be:
static inline int new_find_first_bit(const unsigned long *b, unsigned size)
	int x = 0;
 	do {
 		unsigned long v = *b++;
 		if (v)
 			return __ffs(v) + x;
	} while ((x += 32) < size);
	return size;
}

Note that we assume that the trailing long is padded with zeros.

In truth, it should probably be either

static inline unsigned new_find_first_bit(u32 const *b, unsigned size)
	int x = 0;
 	do {
 		u32 v = *b++;
 		if (v)
 			return __ffs(v) + x;
	} while ((x += 32) < size);
	return size;
}

or

static inline unsigned
new_find_first_bit(unsigned long const *b, unsigned size)
	unsigned x = 0;
 	do {
 		unsigned long v = *b++;
 		if (v)
 			return __ffs(v) + x;
	} while ((x += CHAR_BIT * sizeof *b) < size);
	return size;
}

Do we actually store bitmaps on 64-bit machines with 32 significant bits
per ulong?
