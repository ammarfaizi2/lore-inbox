Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWCXXrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWCXXrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWCXXrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:47:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932284AbWCXXrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:47:09 -0500
Date: Fri, 24 Mar 2006 15:49:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berkeley.edu
Subject: Re: eCryptfs Design Document
Message-Id: <20060324154920.11561533.akpm@osdl.org>
In-Reply-To: <20060324222517.GA13688@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:
>
> On Fri, Nov 18, 2005 at 10:16:59PM -0800, Andrew Morton wrote:
> > If Linux is going to offer a feature like this then people have to
> > be able to trust it to be quite secure.  What we don't want to
> > happen is to distribute it for six months and then be buried in
> > reports of vulnerabilites from cryptography specialists.  Even worse
> > if those reports lead to exploits.
> >
> > So I guess what I'm asking is: has this code been reviewed by crypto
> > experts?  Bearing in mind that it'll be world-class crypto people
> > who will try to poke holes in it.
> 
> 
> ...
> The PDF document is obtainable from the eCryptfs SourceForge file
> download section:
> 
> http://sourceforge.net/project/showfiles.php?group_id=133988
>
> I also have it posted on the eCryptfs web site:
> 
> http://ecryptfs.sourceforge.net/ecryptfs_design_doc_v0_1.pdf

Helps, thanks.

> ...
>
> 3.2.3 Page Read
> 
> ...
> 
> On a page read, the eCryptfs page index is interpolated into the
> corresponding lower page index, taking into account the header page in
> the file.

I trust that PAGE_CACHE_SIZE is not implicitly encoded into the file layout?

> ...
> When a writepage() request comes through as a result of a VFS syscall,
> eCryptfs will read the target extent from the lower file using the
> process described in the prior paragraph. The data on that page is
> modified according to the write request. The entire (modified) page is
> re-encrypted (again, in CBC mode) with the same IV and key that were
> used to originally encrypt the page; the newly encrypted page is then
> written out to the lower file.

So ecryptfs files have their own plain-text pagecache, which is backed by
the underlying file's encrypted pagecache.  Passing through things like
fsync() will be interesting.  We get that wrong for loop at present.

hm.  The above write() description doesn't sound right.  The read+decrypt
from the underlying fs should happen at ->prepare_write(), not at
->writepage().  And it can be elided if ->prepare_write() is about to write
the whole page, and if the underlying fs's blocksize is less than or equal
to the ecryptfs's blocksize.

Or something like that.  The way this document talks about a file's "page
size" is a worry.  Files have block sizes, and they're <= PAGE_CACHE_SIZE,
so the files are portable between different PAGE_SIZE setups.

Anyway, I'll stop trying to review the code without the code.



One dutifully wonders whether all this functionality could be provided via
FUSE...

