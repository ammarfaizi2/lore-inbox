Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753267AbWKCPZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbWKCPZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbWKCPZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:25:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753267AbWKCPZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:25:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162561291.5635.64.camel@lade.trondhjem.org> 
References: <1162561291.5635.64.camel@lade.trondhjem.org>  <1162502667.6071.66.camel@lade.trondhjem.org> <1162496968.6071.38.camel@lade.trondhjem.org> <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> <25037.1162487801@redhat.com> <32754.1162499917@redhat.com> <12984.1162549621@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Karl MacMillan <kmacmill@redhat.com>, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 03 Nov 2006 15:23:33 +0000
Message-ID: <22908.1162567413@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> It is not as if we care about an extra context switch here,

Avoiding context switches aren't the main problem; avoiding serialisation is.

> and we really don't want to do that file i/o in the context of the rpciod
> process if we can avoid it.

We aren't doing file I/O in the context of the rpciod process, at least not to
the cache.  It's either done in the context of the process that issued the
read, write or pagefault.  keventd handles the copying of data from the backing
file pages to the netfs pages when we satisfy a read from the cache.

> It might be nice to be able to do those calls that only involve lookup+read
> in the context of the user's process in order to avoid the context switch
> when paging in data from the cache,

We do most of both in the user's process's context already.

The security problems come from the lookups, creates, xattr ops that we have to
do when acquiring a cookie.  All of these are done in the context of the
process that called iget5 for NFS.  We could farm them out to another process
to avoid the security, but that would then cause serialisation and context
switches.

> but writing to it both can and should be done as a write-behind process.
> 
> IOW: we should rather set up a separate workqueue to write data to disk,
> and just concentrate on working out a way to lookup and read data with
> no fsuid/fsgid changes and preferably a minimum of selinux magic.

Writing data to the cache is done by the pagecache at the moment.  I'd really
like to use direct I/O instead as that'd mean I wouldn't need shadow pages in
the page cache and I'd also be able to avoid the page-to-page copy I'm
currently doing.

David
