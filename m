Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWFYGsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWFYGsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 02:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWFYGsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 02:48:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:25300 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932081AbWFYGsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 02:48:45 -0400
From: Neil Brown <neilb@suse.de>
To: David Howells <dhowells@redhat.com>
Date: Sun, 25 Jun 2006 16:48:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17566.12727.489041.220653@cse.unsw.edu.au>
Cc: balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com, jblunck@suse.de,
       dev@openvz.org, olh@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting
In-Reply-To: message from David Howells on Saturday June 24
References: <17564.52290.338084.934211@cse.unsw.edu.au>
	<15603.1150978967@warthog.cambridge.redhat.com>
	<553.1151156031@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday June 24, dhowells@redhat.com wrote:
> 
> Neil Brown <neilb@suse.de> wrote:
> 
> > Do you not have easy access to the roots of all trees in your
> > super-block-sharing situation so that shrink_dcache_parent can be
> > called on them all?
> 
> How about this?

I think this is definitely going in the right direction.
A few comments.

 - The test for IS_ROOT surprises me.  I thought anonymous dentries
   were all IS_ROOT.   Maybe this changes with your shared-superblock
   changes? 

 - You have two nested loops implemented with gotos.  Dijykstra would
   be shocked!  The logic looks like it should be:

     for(;;) {
        while (!list_empty(&dentry->d_subdirs)) {
		stuff-1;
		dentry = list_entry(dentry->d_subdirs.next,....)
	}
	while (list_empty(dentry->d_subdirs)) {
		parent = dentry->d_parent (or NULL)
		d_free(dentry)
		if (!parent) return;
		dentry = parent;
	}
     }

    Which I think makes it a lot more readable (obviously I have left
    out lots of the details in the above.

  - The section that I have called 'stuff-1' above seems excessive.
    Everytime you visit a dentry with children, you remove them from
    the unused list (if present) and d_drop them from the hash.  After
    the first time, these should all be no-ops.  If there some
    particular reason for this that I'm not seeing (which case I'd
    like a comment) or can you just unuse/drop the dentry just before
    freeing it

  - Think the reference counting deserves a comment.  I think that
    this routine holds a reference count on 'dentry' and every parent
    up to the IS_ROOT.  Is that right?

In summary, it looks right, though I feel I would want to go through
and double check the refcounting again, but I would rather do that
with it restructured into while loops.
Is that fair?

NeilBrown
