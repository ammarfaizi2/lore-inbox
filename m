Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVJMSKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVJMSKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVJMSKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:10:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932148AbVJMSKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:10:23 -0400
Date: Thu, 13 Oct 2005 11:10:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Dooks <ben-linux@fluff.org>
cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] drivers/base - fix sparse warnings
In-Reply-To: <20051013165441.GA18360@home.fluff.org>
Message-ID: <Pine.LNX.4.64.0510131059510.15297@g5.osdl.org>
References: <20051013165441.GA18360@home.fluff.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Oct 2005, Ben Dooks wrote:
> 
> The patch does not solve all the sparse errors generated,
> but reduces the count significantly.

Well, you should also then remove the _bad_ declarations.

For example, attribute_container_init() right now is defined in 
attribute_container.c, but then it's _declared_ (with no checking) where 
it's used in init.c. 

The sparse warnign is appropriate: it was not declared where that 
declaration is actually visible to the definition, so the code basically 
isn't type-safe at all (since there's nothing that enforces the 
declaration actually matching the definition).

You made the declaration properly visible, but you should also remove the 
bogus declaration. A declaration that isn't visible to the definition is 
always bad - since in the absense of a compiler with global visibility it 
may or may not actually match what it supposedly declares.

I wonder if I should make sparse warn about multiple declarations..

These days, sparse actually has some limited support for checking _global_ 
visibility, and we could do cross-checking across thousands of files. 
However, the build environment isn't really very amenable to that, so 
doing a global sparse check is pretty hard in practice.

We could possibly do a per-directory global check, which might be better 
than nothing (ie if you were to have incorrect declaration in a C file 
that is in the same directory as another C file, then we could 
cross-check).

But the kernel kbuild environment is pretty hairy, and I wouldn't even 
know where to begin trying to do that. It's also fundamentally hard to do 
if there are per-file pre-defines (since to do a cross-check, sparse wants 
to see all C files together on the command line).

		Linus
