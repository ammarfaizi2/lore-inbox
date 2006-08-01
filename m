Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161348AbWHAHkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161348AbWHAHkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWHAHkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:40:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161348AbWHAHkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:40:06 -0400
Date: Tue, 1 Aug 2006 00:39:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: ufs_get_locked_patch race fix
Message-Id: <20060801003958.c628455f.akpm@osdl.org>
In-Reply-To: <20060801073043.GA17186@rain>
References: <20060731125702.GA5094@rain>
	<20060731230251.3b149902.akpm@osdl.org>
	<20060801073043.GA17186@rain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 11:30:43 +0400
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> On Mon, Jul 31, 2006 at 11:02:51PM -0700, Andrew Morton wrote:
> > On Mon, 31 Jul 2006 16:57:02 +0400
> > Evgeniy Dushistov <dushistov@mail.ru> wrote:
> > 
> > Looks good to me.
> > 
> > Is there any need to be checking ->index?  Normally we simply use the
> > sequence:
> > 
> > 	lock_page(page);
> > 	if (page->mapping == NULL)
> > 		/* truncate got there first */
> > 
> > to handle this case.
> 
> Yes, I made it in analogy with `find_lock_page' and missed fact
> that if we increment usage counter of page, we have no need to check
> page->index.

OK.  find_lock_page() has the splice stuff in it.

> Need another patch?

Is OK, I updated it.

I'm not sure that the `goto repeat' is needed if truncate got there first,
really - if truncate took the page down then it's now outside i_size and
shouldn't be coming back.

If the page _can_ come back then this code is all rather problematic. 
Because this means that the page can come back (via an extending write())
one nanosecond after ufs_get_locked_page() returns NULL.  Won't the callers
of ufs_get_locked_page() get confused by that?

