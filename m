Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTL1IXX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 03:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTL1IXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 03:23:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:55227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264981AbTL1IXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 03:23:21 -0500
Date: Sun, 28 Dec 2003 00:23:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Matt Mackall <mpm@selenic.com>,
       Linux Networking Development Mailing List 
	<netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.6.0-tiny] "uninline" {lock,release}_sock
In-Reply-To: <20031228075426.GB24351@conectiva.com.br>
Message-ID: <Pine.LNX.4.58.0312280017060.2274@home.osdl.org>
References: <20031228075426.GB24351@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Dec 2003, Arnaldo Carvalho de Melo wrote:
> 
> 	Please apply on top of your 2.6.0-tiny1 tree, CC to netdev for
> eventual comments.

Please don't do it this way.

This is quite possibly faster even _normally_, so it might make more sense 
to just do it globally instead of having a CONFIG_NEX_SMALL.

Basically, inline functions tend to win only when inlining them is smaller
and simpler than actually calling a function. The most common cause of
that is that some argument is commonly constant (and thus gets simplified
away by inlining), or the function itself literally expands to just a few 
instructions (the list functions, the inline asms for things like "cli" 
etc).

We use a lot too many inline functions for other reasons: one reason to 
use them is that they are sometimes more convenient than it is to find a 
good place for the non-inline version. Another common reason is that the 
thing started out smaller than it eventually became - and the inline just 
stuck around.

But if you do things like this for a CONFIG_SMALL, then the convenience 
argument obviously isn't true any more, and you'd be a lot better off just 
unconditionally making it a real function call.

Function calls aren't all that expensive, especially with FASTCALL() etc 
to show that you don't have to follow the common calling conventions. 
Right now I think FASTCALL() only matters on x86, but some other 
architectures could make it mean "smaller call clobbered list" or similar.

Have you benchmarked with the smaller kernel? 

		Linus
