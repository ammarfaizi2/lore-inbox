Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVC3T4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVC3T4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVC3T4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:56:32 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25278 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262432AbVC3TyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:54:21 -0500
Subject: Re: RFC: Bug in generic_forget_inode() ?
From: Russ Weight <rweight@us.ibm.com>
Reply-To: rweight@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050318161126.7e72e8f3.akpm@osdl.org>
References: <1111183051.7102.33.camel@russw.beaverton.ibm.com>
	 <20050318141716.494ab02a.akpm@osdl.org>
	 <1111190260.7102.78.camel@russw.beaverton.ibm.com>
	 <20050318161126.7e72e8f3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Mar 2005 11:54:13 -0800
Message-Id: <1112212454.25362.61.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 16:11 -0800, Andrew Morton wrote:
> Russ Weight <rweight@us.ibm.com> wrote:
> >
> > On Fri, 2005-03-18 at 14:17 -0800, Andrew Morton wrote:
> > > Russ Weight <rweight@us.ibm.com> wrote:
> > > >
> > > > generic_forget_inode() is eventually called (within the context of
> > > >  iput), the inode is placed on the unused list, and the inode_lock is
> > > >  dropped.
> > > > 
> > > >  kswapd calls prune_icache(), locks the inode_lock, and pulls the same
> > > >  inode off of the unused list. Upon completion, prune_icache() calls
> > > >  dispose_list() for the inodes that it has collected.
> > > > 
> > > >  generic_forget_inode() calls write_inode_now(), which calls
> > > >  __writeback_single_inode() which calls __sync_single_inode().
> > > >  __sync_single_inode() panics when attempting to move the inode onto the
> > > >  unused list (the last call to list_move). This is due to the poison
> > > >  values that were previously loaded into the next and prev list pointers
> > > >  by list_del().
> > > 
> > > It's not clear what the actual bug is here.  When you say that
> > > __sync_single_inode() panics over the list pointers, who was it that
> > > poisoned them?  dispose_list()?
> > > 
> > > Certainly isofs_fill_super() could trivially be rewritten to not do the
> > > iget()/iput() but we should be sure that that's really the bug.  The inode
> > > lifetime management is rather messy, I'm afraid.
> > 
> > The pointers are poisoned by dispose_list(). The race condition is
> > between prune_icache() and generic_forget_inode().
> > 
> > When I suggested that a change to isofs_fill_super() might be
> > considered, I was speculating that isofs_fill_super() might be creating
> > an unexpected state by doing something unconventional in its usage of
> > iget() and iput(). This is something I had not investigated.
> > 
> > The problem is more likely in generic_forget_inode(). It releases the
> > inode_lock and then locks it again without doing anything to prevent the
> > inode from being stolen, and without checking to see if it has been
> > stolen. Likewise, write_inode_now() does not do any checks to see if the
> > inode has been stolen.
> > 
> 
> I dunno.  This is really fiddly code and does like to blow up in your face.
> I doubt if the problem is in such a well-trodden path as
> generic_forget_inode().
> 
> Perhaps isofs is breaking the rules by running iget() prior to setting
> MS_ACTIVE.  (What rules, you ask?  hah.)
> 

isofs is, in fact, running iget() prior to setting MS_ACTIVE. I have
tested a fix for this and I will post a patch shortly.
