Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVKDPcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVKDPcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVKDPcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:32:48 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:37895 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750793AbVKDPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:32:47 -0500
To: jblunck@suse.de
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-reply-to: <20051104151104.GA22322@hasse.suse.de> (jblunck@suse.de)
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de>
Message-Id: <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 04 Nov 2005 16:32:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > As I said: "Old glibc implementations (e.g. glibc-2.2.5) are
> > > lseeking after every call to getdents() ..."
> > 
> > Hmm, why would it do that?  This seems like it's glibc being stupid.
> > 
> 
> Well, glibc is that stupid and triggers the bug.

Seems to me, the simple solution is to upgrade your glibc.

> > That said, you are right that the libfs readdir implementation is not
> > strictly standards conforming.  But neither is your patch: this
> > algorithm will break if the entry at the current position is removed
> > and then a new entry with the same name is created.
> 
> True. Seeking to that offset should at least fail and shouldn't stop at the
> new entry.

No it should _not_ fail, it should continue from the next _existing_
entry.

> But SuSV3 says that the offset given by telldir() is valid until the
> next rewinddir().  This is no problem for directories that can only
> grow.  I tried to implement some kind of deferred dput'ing of the
> d_child's but that was too hackish and was wasting memory. So the
> best thing I can do now is fail if someone wants to seek to an
> offset of an already unlinked file.
> 
> So I can include the inode number in the hashing process
> somehow. Any ideas on that one?

No good.  Same problem if you move out then move back the entry.

> 
> > Unfortunately I can't since I don't have such old glibc.
> 
> The testcase is similar to what "rm *" with the old glibc would do. It just
> a testcase to show where the problem is.

I understand, but I have glibc-2.3.5 which apparently doesn't seek
after readdir().

Miklos

