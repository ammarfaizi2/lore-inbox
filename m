Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266015AbUANXHC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbUANXFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:05:42 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:12287 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265174AbUANXDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:03:48 -0500
Date: Wed, 14 Jan 2004 15:03:31 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: joe.korty@ccur.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040114150331.02220d4d.pj@sgi.com>
In-Reply-To: <16381.61618.275775.487768@cargo.ozlabs.ibm.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M suggested (in the 32-bit display loop of lib/mask.c):
> #define BITMAP_WORD(p, n)	(((u32 *)(p))[(n) ^ 1])

Then, later, Joe sugguested a patch rewriting the lib/mask.c display
loop using various C bit operations (& ! / % << >>).

Joe - question - is there any good reason not to use Paul M's
suggestion, eor'ing the index with 1 on 64 bit big endian hardware?
I have a patch about ready (as soon as I can get time on my big system
to test it) that uses the eor 1 idea.

The eor 1 code looks good to me, and takes a few bytes fewer machine
instructions.  Perhaps you know something I am missing.  The actual
patch should be up in about 5 hours, in case you'd rather not comment on
code unseen ;).

Joe suggested:
> This patch preserves Paul's ideas of how a cpumask_t should be printed
> out even though I do not agree with those ideas.  At a minimum I prefer
> a constant-width display so that columns of cpumasks will be readable.

On further review, I think you're right on this, Joe.  After I get the
above big endian fix out, I will attempt a patch that changes this
format, zero-filling each word to 8 hex chars, from:

=========== OLD ===========
 * Examples:
 *   A mask with just bit 0 set displays as "1".
 *   A mask with just bit 127 set displays as "80000000,0,0,0".
 *   A mask with just bit 64 set displays as "1,0,0".
 *   A mask with bits 0, 1, 2, 4, 8, 16, 32 and 64 set displays
 *     as "1,1,10117".  The first "1" is for bit 64, the second
 *     for bit 32, the third for bit 16, and so forth, to the
 *     "7", which is for bits 2, 1 and 0.
 *   A mask with bits 32 through 39 set displays as "ff,0".
=========== OLD ===========

to:

=========== NEW ===========
 * Examples:
 *   A mask with just bit 0 set displays as "00000001".
 *   A mask with just bit 127 set displays as "80000000,00000000,00000000,00000000".
 *   A mask with just bit 64 set displays as "00000001,00000000,00000000".
 *   A mask with bits 0, 1, 2, 4, 8, 16, 32 and 64 set displays
 *     as "00000001,00000001,00010117".  The first "1" is for bit 64, the second
 *     for bit 32, the third for bit 16, and so forth, to the
 *     "7", which is for bits 2, 1 and 0.
 *   A mask with bits 32 through 39 set displays as "000000ff,00000000".
=========== NEW ===========

How does that look to you?  Anyone else want to chime in?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
