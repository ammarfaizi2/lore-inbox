Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWCIAbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWCIAbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWCIAbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:31:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932632AbWCIAbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:31:40 -0500
Date: Wed, 8 Mar 2006 16:29:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: kenneth.w.chen@intel.com, yanmin.zhang@intel.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: hugepage: Strict page reservation for hugepage inodes
Message-Id: <20060308162932.07a05650.akpm@osdl.org>
In-Reply-To: <20060308235207.GB17590@localhost.localdomain>
References: <20060308102314.GB32571@localhost.localdomain>
	<200603081838.k28Icwg10327@unix-os.sc.intel.com>
	<20060308235207.GB17590@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"'David Gibson'" <david@gibson.dropbear.id.au> wrote:
>
> On Wed, Mar 08, 2006 at 10:38:58AM -0800, Chen, Kenneth W wrote:
> > David Gibson wrote on Wednesday, March 08, 2006 2:23 AM
> > > Yes.  This is a simplifying assumption.  I know of no real application
> > > that will waste pages because of this behaviour.  If you know one,
> > > maybe we will need to reconsider.
> > > 
> > > > I have an idea. How about to record all the start/end address of
> > > > huge page mmaping of the inode? Long long ago, there was a patch at 
> > > > http://marc.theaimsgroup.com/?l=lse-tech&m=108187931924134&w=2.
> > > > Of course, we need port it to the latest kernel if this idea is better.
> > > 
> > > I know the patch - I was going to port it to the current kernel, but
> > > came up with my patch instead, because it seemed like a simpler
> > > approach.
> > 
> > I really think the Variable length reservation system is the way to go
> > for tracking hugetlb commit.  It is more robust and in my opinion, it
> > is better than traverse the page cache radix tree.  At least, you don't
> > have to worry about all the race condition there.  Oh, it also can get
> > rid of the hugetlb_instantiation_mutex that was introduced.  Someday,
> > people is going to scream at you for serializing hugetlb fault path.
> 
> Well, not my decision, or yours I think.  wli?  akpm?

You're the guy who's doing all the work...

The linear list walk is a worry.  Every time we have one of those someone
gets bitten by it.

It's rather similar to the vma rbtree.

The radix-tree supports both in-order traversal and O(log(n)) lookup.  For
non-duplicated-key items it _should_ be OK?  (It could be used for
duplicated-key items too, btw).


