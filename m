Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUHaQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUHaQwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHaQwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:52:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:39576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264377AbUHaQwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:52:40 -0400
Date: Tue, 31 Aug 2004 09:52:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, bunk@fs.tum.de,
       arjanv@redhat.com, axboe@suse.de
Subject: Re: What policy for BUG_ON()?
In-Reply-To: <1093964782.434.7054.camel@cube>
Message-ID: <Pine.LNX.4.58.0408310945580.2295@ppc970.osdl.org>
References: <1093964782.434.7054.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Albert Cahalan wrote:
> 
> The normal expectation for non-debug builds
> would be this:
> 
> #define BUG_ON(x)

No, this is bad, for one big reason: it generates compiler warnings if 'x'
happens to be the only thing that uses some value. You get things like
"unused variable 'mode'" etc in perfectly good code.

For example, the code might look something like

	int count = 0;

	for_each_online_cpu(cpu) {
		... do something ..
		.. update count ..
	}

	BUG_ON(!count);

and if you now compile on UP and with debugging enabled, the compiler
might complain that you're computing "count" but never _using_ the value.

This is generally why you should have macros like this not become empty, 
but become something that the compiler can compile away. Which is why I'd 
much rather see

	#define BUG_ON(x) (void)(x)

regardless of any side-effect issues - it's a way to let the compiler 
optimize the thing away, but still show that something was used at least 
"conceptually"..

		Linus
