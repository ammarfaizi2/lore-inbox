Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTD3Rzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTD3Rzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:55:50 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:28838 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262271AbTD3RzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:55:10 -0400
Date: Wed, 30 Apr 2003 14:07:00 -0400
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       chas williams <chas@locutus.cmf.nrl.navy.mil>, torvalds@transmeta.com,
       viro@math.psu.edu, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430180659.GA29107@delft.aura.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@warthog.cambridge.redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	torvalds@transmeta.com, viro@math.psu.edu,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20030430160239.A8956@infradead.org> <27889.1051716620@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27889.1051716620@warthog.warthog>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:30:20PM +0100, David Howells wrote:
> The four calls implemented by Linux are:
> 
>  (*) int setpag(void)
> 
>      Set Process Authentication Group number. This could easily be moved into
>      the kernel proper, with the PAG being stored in or depending from the
>      task structure somehow.
> 
>      This would then obviate the need for OpenAFS to mangle the setgroups and
>      getgroups syscalls.

Has been proposed many times in the context of Coda. Perhaps now that
there are 2 filesystems in the tree that want something like this we can
afford the extra int in the task structure. More likely we'll just have
to wait patiently for a credentials cache, or task ornaments, or
something might be possible with the LSM framework.

>  (*) int pioctl(const char *path, int cmd, void *arg, int followsymlink)
> 
>      Al Viro's favourite:-) Do ioctl() on a file refered to by pathname. Can't
>      be emulated by open/ioctl/close because:
> 
>      (a) it can operate directly on symbolic links.
>      (b) some of its functions don't require a file and don't fail if one
> 	 can't be opened.

Coda has the same abomination, but we use an ioctl on a special file in
the root of the Coda tree (/coda/.CONTROL). The advantage of this is
that if we have multiple clients and mountpoints we know which client is
supposed to handle the pioctl.

>  (*) int afs_call(...)
>  (*) int afs_icl(...)

We don't have anything like that, and most likely just stuffed them
into the pioctl multiplexor.

> There are six more which linux doesn't actually support, even though the
> multiplexor does:
> 
>  (*) icreate
>  (*) iopen
>  (*) idec
>  (*) iinc
>  (*) iread
>  (*) iwrite
> 
>      Deal with file by inode number.

You don't want to do that anyways, it will only work reliably on a few
filesystems. ReiserFS can possibly have inode collisions which are
resolved based on the parent directory inode. ext3 only journals writes
when a filehandle is closed, so opening by inode, writing to it and
closing it doesn't trigger a journal update. ramfs and tmpfs really
don't have any usable underlying inodes that can be opened with a
device/inode number pair because there is no 'device'.

Jan
