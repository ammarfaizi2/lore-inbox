Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUIOWIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUIOWIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUIOWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:06:04 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:47544 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267618AbUIOWEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:04:48 -0400
Date: Thu, 16 Sep 2004 00:04:09 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040915220409.GE15426@dualathlon.random>
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com> <20040915145524.079a8694.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915145524.079a8694.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:55:24PM -0700, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > Zeroing the final partial page during expanding truncate (flushing TLB)
> > sounds like a reasonable half measure; we don't do anything at the moment.
> 
> Sure about that?  block_truncate_page() gets called.

block_truncate_page is executed on the _new_ partial page, what we're
talking about here is the _old_ partial page, the partial page before
calling truncate. That one isn't zeroed out, and zeroing it out would
require marking it dirty too since the garbage could be flushed to disk
already. That's why I was sticking with a solution that would leave
truncate a no-I/O operation as far as a data is concerned (and in
general a solution that would never generate any further I/O compared to
current kernel).

Probably we can ignore this thanks to Alan's feedback.

(also note, we should talk about partial blocks here, not partial pages,
partial pages isn't the issue if the i_size is softblocksize aligned,
but let's assume 4k softblocksize on a x86 or x86-64 for clarity so that
pages is the same as softblocksize ;)
