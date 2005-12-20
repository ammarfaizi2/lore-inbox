Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVLTSUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVLTSUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVLTSUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:20:37 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:55561 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750829AbVLTSUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:20:36 -0500
Message-ID: <43A84B70.4050304@argo.co.il>
Date: Tue, 20 Dec 2005 20:20:32 +0200
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
References: <1135095487.19193.90.camel@localhost.localdomain>	 <43A846A1.4080007@argo.co.il> <1135102113.19193.118.camel@localhost.localdomain>
In-Reply-To: <1135102113.19193.118.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2005 18:20:35.0132 (UTC) FILETIME=[11F5BFC0:01C60592]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

>On Tue, 2005-12-20 at 20:00 +0200, Avi Kivity wrote:
>  
>
>>You can io_submit() a list of IO_CMD_PREAD[V]s and immediately 
>>io_getevents() them. In addition to specifying different file offsets 
>>you can mix reads and writes, mix file descriptors, and reap nonblocking 
>>events quickly (by specifying a timeout of zero).
>>
>>Sure, it's two syscalls instead of one, but it's much more flexibles, 
>>and databases should be using aio anyway. Oh, and no kernel changes 
>>needed, apart from merging vectored aio.
>>    
>>
>
>
>Yes. We discussed this also earlier. Using AIO is the alternative.
>But using AIO is not simple as doing preadv()/pwritev() for the
>applications doesn't care about using AIO. AIO needs extra coding
>to setup context, iocb, submits and getevents etc..
>  
>
Possibly a library can do that (placing the context in thread local 
storage), but I see your point.

>And also, inside the kernel - AIO requests go through lots of
>code/routines -- before coming to ->aio_read() -- which I was
>planning to avoid by having a direct syscall to do preadv/pwritev.
>  
>
I'd be surprised if this isn't dominated by the cost of serving the 
request, even from cache.

If we can persuade the aio maintainers to add some flag to io_submit() 
which makes the request synchronous, it would reduce the overhead 
somewhat, but it is against the spirit of aio.

>BTW, we still don't have vectored AIO support in the kernel.
>Zack is working on it - which would add another set of
>file operations aio_readv/aio_writev.
>  
>
Hopefully they will supercede aio_read/aio_write?

BTW, don't databases like using many many files for their backing store? 
The ability to write to many fds in one call should be attractive to them.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

