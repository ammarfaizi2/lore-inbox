Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUHIPwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUHIPwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUHIPwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:52:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16522 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266703AbUHIPsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:48:05 -0400
Date: Mon, 9 Aug 2004 11:47:48 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>,
       <dwmw2@infradead.org>, <greg@kroah.com>, <chrisw@osdl.org>,
       <sfrench@samba.org>, <mike@halcrow.us>, <trond.myklebust@fys.uio.no>,
       <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management [try #2]
In-Reply-To: <32470.1092062111@redhat.com>
Message-ID: <Xine.LNX.4.44.0408091124460.3322-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, David Howells wrote:

> > I figured you would write to the file (a keyring id?) and it would return 
> > a key id.
> 
> What do you mean by return? You can't pass it back as write()'s return
> value. I suppose you could then arrange for the fd to be read():-/

You write and then read, like the transaction based IO methods in 
selinuxfs (TA_write, TA_read).

> > > What are these? Files containing keyring ID numbers? If so, better to just
> > > have one file from whence you can read all the IDs, and since
> > > /proc/pid/status has to grab the requisite lock anyway...
> > 
> > They would contain symlinks to keyring IDs.
> 
> Yes, but given that the targets of the symlinks would not be in /proc, how do
> you concoct the symlink. I suppose you could assume "/sysfs/keys/<keyid>" as
> the target, but that's not very nice.

Not sure how to do this.

> > > Besides, the search _has_ to be available in kernel space. A filesystem
> > > such as AFS or NFS would need to be able to call it during file->open(),
> > > and maybe at other times. Would you suggest that it should call out to
> > > userspace to do the keyring search?
> > 
> > No.  The reason for suggesting this was because with a filesystem API, the 
> > information is already available in userspace, and it would be quite 
> > simple to enumerate it.  As you said, it's not something that would happen 
> > all the time, so it's not performance critical.  But if you need a kernel 
> > API for the same thing, it's a moot point.
> 
> It would be quite an involved process to do this in userspace. You'd have to
> walk through a nest of keyrings, and you'd have to do a lot of file opening,
> and closing (possibly 2 per key: type and description, though these could be
> available through the same file) and reading of dirs and symlinks.

It might be possible to do clever things with symlinks so that you can 
access the keys simply in a variety of common ways (e.g. per-session 
directory, all keys directory etc.)

> Maintaining access controls would be fun though... How does the kernel then
> distinguish between a read and a search?

I guess you'd use normal filsystem access controls instead of storing them
with the keys themselves.  i.e. keyrings are directories, and keys are
files (or directories with files including metadata and key data).  Then
xattrs could be used to integrate with things like SELinux.  A user could
then use chmod to specify whether a kerying can be searched, for example.

The main point is that a filesystem API provides several useful framework
components by default:access control, creat/open/read/write etc. syscalls,
hierarchical structure and xattrs.  Using a filesystem API means not
inventing yet another class of API.


- James
-- 
James Morris
<jmorris@redhat.com>




