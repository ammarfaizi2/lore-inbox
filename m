Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265376AbUFHWwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUFHWwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUFHWwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:52:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:52188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265377AbUFHWwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:52:35 -0400
Date: Tue, 8 Jun 2004 15:54:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: arjanv@redhat.com, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop page_state stack waste
Message-Id: <20040608155458.11b4d5df.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0406082331470.2556-100000@localhost.localdomain>
References: <20040608141106.3c7c3c10.akpm@osdl.org>
	<Pine.LNX.4.44.0406082331470.2556-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Tue, 8 Jun 2004, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > Replace get_page_state (which memset most of full page_state to 0) by
> > > get_main_page_state, which just sets the small structure needed.  This
> > > helps 4k stacks not to overflow: cuts 224 bytes off try_to_free_pages
> > > and wakeup_bdflush (and sync_inodes_sb) stack usages: wakeup_bdflush
> > > doesn't do much, but is called by try_to_free_pages and mempool_alloc.
> > 
> > Yeah, I was looking at that.  I simply did:
> > -} ____cacheline_aligned;
> > +};
> 
> Well, that is a smaller patch; but you're still wasting 124 bytes of
> stack in wakeup_bdflush below 124 bytes wasted in try_to_free_pages.
> 

yup, but that's better than 256+256, or 512+256 in -mm.

Your patch was kinda icky.  I think it would be better to remove those
page_state variables altogether and use something along the lines of

unsigned long __read_page_state(unsigned offset);
#define read_page_state(var) __read_page_state(offsetof(page_states, var))

I'll cook something up...
