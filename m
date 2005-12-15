Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVLON6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVLON6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVLON6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:58:22 -0500
Received: from science.horizon.com ([192.35.100.1]:44841 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932539AbVLON6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:58:22 -0500
Date: 15 Dec 2005 08:58:12 -0500
Message-ID: <20051215135812.14578.qmail@science.horizon.com>
From: linux@horizon.com
To: torvalds@osdl.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our Fearless Leader, in a fit of madness, intoned:
> A real semaphore is counting. 
> 
> Dammit, unless the pure mutex has a _huge_ performance advantage on major 
> architectures, we're not changing it. There's absolutely zero point. A 
> counting semaphore is a perfectly fine mutex - the fact that it can _also_ 
> be used to allow more than 1 user into a critical region and generally do 
> other things is totally immaterial.

You're being thick today.  Pay attention to the arguments.

A counting semaphore is NOT a perfectly fine mutex, and it SHOULD be changed.

People are indeed unhappy with the naming, and whether patching 95%
of the callers of up() and down() is a good idea is a valid and active
subject of debate.  (For an out-of-tree -rt patch, is was certaintly
an extremely practical solution.)

But regardless of the eventual naming convention, mutexes are a good idea.
A mutex is *safer* than a counting semaphore.  That's the main benefit.
Indeed, unless there's a performance advantage to a counting semaphore,
you should use a mutex!

It documents in the source what you're doing.  Using a counting semaphore
for a mutex is as silly as using a float for a loop index.  Even if
there isn't much speed penalty on modern processors.

Or perhaps I should compare it to using void * everywhere.  That's a
perfectly fine pointer; why type-check it?

A separate mutex type allows extra error-checking.  You can keep track
of the current holder (since there can be only one) and check that the
same person released it and didn't try to double-acquire it.

You can do priority inheritance, which is the main motivation for doing
this work in the -rt patches.

This isn't about speed, it's about bug-free code.  And having a mutex
abstraction distinct from a general counting semaphore is damn useful
error-checking, even if it is simply a thin wrapper over a counting
semaphore.  The only reason the code is full of counting semaphores
right now is that that's all people had.

Better to give them the right tool.
