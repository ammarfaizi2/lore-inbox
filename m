Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbULOVuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbULOVuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbULOVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:50:23 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:17573 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262506AbULOVuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:50:13 -0500
To: avi@argo.co.il
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <41C07A7C.1050905@argo.co.il> (message from Avi Kivity on Wed, 15
	Dec 2004 19:55:08 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il> <E1CZG1J-0004zW-00@dorka.pomaz.szeredi.hu> <41ACFAE7.2050002@argo.co.il> <E1CZHH7-0005Ev-00@dorka.pomaz.szeredi.hu> <41C07A7C.1050905@argo.co.il>
Message-Id: <E1Ceh1k-00022A-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 15 Dec 2004 22:49:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >No partitioning is needed.  If fuse doesn't consume too much memory
> >for dirty data buffers that memory is free to use for other purposes.
> >
> >But fuse would be limited in the number of pages which it can use for
> >dirty buffers exactly to prevent it from causing OOM.
> >  
> >
> yes, that will work. wil need to be extra-careful when one fuse is 
> loopback-mounted on another.

Since loopback doesn't use shared mapping (I think it uses sendfile)
this isn't a problem for fuse: all non-mmap writes are synchronous,
there'll be no dirty pages (only locked ones), so any allocation by
the userspace filesytem won't deadlock on page reclaim.

I think the solution to the writable mmap problem is also to make
those writes "quasi-synchronous", by not letting too many pages to get
dirty.

> I'm concerned that you're duplicating all the accounting done currently, 
> and all of the writeback logic that is dependent on the number of dirty 
> pages.

Maybe it can be done without duplication.  Since all the memory
reclaim code is based on the "zone" concept, maybe this can be reused.
I don't know how far-feched is the idea of "virtual zones" which
borrow pages from the physical zones, but have their own limits.

> an additional concern is a fuse/non-fuse mix - how do you balance them out?

I wouldn't want to reserve any pages for fuse, only limit the number
of dirtiable pages.  That means that if all pages are used up for
non-fuse purposes, that's OK.

> I'm no mmap expert. but doesn't writing to a mmaped page have to 
> increase your dirty counter somehow?

For ramfs/tmpfs it doesn't.  But I'm not saying that this is the
solution for fuse.  This was a purely theoretical idea.

Thanks,
Miklos

