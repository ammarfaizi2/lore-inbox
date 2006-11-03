Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753397AbWKCRbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbWKCRbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbWKCRbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:31:13 -0500
Received: from pat.uio.no ([129.240.10.4]:8422 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1753397AbWKCRbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:31:11 -0500
Subject: Re: Security issues with local filesystem caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <22908.1162567413@redhat.com>
References: <1162561291.5635.64.camel@lade.trondhjem.org>
	 <1162502667.6071.66.camel@lade.trondhjem.org>
	 <1162496968.6071.38.camel@lade.trondhjem.org>
	 <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
	 <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com> <25037.1162487801@redhat.com>
	 <32754.1162499917@redhat.com> <12984.1162549621@redhat.com>
	 <22908.1162567413@redhat.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 12:30:34 -0500
Message-Id: <1162575034.5629.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.55, required 12,
	autolearn=disabled, AWL 1.45, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 15:23 +0000, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > It is not as if we care about an extra context switch here,
> 
> Avoiding context switches aren't the main problem; avoiding serialisation is.

Why? It is a backing cache. The only case where serialisation ought to
bother you is the case where the client has to invalidate the cache due
to a server-side update of the file.

> > and we really don't want to do that file i/o in the context of the rpciod
> > process if we can avoid it.
> 
> We aren't doing file I/O in the context of the rpciod process, at least not to
> the cache.  It's either done in the context of the process that issued the
> read, write or pagefault.

Once the RPC calls have been launched, the process returns to the VM
layer and just waits for the next page to be unlocked. It never returns
to the filesystem layer. So where are you using the process context to
write out the cached data?

> The security problems come from the lookups, creates, xattr ops that we have to
> do when acquiring a cookie.  All of these are done in the context of the
> process that called iget5 for NFS.  We could farm them out to another process
> to avoid the security, but that would then cause serialisation and context
> switches.

The cookie lookups need to be synchronous, but why would the file
creation need to be synchronous? Creating the cachefs file and waiting
on that to complete etc are all utterly useless activities as far as
satisfying the user request for data goes. Just start the process of
creating a backing file, and then get on with the actual syscall.

> Writing data to the cache is done by the pagecache at the moment.  I'd really
> like to use direct I/O instead as that'd mean I wouldn't need shadow pages in
> the page cache and I'd also be able to avoid the page-to-page copy I'm
> currently doing.

Agreed.

Trond

