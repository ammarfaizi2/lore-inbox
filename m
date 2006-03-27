Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWC0HiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWC0HiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWC0HiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:38:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1231 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750773AbWC0HiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:38:02 -0500
Subject: Re: RFC - Approaches to user-space probes
From: Arjan van de Ven <arjan@infradead.org>
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20060327065447.GA25745@in.ibm.com>
References: <20060327065447.GA25745@in.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 09:37:48 +0200
Message-Id: <1143445068.2886.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 12:24 +0530, Prasanna S Panchamukhi wrote:
> Hi All,
> 
> As Andrew Morton suggested, here is a document on user-space probes
> discussing known approaches and design issues.
> 
> Please provide your comments and suggestions.
> 
> Thanks
> Prasanna
> ----
> 
> The basic need is to provide infrastructure for user-space dynamic
> instrumentation. As with kprobes, there is no need to recompile or
> restart the applications for instrumentation, under a debugger for
> instance.
> 
> Some of the use-cases are:
> 
> - To find out the memory leaks dynamically just by inserting probes on
>   malloc and free library routines.

for that you do need to do that from the start of an application, at
which point perfectly good tooling exists already; leak tracking without
full state is, well, not something that'll work too well I suspect.
Also I don't see really why this needs kernel help :)




> - Low overhead and user can have thousands of active probes on the
>   system and detect any instance when the probe was hit including
>   probes on shared library etc.

I suspect this is the only reason for doing it inside the kernel;
anything else still really shouts "do it in userspace via ptrace" to me.


> ===========================================================
> LOCAL PROBES(PER PROCESS) VS GLOBAL PROBES(EXECUTABLE FILE)
> ===========================================================
> 
> - All processes take a trap since the same executable file
>   gets mapped into different address_space.

is that true for breakpoints inserted after start?
The reason I ask because... what if half the processed took a COW on the
page with the instruction you want to trap on. Are you going to edit all
those COW'd pages?


Also you no longer have the option to only do it on a selected subset of
processes (eg the workload vs the system)

> - Compare this with ptrace breakpoints (hence strace and gdb) where
>   tracepoints and breakpoints are localized to a specified set of
>   processes.  To support local probes the text pages are privatized
>   for that process. Global user-probes does not have the side effects
>   (privatization of pages) that ptrace has.

No instead it gets to "deal" with that already having happened ;)


Overall I see only one possible reason to do this in the kernel:
performance. Anything else really suggests that a userspace approach is
more than reasonable to me. (It might not be always be super easy, but
on the other hand you gain a lot back by doing that, for example you
have a lot better backtrace and debuginformation there so that you can
do far more advanced probes like "probe only if the caller is ..." etc)


