Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWDZXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWDZXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDZXdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:33:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751127AbWDZXdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:33:07 -0400
Date: Wed, 26 Apr 2006 16:35:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in
 handling medium errors
Message-Id: <20060426163536.6f7bff77.akpm@osdl.org>
In-Reply-To: <44500033.3010605@rtr.ca>
References: <200604261627.29419.lkml@rtr.ca>
	<1146092161.12914.3.camel@mulgrave.il.steeleye.com>
	<20060426161444.423a8296.akpm@osdl.org>
	<44500033.3010605@rtr.ca>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <lkml@rtr.ca> wrote:
>
> > That's if we think -stable needs this fixed.
> 
> Let's say a bunch of read bio's get coalesced into a single
> 200+ sector request.  This then fails on one single bad sector
> out of the 200+.  Without the patch, there is a very good chance
> that sd.c will simply fail the entire request, all 200+ sectors.
> 
> With the patch, it will fail the first block, and then retry
> the remaining blocks.  And repeat this until something works,
> or until everything has failed one by one.

Yowch.  I have the feeling that this'll take our EIO-handling time from
far-too-long to far-too-long*200.

I am still traumatised by my recent ten-minute wait for a dodgy DVD to
become ejectable.

I don't think -stable needs this, personally.

> Better, but still not the best.
> 
> What I need to have happen when a request is failed due to bad-media,
> is have it split the request into a sequence of single-block requests
> that are passed to the LLD one at a time.  The ones with real bad
> sectors will then be independently failed, and the rest will get done.
> 
> Much better.  Much more complex.
> 
> I'm thinking about something like that, just not sure whether to put it
> (initially) in libata, sd.c, or the block layer.

block, I suspect.  My DVD trauma was IDE-induced.  Jens is mulling the
problem - I'd suggest you coordinate with him.

It would be a good thing to fix.

It's moderately hard to test, though.  Easy enough for DVDs and CDs, but
it's harder to take a marker pen to a hard drive.
