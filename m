Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUBTSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBTSr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:47:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35236 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261243AbUBTSrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:47:18 -0500
Date: Fri, 20 Feb 2004 19:48:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220184822.GA23460@elte.hu>
References: <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > there's another class of problems: is it an issue that directory renames
> > that move this directory (higher up in the directory hierarchy of this
> > directory) do not invalidate the cache? In that case there's no dnotify
> > event either.
> 
> This is one of the reasons why I worry about user-space caching. It's
> just damn hard to get right.

this particular problem could be solved by walking down to the root
dentry for every sys_manage_dir_cache() lookup and check that each
dentry is still cache-valid. This involves some overhead, but it's still
faster than doing the same from userspace. (ie. validating each previous
path component at lookup time.) Since this doesnt change the dcache it
ought to be doable via the rcu-read path and would thus still have
pretty good SMP properties. [except when traversing mountpoints :-( ].

but this scheme also has other problems: who decides who is the 'cache
manager'? What if there are two instances of fileservers both using the
same fileset and also trying to do caching this way?

perhaps using a simple 64-bit generation counter would be better. Samba
would get a new syscall to get the sum of each generation counter down
to the root dentry - a total validation of the pathname. If the counter
matches with that in the userspace cache entry then no need to re-create
the cache. Such generation counters would be usable for multiple file
servers as well. Hm?

> It's hard in kernel space too, of course, but we've had smart people
> working on the dcache for years. So if we can sanely avoid
> duplication, that would be a good thing.

i believe Samba already has what is in essence a duplication of the
dcache. We could enable it to be fairly coherent, for Samba to be able
to have an authorative 'does this file exist' answer without any
excessive readdir()s.

	Ingo
