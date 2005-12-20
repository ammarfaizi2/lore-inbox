Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVLTSAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVLTSAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVLTSAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:00:08 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:32009 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750750AbVLTSAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:00:06 -0500
Message-ID: <43A846A1.4080007@argo.co.il>
Date: Tue, 20 Dec 2005 20:00:01 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Al Viro <viro@ftp.linux.org.uk>, hch@lst.de, akpm@osdl.org,
       davem@redhat.com, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] New iovec support & VFS changes
References: <1135095487.19193.90.camel@localhost.localdomain>
In-Reply-To: <1135095487.19193.90.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2005 18:00:04.0351 (UTC) FILETIME=[345B78F0:01C6058F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

>I was trying to add support for preadv()/pwritev() for threaded
>databases. Currently the patch is in -mm tree.
>
>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-
>rc5/2.6.15-rc5-mm3/broken-out/support-for-preadv-pwritev.patch
>
>This needs a new set of system calls. Ulrich Drepper pointed out
>that, instead of adding a system call for the limited functionality
>it provides, why not we add new iovec interface as follows (offset-per-
>segment) which provides greater functionality & flexibility.
>
>+struct niovec
>+{
>+	void __user *iov_base;
>+	__kernel_size_t iov_len;
>+	__kernel_loff_t iov_off; /* NEW */
>+};
>
>In order to support this, we need to change all the file_operations
>(readv/writev) and its helper functions to take this new structure.
>
>I took a stab at doing it and I want feedback on whether this is
>acceptable. All the patch does - is to make kernel use new structure,
>but the existing syscalls like readv()/writev() still deals with
>original one to keep the compatibility. (pipes and sockets need 
>changing too - which I have not addressed yet).
>
>Is this the right approach ?
>
>  
>
You can io_submit() a list of IO_CMD_PREAD[V]s and immediately 
io_getevents() them. In addition to specifying different file offsets 
you can mix reads and writes, mix file descriptors, and reap nonblocking 
events quickly (by specifying a timeout of zero).

Sure, it's two syscalls instead of one, but it's much more flexibles, 
and databases should be using aio anyway. Oh, and no kernel changes 
needed, apart from merging vectored aio.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

