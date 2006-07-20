Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWGTQG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWGTQG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGTQG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:06:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37553 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030349AbWGTQG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:06:27 -0400
Date: Thu, 20 Jul 2006 18:06:39 +0200
From: Jan Kara <jack@suse.cz>
To: Neil Brown <neilb@suse.de>
Cc: James <20@madingley.org>, Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
Subject: Re: Bad ext3/nfs DoS bug
Message-ID: <20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk> <1153209318.26690.1.camel@localhost> <20060718145614.GA27788@circe.esc.cam.ac.uk> <1153236136.10006.5.camel@localhost> <20060718152341.GB27788@circe.esc.cam.ac.uk> <1153253907.21024.25.camel@localhost> <20060719092810.GA4347@circe.esc.cam.ac.uk> <20060719155502.GD3270@atrey.karlin.mff.cuni.cz> <17599.2754.962927.627515@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17599.2754.962927.627515@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday July 19, jack@suse.cz wrote:
> > > So what happens next? Is the ext3 maintainer on sabatical,
> > > or am I expected to submit a patch to fix this?
> >   I guess people are mostly busy with OLS and such so maybe they missed
> > the discussion.. Giving CC to relevant people to catch their attention
> > :)
> >   Andrew, Stephen: James has come across a nasty bug (potentially remote
> > DoS). NFS extracts inode number from a filehandle and the inode number
> > eventually ends in ext3_read_inode(). Now if the inode number is bogus,
> > ext3_get_inode_block() calls ext3_error() and filesystem is remounted
> > RO or whatever else is configured. That is quite undesirable in this
> > case.
> >   Now the easy "fix" is to change ext3_error() to ext3_warning() but an
> > attacker flooding your logs with warnings is probably not good either
> > and in case the inode number comes from ext3 itself we should really do
> > ext3_error() as there is some corruption in the fs.
> >   Better fix would be to add a flag to read_inode() saying that the inode
> > number is from untrusted source (but that means changing a prototype of a
> > function every fs uses) and change export_iget() to pass this flag. Yet
> > another solution would be to make ext3 implement its own get_dentry() export
> > function and pass the flag internally...
> >   What do you think is the best solution?
> 
> I think that a good solution (hard to say if it is the best) is to
> remove that error message altogether, and put it where inode numbers
> are read out of directories.  Something like the following patch -
> compile tested only.
  Yes, that looks fine too. I did not realize that we get the inode
number only in a few places. Maybe we could wrap the checks in a
function (possibly inline) so that the checks are just in one place?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
