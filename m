Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUC2X7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUC2X7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:59:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36767 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263191AbUC2X7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:59:01 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
	<20040327214238.GA23893@mail.shareable.org>
	<m1ptax97m6.fsf@ebiederm.dsl.xmission.com>
	<m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
	<20040328122242.GB32296@mail.shareable.org>
	<m14qs8vipz.fsf@ebiederm.dsl.xmission.com>
	<20040328235528.GA2693@mail.shareable.org>
	<m1zna0tp55.fsf@ebiederm.dsl.xmission.com>
	<20040329123658.GA4984@mail.shareable.org>
	<m18yhjh2d4.fsf@ebiederm.dsl.xmission.com>
	<20040329230537.GA8568@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Mar 2004 16:58:33 -0700
In-Reply-To: <20040329230537.GA8568@mail.shareable.org>
Message-ID: <m1u107fbo6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > So I see a problem with Scenario C.   Perhaps you can refute it.
> 
> Ick.  You're right.  I cannot refute it.

The upside is since we can't it makes the implementation much easier :)
 
> Fwiw, I would have broken the directory cows on the first write, not
> the open.

I did it only so that programs do not see inode numbers change under
them.  For the copy that gets the original inode numbers delaying
until write is fine, for the copy with the new inode numbers to avoid
surprises you need to break the cow on the directory and move it to
the files on readdir, stat, and open.
 
> Thus, snapshots using lazy directory copies requires either that there
> are no hard links of the type you described (e.g. when snapshotting
> the root of the filesystem), or rather complex metadata to track the
> hard links, not dissimilar to the metadata needed to preserve hard
> links _within_ the snapshot.  They both seem far too complex to be worth it.

Agreed.
 
> Hard links just don't play well with lazy cowlinked directories.
>
> They are fine with non-lazy directory cowlinking, where the whole
> directory tree is duplicated and only files are cow'd.  Note that this
> doesn't apply to the original implementation which used hard links
> with a special flag: maintaining hard links in conjunction with
> cowlinks requires the inode duplication we've been talking about.

? The problem is lazy propagation of the cow flag.  The implementation
for ordinary files does not matter.  Only the implementation
for directories matters.
 
> Btw, if we have cowlinks implemented using inode duplication, then it
> isn't necessary for both inodes to have the same metadata such as
> mtime, ctime, mode etc.  Only the data is shared.  That means the
> sendfile() system call could conceivably be overloaded, meaning to
> copy the data, and let "cp --cow" decide whether it wants to copy the
> metadata (same as as "cp -rp" or "cp -rpd"), or not (same as "cp -r").

Sendfile feels about right but it has a few issues that complication
something like this.  It works on file descriptors, and it takes
a length parameter.

There is a lot of room for things to go wrong when implementing
cowlink(const char *oldname, const char *newname) in user space.

Since the semantics are a delayed sendfile in other ways sendfile
feels like a good fit.

Eric

