Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWJDTRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWJDTRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWJDTRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:17:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750855AbWJDTRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:17:17 -0400
Date: Wed, 4 Oct 2006 12:16:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061004121645.fd2765e4.akpm@osdl.org>
In-Reply-To: <45240034.2040704@oracle.com>
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org>
	<4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org>
	<45240034.2040704@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 11:40:52 -0700
Zach Brown <zach.brown@oracle.com> wrote:

> 
> > We have lots of nice new tools in-kernel which permit applications to
> > manipulate and to invalidate pagecache.  Please, start using them rather
> > than pushing bits of oracle into the core vfs ;)
> 
> And apps that were written before they were available? :)  We're OK with
> their behaviour changing under newer kernels because they now have a
> previous source of memory pressure that they didn't have before?
> 
> It seems a bit much to suggest that retaining the previous behaviour of
> avoiding memory pressure by using the O_DIRECT API is somehow "pushing
> bits of oracle into the core vfs" :).
> 
> Maybe that aspect of the API was unintentional, though.  That would be a
> shame.  I suspect Oracle isn't alone in relying on it.

Why do so many patches degenerate into these little question-and-answer
sessions?  It's like pulling teeth.  Please completely describe the
problem.

What "newer kernels"?  The kernel has had the fall-back-to-buffered
behaviour for *ages*.

What's so bad about having a bit of pagecache floating about during what
is, I expect, a fairly rare operation?

What are the user-visible effects of this pagecache?

Please don't just sling a patch at us and leave us to guess what it's for.

> > Please, no truncate_inode_pages.  For this application, the far-safer
> > invalidate_inode_pages() would suffice.
> 
> So now apps always have to pay the cost of looking up pages to
> invalidate on the off chance that they wrote to a sparse region, based
> on the current implementation detail that sparse regions fall back to
> buffered?

"current"?  It was current about two years ago!


What I've thus far been able to decrypt from this exchange has been that
you think that the Linux direct-IO API should, as a side-effect, guarantee
that a direct-io write (and read?) of a file area should not leave that
part of the file in pagecache.

Well we _could_ define the API in that fashion.  It'd need to be carefully
documented somewhere.  But it's a fairly bizarre requirement, especially as
userspace already has quite rich ways of manipulating pagecache.

To do this right without modifying userspace we're going to need to sync
these pages to disk within the write() syscall and then invalidate them. 
That might screw somebody else up, but I think it could be justified on the
grounds that direct-io is a synchronous operation, so we should still be
synchronous if we went the buffered route.

