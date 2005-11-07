Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVKGSKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVKGSKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVKGSKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:10:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63445 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965169AbVKGSKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:10:20 -0500
Date: Mon, 7 Nov 2005 10:10:08 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051107181008.GA25983@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051106134945.0e10cb60.akpm@osdl.org> <436EA9F9.4020809@yahoo.com.au> <20051107045809.GA24195@us.ibm.com> <436EEB5E.5020704@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436EEB5E.5020704@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 04:51:26PM +1100, Nick Piggin wrote:
> Paul E. McKenney wrote:
> >On Mon, Nov 07, 2005 at 12:12:25PM +1100, Nick Piggin wrote:
> 
> >>Yes, it is basically ready to go.
> >
> >Would it simplify the rcuref.h code?  Or lib/dec_and_lock.c?
> 
> Yep, I recently posted it to lkml... rcuref.h disappears, and
> dec_and_lock becomes simplified not to mention more efficient
> on those architectures which do not define HAVE_ARCH_CMPXCHG.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113117753625350&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113117753629218&w=2
> 
> I need the infrastructure for lockless pagecache, but fortunately
> it is very useful for other things as well. Especially lockless
> algorithms it seems.

I have been inconvenienced by lack of cmpxchg across all architectures
a number of times -- one can often work around it, but...

Here are the places that check __HAVE_ARCH_CMPXCHG in 2.6.14:

o	arch/i386/kernel/acpi/boot.c <global> 85 #ifndef __HAVE_ARCH_CMPXCHG

	Warning message saying that ACPI must use 486 or later.
	Should be able to get rid of this, though not sure what you
	have to do to ACPI.

o	include/asm-i386/mc146818rtc.h <global> 16 #ifdef __HAVE_ARCH_CMPXCHG

	Provides __cmpxchg()-based code for 486 and better, and assumes
	that 386 is UP.  Should be able to eliminate the 386 code and
	the #ifdef.

o	include/linux/rcuref.h <global> 47 #ifdef __HAVE_ARCH_CMPXCHG
o	kernel/rcupdate.c <global> 76 #ifndef __HAVE_ARCH_CMPXCHG
o	lib/dec_and_lock.c <global> 6 #ifdef __HAVE_ARCH_CMPXCHG

	Looks like you have these three covered.

There are about 50 uses of cmpxchg, and it is possible that some of them
would be simplified by your primitives, as well.

So having cmpxchg available would be a very good thing!

						Thanx, Paul
