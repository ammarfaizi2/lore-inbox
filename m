Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVLTSIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVLTSIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVLTSIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:08:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:61663 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750768AbVLTSID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:08:03 -0500
Subject: Re: [RFC][PATCH] New iovec support & VFS changes
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Al Viro <viro@ftp.linux.org.uk>, hch@lst.de, akpm@osdl.org,
       davem@redhat.com, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43A846A1.4080007@argo.co.il>
References: <1135095487.19193.90.camel@localhost.localdomain>
	 <43A846A1.4080007@argo.co.il>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 10:08:33 -0800
Message-Id: <1135102113.19193.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 20:00 +0200, Avi Kivity wrote:
> Badari Pulavarty wrote:
> 
> >I was trying to add support for preadv()/pwritev() for threaded
> >databases. Currently the patch is in -mm tree.
> >
> >http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-
> >rc5/2.6.15-rc5-mm3/broken-out/support-for-preadv-pwritev.patch
> >
> >This needs a new set of system calls. Ulrich Drepper pointed out
> >that, instead of adding a system call for the limited functionality
> >it provides, why not we add new iovec interface as follows (offset-per-
> >segment) which provides greater functionality & flexibility.
> >
> >+struct niovec
> >+{
> >+	void __user *iov_base;
> >+	__kernel_size_t iov_len;
> >+	__kernel_loff_t iov_off; /* NEW */
> >+};
> >
> >In order to support this, we need to change all the file_operations
> >(readv/writev) and its helper functions to take this new structure.
> >
> >I took a stab at doing it and I want feedback on whether this is
> >acceptable. All the patch does - is to make kernel use new structure,
> >but the existing syscalls like readv()/writev() still deals with
> >original one to keep the compatibility. (pipes and sockets need 
> >changing too - which I have not addressed yet).
> >
> >Is this the right approach ?
> >
> >  
> >
> You can io_submit() a list of IO_CMD_PREAD[V]s and immediately 
> io_getevents() them. In addition to specifying different file offsets 
> you can mix reads and writes, mix file descriptors, and reap nonblocking 
> events quickly (by specifying a timeout of zero).
> 
> Sure, it's two syscalls instead of one, but it's much more flexibles, 
> and databases should be using aio anyway. Oh, and no kernel changes 
> needed, apart from merging vectored aio.


Yes. We discussed this also earlier. Using AIO is the alternative.
But using AIO is not simple as doing preadv()/pwritev() for the
applications doesn't care about using AIO. AIO needs extra coding
to setup context, iocb, submits and getevents etc..

And also, inside the kernel - AIO requests go through lots of
code/routines -- before coming to ->aio_read() -- which I was
planning to avoid by having a direct syscall to do preadv/pwritev.

BTW, we still don't have vectored AIO support in the kernel.
Zack is working on it - which would add another set of
file operations aio_readv/aio_writev.

Thanks,
Badari

