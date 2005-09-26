Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbVIZQla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbVIZQla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbVIZQl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:41:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751665AbVIZQl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:41:29 -0400
Date: Mon, 26 Sep 2005 09:41:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over
 time.
In-Reply-To: <Pine.LNX.4.60.0509261654550.29344@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0509260926160.3308@g5.osdl.org>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
 <Pine.LNX.4.60.0509261654550.29344@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Sep 2005, Anton Altaparmakov wrote:
> > 
> > What was the warning that caused this (and the two other things that look 
> > the same)?
> 
> fs/ntfs/mft.c:2577:24: warning: incompatible types for operation (&)
> fs/ntfs/mft.c:2577:24:    left side has type unsigned long long [unsigned] [usertype] <noident>
> fs/ntfs/mft.c:2577:24:    right side has type bad type enum MFT_REF_CONSTS [toplevel] MFT_REF_MASK_CPU
> fs/ntfs/mft.c:2577:24: warning: cast from unknown type

Ok, not the most wonderful of error messages, I do have to admit ;)

That's sparse being very verbose and not saying a lot, but what happens is
that the "enum" doesn't have a well-defined type, since the different 
constants in the enum don't have compatible types.

So it's type ends up being a "bad type enum MFT_REF_CONSTS"

(It also prints out the name of the symbol with that type, which is why
you also see the MFT_REF_MASK_CPU - the "[toplevel]" is just an internal 
sparse bit saying that it was declared outside of any block scope).

I'm actually a bit surprised that the cast even shut sparse up. It
probably shouldn't have, and it should have complained about casting an
unknown type even _with_ your added cast (ie I think it should have cut
your four lines of warning down to one).

Did it?

> > The issue? "enum" is really an integer type. As in "int". Trying to put a 
> > larger value than one that fits in "int" is not guaranteed to work.
> 
> Yes, that is true but as you say it does work with gcc.

Yes, and sparse will actually conform to gcc behaviour. I think we had a 
warning about it, but it's sadly quite common in the kernel ;p

So if the size of the constants was the only problem, sparse wouldn't 
actually have complained.

The reason it ended up complaining was that it couldn't promote the 
different enum values to the same type. 

I suspect it might be more readable had it complained at enum declaration
time instead, since at that point it would have been able to describe
_why_ it didn't like that enum a bit better. But the problem with that 
approach is that then it complains whether the thing is used or not (and a 
lot of things are bad only at usage time, so sparse tends to try to 
delay any complaints as long as computerly possible).

> > There's another issue, namely that the type of the snum is not only of 
> > undefined size (is it the same size as an "int"? Is it an "unsigned long 
> > long"?) but the "endianness" of it is also now totally undefined. You have 
> > two different endiannesses inside the _same_ enum. What is the type of the 
> > enum?
> 
> Good question.  "confused"?  (-;

Well, in gcc it's clear: it's "unsigned long long".  Because gcc doesn't 
know about little-endian vs big-endian.

In sparse, it's not actually confused either, it's "enum of type
bad_ctype". But the error message isn't very helpful unless you understand
how sparse does that internally (that's why sparse says "right side has
type bad type enum ..." - that "bad type enum" is the magic code-word)

		Linus
