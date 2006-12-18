Return-Path: <linux-kernel-owner+w=401wt.eu-S1751078AbWLRB3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWLRB3t (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 20:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWLRB3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 20:29:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47137 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbWLRB3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 20:29:48 -0500
Date: Sun, 17 Dec 2006 17:29:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Linus Torvalds wrote:
> 
> So we should probably do a "wait_for_page()" in do_no_page()?
> 
> Or maybe only do it for write accesses (since we don't really care about 
> getting mapped readably)? If so, we need to do it in the write case of 
> do_no_page() _and_ in the do_wp_page() case. Hmm?

I think we discussed doing exactly this at some earlier time, actually, 
just to try to throttle people who do lots of page dirtying. 

Maybe we even do it somewhere, but I tried to see it, and in the normal 
"nopage()" routine we very much try to _avoid_ locking the page (ie if 
it's marked PageUptodate() we'll return it whether locked or not). Which 
is fine - especially for readers, there really isn't any reason to ever 
delay them getting access to a page just because it's locked for write-out 
or something (once it's mapped, they'll have access to it regardless of 
any locked state in the kernel anyway).

So I don't actually see any serialization at all that would keep a random 
page from being paged back in.

		Linus
