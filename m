Return-Path: <linux-kernel-owner+w=401wt.eu-S932352AbXALSHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbXALSHi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbXALSHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 13:07:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49629 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbXALSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 13:07:38 -0500
Date: Fri, 12 Jan 2007 10:06:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: dean gaudet <dean@arctic.org>
cc: Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, dean gaudet wrote:
> 
> it seems to me that if splice and fadvise and related things are 
> sufficient for userland to take care of things "properly" then O_DIRECT 
> could be changed into splice/fadvise calls either by a library or in the 
> kernel directly...

The problem is two-fold:

 - the fact that databases use O_DIRECT and all the commercial people are 
   perfectly happy to use a totally idiotic interface (and they don't care 
   about the problems) means that things like fadvice() don't actually 
   get the TLC. For example, the USEONCE thing isn't actually 
   _implemented_, even though from a design standpoint, it would in many
   ways be preferable over O_DIRECT.

   It's not just fadvise. It's a general problem for any new interfaces 
   where the old interfaces "just work" - never mind if they are nasty. 
   And O_DIRECT isn't actually all that nasty for users (although the 
   alignment restrictions are obviously irritating, but they are mostly 
   fundamental _hardware_ alignment restrictions, so..). It's only nasty 
   from a kernel internal security/serialization standpoint.

   So in many ways, apps don't want to change, because they don't really 
   see the problems.

   (And, as seen in this thread: uses like NFS don't see the problems 
   either, because there the serialization is done entirely somewhere 
   *else*, so the NFS people don't even understand why the whole interface 
   sucks in the first place)

 - a lot of the reasons for problems for O_DIRECT is the semantics. If we 
   could easily implement the O_DIRECT semantics using something else, we 
   would. But it's semantically not allowed to steal the user page, and it 
   has to wait for it to be all done with, because those are the semantics 
   of "write()".

   So one of the advantages of vmsplice() and friends is literally that it 
   could allow page stealing, and allow the semantics where any changes to 
   the page (in user space) might make it to disk _after_ vmsplice() has 
   actually already returned, because we literally re-use the page (ie 
   it's fundamentally an async interface).

But again, fadvise and vmsplice etc aren't even getting the attention, 
because right now they are only used by small programs (and generally not 
done by people who also work on the kernel, and can see that it really 
would be better to use more natural interfaces).

> looking at the splice(2) api it seems like it'll be difficult to implement 
> O_DIRECT pread/pwrite from userland using splice... so there'd need to be 
> some help there.

You'd use vmsplice() to put the write buffers into kernel space (user 
space sees it's a pipe file descriptor, but you should just ignore that: 
it's really just a kernel buffer). And then splice the resulting kernel 
buffers to the destination.

		Linus
