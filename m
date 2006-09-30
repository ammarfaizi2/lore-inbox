Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWI3WCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWI3WCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWI3WCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:02:52 -0400
Received: from ns.suse.de ([195.135.220.2]:20381 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751399AbWI3WCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:02:51 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sun, 1 Oct 2006 00:02:46 +0200
User-Agent: KMail/1.9.3
Cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200609302230.24070.ak@suse.de> <Pine.LNX.4.64.0609301449130.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301449130.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010002.46634.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 September 2006 23:56, Linus Torvalds wrote:
> 
> On Sat, 30 Sep 2006, Andi Kleen wrote:
> > 
> > Anyways, I guess we need even more validation in the fallback code,
> > but just terminating the kernel thread stacks should fix that particular case.
> 
> Why not just add the simple validation?
> 
> A kernel stack is one page in size. If you move to another page, you 
> terminate. It's that simple.

No, it's not. On x86-64 it can be three or more stacks nested in
complicated ways (process stack, interrupt stack, exception stack)
The exception stack can happen multiple times.
 
> What if the kernel stack is corrupt? Buffer overruns do that.
> 
> This patch seems to just paper over the _real_ problem, namely the fact 
> that the stack tracer code doesn't actually validate any of its arguments.

It has pretty good sanity checking by first using __get_user for the stack
data, and the regularly double checking the EIPs by looking them up
in CFI. If it can't find them it will abort.

> The old unwinder (well, at least for x86, and I assume x86-64 used that as 
> the beginning point) didn't have this problem at all, exactly because it 
> couldn't get on the wrong stack-page in the first place.

In this particular case what happened is that the dwarf2 unwinder
ended and then the fallback was in the wrong page and couldn't handle 
it.
 
> The old code literally had:
> 
> 	static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
> 	{
> 	        return  p > (void *)tinfo &&
> 	                p < (void *)tinfo + THREAD_SIZE - 3;
> 	}
> 
> and would refuse to touch anything that wasn't in the stack page. It was 
> simple, AND WE NEVER _EVER_ HAD A BUG RELATED TO IT, AFAIK.

That was before interrupt stacks were introduced. With that it is significantly
more complicated. On x86-64 even more because there are exception stacks.

-Andi
