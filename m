Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWCaSSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWCaSSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWCaSSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:18:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932196AbWCaSSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:18:20 -0500
Date: Fri, 31 Mar 2006 20:18:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331181827.GC14022@suse.de>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org> <20060331121817.GA11810@elte.hu> <20060331122339.GS14022@suse.de> <20060331122626.GT14022@suse.de> <20060331124754.GB15331@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331124754.GB15331@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > > > with pipe-based buffering this approach has still the very same problems 
> > > > that sendfile() has with packet boundaries, because it's not enough to 
> > > > have "large enough" buffering (like a pipe has), the pipe also has to be 
> > > > drained, and the networking layer has to know the precise boundary of 
> > > > data.
> > > > 
> > > > the right solution to the packet boundary problem is to pass in a proper 
> > > > "does userspace expect more data right now" flag, or to let userspace 
> > > > 'flush' the socket independently - which is independent of the 
> > > > pipe-in-slice issue. This solution already exists: the MSG_MORE flag.
> > > 
> > > We can add a SPLICE_F_MORE flag for this, right now splice doesn't set
> > > the MSG_MORE flag for the end of the pipe.
> > 
> > Ala
> 
> >  #define SPLICE_F_MOVE	(0x01)	/* move pages instead of copying */
> > +#define SPLICE_F_MORE	(0x02)	/* expect more data */
> 
> ok, nice - something like this should work. The direction of the flag is 
> a philosophical question i guess: i believe in Linux we prefer to 
> default to "buffering enabled", i.e. the default flag should be "expect 
> more data". So maybe it would be better to pass in PLICE_F_END, to 
> indicate end-of-data. [it doesnt mean 'permanent end', so all the files 
> still remain open: this could be something like a HTTP 1.1 pipelined 
> request.]

Hmm I do prefer a MORE as to an END, as it will always give predictable
results. The MORE is a performance hit, where as a missing END wont
necessarily be detected until you start looking at latencies.

> furthermore, the internal implementation should also get smarter and do 
> a flush-socket if it would e.g. block on a pagecache page. [we often 
> prefer a partial packet in such cases instead of having a half-built 
> packet hang around.]

That's a really good idea! Wont be too much trouble to add, probably the
easiest is to add a 'wait' variable to the ->map() function or something
along those lines.

> btw., that 'data boundary' detail is likely lost with the pipe 
> intermediary solution: there is no direct connection between 'input 
> file' and 'output socket', so a 'flush now' event doesnt get propagated 
> in a natural way. (unless we extend pipes with 'data boundary' markers, 
> or force their flushing, which looks a whole lot of complexity for such 
> a simple thing.)

Probably not.

-- 
Jens Axboe

