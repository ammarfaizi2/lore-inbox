Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbTGLSTK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbTGLSTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:19:10 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:54475 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S268228AbTGLSTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:19:08 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20030712073710.GK843@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>
	 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>
	 <20030712073710.GK843@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1058034751.13318.95.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Jul 2003 14:32:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 03:37, Jens Axboe wrote:

> > I believe the new way provides better overall read performance in the
> > presence of lots of writes.
> 
> I fail to see the logic in that. Reads are now treated fairly wrt
> writes, but it would be really easy to let writes consume the entire
> capacity of the queue (be it all the requests, or just going oversized).
> 
> I think the oversized logic is flawed right now, and should only apply
> to writes. Always let reads get through. And don't let writes consume
> the last 1/8th of the requests, or something like that at least. I'll
> try and do a patch for pre4.

If we don't apply oversized checks to reads, what keeps a big streaming
reader from starving out all the writes?

The current patch provides a relatively fixed amount of work to get a
request, and I don't think we should allow that to be bypassed.  We
might want to add a special case for synchronous reads (like bread), via
a b_state bit that tells the block layer an immediate unplug is coming
soon.  That way the block layer can ignore the oversized checks, grant a
request and unplug right away, hopefully lowering the total number of
unplugs the synchronous reader has to wait through.

Anyway, if you've got doubts about the current patch, I'd be happy to
run a specific benchmark you think will show the bad read
characteristics.

-chris


