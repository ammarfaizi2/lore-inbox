Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTLRCe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 21:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbTLRCe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 21:34:28 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:11684 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264902AbTLRCe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 21:34:27 -0500
Message-ID: <3FE113A5.8060900@pacbell.net>
Date: Wed, 17 Dec 2003 18:40:37 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Curnow <Richard.Curnow@superh.com>
Subject: Re: Handling of bounce buffers by rh_call_control
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net> <200312172247.RAA08325@gatekeeper.tmr.com>
In-Reply-To: <200312172247.RAA08325@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> | > -       u8              *ubuf = urb->transfer_buffer;
> | > +       u8              *ubuf = (u8 *) urb->transfer_dma;
> | >         int             len = 0;
> | >  
> | > ...
> | > 		memcpy (ubuf, bufp, len);
> | 
> | Which is why that particular patch is wrong:  "ubuf" is a dma address,
> | not expected to work for memcpy().
> 
> But the existing code most certainly does use it with memcpy. I'm
> looking at test11-mm1 source, but the last memcpy line he noted is most
> definitely in the existing source.

As in, "ubuf is NOW a dma address ... it wasn't one before that patch,
it was a regular kernel mappped address.  Otherwise memcpy() would
never have worked.  Changing it would break more typical kernels, with
no need for bounce buffering.

The right fix is just to bypass the DMA mapping for root hubs,
as in that 2.6 patch from Russell that I mentioned.  It's the
unmap that was causing trouble, since it clobbered the data
which memcpy() had just stored into that buffer.

- Dave




