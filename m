Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUANWd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUANWcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:32:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:60289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263510AbUANWbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:31:07 -0500
Date: Wed, 14 Jan 2004 14:32:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /dev/anon
Message-Id: <20040114143221.25dd7c7e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0401140749100.1829-100000@bigblue.dev.mdolabs.com>
References: <20040114144131.GA6407@ccure.user-mode-linux.org>
	<Pine.LNX.4.44.0401140749100.1829-100000@bigblue.dev.mdolabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
>
> On Wed, 14 Jan 2004, Jeff Dike wrote:
> 
> > > I thought your goal was to release memory 
> > > to the host, that's why I proposed sys_madvise(MADV_DONTNEED).
> > 
> > It is, I want memory released immediately as though it were clean, and
> > MADV_DONTNEED doesn't help.
> 
> Strange, I didn't notice this before. If you look at the comment in 
> mm/madvise.c:madvise_dontneed, it advertises that dirty pages are actually 
> thrown away (that would be what you're actually looking for). But if you 
> go down to zap_page_range -> unmap_vmas -> unmap_page_range -> 
> zap_pmd_range -> zap_pte_range, if the page is dirty, set_page_dirty -> 
> __set_page_dirty_buffers pushes the page into the mapping dirty pages list 
> and __mark_inode_dirty push the inode inside the superblock dirty list. So 
> the comment seems to be wrong (I also verified this with a simple program, 
> and pages are actually flushed).
> 

We cannot invalidate the pages due to MADV_DONTNEED: there may be
freshly-allocated, unwritten file blocks associated with them.  You'd have
to be playing games with write() amd MAP_SHARED to do this.

