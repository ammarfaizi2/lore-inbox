Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWCaMuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWCaMuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCaMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:50:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63635 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932091AbWCaMuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:50:22 -0500
Date: Fri, 31 Mar 2006 14:47:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331124754.GB15331@elte.hu>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org> <20060331121817.GA11810@elte.hu> <20060331122339.GS14022@suse.de> <20060331122626.GT14022@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331122626.GT14022@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> > > with pipe-based buffering this approach has still the very same problems 
> > > that sendfile() has with packet boundaries, because it's not enough to 
> > > have "large enough" buffering (like a pipe has), the pipe also has to be 
> > > drained, and the networking layer has to know the precise boundary of 
> > > data.
> > > 
> > > the right solution to the packet boundary problem is to pass in a proper 
> > > "does userspace expect more data right now" flag, or to let userspace 
> > > 'flush' the socket independently - which is independent of the 
> > > pipe-in-slice issue. This solution already exists: the MSG_MORE flag.
> > 
> > We can add a SPLICE_F_MORE flag for this, right now splice doesn't set
> > the MSG_MORE flag for the end of the pipe.
> 
> Ala

>  #define SPLICE_F_MOVE	(0x01)	/* move pages instead of copying */
> +#define SPLICE_F_MORE	(0x02)	/* expect more data */

ok, nice - something like this should work. The direction of the flag is 
a philosophical question i guess: i believe in Linux we prefer to 
default to "buffering enabled", i.e. the default flag should be "expect 
more data". So maybe it would be better to pass in PLICE_F_END, to 
indicate end-of-data. [it doesnt mean 'permanent end', so all the files 
still remain open: this could be something like a HTTP 1.1 pipelined 
request.]

furthermore, the internal implementation should also get smarter and do 
a flush-socket if it would e.g. block on a pagecache page. [we often 
prefer a partial packet in such cases instead of having a half-built 
packet hang around.]

btw., that 'data boundary' detail is likely lost with the pipe 
intermediary solution: there is no direct connection between 'input 
file' and 'output socket', so a 'flush now' event doesnt get propagated 
in a natural way. (unless we extend pipes with 'data boundary' markers, 
or force their flushing, which looks a whole lot of complexity for such 
a simple thing.)

straight pagecache->socket splicing on the other hand preserves 'data 
boundary' markers in a natural way for two reasons: 1) the input and 
output objects are known to the kernel at once 2) because there is no 
internal buffering to begin with.

	Ingo
