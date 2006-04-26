Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWDZXUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWDZXUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWDZXUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:20:39 -0400
Received: from rtr.ca ([64.26.128.89]:5837 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932429AbWDZXUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:20:38 -0400
Message-ID: <44500033.3010605@rtr.ca>
Date: Wed, 26 Apr 2006 19:20:19 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in handling
 medium errors
References: <200604261627.29419.lkml@rtr.ca>	<1146092161.12914.3.camel@mulgrave.il.steeleye.com> <20060426161444.423a8296.akpm@osdl.org>
In-Reply-To: <20060426161444.423a8296.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> It'd be nice to have something simple-and-obvious for the
> simple-and-obvious -stable maintainers.

That's why I kept the original patch very simple and focused,
rather than trying to fix all of the convoluted code around it.

It's nice and simple, and *looks* correct.

A longer term cleanup of that function is better left to James!

> That's if we think -stable needs this fixed.

Let's say a bunch of read bio's get coalesced into a single
200+ sector request.  This then fails on one single bad sector
out of the 200+.  Without the patch, there is a very good chance
that sd.c will simply fail the entire request, all 200+ sectors.

With the patch, it will fail the first block, and then retry
the remaining blocks.  And repeat this until something works,
or until everything has failed one by one.

Better, but still not the best.

What I need to have happen when a request is failed due to bad-media,
is have it split the request into a sequence of single-block requests
that are passed to the LLD one at a time.  The ones with real bad
sectors will then be independently failed, and the rest will get done.

Much better.  Much more complex.

I'm thinking about something like that, just not sure whether to put it
(initially) in libata, sd.c, or the block layer.

Cheers

