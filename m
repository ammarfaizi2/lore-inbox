Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRHFHJE>; Mon, 6 Aug 2001 03:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267053AbRHFHIx>; Mon, 6 Aug 2001 03:08:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30189 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267043AbRHFHIo>;
	Mon, 6 Aug 2001 03:08:44 -0400
Date: Mon, 6 Aug 2001 03:08:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org, Gergely Madarasz <gorgo@itc.hu>
Subject: Re: 2.4.8-pre4 drivers/net/wan/comx.c unresolved symbol
In-Reply-To: <1101.997078634@ocs3.ocs-net>
Message-ID: <Pine.GSO.4.21.0108060245560.13716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Keith Owens wrote:

> This is probably already known but 2.4.8-pre4 drivers/net/wan/comx.c
> has an unresolved symbol proc_get_inode when compiled as a module.

Yes. The fix is also know - rm(1). comx.c is oopsable in so many ways
that it's not worth fixing. I've played with it for quite a while trying
to fix the sucker, but there were more and more bugs. About the only
function they hadn't fscked up was their reimplementation of strcasecmp(3).
Diagnosis: FUBAR. Literally.

If the authors (who, AFAICS, happen to be manufacturers of the hardware in
question) are interested in having that driver in a tree I would _really_
recommend them to rewrite the damn thing from scratch and submit it for
review before it goes into the kernel.

I can dig up the list of bugs (incomplete - at some point I simply gave
up on that) and post it, if anyone is interested.

And no, exporting proc_get_inode() will not help anything - their procfs
code is completely b0rken (as in, if you ever rmmod the thing _or_
unregister an interface - any user can crash the box). And that's aside
of GFP_KERNEL kmalloc() with interrupts disabled, extremely odd ideas
about the semantics of netdev ->stop(), lousy use of timers, kmalloc()
before MOD_INC_USE_COUNT, various and sundry races, yodda, yodda.

