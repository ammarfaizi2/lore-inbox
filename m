Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUJ0Ckr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUJ0Ckr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUJ0Ckr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:40:47 -0400
Received: from ozlabs.org ([203.10.76.45]:29639 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261580AbUJ0Ckd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:40:33 -0400
Subject: Re: [RFC as402] Delaying module memory release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0410261520170.690-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0410261520170.690-100000@ida.rowland.org>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 12:40:11 +1000
Message-Id: <1098844811.22012.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 15:52 -0400, Alan Stern wrote:
> This issue has come up in the past, without much in the way of visible 
> results.
> 
> The problem is that sometimes the memory for a kernel module needs to be
> freed _after_ rmmod has exited.  The classic example is where the standard
> input to the rmmod process has been redirected to a pseudo-file that pins
> a kobject whose release method calls into the module.  Another example
> (which could be worked around with some effort) is multiple kernel threads
> executing in the module -- the module exit routine would have to wait for 
> each one of them to terminate.
> 
> In these cases it's not desirable/feasible to increment the module's 
> refcount.

Why not?  In the former the module is still in use, in the latter the
module_exit routine is expected to clean up.

> Instead the module's exit routine should run and rmmod should 
> return, but the module's memory should only be freed when it is known that 
> nothing else will try to use it.

[Snip poor man's two-stage module delete patch].

We've been here lots of times before.  Most people want "remove or fail"
semantics for module removal.  Two-stage delete doesn't do this, but
instead leaves modules in a "half-removed" state, where the module
cannot be used, but usually a replacement module cannot be loaded
either.  This is what "rmmod --wait" does: close off module use to
future users (ie. try_module_get() will fail) and wait for the refcnt to
hit 0.

This option has not proven popular.
Rusty.
-- 

