Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUC3Akm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUC3Akl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:40:41 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:37060 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263295AbUC3Akk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:40:40 -0500
Date: Mon, 29 Mar 2004 15:43:30 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040329154330.445e10e2.pj@sgi.com>
In-Reply-To: <20040329235233.GV791@holomorphy.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	<1080601576.6742.43.camel@arrakis>
	<20040329235233.GV791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My thinking on when to worry about the unused bits, and when not to, is
thus.

For the lib/bitmap.c code, it seems that the existing standard, followed
by everything except bitmap_complement(), is to not set any unused bits
(at least when called with correct arguments in range), but to always
filter them out when testing for some Boolean condition or scalar result
(weight).

So I fixed bitmap_complement() to also not set them, and I put checks in
my new Booleans bitmap_subset() and bitmap_intersects(), to filter them
out.

But I didn't worry about them in bitmap_xor() or bitmap_andnot(), just
like the similar bitmap_or() and bitmap_and() don't worry about them
(proper calls of or/and/xor/andnot will not set the unused bits anyway.)

The standard I set for the include/linux/mask.h code is different than
for lib/bitmap.c.  In the mask.h code, I won't set them if all your
calls are proper and in range (same as bitmap), but I also make no
effort to filter them out on Boolean or scalar ops (though if some
bitmap op I happen to call does filter such, I don't worry about it).

So with the bitmap API, you can get unused bits set, and not notice it
in most cases, due to the filtering.  But with the mask API, you'd best
not screw up and set them, or else you might get different Boolean and
scalar results, depending on implementation details.

My biggest defense against coding bugs in kernel code using these masks
is to get the cpumask and nodemask API easier to understand and use.
This should reduce bugs do to coder confusion.  So long as they call
this stuff with proper arguments, all is well.

The bitmap stuff probably does more checking than I would like, but I
felt it was more important to be consistent there, as bitmaps are an
exposed API in their own right.  Either add unused bit zeroing and
filtering in the remaining places (complement and the new subset and
intersects), or rip it all out.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
