Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVAFBhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVAFBhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVAFBhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:37:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:5349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262696AbVAFBg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:36:58 -0500
Date: Wed, 5 Jan 2005 17:36:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105173624.5c3189b9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
	<20050105020859.3192a298.akpm@osdl.org>
	<20050105180651.GD4597@dualathlon.random>
	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
	<20050105174934.GC15739@logos.cnet>
	<20050105134457.03aca488.akpm@osdl.org>
	<20050105203217.GB17265@logos.cnet>
	<41DC7D86.8050609@yahoo.com.au>
	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Thu, 6 Jan 2005, Nick Piggin wrote:
> 
> > I think what Andrea is worried about is that blk_congestion_wait is 
> > fairly vague, and can be a source of instability in the scanning 
> > implementation.
> 
> The recent OOM kill problem has been happening:
> 1) with cache pressure on lowmem only, due to a block device write
> 2) with no block congestion at all
> 3) with pretty much all pageable lowmme pages in writeback state

You must have a wild number of requests configured in the queue.  Is this
CFQ?

I've done testing with "all of memory under writeback" before and it went
OK.  It's certainly a design objective to handle this well.  But that
testing was before we broke it.

> It appears the VM has trouble dealing with the situation where
> there is no block congestion to wait on...

It's misnamed.  We don't "wait for the queue to come out of congestion". 
We simply throttle until a write completes, or, rarely, timeout.

The bug which you fixed would cause the VM to scan itself to death without
throttling.  Did the fix fix things?
