Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTKUH1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTKUH1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:27:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:20892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264312AbTKUH1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:27:11 -0500
Date: Thu, 20 Nov 2003 23:26:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: ndiswrapper
In-Reply-To: <bpk908$jcd$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0311202316500.13351-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Nov 2003, H. Peter Anvin wrote:
> By author:    Bill Davidsen <davidsen@tmr.com>
> > 
> > I'm curious if the NDIS stuff could be run in ring 1 or 2, being an old
> > MULTICS guy. Not for political reasons, just good tech.
> 
> Unfortunately the segmentation and paging were so poorly integrated in
> i386 that rings 1-2 are pretty much totally useless.

That may be the politically sensitive (except to Intel) correct answer, 
but in the end I suspect that the _real_ answer is that ring 1/2 are just 
fundamentally useless, and it has nothing to do with x86 implementation 
semantics or anything else.

Any kind of reasonable performance driver requires direct access to the
buffers it is going to fill in. And not just the actual data contents, but
to the metadata too - the pointers that comprise the skb (or in BSD, mbuf)  
lists, etc.

So even if you were to use ring1/2 for the driver, you'd really need to
give write access to a large portion of the data structures that the
"core" kernel networking would use.

Which means that you either put the core kernel in ring1/2 as well (at
which point you don't actually use ring0 for anything interesting at all -
you could put a microkernel there, but hey, there's no real point), or you
map in a _lot_ of ring0 metadata into ring1/2, at which point you lost the
whole point of using a different protection domain.

And quite frankly, if you're willing to actually dynamically map all the
ranges and be careful, why use ring1/2 at all? You might as well use ring3
and make the whole thing be a user-mode wrapper. You'd never perform
really well, but for debugging it is acceptable.

Anyway, whatever way you turn, ring1/2 just don't actually _give_ you 
anything. Which is, in the end, the _real_ reason nobody uses them.

(I agree, the fact that the x86 paging hardware makes 1/2/3 be equivalent 
makes it an even _less_ useful abstraction, but I think it is a mistake to 
think that it would be any more useful even if the page tables wasted 
precious bits on unnecessary level information).

Multi-ring was a failure. Let it go. The only reason it is making
something of a comeback (Palladium-whatever-it-is-called-today) has no
good technical reasons, and is purely about other things.

		Linus

