Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbTEWTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTEWTa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:30:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25486 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264154AbTEWTa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:30:56 -0400
Date: Fri, 23 May 2003 11:42:02 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: hugh@veritas.com
Cc: phillips@arcor.de, akpm@digeo.com, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Message-ID: <20030523114202.C5383@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 06:47:31PM +0100, Hugh Dickins wrote:
> On Fri, 23 May 2003, Daniel Phillips wrote:
> > On Friday 23 May 2003 18:21, Hugh Dickins wrote:
> > > Sorry, I miss the point of this patch entirely.  At the moment it just
> > > looks like an unattractive rearrangement - the code churn akpm advised
> > > against - with no bearing on that vmtruncate race.  Please correct me.
> > 
> > This is all about supporting cross-host mmap (nice trick, huh?).  Yes, 
> > somebody should post a detailed rfc on that subject.
> 
> Ah, thanks - translated into terms that I can understand, so that
> some ->nopage() not yet in the tree could do something after the
> install_new_page() returns.  Hmm.  Can we be sure it's appropriate
> for install_new_page to drop mm->page_table_lock before it returns?

Exactly -- allows a ->nopage() to drop some lock to avoid races
between pagefault and either vmtruncate() or invalidate_mmap_range().
This race (from the cross-host mmap viewpoint) is described in:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=105286345316249&w=2

install_new_page() has to drop mm->page_table_lock() for the same
reason that the previous do_no_page() did.  In addition, dropping
the lock permits a ->nopage() to invoke things like zap_page_range()
which acquire mm->page_table_lock().

						Thanx, Paul
