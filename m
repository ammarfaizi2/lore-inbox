Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVCRX5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVCRX5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVCRX5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:57:49 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21914 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262118AbVCRX5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:57:43 -0500
Subject: Re: RFC: Bug in generic_forget_inode() ?
From: Russ Weight <rweight@us.ibm.com>
Reply-To: rweight@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: dev@sw.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20050318141716.494ab02a.akpm@osdl.org>
References: <1111183051.7102.33.camel@russw.beaverton.ibm.com>
	 <20050318141716.494ab02a.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Mar 2005 15:57:40 -0800
Message-Id: <1111190260.7102.78.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 14:17 -0800, Andrew Morton wrote:
> Russ Weight <rweight@us.ibm.com> wrote:
> >
> > generic_forget_inode() is eventually called (within the context of
> >  iput), the inode is placed on the unused list, and the inode_lock is
> >  dropped.
> > 
> >  kswapd calls prune_icache(), locks the inode_lock, and pulls the same
> >  inode off of the unused list. Upon completion, prune_icache() calls
> >  dispose_list() for the inodes that it has collected.
> > 
> >  generic_forget_inode() calls write_inode_now(), which calls
> >  __writeback_single_inode() which calls __sync_single_inode().
> >  __sync_single_inode() panics when attempting to move the inode onto the
> >  unused list (the last call to list_move). This is due to the poison
> >  values that were previously loaded into the next and prev list pointers
> >  by list_del().
> 
> It's not clear what the actual bug is here.  When you say that
> __sync_single_inode() panics over the list pointers, who was it that
> poisoned them?  dispose_list()?
> 
> Certainly isofs_fill_super() could trivially be rewritten to not do the
> iget()/iput() but we should be sure that that's really the bug.  The inode
> lifetime management is rather messy, I'm afraid.

The pointers are poisoned by dispose_list(). The race condition is
between prune_icache() and generic_forget_inode().

When I suggested that a change to isofs_fill_super() might be
considered, I was speculating that isofs_fill_super() might be creating
an unexpected state by doing something unconventional in its usage of
iget() and iput(). This is something I had not investigated.

The problem is more likely in generic_forget_inode(). It releases the
inode_lock and then locks it again without doing anything to prevent the
inode from being stolen, and without checking to see if it has been
stolen. Likewise, write_inode_now() does not do any checks to see if the
inode has been stolen.

- Russ 
