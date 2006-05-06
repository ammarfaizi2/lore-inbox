Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWEFQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWEFQnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWEFQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:43:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750916AbWEFQnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:43:46 -0400
Date: Sat, 6 May 2006 09:42:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <lkml@halcrow.us>, Linus Torvalds <torvalds@osdl.org>
Cc: penberg@cs.helsinki.fi, shaggy@austin.ibm.com, dhowells@redhat.com,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
Message-Id: <20060506094228.25fcda1b.akpm@osdl.org>
In-Reply-To: <20060506160044.GA8209@halcrow.us>
References: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>
	<20060504031755.GA28257@hellewell.homeip.net>
	<20060504034127.GI28613@hellewell.homeip.net>
	<23514.1146779003@warthog.cambridge.redhat.com>
	<1146842548.10109.27.camel@kleikamp.austin.ibm.com>
	<1146843528.11271.1.camel@localhost>
	<20060505192148.e2c968b7.akpm@osdl.org>
	<20060506160044.GA8209@halcrow.us>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 May 2006 11:00:44 -0500
Michael Halcrow <lkml@halcrow.us> wrote:

> On Fri, May 05, 2006 at 07:21:48PM -0700, Andrew Morton wrote:
> > > On Fri, 2006-05-05 at 10:22 -0500, Dave Kleikamp wrote:
> > > > I understand this comes from the FiST package.  In that code,
> > > > there is a comment in one of these functions explaining the
> > > > second read.  It would be nice to have that comment in here too:
> > > > 
> > > >    /*
> > > >     * call readpage() again if we returned from wait_on_page with a
> > > >     * page that's not up-to-date; that can happen when a partial
> > > >     * page has a few buffers which are ok, but not the whole
> > > >     * page.
> > > >     */
> ...
> > And why doesn't it cause do_generic_mapping_read() and
> > page_cache_read() to fail?
> > 
> > This is all raher fishy.
> 
> I asked Erez about this; I will try to accurately summarize his
> response. He indicated that, about 5 or so years ago, when ext2/3's
> block size was set to 1K or 2K, but the page size was 4K, they found
> that it was possible to get a page which had some of the blocks in the
> bufcache, while other blocks were not.

hm, OK, I'm not sure that Linux buffered file contents in that manner in
that timeframe.  Maybe it did, before my time..

> Their solution at the time was to just read again, and that seemed to
> fix the problem for them. It was not obvious as to why things were
> happening that way, and it may be the case that the second read is no
> longer necessary in the current kernel.
> 

Yeah, it shouldn't be needed now.  It'd be a howler of a bug if it is
needed.

Note that the pagefault handlers do still do a second readpage().  The
comment implies that this is an open-coded attempt to recover from an I/O
error.  I do recall that a year or so ago we discussed taking out that
second readpage attempt, but Linus had good-sounding reasons for keeping
it.  But I forget what they were.  Perhaps he can remind me?

