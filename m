Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUKNJXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUKNJXX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUKNJXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:23:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:36994 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261269AbUKNJXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:23:19 -0500
Date: Sun, 14 Nov 2004 09:23:08 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu,
       seto.hidetoshi@jp.fujitsu.com, ahu@ds9a.nl
Subject: Re: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5 [u])
Message-ID: <20041114092308.GA4389@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114010943.3d56985a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The patch wasn't supposed to optimise anything.  It fixed a bug which was
> causing hangs.  See
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
> 
> Or are you saying that userspace is buggy??

I haven't looked at the NPTL code, but that URL's pseudo-code is buggy.
The call to FUTEX_WAKE should be doing wake++ conditionally on the
return value, not unconditionally.

Also, the patch doesn't actually fix the described problem.

It may hide it in tests, but the race or a similar one is present in a
different execution order.

The real NPTL code is more complicated than described at that URL,
because real pthread_cond_wait takes a mutex argument as well.  The
bug report does not say how that is handled, and it is critically
important that the mutex and convar are updated concurrently in the
right way.

So I don't know if NPTL is buggy, but the pseudo-code given in the bug
report is (because of unconditional wake++), and so is the failure
example (because it doesn't use a mutex).

-- Jamie
