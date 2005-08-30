Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVH3OGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVH3OGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVH3OGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:06:05 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28342 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932092AbVH3OGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:06:04 -0400
Date: Tue, 30 Aug 2005 07:06:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 1/3] x86_64: Add a notify_die() call to the "no context" part of do_page_fault()
Message-ID: <20050830140603.GB3966@smtp.west.cox.net>
References: <resend.1.2982005.trini@kernel.crashing.org> <43140BC5.1090804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43140BC5.1090804@mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 12:33:25AM -0700, George Anzinger wrote:
> Tom Rini wrote:
> >CC: Andi Kleen <ak@suse.de>
> >This adds a call to notify_die() in the "no context" portion of
> >do_page_fault() as someone on the chain might care and want to do a fixup.
> >
> >---
> >
> > linux-2.6.13-trini/arch/x86_64/mm/fault.c |    4 ++++
> > 1 files changed, 4 insertions(+)
> >
> >diff -puN arch/x86_64/mm/fault.c~x86_64-no_context_hook 
> >arch/x86_64/mm/fault.c
> >--- linux-2.6.13/arch/x86_64/mm/fault.c~x86_64-no_context_hook 2005-08-29 
> >11:09:13.000000000 -0700
> >+++ linux-2.6.13-trini/arch/x86_64/mm/fault.c	2005-08-29 
> >11:09:13.000000000 -0700
> >@@ -514,6 +514,10 @@ no_context:
> > 	if (is_errata93(regs, address))
> > 		return; 
> > 
> >+	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> >+				SIGSEGV) == NOTIFY_STOP)
> >+		return;
> >+
> > /*
> >  * Oops. The kernel tried to access some bad page. We'll have to
> >  * terminate things with extreme prejudice.
> 
> Please use a more descriptive text than "no context".  This bit of info 
> SHOULD be available to the gdb/kgdb user and should indicate why kgdb 
> was entered.  It thus should be something like "bad kernel address" or 
> "illegal kernel address".

"no context" is the label we're in, in the code.  What it's actually
used for is "hey, we (== kgdb) tried to read/write a very very bogus
addr, time to longjmp".  If it's not true that kgdb is at fault then we
drop to the debugger anyhow, and the user can see where they came from.

-- 
Tom Rini
http://gate.crashing.org/~trini/
