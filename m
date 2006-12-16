Return-Path: <linux-kernel-owner+w=401wt.eu-S1753806AbWLPVg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbWLPVg5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 16:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbWLPVg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 16:36:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46348 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbWLPVg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 16:36:56 -0500
Date: Sat, 16 Dec 2006 13:36:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Jens Axboe <jens.axboe@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6.20-rc1
In-Reply-To: <200612150141.09020.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <20061214212055.GR5010@kernel.dk> <200612150048.25552.s0348365@sms.ed.ac.uk>
 <200612150141.09020.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2006, Alistair John Strachan wrote:
> 
> In total isolation, v2.6.19..0e75f9063f5c55fb0b0b546a7c356f8ec186825e it 
> breaks. Reverting just 0e75f9063f5c55fb0b0b546a7c356f8ec186825e, it works 
> again.
> 
> So I think this is the source, but I can't explain why it "goes away" before 
> git1 and "comes back" before 2.6.20-rc1.

Can you see if the kernel state at commit 77d172ce ("[PATCH] fix SG_IO bio 
leak") is good? Ie just do something like

	git checkout -b test-branch 77d172ce

and compile and test that?

That commit _should_ be the one that fixed whatever problems that commit 
0e75f906 introduced. It *did* fix it for other - somewhat similar - 
situations.

That said: Jens - I think 0e75f906 was a mistake. "blk_rq_unmap()" really 
should be passed the "struct bio", not the "struct request *". Right now 
it does something _really_ strange with requests with linked bio's, and I 
don't think your and FUJITA's "leak fix" really works. What happens when 
the bio was a linked list on the request, and you put the old _head_ on 
the request with "rq->bio = bio"? What happens to the other parts of it?

IOW, I think this is broken. I think we should revert 0e75f906. Or at 
least you should explain to me why it's not broken, and why clearly people 
(eg Alistair) still see problems with it?

		Linus
