Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUIQNxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUIQNxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUIQNxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:53:42 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:20111 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268756AbUIQNxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:53:38 -0400
Date: Fri, 17 Sep 2004 15:52:57 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040917135257.GV15426@dualathlon.random>
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com> <20040915145524.079a8694.akpm@osdl.org> <20040915220016.GC9106@holomorphy.com> <20040915220819.GF15426@dualathlon.random> <4149539D.9070001@hist.no> <20040916142638.GW15426@dualathlon.random> <414AEB5E.30803@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414AEB5E.30803@hist.no>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:49:18PM +0200, Helge Hafting wrote:
> I am assuming that the "garbage" between i_size and the
> page boundary is stuff left over from whatever that
> memory page was used for earlier?  If so, it could be
> 4095 bytes out of the 4096 that was used to cache some
> other file earlier.  Possibly someone else's confidential file. 
> Or a piece of some network package that was processed a while ago.

I see what you mean now, but this is not the case, the new page is
cleared by block_truncate_page, as Andrew pointed out. So when we get a
new partial page we zero out the content beyond the end of the inode.
It's when we extend again that we don't do anything on such partial page
previously processed and zeroed-out by block_truncate_page. So there
can't be some network data processed a while ago, or other random memory
content. It's just up to the application to be correct and not to write
its own data beyond the end of the i_size if it doesn't want this data
to hit disk (and other data will be written anyways below the i_size,
which has the same issue). So basically I don't see any security issue.
