Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVLUGBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVLUGBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVLUGBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:01:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:34757 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932250AbVLUGBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:01:35 -0500
Date: Wed, 21 Dec 2005 07:00:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051221060037.GA32185@elte.hu>
References: <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au> <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org> <20051220193423.GC24199@flint.arm.linux.org.uk> <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org> <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain> <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> If it had _started_ with a mutex implementation that was faster, 
> simpler, and didn't rename the old and working semaphores, I'd have 
> been perfectly fine with it.

oh, i'm totally OK with not doing the renames and leaving semaphores 
alone!

Just in case it wasnt clear: i very much expected that the migration 
helper patches would be controverial, and that they would probably not 
go upstream. [Christoph said last week that they were fit for an 
obfuscated C contest, not the kernel, and i didnt expect this sentiment 
to change overnight.] Look at my patch order:

 xfs-mutex-namespace-collision-fix.patch

 add-atomic-xchg-i386.patch
 add-atomic-xchg-x86_64.patch
 add-atomic-xchg-ia64.patch
 add-atomic-call-func-i386.patch
 add-atomic-call-func-x86_64.patch
 add-atomic-call-func-ia64.patch
 add-atomic-call-wrappers-all-other-arches.patch

 mutex-core.patch

 mutex-debug.patch
 mutex-debug-more.patch

 mutex-migration-helper-i386.patch    # not upstream from here
 mutex-migration-helper-x86_64.patch
 mutex-migration-helper-ia64.patch
 mutex-migration-helper-core.patch

 sx8-sem2completions.patch
 cpu5wdt-sem2completions.patch
 ide-gendev-sem-to-completion.patch
 loop-to-completions.patch

 arch-semaphores.patch

The first 11 patches are finegrained and contain _zero_ of the migration 
and rename stuff. I specifically created the patch-series in such a way, 
so that we could simply chop off the last few patches.

in the future i'll only send patches up to mutex-debug-more.patch, as 
suggested by Christoph and you as well. So there's really no 
controversy. Btw., that was true for my first queue already, as noticed 
by Christoph [*].
 
Basically all of the activity in the last 2 days was in the first 11 
patches. I'll send an updated queue later today.

	Ingo

[*] the migration helpers were incredibly useful for pulling this off.
    Without the wide exposure of mutexes to existing semaphore users i'd
    not have been able to profile the system, to measure the impact the
    effects of mutexes on performance. I'd also not have been able to
    say what percentage of semaphores could move over to mutexes. We 
    could also not have carried the mutex implementation in the -rt tree 
    for more than a year, in which year millions of lines were changed 
    in the upstream kernel! It would have been simply impossible to even 
    attempt this, without the type-sensitive APIs and the minimal 
    renames to categorize semaphores.
