Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVEDQDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVEDQDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 12:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVEDQDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 12:03:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:60306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261901AbVEDQDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 12:03:02 -0400
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls. 
In-reply-to: <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com> 
References: <20050421152345.6b87aeae@es175> <20050503144325.GF4501@atrey.karlin.mff.cuni.cz> <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com>
Comments: In-reply-to Badari Pulavarty <pbadari@us.ibm.com>
   message dated "03 May 2005 08:01:03 -0700."
Date: Wed, 04 May 2005 09:02:52 -0700
From: Cliff White <cliffw@osdl.org>
Message-Id: <E1DTMKq-00043x-BO@es175>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> --=-LBuZsEP+un6vb/N1S6Yo
> Content-Type: text/plain
> Content-Transfer-Encoding: 7bit
> 
> On Tue, 2005-05-03 at 07:43, Jan Kara wrote:
> >   Hello,
> > 
> > > Started seeing some odd behaviour with recent kernels, haven't been able 
> to
> > > run it down, could use some suggestions/help.
> > > 
> > > Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or
> > > reiserfs things work just fine.
> > > 
> > > With ext3, the  test stalls, such that:
> > > CPU is 50% idle, 50% waiting IO (top)
> > > vmstat shows one process blocked wio
> >   I've looked through your dumps and I spotted where is the problem -
> > it's our well known and beloved lock inversion between PageLock and
> > transaction start (giving CC to Badari who's the author of the patch
> > that introduced it AFAIK).
> 
> Yuck. It definitely not intentional.
> 
> >   The correct order is: first get PageLock and *then* start transaction.
> > But in ext3_writeback_writepages() first ext3_journal_start() is called
> > and then __mpage_writepages is called that tries to do LockPage and
> > deadlock is there. Badari, could you please fix that (sadly I think that
> > would not be easy)? Maybe we should back out those changes until it gets
> > fixed...
> 
> Hmm.. let me take a closer look. You are right, its not going to be
> simple fix.
> 
> Cliff, here is the patch to backout writepages() for ext3. Can you
> verify that problems goes away with this patch ?
> 
I can now verify that the problem is not there with Badari's no-writepages
patch  - all the runs last night completed, performance is about what it was
for 2.6.12-rc1.
cliffw


> Thanks,
> Badari
> 
> --=-LBuZsEP+un6vb/N1S6Yo
> Content-Disposition: attachment; filename=ext3-writeback-nowritepages.patch
> Content-Type: text/plain; name=ext3-writeback-nowritepages.patch; charset=UTF
> -8
> Content-Transfer-Encoding: 7bit
> 
> --- linux-2.6.12-rc3.org/fs/ext3/inode.c	2005-05-02 22:28:30.000000000 -
> 0700
> +++ linux-2.6.12-rc3/fs/ext3/inode.c	2005-05-02 22:29:00.000000000 -0700
> @@ -1621,7 +1621,9 @@ static struct address_space_operations e
>  	.readpage	= ext3_readpage,
>  	.readpages	= ext3_readpages,
>  	.writepage	= ext3_writeback_writepage,
> +#if 0
>  	.writepages	= ext3_writeback_writepages,
> +#endif
>  	.sync_page	= block_sync_page,
>  	.prepare_write	= ext3_prepare_write,
>  	.commit_write	= ext3_writeback_commit_write,
> 
> --=-LBuZsEP+un6vb/N1S6Yo--
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
