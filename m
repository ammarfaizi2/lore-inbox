Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWKCWbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWKCWbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWKCWbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:31:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932210AbWKCWbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:31:48 -0500
Date: Fri, 3 Nov 2006 14:31:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061103143145.85a9c63f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 14:10:01 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> > 
> > Wall time is a bogus concept in the VM.  Can we please stop relying upon it?
> 
> We use the same 2 second pulse to drain slab caches, and the page 
> allocators per cpu caches. The slab draining has been around forever.

And it doesn't make sense there either.

Well.  There are situations where it makes a _bit_ of sense: in those
places where we are trying to determine whether a piece of memory is still
in the CPU's cache.  If we assume that the CPU is evicting cachelines at a
constant lines/sec rate then yes, using walltime has some correlation with
reality.

But in this application which you are proposing, any correlation with
elapsed walltime is very slight.  It's just the wrong baseline to use. 
What is the *sense* in it?

> > > not matter though since we always can fall back to operating without
> > > full_interleave_nodes. As a result of the racyness we may uselessly
> > > skip a node or retest a node.
> > 
> > This design relies upon nodes having certain amounts of free memory.  This
> > concept is bogus.  Because it treats clean pagecache which hasn't been used
> > since last Saturday as "in use".  It is not in use.
> 
> It relies on free pages, not on in use pages.

Yes.  And it is wrong to do so.  Because a node may well have no "free"
pages but plenty of completely stale ones which should be reclaimed.

This patch is very specific to the one particular usage scenario which your
users happen to deploy but is quite ineffective for other (and quite valid)
usage scenarios.

> The attempt is to bypass 
> expensive reclaim as long as we can find free memory on other nodes.

Reclaim isn't expensive.
