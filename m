Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUJDWwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUJDWwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUJDWwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:52:30 -0400
Received: from mx01.netapp.com ([198.95.226.53]:41895 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S268633AbUJDWwV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:52:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NFS] Re: [PATCH] NFS using CacheFS
Date: Mon, 4 Oct 2004 15:51:57 -0700
Message-ID: <482A3FA0050D21419C269D13989C611302B07E52@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] Re: [PATCH] NFS using CacheFS
Thread-Index: AcSqYJo9e8Nc6G5zQh6GOsBNpACnWwAAsJNA
From: "Lever, Charles" <cel@netapp.com>
To: "Steve Dickson" <SteveD@redhat.com>
Cc: <nfs@lists.sourceforge.net>,
       "Linux filesystem caching discussion list" <linux-cachefs@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2004 22:51:57.0814 (UTC) FILETIME=[C09C5960:01C4AA64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> På må , 04/10/2004 klokka 22:45, skreiv Steve Dickson:
> 
> > 3) There is no user level support. I realize this is 
> extremely cheesy
> >      but I noticed that the NFS posix mount  option (in the 
> 2.6 kernel)
> >      was no longer being used, so I high jacked it.  Which means
> >      to make NFS to used CacheFS you need to use the posix option:
> > 
> >      mount -o posix server:/export/home /mnt/server/home
> 
> This is my one and only real gripe about it. The posix mount option is
> clearly documented, so we really cannot play around with it. Why can't
> you just add a separate cachefs flag?

probably ought to look like the Solaris UI here.  isn't there a "cachefs" mount option on Solaris?  anyway, reusing "posix" just for a prototype seems harmless enough.

> I'm a bit worried about the use of the raw IP address in
> nfs_cache_server_match(). It seems to me that when we add the NFSv4.1
> support for trunking over several different transport mechanisms (RDMA,
> IPv4/v6 etc) on the same mountpoint, then we may end up with a problem.
> We can probably leave it in for now, but later we may want to consider
> switching to using server->hostname or something equivalent.

yup, we want to avoid adding any transport specific detail in the NFS client, and leave that kind of stuff to the RPC client.  good catch, trond.

i did a lengthy study of the AFS cache manager about a decade ago.  interestingly, the place where it really falls down is in recycling disk blocks for use with a new incoming file to be cached.  the underlying cache file system has to get rid of the on-disk data for old files before it can reuse the blocks for a new file.  otherwise, the old data is exposed if the new file maps in pages it hasn't written to yet.  if the cache is turning over quickly, handling this correctly can result in serious disk thrashing as the cache file system frees and erases blocks on disk and then reallocates them to the new file.

steve, is there [english] documentation somewhere that describes how the cachefs works?
