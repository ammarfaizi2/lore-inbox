Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422948AbWBBFhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422948AbWBBFhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422947AbWBBFhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:37:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422948AbWBBFhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:37:02 -0500
Date: Wed, 1 Feb 2006 21:36:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] compat: fix compat_sys_openat and friends
In-Reply-To: <20060202161151.58839ffd.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0602012134150.21884@g5.osdl.org>
References: <20060202161151.58839ffd.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Stephen Rothwell wrote:
>
> Most of the 64 bit architectures will zero extend the first argument to
> compat_sys_{openat,newfstatat,futimesat} which will fail if the 32 bit
> syscall was passed AT_FDCWD (which is a small negative number).  Declare
> the first argument to be an unsigned int which will force the correct
> sign extension when the internal functions are called in each case.

Umm.

Wouldn't it be _much_ better to declare the argument as a "long", since 
some architectures (alpha, for example) may assume that 32-bit arguments 
have been _sign_extended, not zero-extended.

Then, when the "compat_sys_xxxx()" function passes the "long" down to the 
_real_ function (which takes an "int"), those architectures (and only 
those architectures) that actually have assumptions about high bits will 
have the compiler automatically do the right zero- or sign-extensions at 
that call-site.

		Linus
