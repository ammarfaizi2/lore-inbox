Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030665AbWKOQmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030665AbWKOQmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030669AbWKOQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:42:19 -0500
Received: from pat.uio.no ([129.240.10.15]:59320 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030665AbWKOQmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:42:18 -0500
Subject: Re: Security issues with local filesystem caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <25967.1163604494@redhat.com>
References: <1163599542.5691.84.camel@lade.trondhjem.org>
	 <1162575034.5629.24.camel@lade.trondhjem.org>
	 <1162561291.5635.64.camel@lade.trondhjem.org>
	 <1162502667.6071.66.camel@lade.trondhjem.org>
	 <1162496968.6071.38.camel@lade.trondhjem.org>
	 <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
	 <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com> <25037.1162487801@redhat.com>
	 <32754.1162499917@redhat.com> <12984.1162549621@redhat.com>
	 <22908.1162567413@redhat.com> <11957.1163532168@redhat.com>
	 <25967.1163604494@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 11:41:11 -0500
Message-Id: <1163608871.5691.159.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.199, required 12,
	autolearn=disabled, AWL 1.66, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 15:28 +0000, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > No. All you should need is the result of the lookup().
> 
> Plus the mkdirs, etc., but I'll assume you implied those.

No! The success or failure of the NFS operation does _not_ depend on
CacheFiles success or failure. As far as I'm concerned, the mkdirs etc
actually _want_ to be farmed out to some background daemon so that they
have no effect on NFS performance. See below.

> > The coherency data needs to be checked against an eventual existing
> > CacheFiles entry during the call to read(), not before.
> 
> Or mmap().
> 
> But, yes, whilst that's true; the read() is almost certainly going to occur
> very quickly after the open(), and so the likelyhood is that asynchronicity is
> not going to matter.

In the event of a mkdir() or create(), asynchronicity _does_ make a
difference, because there is no cached file to read.

> > Umm...because the former is a model which actually fits your security
> > requirements (i.e. one privileged daemon gets lookup()+open()+mkdir()...
> > rights on the CacheFiles partition), whereas the latter is not (all
> > tasks need lookup()+open()+mkdir().... privileges)?
> 
> The former model is much more complex than the latter, and also has perfomance
> issues.

See below.

> Besides, the latter model seems to work for me (as long as I'm allowed to
> change the security ID a process is acting as).
> 
> > > If so, that'd be nfs_readpage_to_fscache() as called from
> > > nfs_readpage_sync() or nfs_readpage_release().
> > 
> > nfs_readpage_release() is an rpciod context, _not_ a user thread
> > context.
> 
> But it *is* process context...

No. It has whole a bunch of restrictions that normal process contexts do
not.

> I'm not sure what to do about that.  I could maintain a record of every page
> being serviced by FS-Cache, but that could be an awful lot of pages, and so
> consume an awful lot of memory.
> 
> I'm hesitant about allocating memory to hold a list of pages in that context as
> it might fail.

All that you want to _try_ to ensure is that the page gets written out
before the memory shrinker kicks it out of the page cache. There is
absolutely no need to do this synchronously. There is not even a need to
guarantee that all read pages will hit fscache.

Again, this is something that a background daemon could happily do for
you.

> > > However, that may do other disk accesses, I suppose, as it calls
> > > prepare_write() and commit_write() on ext3.
> > 
> > Which would generally be forbidden under the rpciod context, BTW, since
> > they imply calls to generic memory allocation (== nasty tricksy deadlock
> > potential, since rpciod may be called upon to help write out NFS pages
> > via shrink_page_list and friends).
> 
> I wish you'd mentioned that six months or more ago when I first waved these
> patches in front of you.
> 
> > > vfs_mkdir() is synchronous.  vfs_create() is synchronous.  vfs_[sg]etxattr
> > > is synchronous.  Lookup is synchronous.
> > 
> > All of them are synchronous as far as accessing the remote filesystem is
> > concerned.
> 
> What has "accessing the remote filesystem" got to do with it?
> 
> > Why would the user process care if a privileged daemon has completed the
> > shadow mkdir() or create() on the CacheFiles system or not?

It doesn't, and that is my point. If the fscache backing store doesn't
have the file, then the user process wants to talk to the remote server
ASAP. It doesn't want to waste its time creating CacheFiles.

> Sigh.
> 
> The user process may not do a read() or an mmap() on a read-only file it has
> just opened until we've found the data storage object in the cache associated
> with that file, or it has created one.

'or it has created one' is a completely artificial bottleneck that _you_
are imposing.

> However, several user processes may be accessing several different files on
> serveral different mounts of maybe several different netfs's all at the same
> time.  This could mean that on behalf of each of these processes, CacheFiles
> has to create serveral directories and a file.
> 
> But it may only have one thread in which to do this, and so each "cache lookup"
> will wind up being serialised around the synchronous ext3 operations that
> create files and directories and set xattrs.  Consider:
> 
> 	SERVICE	PROC A	PROC B	PROC C	PROC D
> 	=======	=======	=======	=======	=======
> 		open()	open()	open()	open()
> 	A:lookup()
> 	A:mkdir()
> 	A:setxattr()
> 	A:mkdir()
> 	A:setxattr()
> 	A:mkdir()
> 	A:setxattr()
> 	A:mkdir()
> 	A:setxattr()
> 	A:mkdir()
> 	A:setxattr()
> 	A:create()
> 	A:setxattr()
> 		read()
> 	B:lookup()
> 	B:mkdir()
> 	B:setxattr()
> 	B:mkdir()
> 	B:setxattr()
> 	B:mkdir()
> 	B:setxattr()
> 	B:mkdir()
> 	B:setxattr()
> 	B:mkdir()
> 	B:setxattr()
> 	B:create()
> 	B:setxattr()
> 			read()
> 	C:lookup()
> 	C:mkdir()
> 	C:setxattr()
> 	C:mkdir()
> 	C:setxattr()
> 	C:mkdir()
> 	C:setxattr()
> 	C:mkdir()
> 	C:setxattr()
> 	C:mkdir()
> 	C:setxattr()
> 	C:create()
> 	C:setxattr()
> 				read()
> 	D:lookup()
> 	D:mkdir()
> 	D:setxattr()
> 	D:mkdir()
> 	D:setxattr()
> 	D:mkdir()
> 	D:setxattr()
> 	D:mkdir()
> 	D:setxattr()
> 	D:mkdir()
> 	D:setxattr()
> 	D:create()
> 	D:setxattr()
> 					read()
> 
> Which is what you're suggesting.  Whereas what I have at the moment is this:

No. Why the hell should read() have to wait on what it knows to be an
empty file? As soon as that lookup() is done you can figure out that the
data is not cached, and that the read() needs to go talk to the NFS
server.
There is no reason whatsoever to wait for 50 synchronous mkdir()s and
setxattr()s to complete. Those operations can and should be farmed out
to a background process to take care of.
The ideal model looks like


        PROC A          PROC B          PROC C          PROC D
        =============== =============== =============== =============== 
        open()          open()          open()          open()
        A:lookup()      B:lookup()      C:lookup()      D:lookup()
        read()          read()          read()          read()

irrespective of whether or not fscache has a stored file.


