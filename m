Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVHBPVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVHBPVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVHBPVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:21:37 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:52199 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261423AbVHBPTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:19:47 -0400
In-Reply-To: <Pine.LNX.4.61.0508021309470.3005@goblin.wat.veritas.com>
Sensitivity: 
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF3A43595E.FFEC3FB7-ON42257051.00470347-42257051.00543518@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 2 Aug 2005 17:19:46 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 02/08/2005 17:19:45
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote on 08/02/2005 02:26:09 PM:

> On Tue, 2 Aug 2005, Martin Schwidefsky wrote:
> >
> > Why do we require the !pte_dirty(pte) check? I don't get it. If a
writeable
> > clean pte is just fine then why do we check the dirty bit at all?
Doesn't
> > pte_dirty() imply pte_write()?
>
> Not quite.  This is all about the peculiar ptrace case, which sets
"force"
> to get_user_pages, and ends up handled by the little maybe_mkwrite
function:
> we sometimes allow ptrace to modify the page while the user does not have
> have write access to it via the pte.

I slowly begin to understand. You want to do a copy on write of the page you
want to change with ptrace but without making the pte a writable pte. To
indicate the fact the page has been cowed the pte dirty bit is misused.

> Robin discovered a race which proves it's unsafe for get_user_pages to
> reset its lookup_write flag (another stage in this peculiar path) after
> a single try, Nick proposed a patch which adds another VM_ return code
> which each arch would need to handle, Linus looked for something simpler
> and hit upon checking pte_dirty rather than pte_write (and removing
> the then unnecessary lookup_write flag).

Yes, I've seen it on lkml.

> Linus' changes are in the 2.6.13-rc5 mm/memory.c,
> but that leaves s390 broken at present.

That is currently my problem which I'm trying to solve. With Nicks latest
patch, we are more or less back to the previous situation in regard to the
checks in __follow_page as far as s390 is concerned. pte_write() is 0 for
write access via access_process_vm on a read-only vma. pte_dirty() is
always 0 but since get_user_pages doesn't fall back on lookup_write = 0
anymore we have an endless loop again. Four letter words ..

> > With the additional !pte_write(pte) check (and if I haven't overlooked
> > something which is not unlikely) s390 should work fine even without the
> > software-dirty bit hack.
>
> I agree the pte_write check ought to go back in next to the pte_dirty
> check, and that will leave s390 handling most uses of get_user_pages
> correctly, but still failing to handle the peculiar case of strace
> modifying a page to which the user does not currently have write access
> (e.g. setting a breakpoint in readonly text).

The straight forward fix is to introduce a software dirty bit that can
get misused for this special case. Not that I like it but its seems the
simplest solution.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

