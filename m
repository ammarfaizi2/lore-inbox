Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUF2Ehs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUF2Ehs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUF2Ehr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:37:47 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:3740 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S265399AbUF2Ehg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:37:36 -0400
Date: Mon, 28 Jun 2004 21:37:34 -0700
Message-Id: <200406290437.i5T4bYPI022901@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@redhat.com, cagney@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: Andrew Morton's message of  Monday, 28 June 2004 21:15:59 -0700 <20040628211559.73ded525.akpm@osdl.org>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Davide's patch (which has been in -mm for 6-7 weeks) doesn't add
> fastpath overhead.

I am also dubious about exactly what it does.  That patch seems a bizarre
obfuscation of the code to me.  TIF_SINGLESTEP is really there to handle
the lazy TF clearing for sysenter entry, and that's all.  I don't think
that patch handles user-mode setting TF properly, unusual though that case
is.  How does that patch interact with PT_TRACESYSGOOD?  It appears to me
that PTRACE_SINGLESTEP will now generate a syscall trap instead of a
single-step trap, which is an undesireable change in behavior I would say.

I don't really care about user-mode setting of TF before executing int
$0x80.  If poeple have programs that use TF in user mode, they have never
complained about the issue before.  For PTRACE_SINGLESTEP, Davide's
approach of setting the kernel-work flag directly when PTRACE_SINGLESTEP
sets TF in the user flags word is the obvious way to avoid the test in the
fast path.  I am inclined to combine that approeach with what my patch
does, i.e. just take out the system call fast-path test and set
TIF_SINGLESTEP_TRAP in PTRACE_SINGLESTEP.  I think the way Davide's patch
uses TIF_SINGLESTEP is pretty questionable.


Thanks,
Roland

