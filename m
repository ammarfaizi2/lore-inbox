Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbTLZUeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbTLZUeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:34:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:38883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265244AbTLZUeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:34:03 -0500
Date: Fri, 26 Dec 2003 12:33:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
In-Reply-To: <20031226201011.GA32316@axis.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com>
 <20031226201011.GA32316@axis.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Nick Craig-Wood wrote:
> 
> The results are just about the same - a slight slowdown for
> hugepages...

I don't think you are really testing the TLB - you are testing the data 
cache.

And the thing is, using huge pages will mean that the pages are 1:1
mapped, and thus get "perfectly" cache-coloured, while the anonymous mmap 
will give you random placement.

And what you are seeing is likely the fact that random placement is 
guaranteed to not have any worst-case behaviour. While perfect 
cache-coloring very much _does_ have worst-case schenarios, and you're 
likely triggering one of them.

In particular, using a pure power-of-two stride means that you are
limiting your cache to a certain subset of the full result with the
perfect coloring.

This, btw, is why I don't like page coloring: it does give nicely
reproducible results, but it does not necessarily improve performance.  
Random placement has a lot of advantages, one of which is a lot smoother
performance degradation - which I personally think is a good thing.

Try your program with non-power-of-two, and non-page-aligned strides. I
suspect the results will change (but I suspect that the TLB wins will 
still be pretty much in the noise compared to the actual data cache 
effects).

		Linus
