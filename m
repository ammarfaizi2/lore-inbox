Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbUK3TSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUK3TSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUK3TRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:17:44 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:18158 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262252AbUK3TRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:17:37 -0500
To: avi@argo.co.il
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <41ACBF87.4040206@argo.co.il> (message from Avi Kivity on Tue, 30
	Nov 2004 20:44:23 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il>
Message-Id: <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Nov 2004 20:16:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >And I firmly believe that this can be done without having to special
> >case filesystem serving processes.
> >  
> >
> I firmly believe the opposite. When a userspace process calls the kernel 
> which (directly or indirectly) calls the userspace filesystem, the 
> filesystem must have elevated priviledges, or it can deadlock when 
> calling back in.

No.

Just by making the filesystem not contribute to the dirty counters
(like ramfs), the deadlock problem can be solved.  In this case you
simply could not get a deadlock, because all those dirty pages
produced by the filesystem look just like normal allocations, which
simply cannot be touched when the userspace filesystem wants to
allocate more memory.

In this case the allocation would just fail.  Deadlock doesn't happen,
though the filesystem wasn't given any elevated privileges.

Of course this isn't a good situation: the memory is filled in with
dirty data of the filesystem which it cannot write back.  All sorts of
programs might fail because of the OOM situation, and the system could
even crash.

The hard part is ensuring that this doesn't happen, but that has
nothing to do with the userspace part of the filesystem.

> As others have mentioned, they are limited in the number of pages they 
> are allowed to dirty.

I looked at ramfs, it isn't even limited.  You can easily crash your
system just by filling it up with data, but no deadlock will happen.
Same situation as described above.  Nothing strange about this, so I
don't really understand why people so vehemently believe that the
"userspace filesystem deadlock" phenomena cannot be solved.

> I don't see a theoretical problem, just some practical ones.
> 
> All can be overcome IMO, and it would be well worth it, too.

We are in agreement then :)

Thanks,
Miklos
