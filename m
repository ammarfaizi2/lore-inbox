Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267990AbUBRUAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267988AbUBRUAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:00:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:26582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267990AbUBRUAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:00:31 -0500
Date: Wed, 18 Feb 2004 11:59:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <20040218113338.GH28599@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402181154290.2686@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl>
 <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
 <20040218113338.GH28599@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > Somebody correctly pointed out that you do not need any out-of-band 
> > encoding mechanism - the very fact that it's an invalid sequence is in 
> > itself a perfectly fine flag. No out-of-band signalling required.
> 
> Technically this is almost(*) correct,
> 
> (*) - It's fine until you concatenate two malformed strings.  Then the
>       out-of-band signal is lost if the combination is valid UTF-8.

But that's what you _want_. Having a real out-of-band signal that says 
"this stuff is wrong, because it was wrong at some point in the past", and 
not allowing concatenation of blocks of utf-8 bytes would be _bad_.

The thing, concatenating two malformed UTF-8 strings is normal behaviour 
in a variety of circumstances, all basically having to do with lower 
levels now knowing about higer-level concepts.

For example, look at a web-page. Look at how the data comes in: it comes 
as a stream of bytes, with blocking rules that have _nothing_ to do with 
the content (timing, mtu's, extended TCP headers etc etc). That doesn't 
mean that you shouldn't be able to
 - work on the partial results and show them to the user as UTF-8
 - be able to concatenate new stuff as it comes in.

Having an out-of-band signal for "bad" would literally be a bad idea. If 
you get a valid UTF-8 stream as a result of concatenation, you should 
consider that to be the correct behaviour, or you should CHECK BEFOREHAND 
if you think it is illegal.

		Linus
