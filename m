Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVJUVEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVJUVEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJUVEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:04:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751054AbVJUVEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:04:20 -0400
Date: Fri, 21 Oct 2005 13:59:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, adilger@clusterfs.com
Subject: Re: [RFC] page lock ordering and OCFS2
Message-Id: <20051021135931.6065bbd1.akpm@osdl.org>
In-Reply-To: <43595131.3030709@oracle.com>
References: <20051017222051.GA26414@tetsuo.zabbo.net>
	<20051017161744.7df90a67.akpm@osdl.org>
	<43544499.5010601@oracle.com>
	<435928BC.5000509@oracle.com>
	<20051021175730.GD22372@infradead.org>
	<43595131.3030709@oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> Christoph Hellwig wrote:
> > On Fri, Oct 21, 2005 at 10:43:24AM -0700, Zach Brown wrote:
> >
> >>It introduces block_read_full_page() and truncate_inode_pages() derivatives
> >>which understand the PG_fs_misc special case.  It needs a few export patches to
> >>the core, but the real burden is on OCFS2 to keep these derivatives up to date.
> >
> > The way you do it looks nice, but the exports aren't a big no-way.  That
> > stuff is far too internal to be exported.  Either we can get Andrew to
> > agree on moving those bits into the codepath for all filesystems or
> > we need to do some hackery where every functions gets renamed to __function
> > with an argument int cluster_aware and we have to functions inling them,
> > one normal and one for cluster filesystems.
> 
> Yeah, I can certainly appreciate that line of reasoning.  I'm happy to do that
> work, but it'd be nice to get some assurance that it won't be wasted effort.
> Andrew, is this a reasonable direction to take things in?  We'd avoid the
> exports by introducing some wrappers and helpers to the core that OCFS2 would
> call..

It depends on what the patch ends up looking like I guess.

All those games with PG_fs_misc look awfully similar to lock_page() - I'd
have thought there's some room for rationalising code in there.

The overall approach would be to avoid adding overhead and complexity for
other filesystems and to only export symbols which constitute a sensible
API: avoid exporting weirdo internal helpers which we might change in the
future (but we don't care about external modules, so why does this matter? 
Because some of them are GPL?)

