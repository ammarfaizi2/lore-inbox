Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbUBAQPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 11:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBAQPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 11:15:23 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24075 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265363AbUBAQPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 11:15:19 -0500
Date: Sun, 1 Feb 2004 16:15:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@xfs.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, nathans@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040201161513.A15966@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@xfs.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>, nathans@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org> <20040131012507.GQ25833@drinkel.cistron.nl> <20040130173851.2cc5938f.akpm@osdl.org> <20040131114638.GA29609@drinkel.cistron.nl> <401BD0CA.5070204@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <401BD0CA.5070204@xfs.org>; from lord@xfs.org on Sat, Jan 31, 2004 at 09:59:06AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:59:06AM -0600, Steve Lord wrote:
> The vn_revalidate call is called out of linvfs_setattr,
> which is called with the i_sem held, it is also potentially called out
> of linvfs_getattr, although since the i_size is always maintained
> as it is changed, this call should not actually be updating the size.
> Possibly changing the code in vn_revalidate to do this:
> 
> 	if (i_size_read(inode) < va.va_size))
> 		i_size_write(inode, va.va_size);
> 
> Would be a good starting point, I suspect those calls from the nfs
> revalidate call are not really going to change the inode size. My
> guess is this will make your problem go away.
> 
> Probably some larger code restructure is needed so that revalidate
> knows if the i_sem is held or not at this point.

I think the right fix is to update the Linux i_size always shortly after
di_size is updated.  There's a lot of updates in the directory code while
should be handled by an i_size_write in the matching linvfs routines, and
there's a few more but we should be able to handle those without
vn_revalidate aswell.

> The O_DIRECT write case is the hard one. In XFS's internal view of
> the world, the inode size is maintained via the XFS_ILOCK, but we
> only hold that across metadata manipulation within the fs code,
> not across I/O such as a call to generic_file_aio_write_nolock.
> Right now the only way I see of dealing with that is to make
> writes which we know will extent the file hold the i_sem for
> the duration in the O_DIRECT case.

That's the more difficult case.  Any reson why you'd hold i_sem
for the whole O_DIRECT I/O instead of just for updating i_sem?

Note that the EOF zeroing code also calls i_size_write.

