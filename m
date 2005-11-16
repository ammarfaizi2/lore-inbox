Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVKPHqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVKPHqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVKPHqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:46:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030204AbVKPHqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:46:05 -0500
Date: Tue, 15 Nov 2005 23:45:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051115234542.45a7aa66.akpm@osdl.org>
In-Reply-To: <20051115234731.9539.qmail@web34105.mail.mud.yahoo.com>
References: <20051115224645.27832.qmail@web34103.mail.mud.yahoo.com>
	<20051115234731.9539.qmail@web34105.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson <theonetruekenny@yahoo.com> wrote:
>
> I ran the same test again against 2.6.15-rc, and got pretty much the same thing.  It starts nice
> and fast (30+MB/s, but drops down to under 10MB/s with the system time pegging one CPU).
> 
> Here is the oprofile result:
> 
> CPU: P4 / Xeon with 2 hyper-threads, speed 2658.47 MHz (estimated)
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask
> of 0x01 (mandatory) count 100000
> samples  %        symbol name
> 412585   14.6687  find_get_pages_tag
> 343898   12.2267  mpage_writepages
> 290144   10.3155  release_pages
> 288631   10.2617  unlock_page
> 286181   10.1746  pci_conf1_write
> 267619    9.5147  clear_page_dirty_for_io
> 128128    4.5554  __lookup_tag
> 120895    4.2982  page_waitqueue
> 52739     1.8750  _spin_lock_irqsave
> 43623     1.5509  skb_copy_bits
> 30157     1.0722  __wake_up_bit
> 29973     1.0656  _read_lock_irqsave
> 

Your application walks the file in 2MB hunks, doing ftruncate() each time
to expand the file by another 2MB.

nfs_setattr() implements the truncate.  It syncs the whole file, using
filemap_write_and_wait() (that seems a bit suboptimal.  All we're doing is
increasing i_size??)

So filemap_write_and_wait() has to write 2MB's worth of pages.  Problem is,
_all_ the pages, even the 99% which are clean are tagged as dirty in the
pagecache radix tree.  So find_get_pages_tag() ends up visiting each page
in the file, and blows much CPU doing so.

The writeout happens in mpage_writepages(), which uses
clear_page_dirty_for_io() to clear PG_dirty.  But it doesn't clear the
dirty tag in the radix tree.  It relies upon the filesystem to do the right
thing later on.  Which is all very unpleasant, sorry.  See the explanatory
comment over clear_page_dirty_for_io().

nfs_writepage() doesn't do any of the things which that comment says it
should, hence the radix tree tags are getting out of sync, hence this
problem.

NFS does strange, incomprehensible-to-little-akpms things in its writeout
path.  Ideally, it should run set_page_writeback() prior to unlocking the
page and end_page_writeback() when I/O completes.  That'll keep the VM
happier while fixing this performance glitch.
