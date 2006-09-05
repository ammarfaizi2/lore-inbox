Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWIEEEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWIEEEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 00:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWIEEEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 00:04:01 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34460 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965140AbWIEEEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 00:04:00 -0400
X-Sasl-enc: 1Rsub9y1YkzCuyMzvXa5LQAWOrivKhP9zM4cOO2yoFdB 1157429038
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157428241.5510.72.camel@localhost>
References: <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <1157421445.5510.13.camel@localhost>
	 <1157424937.3002.4.camel@raven.themaw.net>
	 <1157428241.5510.72.camel@localhost>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 12:03:50 +0800
Message-Id: <1157429030.3915.8.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 23:50 -0400, Trond Myklebust wrote:
> On Tue, 2006-09-05 at 10:55 +0800, Ian Kent wrote:
> > On Mon, 2006-09-04 at 21:57 -0400, Trond Myklebust wrote:
> > > On Mon, 2006-09-04 at 21:24 +0800, Ian Kent wrote:
> > > 
> > > > > [pid  3838] mkdir("/net", 0555)         = -1 EEXIST (File exists)
> > > > > [pid  3838] stat64("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> > > > > [pid  3838] mkdir("/net/trash", 0555)   = -1 EEXIST (File exists)
> > > > > [pid  3838] stat64("/net/trash", {st_mode=S_IFDIR|0555, st_size=1024, ...}) = 0
> > > > > [pid  3838] mkdir("/net/trash/mnt", 0555) = -1 EACCES (Permission denied)
> > > > 
> > > > This is the point I'm trying to make.
> > > > I'm able to reproduce this with exports that don't have "nohide".
> > > > The mkdir used to return EEXIST, possibly before getting to the EACCES
> > > > test. It appears to be a change in semantic behavior and I can't see
> > > > where it is coming from. autofs expects an EEXIST but not an EACCES and
> > > > so doesn't perform the mount. I could ignore the EACCES but that would
> > > > be cheating.
> > > 
> > > Why the hell is it doing a mkdir in the first place? ...and why the hell
> > > is it not able to cope with EACCES? The latter is hardly an unlikely
> > > reply: it means that the automounter should not be doing this in the
> > > first place, 'cos it doesn't have the privileges. That is not the same
> > > as saying that it doesn't have the privileges to do a lookup.
> > 
> > Why the hell shouldn't it be able to do an mkdir!
> 
> Firstly, if the call to mkdir actually _was_ successful, it would be
> creating a new directory on the NFS server, and it would be doing so
> with the automounter's privileges instead of the user's privileges. Why
> would I want it to do that?
> 
> Secondly, and more pertinently to this case, you have no guarantee that
> the automounter has _any_ privileges on the server at all other than
> what is required to mount a filesystem. selinux is enforcing that on the
> client side here, but the server could just as well be set up to do the
> same (in fact, you could set up selinux to do the exact same thing on
> the server).
> 
> IOW, the automounter should just be calling stat('/net/trash/mnt'). It
> shouldn't be trying to create directories on the server at all.

Sure but this is an old version of autofs which is in use so changing
the expected behavior of a system call is not acceptable and I expect
other applications may well have a problem with this also.

> 
> > It is coping with the EACCESS return by not mounting the filesystem
> > which is the correct response in this case.
> 
> No it isn't. The directory exists. It can be looked up. There is no
> reason why you can't mount something on top of it.
> 
> Being permitted to do mkdir() or not has nothing to do with anything.

Agreed.

The fact that it's a mkdir is irrelevant given that nfs_lookup is
returning an EACCESS instead of EEXIST this will likely affect other
system calls such as "stat". I'll check this.



