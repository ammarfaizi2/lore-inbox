Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJWQEG>; Wed, 23 Oct 2002 12:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSJWQEG>; Wed, 23 Oct 2002 12:04:06 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:35296 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S262670AbSJWQEF>; Wed, 23 Oct 2002 12:04:05 -0400
Date: Wed, 23 Oct 2002 12:09:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Russell Coker <russell@coker.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <20021023155457.L2732@redhat.com>
Message-ID: <Pine.GSO.4.33.0210231112420.7042-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002, Stephen C. Tweedie wrote:

> Good question --- what is the reason you need these, and are other
> security modules likely to need similar functionality?  If so, there's
> an argument for new syscalls which take a credentials/sid area as a
> return argument.

The extended *stat calls enable applications to obtain file SIDs along
with the regular file status for a variety of purposes, e.g. SELinux
provides patched versions of ls (displaying security contexts to users),
find (searching for files with particular security contexts or displaying
the contexts of files matching the find criteria to users), cp -p and tar
(preserving contexts on copies and in archives), logrotate (preserving
contexts when logs are rotated), and crond (checking the context on a
user-generated crontab spool file to protect against running cron jobs
with a given process SID from a less trusted source).  While you don't
always need to get both the file status and the security attributes for a
given file, you often do for programs like ls, cp, tar, etc.

If we migrate SELinux to using extended attributes to store file security
contexts (pending their merging into 2.5), then we could replace the
extended *stat with getxattr, although getxattr doesn't provide an atomic
way of getting both the regular file status information and the security
attributes for a given file.  Closest approximation to stat_secure() would
be an open(...O_RDONLY), fstat(), fgetxattr(), close() sequence to ensure
that the file status and security attributes are from the same inode, but
this assumes that you can always read the file in order to stat it and
isn't exactly ideal.

For System V IPC and socket IPC, the extended calls enable applications to
obtain security information about the sender and the data so that the
security-aware applications can make security decisions and label data
appropriately.  An extended form of SCM_CREDENTIALS that supports
additional security data and is not limited to local domain sockets [the
SELinux calls work for INET sockets if labeled networking is used] might
be reasonable for socket IPC.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com










