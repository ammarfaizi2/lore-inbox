Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWFGSI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWFGSI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWFGSI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:08:59 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:38141 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751192AbWFGSI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:08:59 -0400
Subject: Re: [PATCH 0/3] mm: tracking dirty pages -v5
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
References: <20060525135534.20941.91650.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 20:08:50 +0200
Message-Id: <1149703730.4408.45.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 21:06 +0100, Hugh Dickins wrote:

> You tend to use get_page/put_page amidst code using page_cache_get/
> page_cache_release.  Carry on: it sometimes looks odd, but I can't see
> any way to impose consistency, short of abolishing one or the other
> throughout the tree.  So don't worry about it.

Noticed that myself too, came to the same conclusion, thanks for the
confirmation thought.

> You've got a minor cleanup to install_page, left over from an earlier
> iteration: the cleanup looked okay, but of no relevance to your patchset
> now, is it?  Just cut mm/fremap.c out of the patchset I think.

OK, unless we go back to the previous way I'll send this tiny cleanup as
a separate patch to Andrew.

> You've taken the simplification of sys_msync a little too far, I believe:
> you ought to try to reproduce the same errors as before, so MS_ASYNC
> should be winding through the separate vmas like MS_SYNC, just to
> report -ENOMEM if it crosses an unmapped area; and MS_INVALIDATE
> used to say -EBUSY if VM_LOCKED, but that has disappeared.  (Perhaps
> I've missed other such details, please recheck.)

Ah, yes, I've noticed this too, I just wasn't sure on if this would be
wanted or not. Is fixed, thanks!

> Your comment should
> say "Nor does it mark" instead of "Nor does it just marks".

Hehe, thanks, please do point out my mistakes with the English language.
I have good enough control to convey most of what I intent but I'm not a
native.

> Your is_shared_writable(vma) in mprotect_fixup is along the right
> lines, but wrong: because at that point vma->vm_flags is the old one,
> and may be omitting VM_WRITE when that is about to be added.  Perhaps
> you should move the "vma->vm_flags = newflags" above it, or perhaps
> you should change is_shared_writable to work on flags rather than vma
> (as Linus' is_cow_mapping does).

How odd, I have the distinct recollection of actually moving that
assignment upwards a few lines, must have been late or something. Thanks
for pointing this out, would've never found it again; with me thinking
it was done with.

<snip: big tiresome story/>

Well, you got me. I don't know either, the only thing I can come up with
is making the breakage compile-time (for 3rd-party modules) instead of
subtle run-time, but its still not pretty.

/me looks around at assorted VM gurus; any ideas out there?

If by tomorrow morning CET nobody has spoken up, I'll just go ahead and
accept Hugh's apology :-), that is revert back to my original way of
doing it. (I can always go back to this scheme if some smart but slower
working brain manages a solution)


Peter

