Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVBXDKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVBXDKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVBXDJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:09:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:3496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261761AbVBXDH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:07:56 -0500
Date: Wed, 23 Feb 2005 19:07:47 -0800
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] set RLIMIT_SIGPENDING limit based on RLIMIT_NPROC
Message-ID: <20050224030747.GG15867@shell0.pdx.osdl.net>
References: <421D0D3F.40902@goop.org> <200502240224.j1O2OqHL010736@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502240224.j1O2OqHL010736@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> While looking into the issues Jeremy had with the RLIMIT_SIGPENDING limit,
> it occurred to me that the normal setting of this limit is bizarrely low.
> The initial hard limit setting (MAX_SIGPENDING) was taken from the old
> max_queued_signals parameter, which was for the entire system in aggregate.
> But even as a per-user limit, the 1024 value is incongruously low for this.

But the old default system-wide limit was 1024.  And you could have
spawned 8k processes then as well.  So I don't think this matters much.

> On my machine, RLIMIT_NPROC allows me 8192 processes, but only 1024 queued
> signals, i.e. fewer even than one pending signal in each process.  (To me,
> this really puts in doubt the sensibility of using a per-user limit for
> this rather than a per-process one, i.e. counted in sighand_struct or
> signal_struct, which could have a much smaller reasonable value.  I don't
> recall the rationale for making this new limit per-user in the first place.)

I don't either, the archives show using per-user as default choice
(never saw a discussion otherwise).  Users can easily queue signals to
themselves (using multiple processes or not), and there was some concern
that somebody actually wanted to be able queue up to 1024 (since it's
what was allowed in the past).

> This patch sets the default RLIMIT_SIGPENDING limit at boot time, using the
> calculation that decides the default RLIMIT_NPROC limit.  This uses the
> same value for those two limits, which I think is still pretty conservative
> on the RLIMIT_SIGPENDING value.

It's an rlimit, so easily setable in userspace at login session time.  I
think we could raise it if people start complaining it's too low (hasn't
seemed to be a problem yet).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
