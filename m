Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWFSC0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWFSC0J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 22:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWFSC0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 22:26:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:30687 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750726AbWFSC0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 22:26:07 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 19 Jun 2006 12:25:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17558.2869.42245.876826@cse.unsw.edu.au>
Cc: dgc@sgi.com, jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
In-Reply-To: message from Andrew Morton on Sunday June 18
References: <20060601095125.773684000@hasse.suse.de>
	<17539.35118.103025.716435@cse.unsw.edu.au>
	<20060616155120.GA6824@hasse.suse.de>
	<17555.12234.347353.670918@cse.unsw.edu.au>
	<20060618235654.GB2114946@melbourne.sgi.com>
	<17557.61307.364404.640539@cse.unsw.edu.au>
	<20060619010013.GC2114946@melbourne.sgi.com>
	<17557.64512.496195.714144@cse.unsw.edu.au>
	<20060618190422.5daf17fe.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 18, akpm@osdl.org wrote:
> On Mon, 19 Jun 2006 11:21:04 +1000
> Neil Brown <neilb@suse.de> wrote:
> 
> > static void prune_dcache(int count, struct super_block *sb)
> > +static void prune_dcache(int count, struct list_head *list)
> >  {
> > +	int have_list = list != NULL;
> > +	struct list_head alt_head;
> >  	spin_lock(&dcache_lock);
> > +	if (list == NULL) {
> > +		/* use the dentry_unused list */
> > +		list_add(&alt_head, &dentry_unused);
> > +		list_del_init(&dentry_unused);
> > +		list = &alt_head;
> > +	}
> 
> This will make dentry_unused appear to be empty.
> 

Yep.  Appear.

> >  	for (; count ; count--) {
> >  		struct dentry *dentry;
> >  		struct list_head *tmp;
> > @@ -405,23 +417,11 @@ static void prune_dcache(int count, stru
> >  
> >  		cond_resched_lock(&dcache_lock);
> 
> And then it makes that apparent-emptiness globally visible.
> 

But who will look?  and will they care?

> Won't this cause concurrent unmounting or memory shrinking to malfunction?

I don't think so.

Unmounting always passes a list to prune_dcache, so dentry_unused
doesn't get emptied, so shrink_dcache_memory will not get confused.

If there are two concurrent calls to shrink_dcache_memory, then one
will find an empty list and do nothing, and it appears this is
possible - there is no locking between callers to shrink_slab.

That's probably not fatal, but it isn't ideal (I expect....).

I guess I don't need to create a separate list.  It seemed cleaner but
does have this awkwardness.
The following patch on top of the previous one changes that behaviour.

I'm wondering now if maybe we should really have two different
'prune_dcache' functions.
One that works on a private list and doesn't bother with
DCACHE_REFERENCED or s_umount, and one that works on the global list
and does the awkward stuff.  I might try that later and see what it
looks like.

NeilBrown


### Diffstat output
 ./fs/dcache.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff .prev/fs/dcache.c ./fs/dcache.c
--- .prev/fs/dcache.c	2006-06-19 11:19:29.000000000 +1000
+++ ./fs/dcache.c	2006-06-19 12:20:49.000000000 +1000
@@ -404,12 +404,10 @@ static void prune_dcache(int count, stru
 	int have_list = list != NULL;
 	struct list_head alt_head;
 	spin_lock(&dcache_lock);
-	if (list == NULL) {
+	if (list == NULL)
 		/* use the dentry_unused list */
-		list_add(&alt_head, &dentry_unused);
-		list_del_init(&dentry_unused);
-		list = &alt_head;
-	}
+		list = &dentry_unused;
+
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
@@ -490,7 +488,8 @@ static void prune_dcache(int count, stru
 		break;
 	}
 	/* split any remaining entries back onto dentry_unused */
-	list_splice(list, dentry_unused.prev);
+	if (have_list)
+		list_splice(list, dentry_unused.prev);
 	spin_unlock(&dcache_lock);
 }
 
