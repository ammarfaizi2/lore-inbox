Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKDQzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKDQzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKDQzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:55:52 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:42953
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750711AbVKDQzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:55:51 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Date: Fri, 4 Nov 2005 10:55:33 -0600
User-Agent: KMail/1.8
Cc: jblunck@suse.de, linux-kernel@vger.kernel.org
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk>
In-Reply-To: <20051104115101.GH7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041055.33882.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 05:51, Al Viro wrote:
> On Fri, Nov 04, 2005 at 12:38:51PM +0100, jblunck@suse.de wrote:
> > This patch effects all users of libfs' dcache directory implementation.
> >
> > Old glibc implementations (e.g. glibc-2.2.5) are lseeking after every
> > call to getdents(), subsequent calls to getdents() are starting to read
> > from a wrong f_pos, when the directory is modified in between. Therefore
> > not all directory entries are returned. IMHO this is a bug and it breaks
> > applications, e.g. "rm -fr" on tmpfs.
> >
> > SuSV3 only says:
> > "If a file is removed from or added to the directory after the most
> > recent call to opendir() or rewinddir(), whether a subsequent call to
> > readdir_r() returns an entry for that file is unspecified."
>
> IOW, the applications in question are broken since they rely on unspecified
> behaviour, not provided by old libc versions.

Are you sure that's the problem?

Directory starts with 26 files named A-F.
Reading through directory starts at A, makes it to J (position 10).
File B gets deleted.
directory reading continues at new position 11, which is now L.

So directory read returns A-J, L-Z, and never returns K even though K didn't 
change.

The "that file" mentioned by SuSv3 above would be _B_ here.  Not K.  K didn't 
change.

That said, I'm pretty sure it's the old libc behavior that's defective.  If a 
new entry B' had been inserted instead, the directory traversal would have 
seen L twice.  Iterating by position is just wrong...

Rob
