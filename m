Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbUDVDlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUDVDlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUDVDlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:41:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:60052 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262923AbUDVDle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:41:34 -0400
Date: Wed, 21 Apr 2004 20:40:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: ext3 reservation question.
Message-Id: <20040421204036.4e530732.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404211959560.18945@ppc970.osdl.org>
References: <200404211655.47329.pbadari@us.ibm.com>
	<Pine.LNX.4.58.0404211959560.18945@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 21 Apr 2004, Badari Pulavarty wrote:
> > 
> > I am worried about a case, where multiple threads writing to 
> > different parts of same file - there by each thread thrashing 
> > reservation window (since each one has its own goal).
> 
> Didn't we have a patch two years ago or something floating around with
> doing lazy (delayed) block allocation on ext2 - doing the actual
> allocation only when writing the thing out? Then you shouldn't have this
> problem under any normal load, hopefully.

That would certainly help.  I had delayed allocation for ext2 all up and
running in 2.5.7 or thereabouts - most of the complexity is in managing
filesystem space reservations.  If you don't care about ENOSPC the VFS at
present "just works".

I do recall deciding that there were fundamental journal-related reasons
why delalloc couldn't be made to work properly on ext3.

ummm.

The code I had at the time would reserve space in the filesystem
correspnding to the worst-case occupancy based on file offset.  When we
actually hit ENOSPC in prepare_write(), we force writeout, which results in
those worst-space reservations being collapsed into their _real_ space
usage, which is much less.  So writeout reclaims space in the filesystem
and prepare_write() can proceed.

That worked fine on ext2.  But on ext3 we have a transaction open in
prepare_write(), and the forced writeback will cause arbitrary amounts of
unexpected metadata to be pumped into the current transaction, causing the
fs to explode.

At least, I _think_ that was the problem.  All is hazy.



Alex Tomas has current patches which do delalloc, but I don't know if they
do all the reservation stuff yet.

We would still face layout problems on SMP - two or more CPUs allocating
blocks in parallel.  Could be solved by serialising writeback in some
manner - the fs-writeback.c code does that to some extent already.


