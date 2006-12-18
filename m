Return-Path: <linux-kernel-owner+w=401wt.eu-S1751627AbWLRCDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWLRCDr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 21:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWLRCDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 21:03:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48838 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbWLRCDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 21:03:46 -0500
Date: Sun, 17 Dec 2006 17:57:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Replying to myself - a sure sign that I don't get out enough ]

On Sun, 17 Dec 2006, Linus Torvalds wrote:
> 
> So I don't actually see any serialization at all that would keep a random 
> page from being paged back in.

We do actually serialize, but we do it _after_ the page has already been 
mapped back. Ie we do it for the dirty page case at rthe end of 
do_wp_page() and do_no_page() when we do the "set_page_dirty_balance()", 
but that's potentially too late - we've already mapped the page read-write 
into the address space.

That said, this means that only threaded apps should ever trigger any 
problems, which would seem to make it unlikely that this is the issue.

But Andrew: I don't think it's necessarily true that 
"try_to_free_buffers()" callers have all unmapped the page.

That seems to be true for vmscan.c (ie the shrink_page_list -> 
try_to_release_page -> try_to_release_buffers callchain), but what about 
the other callchains (through filesystems, or through "pagevec_strip()" or 
similar?) That pagevec_strip() is called from shrink_active_list(), I 
don't see that unmapping the pages..

		Linus
