Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUIYPni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUIYPni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 11:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbUIYPnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 11:43:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:25998 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269347AbUIYPnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 11:43:32 -0400
Date: Sat, 25 Sep 2004 08:43:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <20040925072516.GS23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0409250834110.2317@ppc970.osdl.org>
References: <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org>
 <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
 <20040925072516.GS23987@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Linus, backing store is irrelevant here (and BTW, variables are no better
> or worse than arguments / structure fields / return values / argument of
> sizeof / etc.)

I agree that in the case of NTFS it is irrelevant. I was talking more in 
general: if you use enums with "types", you really should only use them as 
compile-time constants. Which is, obviously, one very common usage of 
enums, but is not the only one.

I personally believe that people use enum's largely in two (independent) 
ways:

 - a convenient compile-time constant:

	enum {
		DevEnableMask = 1UL << 0,
		DevIRQMask = 1UL << 5,
		DevError = 1UL << 31
	};

   where you never actually _save_ an enum anywhere. In this case, the 
   typing is very convenient indeed.

 - a "type enumerator":

	enum token_type {
		TOKEN_IDENT = 1,
		TOKEN_NUMBER,
		TOKEN_MACRO,
	...

   where the enum actually is used as a variable to distinguish different 
   cases. In this case, the per-enum typing ends up being possibly even 
   confusing, since using a constant will have a potentially _different_ 
   type than loading that constant from a variable.

The second case is why I think it's a sane thing to warn if anybody ever 
creates a variable (or structure/union member) with an enum that used the 
typing features. Not because we can't make the enum fit all the values, 
but because the types simply WILL NOT MATCH. They fundamentally cannot, 
since we took the approach of having per-entry types.

And for sparse, since the type is _the_ most important part of anything, 
we should warn when the types won't match.

		Linus
