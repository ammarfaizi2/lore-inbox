Return-Path: <linux-kernel-owner+w=401wt.eu-S1753823AbXABX4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbXABX4N (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbXABX4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:56:13 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:33573 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbXABX4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:56:12 -0500
In-Reply-To: <20061227153855.GA25898@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5A322D46-A73A-43DD-8667-CE218DDA48B0@oracle.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Date: Tue, 2 Jan 2007 15:56:09 -0800
To: suparna@in.ibm.com
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay, I'm finally back from the holiday break :)

> (1) The filesystem AIO patchset, attempts to address one part of  
> the problem
>     which is to make regular file IO, (without O_DIRECT)  
> asynchronous (mainly
>     the case of reads of uncached or partially cached files, and  
> O_SYNC writes).

One of the properties of the currently implemented EIOCBRETRY aio  
path is that ->mm is the only field in current which matches the  
submitting task_struct while inside the retry path.

It looks like a retry-based aio write path would be broken because of  
this.  generic_write_checks() could run in the aio thread and get its  
task_struct instead of that of the submitter.  The wrong rlimit will  
be tested and SIGXFSZ won't be raised.  remove_suid() could check the  
capabilities of the aio thread instead of those of the submitter.

I don't think EIOCBRETRY is the way to go because of this increased  
(and subtle!) complexity.  What are the chances that we would have  
ever found those bugs outside code review?  How do we make sure that  
current references don't sneak back in after having initially audited  
the paths?

Take the io_cmd_epoll_wait patch..

>     issues). The IO_CMD_EPOLL_WAIT patch (originally from Zach  
> Brown with
>     modifications from Jeff Moyer and me) addresses this problem  
> for native
>     linux aio in a simple manner.

It's simple looking, sure.  This current flipping didn't even occur  
to me while throwing the patch together!

But that patch ends up calling ->poll (and poll_table->qproc) and  
writing to userspace (so potentially calling ->nopage) from the aio  
threads.  Are we sure that none of them will behave surprisingly  
because current changed under them?

It might be safe now, but that isn't really the point.  I'd rather we  
didn't have yet one more subtle invariant to audit and maintain.

At the risk of making myself vulnerable to the charge of mentioning  
vapourware, I will admit that I've been working on a (slightly mad)  
implementation of async syscalls.  I've been quiet about it because I  
don't want to whip up complicated discussion without being able to  
show code that works, even if barely.  I mention it now only to make  
it clear that I want to be constructive, not just critical :).

- z
