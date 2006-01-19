Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWASGII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWASGII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWASGII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:08:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:31456 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932545AbWASGIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:08:07 -0500
Date: Wed, 18 Jan 2006 22:07:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
Message-Id: <20060118220753.3f005b5a.pj@sgi.com>
In-Reply-To: <20060119014812.GB18181@linux-sh.org>
References: <20060119014812.GB18181@linux-sh.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks to me like I never properly reviewed James patch
when it was originally submitted.  It has some minor confusions
that have gotten slightly worse with this patch.

Just reading the patch, I see the following possible opportunities
for improvement:

 * Could the calculation of mask:
        mask = (1ul << (pages - 1));
        mask += mask - 1;
   be simplified to:
	mask = (1UL << pages) - 1;
   (and note that 1UL is easier to read than 1ul)

 * The variable named 'pages' is misnamed.  It happens that the
   current user of this code is using one bit to represent one
   page, but that is not something that this code has any business
   knowing.  For this code, it might better be 'nbits' or some such.

 * With your 'pages > BITS_PER_LONG' patch, this 'pages' variable
   becomes more confused.  Apparently, it is the number of bits
   to consider in each word scanned, and 'scan' is the number of
   words to scan.  Hmmm ... that's not quite right either.  It
   seems that 'pages' is first set (in bitmask_find_free_region)
   to the number of bits total to find, which value is used to
   compute 'scan', the number of words needed to hold that many
   bits; then 'pages' is recomputed to be the number of bits in
   a single word to examine, which value is used to compute the
   'mask'.  This sort of dual use of a poorly named variable is
   confusing.  I'd suggest two variables - 'nbitstotal' and
   'nbitsinword', or some such.  Or short variable names, and
   a comment:
	int bt;		/* total number of bits to find free */
	int bw;		/* how many bits to consider in one word */

 * The block comment states:
	allocate a memory region from a bitmap
   This is another confusion between the user of this code, and
   this current code.  I think we are allocating a sequence of
   consecutive bits of size and allignment some power of two
   ('order' is that power), not allocating a 'memory region.'

 * There is no function block comment for bitmap_allocate_region().

 * The include/linux/bitmap.h header comment is missing the
   three lines specifying these three routines.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
