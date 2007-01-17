Return-Path: <linux-kernel-owner+w=401wt.eu-S1751363AbXAQXcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAQXcr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXAQXcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:32:47 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:35181 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751363AbXAQXcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:32:45 -0500
Date: Wed, 17 Jan 2007 15:30:25 -0800 (PST)
From: Nate Diller <nate@agami.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Nate Diller <nate.diller@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Subject: Re: [PATCH -mm 0/10][RFC] aio: make struct kiocb private
In-Reply-To: <20070117215230.GB28828@kvack.org>
Message-ID: <Pine.LNX.4.64.0701171424450.23419@nate-64.agami.com>
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
 <20070116032347.GA3697@infradead.org> <5c49b0ed0701152025t2e9fdd6cld36b077f36c78afe@mail.gmail.com>
 <20070117215230.GB28828@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Benjamin LaHaise wrote:

> On Mon, Jan 15, 2007 at 08:25:15PM -0800, Nate Diller wrote:
>> the right thing to do from a design perspective.  Hopefully it enables
>> a new architecture that can reduce context switches in I/O completion,
>> and reduce overhead.  That's the real motive ;)
>
> And it's a broken motive.  Context switches per se are not bad, as they
> make it possible to properly schedule code in a busy system (which is
> *very* important when realtime concerns come into play).  Have a look
> at how things were done in the 2.4 aio code to see how completion would
> get done with a non-retry method, typically in interrupt context.  I had
> code that did direct I/O rather differently by sharing code with the
> read/write code paths at some point, the catch being that it was pretty
> invasive, which meant that it never got merged with the changes to handle
> writeback pressure and other work that happened during 2.5.

I'm having some trouble understanding your concern.  From my perspective,
any unnecessary context switch represents not only performance loss, but
extra complexity in the code.  In this case, I'm not suggesting that the
aio.c code causes problems, quite the opposite.  The code I'd like to change
is FS and md levels, where context switches happen because of timers,
workqueues, and worker threads.  For sync I/O, these layers could be doing
their completion work in process context, but because waiting on sync I/O is
done in layers above, they must resort to other means, even for the common
case.  The dm-crypt module is the most straightforward example.

I took a look at some 2.4.18 aio patches in kernel.org/.../bcrl/aio/, and if
I understand what you did, you were basically operating at the aops level
rather than f_ops.  I actually like that idea, it's nicer than having the
direct-io code do its work seperately from the aio code.  Part of where I'm
going with this patch is a better integration between the block layer
(make_request), page layer (aops), and FS layer (f_ops), particularly in the
completion paths.  The direct-io code is an improvement over the common code
on that point, do_readahead() and friends all wait on individual pages to
become uptodate.  I'd like to bring some improvements from the directIO
architecture into use in the common case, which I hope will help
performance.

I know that might seem somewhat unrelated, but I don't think it is.  This
change goes hand in hand with using completion handlers in the aops.  That
will link together the completion callback in the bio with the aio callback,
so that the whole stack can finish its work in one context.

> That said, you can't make kiocb private without completely removing the
> ability of the rest of the kernel to complete an aio sanely from irq context.
> You need some form of i/o descriptor, and a kiocb is just that.  Adding more
> layering is just going to make things messier and slower for no real gain.

This patchset does not change how or when I/O completion happens,
aio_complete() will still get called from direct-io.c, nfs-direct.c, et al. 
The iocb structure is still passed to aio_complete, just like before.  The
only difference is that the lower level code doesn't know that it's got an
iocb, all it sees is an opaque cookie.  It's more like enforcing a layer
that's already in place, and I think things got simpler rather than messier. 
Whether things are slower or not remains to be seen, but I expect no
measurable changes either way with this patch.

I'm releasing a new version of the patch soon, it will use a new iodesc
structure to keep track of iovec state, which simplifies things further.  It
also will have a new version of the usb gadget code, and some general
cleanups.  I hope you'll take a look at it.

NATE
