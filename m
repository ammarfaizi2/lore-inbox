Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWGJJhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWGJJhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWGJJhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:37:21 -0400
Received: from palrel11.hp.com ([156.153.255.246]:5009 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S964838AbWGJJhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:37:19 -0400
Date: Mon, 10 Jul 2006 02:28:52 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO bitmaps
Message-ID: <20060710092852.GC26382@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200607071155_MC3-1-C45F-B7C2@compuserve.com> <Pine.LNX.4.64.0607081425430.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607081425430.3869@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Sat, Jul 08, 2006 at 02:26:53PM -0700, Linus Torvalds wrote:
> > From: Stephane Eranian <eranian@hpl.hp.com>
> > 
> > Use thread info flags to track use of debug registers and IO bitmaps.
> >  
> > 	- add TIF_DEBUG to track when debug registers are active
> >  	- add TIF_IO_BITMAP to track when I/O bitmap is used
> >  	- modify __switch_to() to use the new TIF flags
> 
> Can you explain what the advantages of this are?
> 
> I don't see it. It's just creating new state to describe state that we 
> already had, and as far as I can tell, it's just a way to potentially have 
> more new bugs thanks to the new state getting out of sync with the old 
> one?
> 

AS Chuck explained, this is motivated by the perfmon patch. We need to save
and restore the performance counters on context switch. We do it only for
the tasks that use them. As such, this is yet another optional work that
needs to be checked in __switch_to(). You have to test it for both
the outgoing and incoming tasks. Andi suggested that instead of adding yet
another test and touch yet another pair of cachelines, we pack all the
'extra' work into a single bitfield per task. This way the number of cachelines
touched is limited to two for the debug registers, I/O bitmap and later perfmon.
I leveraged the TIF mechanism for this as it seemed quite appropriate.

As you point out, it adds a little bit of complexity in that you need to
ensure that when you touch the debug registers and/or the I/O bitmap, we keep
the TIF flags in sync. The patch I submitted ensures that. The good thing
is that, for both, the number of places were they are activated/stopped is very
limited.

-- 
-Stephane
