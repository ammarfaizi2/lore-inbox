Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUC2XF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUC2XF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:05:58 -0500
Received: from mail.shareable.org ([81.29.64.88]:45459 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263246AbUC2XFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:05:43 -0500
Date: Tue, 30 Mar 2004 00:05:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040329230537.GA8568@mail.shareable.org>
References: <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com> <20040327214238.GA23893@mail.shareable.org> <m1ptax97m6.fsf@ebiederm.dsl.xmission.com> <m1brmhvm1s.fsf@ebiederm.dsl.xmission.com> <20040328122242.GB32296@mail.shareable.org> <m14qs8vipz.fsf@ebiederm.dsl.xmission.com> <20040328235528.GA2693@mail.shareable.org> <m1zna0tp55.fsf@ebiederm.dsl.xmission.com> <20040329123658.GA4984@mail.shareable.org> <m18yhjh2d4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18yhjh2d4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> So I see a problem with Scenario C.   Perhaps you can refute it.

Ick.  You're right.  I cannot refute it.

Fwiw, I would have broken the directory cows on the first write, not
the open.

Thus, snapshots using lazy directory copies requires either that there
are no hard links of the type you described (e.g. when snapshotting
the root of the filesystem), or rather complex metadata to track the
hard links, not dissimilar to the metadata needed to preserve hard
links _within_ the snapshot.  They both seem far too complex to be worth it.

Hard links just don't play well with lazy cowlinked directories.

They are fine with non-lazy directory cowlinking, where the whole
directory tree is duplicated and only files are cow'd.  Note that this
doesn't apply to the original implementation which used hard links
with a special flag: maintaining hard links in conjunction with
cowlinks requires the inode duplication we've been talking about.

Btw, if we have cowlinks implemented using inode duplication, then it
isn't necessary for both inodes to have the same metadata such as
mtime, ctime, mode etc.  Only the data is shared.  That means the
sendfile() system call could conceivably be overloaded, meaning to
copy the data, and let "cp --cow" decide whether it wants to copy the
metadata (same as as "cp -rp" or "cp -rpd"), or not (same as "cp -r").

-- Jamie
