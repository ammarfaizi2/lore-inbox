Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbUK3VRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUK3VRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUK3VRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:17:32 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:50048 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262310AbUK3VRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:17:15 -0500
To: avi@argo.co.il
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <41ACD03C.9010300@argo.co.il> (message from Avi Kivity on Tue, 30
	Nov 2004 21:55:40 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il>
Message-Id: <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Nov 2004 22:13:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> you're describing the deadlock here: all memory is full, no process 
> which allocates memory can make any progress.

Yes they, can: the allocation will fail, function will return -ENOMEM,
malloc will return NULL, pagefault will fail with OOM.  This is
progress, though not the best sort.  It is most certainly _not_ a
deadlock.

> This is not a true oom situation: there can be plenty of memory in
> dirty pagecache which we could reclaim if we had that tiny bit of
> reserve memory.

The amount of reserved memory that would be needed depends upon the
filesystem.  Some filesystems would need only very little to be able
to free some memory, some would need a lot (e.g. a bzip2 compressing
filesystem).  There's no magic solution with reserving memory.

And this is not unique to userspace filesystems, as Rik van Riel
pointed out earlier, network filesystems are also prone to deadlock:

http://lkml.org/lkml/2004/11/27/81

> >I looked at ramfs, it isn't even limited.  You can easily crash your
> >system just by filling it up with data, but no deadlock will happen.
> >  
> >
> Right. But ramfs doesn't call a userspace process which calls the kernel 
> right back.

Doesn't matter one little whit.  The end result is the same: Out Of
Memory, which is _not_ equivalent to deadlock.  Please think it over.

Miklos
