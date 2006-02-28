Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWB1TtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWB1TtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWB1TtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:49:06 -0500
Received: from ns2.suse.de ([195.135.220.15]:57274 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932535AbWB1TtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:49:04 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: o_sync in vfat driver
Date: Tue, 28 Feb 2006 14:48:55 -0500
User-Agent: KMail/1.9.1
Cc: col-pepper@piments.com, linux-kernel@vger.kernel.org
References: <op.s5lrw0hrj68xd1@mail.piments.com> <200602281347.46169.mason@suse.com> <20060228111032.559e849b.akpm@osdl.org>
In-Reply-To: <20060228111032.559e849b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281448.56666.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 14:10, Andrew Morton wrote:

> On a single line, please.
>
Ack.

> > +	if (MSDOS_SB(inode->i_sb)->options.flush) {
>
> Did you consider making `-o flush' a generic mount option rather than
> msdos-only?

Yes, long term I think the generic option is better.  I have three or so ideas 
for a generic patch:

1) When the block device leaves congestion, it asks for more io
2) pdflush operation that tries to constantly keep a given block device 
congested
3) my current patch aggregated to other filesystems that people want -o flush 
on.

I've made a few stabs at #1, but didn't like the end result.  #2 seems like 
the best choice so far.  If I got it working nicely I would add the generic 
option, otherwise with option #3 it's probably best to keep it per FS.

The main goal for my current patch was to find out if this functionality will 
actually make people happy (so far the beta testers like it).  If the 
complaints are low, it's worth the time to add something generic.

>
> I guess there isn't a lot of demand for this for other filesystems, and
> having an ignored option like this is a bit misleading...
>
> > +void
> > +writeback_inode(struct inode *inode)
> > +{
> > +
> > +	struct address_space *mapping = inode->i_mapping;
> > +	struct writeback_control wbc = {
> > +		.sync_mode = WB_SYNC_NONE,
> > +		.nr_to_write = 0,
> > +	};
> > +	sync_inode(inode, &wbc);
> > +	filemap_fdatawrite(mapping);
>
> I think that filemap_fdatawrite() will be a no-op?

This part is nasty, I want to write all of the file data pages and write the 
inode without waiting on it.  The nr_to_write = 0 will make sure that 
sync_inode only writes the inode, and WB_SYNC_NONE makes sure it does not 
wait for that io to finish.

What I really want is WB_SYNC_NONE in mpage_writepages, but I don't want to 
trigger this code:

        if (wbc->sync_mode == WB_SYNC_NONE) {
                index = mapping->writeback_index; /* Start from prev offset */

So, I use filemap_fdatawrite to make sure all of the data pages get written.  
It's not perfect, but I was going for minimal changes outside of fat.

-chris
