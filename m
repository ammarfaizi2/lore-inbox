Return-Path: <linux-kernel-owner+w=401wt.eu-S1754382AbWLRSfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbWLRSfY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbWLRSfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:35:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34371 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380AbWLRSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:35:23 -0500
Date: Mon, 18 Dec 2006 10:35:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166466272.10372.96.camel@twins>
Message-ID: <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <1166466272.10372.96.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Peter Zijlstra wrote:
> > 
> > Or maybe the WARN_ON() just points out _why_ somebody would want to do 
> > something this insane. Right now I just can't see why it's a valid thing 
> > to do.
> 
> Maybe, but I think Nick's mail here:
>   http://lkml.org/lkml/2006/12/18/59
> 
> shows a trace like that.

Sure, but I actually think that "try_to_free_buffers()" was buggy in the 
first place, shouldn't have done what it did at all (it has NO business 
clearing dirty data), and should be fixed with my other simple and clean 
patch that just removes the crap.

But sadly, Andrei said that he still saw data corruption, which implies 
that the problem had nothing to do with "try_to_free_buffers()" at all.

(On that note: Andrei - if you do test this out, I'd suggest applying my 
patch too - the one that you already tested. It won't apply cleanly on top 
of Andrew's patch, but it should be trivial to apply by hand, since you 
really just want to remove the whole "if (ret) {...}" sequence. I realize 
that it didn't make any difference for you, but applying that patch is 
probably a good idea just to remove the noise for a codepath that you 
already showed to not matter)

> I'm guessing that if we do the WARN_ON() some folks might get a lot of 
> output, perhaps WARN_ON_ONCE() ?

Well, I'd rather get lots of noise to see all the paths that can cause 
this. We've been concentrating mainly on one (try_to_free_buffers()), but 
that one was already shown not to matter or at least not to be the _whole_ 
issue, so..

		Linus
