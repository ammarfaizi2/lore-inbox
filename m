Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUAEUqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUAEUqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:46:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:27624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265843AbUAEUqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:46:33 -0500
Date: Mon, 5 Jan 2004 12:46:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Gardiner Myers <jgmyers@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch/revised] wake_up_info() ...
In-Reply-To: <3FF9BAD3.9040804@speakeasy.net>
Message-ID: <Pine.LNX.4.58.0401051239110.2153@home.osdl.org>
References: <fa.kf16nao.126qarq@ifi.uio.no> <3FF9BAD3.9040804@speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, John Gardiner Myers wrote:
>
> It would seem better if info were a void *, to permit sending more than 
> a single unsigned long.

The argument against that is that since there is basically no 
synchronization here, you can't pass a pointer to some random object. So 
by default, you should think of the cookie as "pass-by-value", ie not a 
pointer. That way there are no liveness issues: there is no issue about 
what happens to the data when the recipient is actually scheduled 
(possibly _much_ much after the actual wakeup).

Also, the forseeable actual use of this piece of data is purely integer:
things like the POLLIN | POLLOUT flags. There may never be any other use.

Also, passing in an "unsigned long" does not preclude using a data area
for more complex cases: if the users do their own synchronization around
the waitqueue on a higher level, and a pointer is a valid thing to use,
you can cast that "unsigned long" to a pointer. This is very common kernel
usage: it may not be "portable" in the theoretical sense, but it's deeply
embedded in the kernel that you can pass pointers as just bitpatters that
fit in an "unsigned long".

The basic rule should be: don't build complex infrastructure. Build simple
infrastructure that you can build complexity on top of if you ever need
it. This was my reaction, and apparently Manfred Spraul reacted the same
way.

		Linus
