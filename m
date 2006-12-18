Return-Path: <linux-kernel-owner+w=401wt.eu-S1754371AbWLRSaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbWLRSaa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbWLRSaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:30:30 -0500
Received: from brick.kernel.dk ([62.242.22.158]:3393 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369AbWLRSaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:30:30 -0500
Date: Mon, 18 Dec 2006 19:32:10 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061218183209.GP5010@kernel.dk>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061214212055.GR5010@kernel.dk> <200612150048.25552.s0348365@sms.ed.ac.uk> <200612150141.09020.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16 2006, Linus Torvalds wrote:
> That said: Jens - I think 0e75f906 was a mistake. "blk_rq_unmap()" really 
> should be passed the "struct bio", not the "struct request *". Right now 
> it does something _really_ strange with requests with linked bio's, and I 
> don't think your and FUJITA's "leak fix" really works. What happens when 
> the bio was a linked list on the request, and you put the old _head_ on 
> the request with "rq->bio = bio"? What happens to the other parts of it?

I agree it's fishy and I did think about it. The design isn't exactly
the prettiest, but it should be safe. The reason is that we don't
actually unlink the individual bio from the list, even if we may set
rq->bio to point somewhere further into the list. So as long as the bio
is valid, the bi_next field is still valid as well. We need a reference
on the bio to perform the unmap and blk_rq_unmap_user() drops this
reference on its own, so the bio must be valid.

Taking a rq pointer when we really want a bio is nasty, though. I'll
chance that at least.

> IOW, I think this is broken. I think we should revert 0e75f906. Or at 
> least you should explain to me why it's not broken, and why clearly people 
> (eg Alistair) still see problems with it?

I'm not so sure it's that patch, the same problem seemed to exist for
some people prior to 2.6.20.

-- 
Jens Axboe

