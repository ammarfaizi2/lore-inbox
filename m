Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUKWSI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUKWSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKWSGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:06:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:21948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbUKWSEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:04:09 -0500
Date: Tue, 23 Nov 2004 10:03:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <41A30612.2040700@dif.dk>
Message-ID: <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Nov 2004, Jesper Juhl wrote:
>
> Linus, would you accept patches like this?

No, please don't.

The warning is sometimes useful, but when it comes to a construct like

	if (a < 0 || a > X)

the fact that "a" is unsigned does not make the construct silly. First 
off, it's (a) very readable and (b) the type of "a" may not be immediately 
obvious if it's a user typedef, for example. 

In fact, the type of "a" might depend on the architecture, or even 
compiler flags. Think about "char" - which may or may not be signed 
depending on ABI and things like -funsigned-char.

In other places, it's not "unsigned" that is the problem, but the fact 
that the range of a type is smaller on one architecture than another. So 
you might have

	inf fn(pid_t a)
	{
		if (a > 0xffff)
			...
	}

which might warn on an architecture where "pid_t" is just sixteen bits 
wide. Does that make the code wrong? Hell no.

IOW, a lot of the gcc warnings are just not valid, and trying to shut gcc 
up about them can break (and _has_ broken) code that was correct before.

> I probably won't be able to properly evaluate/review *all* the instances 
> of this in the kernel,

It's not even that I will drop the patches, it's literally that "fixing" 
the code so that gcc doesn't complain can be a BUG. We've gone through 
that. 

		Linus
