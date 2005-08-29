Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVH2D0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVH2D0s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVH2D0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:26:48 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:61583 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750728AbVH2D0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:26:48 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050828183531.0b4d6f2d.akpm@osdl.org>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>
	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>
	 <20050828183531.0b4d6f2d.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 22:26:34 -0500
Message-Id: <1125285994.5048.40.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-28 at 18:35 -0700, Andrew Morton wrote:
> > Well ... It's my opinion (and purely unsubstantiated, I suppose) that
> > it's more efficient on 32 bit platforms to do bit operations on 32 bit
> > quantities, which is why I changed the radix tree map shift to 5 for
> > that case.
> > 
> > It also makes much cleaner code than having to open code checks on
> > variable sized bitmaps.

> It does make the tree higher and hence will incur some more cache missing
> when descending the tree.

Actually, I don't think it does:  the common user is the page tree.
Obviously, I've changed nothing on 64 bits, so we only need to consider
what I've done on 32 bits.  A page size is almost universally 4k on 32
bit, so we need 20 bits to store the page tree index.  Regardless of
whether the index size is 5 or 6, that gives a radix tree depth of 4.

> We changed the node size a few years back.  umm.... 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0206.2/0141.html

Yes, but that was to reduce the index size from 7 to 6 for slab
allocation reasons.  I've just reduced it to 5 on 32 bit.

> It would be a little bit sad to be unable to make such tuning adjustments
> in the future.  Not a huge loss, but a loss.

Well .. OK .. If the benchmarks say I've slowed us down on 32 bits, I'll
put the variable sizing back in the tag array.

James

