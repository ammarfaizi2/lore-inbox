Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWJIHuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWJIHuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWJIHun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:50:43 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:42122 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932335AbWJIHun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:50:43 -0400
Date: Mon, 9 Oct 2006 09:49:15 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg KH <greg@kroah.com>, Ashok Raj <ashok.raj@intel.com>,
       Nathan Lynch <nathanl@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] sysfs: allow removal of nonexistent sysfs groups.
Message-ID: <20061009074915.GD6936@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com> <4524E983.6010208@garzik.org> <20061005124848.GB6920@osiris.boeblingen.de.ibm.com> <45250161.4060002@garzik.org> <20061005131623.GC6920@osiris.boeblingen.de.ibm.com> <20061009072920.GB6936@osiris.boeblingen.de.ibm.com> <20061009004014.11ed8df2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009004014.11ed8df2.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 12:40:14AM -0700, Andrew Morton wrote:
> On Mon, 9 Oct 2006 09:29:20 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > This patch makes it safe to call sysfs_remove_group() with a name group
> > that doesn't exist. Needed to make fix cpu hotplug stuff in topology code.
> > 
> 
> Surely an attempt to remove a non-existent entry is a bug, and this
> (racy-looking) patch just covers that up?

It just tries to keep cpu hotplug code in drivers/base/topology.c simple. Since
otherwise one would have to remember if sysfs_create_group() succeeded or not.
Hmm.. thinking again, this patch looks indeed racy.

> > Index: linux-2.6/fs/sysfs/group.c
> > ===================================================================
> > --- linux-2.6.orig/fs/sysfs/group.c	2006-10-09 09:15:25.000000000 +0200
> > +++ linux-2.6/fs/sysfs/group.c	2006-10-09 09:25:23.000000000 +0200
> > @@ -68,9 +68,12 @@
> >  {
> >  	struct dentry * dir;
> >  
> > -	if (grp->name)
> > +	if (grp->name) {
> > +		if (!sysfs_dirent_exist(kobj->dentry->d_fsdata, grp->name))
> > +			return;
> >  		dir = lookup_one_len(grp->name, kobj->dentry,
> >  				strlen(grp->name));
> > +	}
> >  	else
> >  		dir = dget(kobj->dentry);
> >  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
