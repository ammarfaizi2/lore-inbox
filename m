Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSH0WEt>; Tue, 27 Aug 2002 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSH0WEs>; Tue, 27 Aug 2002 18:04:48 -0400
Received: from pat.uio.no ([129.240.130.16]:62159 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317299AbSH0WEr>;
	Tue, 27 Aug 2002 18:04:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: problems with changing UID/GID
Date: Wed, 28 Aug 2002 00:09:03 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm> <shsvg5wqemp.fsf@charged.uio.no> <20020827200110.GB8985@tapu.f00f.org>
In-Reply-To: <20020827200110.GB8985@tapu.f00f.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208280009.03090.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 August 2002 22:01, Chris Wedgwood wrote:
> On Tue, Aug 27, 2002 at 09:35:10PM +0200, Trond Myklebust wrote:
>
>     Locking does absolutely nothing for the problem of checking file
>     access with one set of credentials, and then doing the subsequent file
>     operation with another set of credentials.
>
> Can we not lock creds at the syscall level? Ick... shoot me for saying
> this :)

Ick indeed... That sounds pretty nasty now that we have SMP and preemptive 
kernels.

I've restarted work on the alternative: putting basic BSD ucreds + VFS changes 
in first. It's a lot of work, but I think it will be worth it.

FYI a BSD ucred is basically a structure of the form

struct ucred {
	int	counter;		/* Reference counter */
	uid_t	uid;			/* task->fsuid */
	gid_t	gid;			/* task->fsgid */
	int	ngroups;		/* task->ngroups */
	gid_t	*groups;		/* task->groups */
};

The reference counter + the copy-on-write rule allows you to share it around 
to other parts of the kernel (struct file, low level filesystems, ...). By 
copy-on-write I mean that once it has been shared, nobody is allowed to 
change the values of the data structures (except the reference counter).

Means that you don't need any form of locking for this structure apart from 
perhaps in those rare CLONE_CRED instances when you are actually changing the 
shared ucred in the task_struct for all the threads.

Cheers,
  Trond
