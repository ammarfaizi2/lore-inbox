Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVJYOzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVJYOzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJYOzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:55:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4584 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932109AbVJYOzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:55:47 -0400
Date: Tue, 25 Oct 2005 10:55:40 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
In-reply-to: <Pine.LNX.4.61.0510250700360.5884@goblin.wat.veritas.com>
X-X-Sender: nico@localhost.localdomain
To: Hugh Dickins <hugh@veritas.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0510251034230.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
 <20051022170240.GA10631@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
 <Pine.LNX.4.61.0510250700360.5884@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2005, Hugh Dickins wrote:

> On Mon, 24 Oct 2005, Nicolas Pitre wrote:
> > However I'd like for the 
> > WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user 
> > buffers should be 64-bit aligned.
> 
> Okay, thanks.  I can submit a patch to restore the WARN_ON later
> (not today).  Though that seems very odd to me, can you explain?  I can
> understand that the original kernel context needs to be 64-bit aligned,
> and perhaps the iwmmxt_task_copy copy of it (I explicitly align that
> buffer).  But I can't see why the saved copy in userspace would need
> to be 64-bit aligned, if it's just __copy_to_user'ed and __copy_from_
> user'ed.  Or is it also accessed in some other, direct way?

If the user signal handler decides to do something with it then it 
probably expects it to be 64-bit aligned as well per current ABI since 
those are 64 bit registers.

> > > Now that I look at it, it's probably buggy - if the page isn't already
> > > dirty, it will modify without the COW action.  Again, please contact
> > > Nicolas about this.
> > 
> > I don't see how standard COW could not happen.  The only difference with 
> > a true write fault as if we used put_user() is that we bypassed the data 
> > abort vector and the code to get the FAR value.  Or am I missing 
> > something?
> 
> It's certainly not buggy in the way that I thought (and I believe rmk
> was thinking): you are checking pte_write, correctly within the lock,
> so COW shouldn't come into it at all - it'll only work if the page is
> already writable by the user.
> 
> But then I'm puzzled by your reply, saying you don't see how standard
> COW could not happen.

NO.  What I'm saying is that if ever the page is _not_ writable (be it 
absent or read-only) then do_DataAbort() is called just like if we had a 
real access fault as if we actually wrote to the page.  What happens at 
that point is therefore exactly the same as a real fault (either COW, 
paging from swap, process killed, or whatever).

> Plus it seems a serious limitation: mightn't this be an area of executable
> text that it has to write into, but is most likely readonly?  Or an area
> of data made readonly by fork?  And is the alignment assured, that the
> long will fit in one page only?

Atomic operations are expected to be performed on an aligned word.  This 
code is only one way (and actually there might be only one person on the 
planet actually needing it at the moment) but all the other much common 
and faster ways would either succeed due to the alignment trap or fail 
due to the alignment trap (the alignment trap doesn't fix up misaligned 
accesses from ldrex/strex on ARMv6).  So in practice only RMK might be 
exercising that code.  If it becomes necessary for more configs then we 
could simply SIGBUS on a misaligned pointer.

> The better way to do it, I think, would be to use ptrace's
> access_process_vm (it is our own mm, but that's okay).

This is IMHO way too much overkill for an operation that should be only 
a few assembly instructions in user space normally.  This really should 
remain as light weight as possible (and used only when there is 
absolutely no other ways).


Nicolas
