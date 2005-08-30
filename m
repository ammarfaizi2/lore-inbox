Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVH3Oux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVH3Oux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVH3Oux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:50:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16626 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932159AbVH3Ouw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:50:52 -0400
Message-ID: <43147237.5030108@mvista.com>
Date: Tue, 30 Aug 2005 07:50:31 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 1/3] x86_64: Add a notify_die() call to the "no context"
 part of do_page_fault()
References: <resend.1.2982005.trini@kernel.crashing.org> <43140BC5.1090804@mvista.com> <20050830140603.GB3966@smtp.west.cox.net>
In-Reply-To: <20050830140603.GB3966@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Tue, Aug 30, 2005 at 12:33:25AM -0700, George Anzinger wrote:
> 
>>Tom Rini wrote:
>>
>>>CC: Andi Kleen <ak@suse.de>
>>>This adds a call to notify_die() in the "no context" portion of
>>>do_page_fault() as someone on the chain might care and want to do a fixup.
>>>
>>>---
>>>
>>>linux-2.6.13-trini/arch/x86_64/mm/fault.c |    4 ++++
>>>1 files changed, 4 insertions(+)
>>>
>>>diff -puN arch/x86_64/mm/fault.c~x86_64-no_context_hook 
>>>arch/x86_64/mm/fault.c
>>>--- linux-2.6.13/arch/x86_64/mm/fault.c~x86_64-no_context_hook 2005-08-29 
>>>11:09:13.000000000 -0700
>>>+++ linux-2.6.13-trini/arch/x86_64/mm/fault.c	2005-08-29 
>>>11:09:13.000000000 -0700
>>>@@ -514,6 +514,10 @@ no_context:
>>>	if (is_errata93(regs, address))
>>>		return; 
>>>
>>>+	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
>>>+				SIGSEGV) == NOTIFY_STOP)
>>>+		return;
>>>+
>>>/*
>>> * Oops. The kernel tried to access some bad page. We'll have to
>>> * terminate things with extreme prejudice.
>>
>>Please use a more descriptive text than "no context".  This bit of info 
>>SHOULD be available to the gdb/kgdb user and should indicate why kgdb 
>>was entered.  It thus should be something like "bad kernel address" or 
>>"illegal kernel address".
> 
> 
> "no context" is the label we're in, in the code.  What it's actually
> used for is "hey, we (== kgdb) tried to read/write a very very bogus
> addr, time to longjmp".  If it's not true that kgdb is at fault then we
> drop to the debugger anyhow, and the user can see where they came from.
> 
No.  What the user sees is the offending code (i.e. prior to the trap to 
page_fault), NOT how kgdb happend to be called.  The "no_context" is IN 
the _context_ of page_fault, but that is lost by the time you get to 
kgdb and ask to see _why_ (via, hint, hint: "p kgdb_info").

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
