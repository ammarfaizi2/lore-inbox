Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbVKDPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbVKDPKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVKDPKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:10:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:45724 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932740AbVKDPKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:10:35 -0500
Date: Fri, 4 Nov 2005 16:11:04 +0100
From: jblunck@suse.de
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104151104.GA22322@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Miklos Szeredi wrote:

> > As I said: "Old glibc implementations (e.g. glibc-2.2.5) are
> > lseeking after every call to getdents() ..."
> 
> Hmm, why would it do that?  This seems like it's glibc being stupid.
> 

Well, glibc is that stupid and triggers the bug.

> That said, you are right that the libfs readdir implementation is not
> strictly standards conforming.  But neither is your patch: this
> algorithm will break if the entry at the current position is removed
> and then a new entry with the same name is created.

True. Seeking to that offset should at least fail and shouldn't stop at the
new entry. But SuSV3 says that the offset given by telldir() is valid until
the next rewinddir().  This is no problem for directories that can only grow.
I tried to implement some kind of deferred dput'ing of the d_child's but that
was too hackish and was wasting memory. So the best thing I can do now is fail
if someone wants to seek to an offset of an already unlinked file.

So I can include the inode number in the hashing process somehow. Any ideas on
that one?

> Unfortunately I can't since I don't have such old glibc.

The testcase is similar to what "rm *" with the old glibc would do. It just
a testcase to show where the problem is.
