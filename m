Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWCXPfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWCXPfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWCXPfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:35:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:12164 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750864AbWCXPfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:35:18 -0500
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
	through fs-wide dirty bit]
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, tytso@mit.edu, zach.brown@oracle.com
In-Reply-To: <20060324143239.GB14508@goober>
References: <20060322011034.GP12571@goober>
	 <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
	 <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org>
	 <20060324143239.GB14508@goober>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 09:35:15 -0600
Message-Id: <1143214515.10413.18.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 06:32 -0800, Valerie Henson wrote:
> On Wed, Mar 22, 2006 at 05:55:03PM -0800, Andrew Morton wrote:
> > Valerie Henson <val_henson@linux.intel.com> wrote:
> > > 
> > > ext2 is simpler and faster than ext3 in many cases.  This is sort of
> > > cheating; ext2 is simpler and faster because it makes no effort to
> > > maintain on-disk consistency and can skip annoying things like, oh,
> > > reserving space in the journal.  I am looking for ways to make ext2
> > > cheat even more.
> > > 
> > 
> > But it might be feasible to knock up an ext3-- in which all the journal
> > operations are stubbed out.
> 
> Hmm... Could we get the mark_buffer_dirty/mark_inode_dirty logic
> right?  Probably create a list in the stubbed journal functions and
> then mark them dirty in the journal close?  However, half the reason
> I'm working on ext2 is the simplicity of the code - stubbing it out
> would solve the performance problem but not the complexity problem.

I don't know the ext3 journaling code at all, so this may or may not be
useful, but jfs has a nointegrity mode that disables writing to the
journal.  To keep it simple, I execute all of the journaling code as
normal except that when it is time to actually submit I/O to the
journal, I call the end_io routine directly.  (I first set bio->bi_size
= 0 to make it look like the I/O was successful.)  There is a bit more
cpu overhead than if we stubbed out all the journaling code, but it's a
lot safer not to have to worry about different paths of execution.

> Note that ext3's habit of clearing indirect blocks on truncate would
> break some things I want to do in the future. (Insert secret plans
> here.)

I can't comment on that.  :-)
-- 
David Kleikamp
IBM Linux Technology Center

