Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUJZQvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUJZQvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUJZQvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:51:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29862 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261333AbUJZQvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:51:04 -0400
Subject: Re: [Ext2-devel] Re: [PATCH 2/3] ext3 reservation allow turn off
	for specifed file
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ray-lk@madrabbit.org, sct@redhat.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20041025164516.1f02bb9f.akpm@osdl.org>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com> <109787 
	<1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
	<1098294941.18850.4.camel@orca.madrabbit.org>
	<1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
	<1098745548.9754.7427.camel@w-ming2.beaverton.ibm.com> 
	<20041025164516.1f02bb9f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2004 09:53:20 -0700
Message-Id: <1098809607.8919.7466.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 16:45, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > 	/*
> > +	 * if user passed a seeky-access hint to kernel,
> > +	 * through POSIX_FADV_RANDOM,(file->r_ra.ra_pages is cleared)
> > +	 * turn off reservation for block allocation correspondingly.
> > +	 *
> > +	 * Otherwise, if user switch back to POSIX_FADV_SEQUENTIAL or
> > +	 * POSIX_FADV_NORMAL, re-open the reservation window.
> > +	 */
> > +	windowsz = atomic_read(&EXT3_I(inode)->i_rsv_window.rsv_goal_size);
> > +	if ((windowsz > 0) && (!file->f_ra.ra_pages))
> > +		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size, -1);
> > +	if ((windowsz == -1) && file->f_ra.ra_pages)
> > +		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size,
> > +					EXT3_DEFAULT_RESERVE_BLOCKS);
> > +
> 
> It's pretty sad that we add this extra code into ext3_prepare_write() -
> it's almost never actually executed.
> 
:(

> I wonder how important this optimisation really is?  I bet no applications
> are using posix_fadvise(POSIX_FADV_RANDOM) anyway.
> 
I don't know if there is application using the POSIX_FADV_RANDOM. No? If
this is the truth, I think we don't need this optimization at present.
Logically reservation does not benefit seeky random write, but there is
no benchmark showing performance issue so far. We have already provided
ways for applications turn off reservation through the existing ioctl
for specified file and -o noreservation mount option for the whole
filesystem.

> It we really see that benefits are available from this approach we probably
> need to bite the bullet and add file_operations.fadvise()
> 
I agree.

Mingming


