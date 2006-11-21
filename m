Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754857AbWKUWt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbWKUWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031255AbWKUWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:49:58 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:23684 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1754857AbWKUWt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:49:56 -0500
Date: Tue, 21 Nov 2006 14:49:41 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org,
       Michael Hipp <Michael.Hipp@student.uni-tuebingen.de>,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, starvik@axis.com, dev-etrax@axis.com
Subject: Re: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
In-Reply-To: <9a8748490611211421p696eb081j5691030f86f6bffe@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0611211438340.3549@attu4.cs.washington.edu>
References: <200610302117.24760.jesper.juhl@gmail.com> 
 <9a8748490611210537q1f493d11w700099da3243ef39@mail.gmail.com> 
 <Pine.LNX.4.64N.0611211211280.25455@attu4.cs.washington.edu>
 <9a8748490611211421p696eb081j5691030f86f6bffe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Jesper Juhl wrote:

> Ok, I see your point. There may not be an actual bug here, but
> couldn't it still be considered an improvement, given that with my
> patch we'll  a) print a warning that we ran into a memory shortage
> problem, and  b) we save a call to ipc->decompress() and some switch
> logic in the failing case.   ???
> 

No, because there is duplication of code.  This error condition is already 
addressed:

	skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
	len = ipc->decompress(stat, skb, skb_out, &rsparm);
	kfree_skb(skb);
	if (len <= 0) {
		switch (len) {
		case DECOMP_ERROR:
			...
			break;
		case DECOMP_FATALERROR:
			...
			break;
		}
		kfree_skb(skb_out);
		return NULL;
	}

Since neither DECOMP_ERROR or DECOMP_FATALERROR represent a NULL return 
from ipc->decompress(), the switch clause is a no-op and skb_out is freed 
and NULL is returned.

The only thing your patch addresses is moving this before the 
ipc->decompress() call and _duplicating_ both the skb free and the return 
code, as well as adding a warning.  The warning is unnecessary because OOM 
killer will be called soon anyway if this condition is ever reached so the 
fact that it was this allocation that could not be satisfied doesn't 
matter.  Likewise, we need the return code from ipc->decompress() to do 
the other error checking involved.

		David
