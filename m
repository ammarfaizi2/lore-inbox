Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbULJS2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbULJS2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULJS2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:28:20 -0500
Received: from waste.org ([209.173.204.2]:60139 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261792AbULJS2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:28:16 -0500
Date: Fri, 10 Dec 2004 10:28:04 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041210182804.GT8876@waste.org>
References: <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210163558.GB10639@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 11:35:58AM -0500, Theodore Ts'o wrote:
> On Thu, Dec 09, 2004 at 08:47:59PM -0800, Matt Mackall wrote:
> > 
> > But it turns out that we can do this without hashing under the lock
> > after all. What's important is that we mix and extract atomically.
> > Something like this should be quite reasonable:
> 
> The core idea is good, but your patch has a bug in it; it bashes
> add_ptr before it gets saved into r->add_ptr.

I seem to remember having a rationale for that, but I'm fine with your
way.

> Also, it's a more
> complicated than it needed to be (which makes it harder to analyze
> it).

Fair enough. s/__add/mix/, please.

> Finally, it won't work if the pool doesn't get initialized with
> sufficient randomness in the init scripts, and there are too many
> constant zero's in the pool.  But this is easily fixed by using a
> different initialization pattern.

It won't work as in we'll still get duplicates? I don't see how that
happens. The polynomial for the output pools is dense enough that even
on the very next one word mix, we're getting 96 bits changed in the
output and 32 new ones shifted in. And we're always doing at least
three adds for each pull.

It's still suboptimal, perhaps, but I'd rather mix more in
init_std_data. In fact, I was hoping to abolish the pool clearing
function in favor of just init_std_data, as there's not much utility
in going back to a known state here. Let's address this separately.

-- 
Mathematics is the supreme nostalgia of our time.
