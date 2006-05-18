Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWERK5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWERK5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 06:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWERK5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 06:57:46 -0400
Received: from [213.46.243.16] ([213.46.243.16]:40318 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751281AbWERK5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 06:57:45 -0400
Subject: Re: [PATCH] memory mapped files not updating timestamps
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: Peter Staubach <staubach@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605171954010.16979@blonde.wat.veritas.com>
References: <446B3E5D.1030301@redhat.com>
	 <Pine.LNX.4.64.0605171954010.16979@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 18 May 2006 12:52:22 +0200
Message-Id: <1147949542.21805.4.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 20:24 +0100, Hugh Dickins wrote:
> On Wed, 17 May 2006, Peter Staubach wrote:

> > The changes add support to detect when the modification time needs to be
> > updated by placing a hook in __set_pages_dirty_buffers and
> > __set_pages_dirty_nobuffers.  One of these two routines will be invoked
> > when the dirty bit is detected in the pte.  The hook sets a new bit in the
> > address_space mapping struct indicating that the file which is associated
> > with that part of the address space needs to have its modification and
> > change time attributes updated.
> 
> You're adding a little overhead to every set_page_dirty, when the vast
> majority (ordinary writes) don't need it: their mctime update is already
> well taken care of.  (Or should we be deleting the code that does that?
> I think I'd rather not dare.)

It would make the code more symetric.

> I think you'd do better to target those places where set_page_dirty is
> called on a mapped page - and do the file_update_time at that point -
> or as near to that point as is sensible/permitted given the locking
> (vma->vm_file gives you the file without needing inode_update_time).

> Peter Zijlstra has patches relating to dirty mmaps in the -mm tree
> at present: I need to take a look at those, and I'll see if it would
> make sense to factor in this mctime issue on top of those - you may
> want to do the same.

Look for the callsites of set_page_dirty_balance(), those two points are
where writable file pages are dirtied.

PeterZ

