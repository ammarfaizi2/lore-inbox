Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWGSPy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWGSPy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWGSPy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:54:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58838 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030195AbWGSPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:54:55 -0400
Date: Wed, 19 Jul 2006 17:55:02 +0200
From: Jan Kara <jack@suse.cz>
To: James <20@madingley.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sct@redhat.com
Subject: Re: Bad ext3/nfs DoS bug
Message-ID: <20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk> <1153209318.26690.1.camel@localhost> <20060718145614.GA27788@circe.esc.cam.ac.uk> <1153236136.10006.5.camel@localhost> <20060718152341.GB27788@circe.esc.cam.ac.uk> <1153253907.21024.25.camel@localhost> <20060719092810.GA4347@circe.esc.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719092810.GA4347@circe.esc.cam.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what happens next? Is the ext3 maintainer on sabatical,
> or am I expected to submit a patch to fix this?
  I guess people are mostly busy with OLS and such so maybe they missed
the discussion.. Giving CC to relevant people to catch their attention
:)
  Andrew, Stephen: James has come across a nasty bug (potentially remote
DoS). NFS extracts inode number from a filehandle and the inode number
eventually ends in ext3_read_inode(). Now if the inode number is bogus,
ext3_get_inode_block() calls ext3_error() and filesystem is remounted
RO or whatever else is configured. That is quite undesirable in this
case.
  Now the easy "fix" is to change ext3_error() to ext3_warning() but an
attacker flooding your logs with warnings is probably not good either
and in case the inode number comes from ext3 itself we should really do
ext3_error() as there is some corruption in the fs.
  Better fix would be to add a flag to read_inode() saying that the inode
number is from untrusted source (but that means changing a prototype of a
function every fs uses) and change export_iget() to pass this flag. Yet
another solution would be to make ext3 implement its own get_dentry() export
function and pass the flag internally...
  What do you think is the best solution?

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
