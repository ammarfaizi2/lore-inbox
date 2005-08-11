Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVHKJnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVHKJnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 05:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVHKJnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 05:43:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932304AbVHKJm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 05:42:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1123716236.8082.12.camel@lade.trondhjem.org> 
References: <1123716236.8082.12.camel@lade.trondhjem.org>  <42F57FCA.9040805@yahoo.com.au> <200508110823.53593.phillips@arcor.de> <1123713258.10292.109.camel@lade.trondhjem.org> <200508110857.06539.phillips@arcor.de> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>, David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 11 Aug 2005 10:42:27 +0100
Message-ID: <26928.1123753347@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > http://marc.theaimsgroup.com/?l=linux-kernel&m=112368417412580&w=2
> 
> Oh. You are talking about CacheFS? That hasn't been declared "ready to
> merge" yet.

I can probably put out FS-Cache now, and the patches for kAFS and NFS to use
it. CacheFS is taking a little longer than expected because I'm having to be
so careful about ENOMEM handling.

> That said, is it really safe to use any flags other than
> PG_lock/PG_writeback there, David?

If I use PG_locked, that hurts performance horribly as readpage() can't then
unlock the page until the page has been read from the network _and_ has been
written to the cache, two operations which _must_ of necessity be sequential.

I can't use PG_writeback to cover the write to the cache as that has indicates
write completion to the network. Writes to the cache and the network may run
in parallel, and so you need two flags to keep track of the completion state
of both.

> I can't see that you want to allow other tasks to modify or free the page
> while you are writing it to the local cache.

I don't. Hence the use of a combination of the PG_fs_misc bit and the
page_mkwrite() VMA op.

The page release address space op also waits for the PG_fs_misc bit.

David
