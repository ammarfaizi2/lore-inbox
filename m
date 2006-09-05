Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWIEEGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWIEEGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 00:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWIEEGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 00:06:23 -0400
Received: from pat.uio.no ([129.240.10.4]:35571 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965141AbWIEEGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 00:06:21 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157425309.3002.10.camel@raven.themaw.net>
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
	 <1157423027.5510.23.camel@localhost>
	 <1157425309.3002.10.camel@raven.themaw.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 00:05:59 -0400
Message-Id: <1157429159.32412.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.003, required 12,
	autolearn=disabled, AWL 2.00, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 11:01 +0800, Ian Kent wrote:
> On Mon, 2006-09-04 at 22:23 -0400, Trond Myklebust wrote:
> > On Mon, 2006-09-04 at 12:52 +0100, David Howells wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > sony:/home/akpm> ls -l /net/bix/usr/src
> > > > total 0
> > > > 
> > > > sony:/home/akpm> showmount -e bix
> > > > Export list for bix:
> > > > /           *
> > > > /usr/src    *
> > > > /mnt/export *
> > > 
> > > Yes, but what's your /etc/exports now?  Not all options appear to showmount.
> > > 
> > > Can you add "nohide" to the /usr/src and /mnt/export lines and "fsid=0" to the
> > > / line if you don't currently have them and try again?
> > > 
> > > > iirc, we decided this is related to the fs-cache infrastructure work which
> > > > went into git-nfs.  I think David can reproduce this?
> > > 
> > > I'd only reproduced it with SELinux in enforcing mode.
> > > 
> > > Under such conditions, unless there's a readdir on the root directory, the
> > > subdirs under which exports exist will remain as incorrectly negative
> > > dentries.
> > > 
> > > The problem is a conjunction of circumstances:
> > > 
> > >  (1) nfs_lookup() has a shortcut in it that skips contact with the server if
> > >      we're doing a lookup with intent to create.  This leaves an incorrectly
> > >      negative dentry if there _is_ actually an object on the server.
> > > 
> > >  (2) The mkdir procedure is aborted between the lookup() op and the mkdir() op
> > >      by SELinux (see vfs_mkdir()).  Note that SELinux isn't the _only_ method
> > >      by which the abort can occur.
> > > 
> > >  (3) One of my patches correctly assigns the security label to the automounted
> > >      root dentry.
> > > 
> > >  (4) SELinux then aborts the automounter's mkdir() call because the automounter
> > >      does _not_ carry the correct security label to write to the NFS directory.
> > > 
> > >  (5) The incorrectly set up dentry from (1) remains because the the mkdir() op
> > >      is not invoked to set it right.
> > > 
> > > The only bit I added was (3), but that's not the only circumstance in which
> > > this can occur.
> > > 
> > > 
> > > If, for example, I do "chmod a-w /" on the NFS server, I can see the same
> > > effects on the client without the need for SELinux to put its foot in the door.
> > > Automount does:
> > > 
> > > [pid  3838] mkdir("/net", 0555)         = -1 EEXIST (File exists)
> > > [pid  3838] stat64("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> > > [pid  3838] mkdir("/net/trash", 0555)   = -1 EEXIST (File exists)
> > > [pid  3838] stat64("/net/trash", {st_mode=S_IFDIR|0555, st_size=1024, ...}) = 0
> > > [pid  3838] mkdir("/net/trash/mnt", 0555) = -1 EACCES (Permission denied)
> > > 
> > > And where I was listing the disputed directory, I see:
> > > 
> > > 	[root@andromeda ~]# ls -lad /net/trash/usr/src
> > > 	drwxr-xr-x 4 root root 1024 Aug 30 10:35 /net/trash/usr/src/
> > > 	[root@andromeda ~]#
> > > 
> > > which isn't what I'd expect.  What I'd expect is:
> > > 
> > > 	[root@andromeda ~]# ls -l /net/trash/usr/src
> > > 	total 15
> > > 	drwxr-xr-x 3 root root  1024 Aug 30 10:35 debug/
> > > 	-rw-r--r-- 1 root root     0 Aug 16 10:01 hello
> > > 	drwx------ 2 root root 12288 Aug 16 10:00 lost+found/
> > > 	[root@andromeda ~]#
> > 
> > One way to fix this is to simply not hash the dentry when we're doing
> > the O_EXCL intent optimisation, but rather to only hash it _after_ we've
> > successfully created the file on the server. Something like the attached
> > patch ought to do it.
> > 
> > Note, though, that this will not fix the autofs problem: autofs is
> > trying to perform a totally unnecessary mkdir(), and is giving up when
> > it is told that SELinux won't authorise that particular operation. This
> > is clearly an autofs bug...
> 
> selinux is not involved in this senario.

Right. David rigged the NFS server to produce the same result as selinux
on autofs. He is demonstrating that autofs is wrong to call mkdir().

As I said above, my patch fixes the problem that David noted in (1)
above, namely that a negative dentry in incorrectly instantiated when
the mkdir() (or other exclusive create) operation fails due to a
permission error.

