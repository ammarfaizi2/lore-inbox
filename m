Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbREVIK3>; Tue, 22 May 2001 04:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbREVIKT>; Tue, 22 May 2001 04:10:19 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:11528 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262579AbREVIKN>; Tue, 22 May 2001 04:10:13 -0400
Date: Tue, 22 May 2001 10:10:07 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: question: permission checking for network filesystem
Message-ID: <20010522101007.A15555@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010521153246.A9454@artax.karlin.mff.cuni.cz> <Pine.LNX.3.96.1010521233913.27071A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010521233913.27071A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Tue, May 22, 2001 at 12:26:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can write lookup so that it always succeeds and returns dummy inode
> without sending anything and do all the work in open & inode operations.
 
It'd be great if I could. But I can't. First, the inode data are checked by
some vfs functions before driver is called (this being the bigest problem:
if (S_ISDIR(inode->i_mode) && (flag & FMODE_WRITE)) goto exit;
- I think these checks could be, perhaps better, done by having right
i_fop->open on different types of inodes)

It could be done partialy (ie. returning dummy data for all but the last
inode in path_walk) if path_walk passed LOOKUP_CONTINUE to i_ops->lookup
(it's passed to d_ops->d_revalidate so NFS can avoid revalidating inodes on
the way). I think adding this flag to i_ops->lookup won't break anything
and make path_walk more self-consistent. (Also passing all flags from
path_walk might help some optimization).

> > exclusivity of write versus execute is the other
> > (can't be workaround).
> 
> MAP_DENYWRITE is used for this. If somebody is mapping file with
> MAP_DENYWRITE, lock it on server. Write locking does not depend on exec,
> and it is bad to expect that it may be used only in exec. 

There is one problem - I don't get to get/deny_write_permission functions.
They operate on i_writecount and don't call the driver. MAP_DENYWRITE must
be solved by mandatory write-lock on the file... I still think it's better
to check permission in open (

Anyway, is there any reason file->f_ops->open shouldn't have the
information inode->i_ops->permission had? Even if I unite opening for read
and for exec, permissions still have to be queried and permission is
definitely no good place. Lookup might do, but it might not do on other
operating systems.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
