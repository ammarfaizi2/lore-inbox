Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUDNXDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUDNXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:03:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:41148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbUDNXBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:01:14 -0400
Date: Wed, 14 Apr 2004 16:02:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: cmm@us.ibm.com, tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Message-Id: <20040414160222.4a227073.akpm@osdl.org>
In-Reply-To: <200404140911.57772.pbadari@us.ibm.com>
References: <200403190846.56955.pbadari@us.ibm.com>
	<1081903949.3548.6837.camel@localhost.localdomain>
	<20040413194734.3a08c80f.akpm@osdl.org>
	<200404140911.57772.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > - Why do we discard the file's reservation on every iput()?  iput's are
> >   relatively common operations. (see fs/fs-writeback.c)
> 
> We just followed old prealloc code. Where ever preallocation is dropped
> we dropped reservation.  May be thats overkill. We will look at it.
> 
> Whats the best place to drop the reservation ?

You know, I wish I had an easy answer to that, but I don't.  It's a matter
of sticking a printk in there, running careful tests, making sure that
we're doing the right thing at the right time.

As we discussed earlier, it could be that in some some situations we should
hold onto the reservation window after the file has been closed - the
slowly-growing mbox or logfile problem.  But without causing bandwidth
regressions in the the many-small-files scenario.

> > - Have you tested and profiled this with a huge number of open files?  At
> >   what stage do we get into search complexity problems?
> 
> In our TODO list. But our original thought was, we have to search only the
> current block group reservations to get a window. So, if we have lots & lots
> of reservations in a single block group - search gets complicated. We were
> thinking of adding (dummy) anchors in the list to represent begining of each
> block group, so that we can get to the start of a block group quickly. But
> so far, we haven't done anything.

hm, I need to look at the new code more closely.  I was hoping that we
could divorce the reservation windows from any knowledge of blockgroups. 
Is that not the case?

> We are also looking at RB tree and see how we can make use of it. Our problem
> is,  we are interested in finding out a big enough hole in the tree to put our
> reservation. We need to look closely.

This sounds awfully like get_unmapped_area().


