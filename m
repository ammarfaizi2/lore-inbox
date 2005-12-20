Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVLTRAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVLTRAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVLTRAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:00:06 -0500
Received: from mail.shareable.org ([81.29.64.88]:48615 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1750750AbVLTRAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:00:04 -0500
Date: Tue, 20 Dec 2005 16:59:39 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, hch@lst.de, akpm@osdl.org,
       davem@redhat.com, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] New iovec support & VFS changes
Message-ID: <20051220165939.GA16465@mail.shareable.org>
References: <1135095487.19193.90.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135095487.19193.90.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> I was trying to add support for preadv()/pwritev() for threaded
> databases. Currently the patch is in -mm tree.
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-
> rc5/2.6.15-rc5-mm3/broken-out/support-for-preadv-pwritev.patch
> 
> This needs a new set of system calls. Ulrich Drepper pointed out
> that, instead of adding a system call for the limited functionality
> it provides, why not we add new iovec interface as follows (offset-per-
> segment) which provides greater functionality & flexibility.
> 
> +struct niovec
> +{
> +	void __user *iov_base;
> +	__kernel_size_t iov_len;
> +	__kernel_loff_t iov_off; /* NEW */
> +};

For a database, it's also helpful to know when an operation is going
to block on I/O (i.e. because the data isn't cached, or write buffers
full) and if that's going to happen, move it to another thread, or
move other operations to another thread.  This allows a program to
continue to work on other things concurrently with I/O more
effectively than thread pool guesswork.

So if you add these new syscalls, it would be helpful to add a "flags"
argument to each of them, and define one flag: "don't block on I/O".
When the flag is set, the syscalls should do as much reading or
writing as they can without blocking, and then return the count, or
EAGAIN.

(FreeBSD's sendfile() has an SF_NODISKIO flag which means this, and it
is used in exactly that way: so a program can move the sendfile() to
another thread iff that is necessary to avoid blocking the program.)

There's also a case for making these into async I/O operations.
However, if there is any possibility of async I/O blocking a task for
a long time (which there is with Linux async I/O apparently), that is
not half as useful as a flag to stop I/O when it would block, and let
the program decide what to do.

I mention this precisely because it's relevant to I/O performance of
databases and similar programs, and therefore a reason to have a
"flags" argument to these new syscalls, even if no flags are defined
at first.

-- Jamie
