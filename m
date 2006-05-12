Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWELQXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWELQXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWELQXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:23:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751298AbWELQXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:23:36 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060512071100.5c5d52e9.akpm@osdl.org> 
References: <20060512071100.5c5d52e9.akpm@osdl.org>  <20060511104038.4ecad038.akpm@osdl.org> <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com> <20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com> <11334.1147437245@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] FS-Cache: Release page->private in failed readahead [try #8] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 12 May 2006 17:23:18 +0100
Message-ID: <1976.1147450998@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > 		SetPageLocked(page);
> 
> 	if (TestSetPagLocked(page))
> 		BUG();
> 
> would make me more comfortable..

That shouldn't be necessary if add_to_page_cache() also doesn't do that, but
if you wish, I can do that - it's the error handling path, so it doesn't
matter too much performancewise.

> > > For the second hunk, is it not possible to do this cleanup in the callback
> > > function?
> > 
> > Which callback function?
> 
> I was referring to the filler_t thingy.  Is it not possible to get control
> of that?

Well, the filler_t thing is generally a_ops->readpage from the caller fs, but
we don't want to call that if add_to_page_cache() failed, and we don't want to
call it if we're just discarding a bunch of pages we've now no intention of
actually reading.

I suppose we could add another callback for ditching pages we don't want to
keep.  This has the potential to be called quite a lot because of the way
readahead works on Linux.

> So please, can we have some comments in there which describe the new
> behaviour in a manner sufficient for a maintainer to follow so people don't
> break your stuff?

Okay... I'll add more comments.  I should probably also extend the
documentation on releasepage().  It won't be till Monday though.

> > Out of interest, why do we need PG_private to say there's something in
> > page->private?  Can't it just be assumed either that if page->private is
> > non-zero or that if a_ops->releasepage() is non-NULL, then we need to
> > "release" the page?
> 
> page->private is an unsigned long, not a pointer.  The core kernel hence
> cannot determine from its value whether or not it is live.  For example, the
> fs might choose to treat it as a bitmap of which-blocks-are-uptodate and
> which-blocks-are-dirty.

Then the second option is still possible (calling releasepage()
unconditionally).

David
