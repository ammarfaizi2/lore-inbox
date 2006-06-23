Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWFWN6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFWN6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWFWN6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:58:03 -0400
Received: from 1wt.eu ([62.212.114.60]:16905 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750703AbWFWNkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:40:49 -0400
Date: Fri, 23 Jun 2006 15:32:17 +0200
From: Willy Tarreau <w@1wt.eu>
To: pageexec@freemail.hu
Cc: Andi Kleen <ak@suse.de>, marcelo@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Message-ID: <20060623133217.GA24737@1wt.eu>
References: <449BC808.4174.277D15CF@pageexec.freemail.hu> <449C0616.4382.286F7C8C@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449C0616.4382.286F7C8C@pageexec.freemail.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 03:17:42PM +0200, pageexec@freemail.hu wrote:
> > > that's not true. if the application expects to crash due to a bad
> > > signal handler then rip=0 may or may not achieve that, depending on
> > > what mapping exists at that address - this is inconsistent behaviour
> > > (from userland's point of view) created by the kernel itself, hence
> > > this is a kernel bug and should be fixed.
> > 
> > If it "wants" to crash it can just jump to 0 (or whatever unmapped address
> > it has) by itself.
> 
> i very carefully didn't say 'want' above, instead i said 'expect'. the
> current code is breaking the expectation that invalid memory dereferences
> will cause a SIGSEGV because the rip=0 code tries to outsmart userland by
> finding such an invalid address - except 0 is not at all guaranteed to be
> invalid. don't think of only 'normal' applications where this assumption
> is mostly true, think of everything that userland may want to do and having
> a mapping at 0 is within the game rules.
> 
> > No need to involve the kernel here.
> 
> but the current code does exactly that. it assumes that it will crash
> the application by jumping to 0 which may or may not be true. the kernel
> has no business making such assumptions, if it wants to trigger an event
> in userland, it had better make sure it'll actually happen, regardless
> what userland may have done.
> 
> > The only point of the patch was to not make the kernel/CPU crash due 
> > to CPU bugs triggered by applications.
> 
> and was it also the purpose to make the application behave differently
> depending on what it has mapped at 0? i doubt so. also, what does 2.6
> do to avoid this? it doesn't have this rip=0 code (yet?).
> 
> > But we really
> > don't care what happens to the application when it corrupts its stack frame.
> 
> then why do you (try to) crash it? apparently you do care about it ;-).
> 
> in particular, the bad signal handler installed by userland would cause a
> SIGSEGV (modulo the CPU bug?), so what the original rip=0 patch wanted to
> do is trigger this SIGSEGV while not tripping on the CPU bug. it achieved
> the second goal but not the first one, that's all i'm trying to explain.

If I understand it well, an application which maps address 0 has no way to
be notified that the kernel detected a corrupted stack pointer. I agree
that if the proposed patch avoids to make this undesired distinction between
apps that map addr 0 and those which don't, it would be better to merge it.
Andi, you said there was nothing wrong with it, do you accept that it gets
merged ?

Regards,
Willy

