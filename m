Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291339AbSAaVqX>; Thu, 31 Jan 2002 16:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291343AbSAaVqN>; Thu, 31 Jan 2002 16:46:13 -0500
Received: from zero.tech9.net ([209.61.188.187]:45324 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291339AbSAaVp7>;
	Thu, 31 Jan 2002 16:45:59 -0500
Subject: Re: [PATCH] 2.5: further llseek cleanup (1/3)
From: Robert Love <rml@tech9.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20020131151917.GA17060@mentor.odyssey.cs.cmu.edu>
In-Reply-To: <1012459512.3213.148.camel@phantasy> 
	<20020131151917.GA17060@mentor.odyssey.cs.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 31 Jan 2002 16:51:57 -0500
Message-Id: <1012513925.3392.175.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-31 at 10:19, Jan Harkes wrote:

> I'm not sure whether the Coda part of this patch is correct. Coda does
> rely in the inode semaphore to protect from concurrency between the
> userspace cachemanager that accesses the file on the host filesystem
> directly and the applications that access the same file through the
> /coda mount.
> 
> See for instance coda_file_write, where we also use the host inode
> semaphore for protection. Only sys_stat() accesses i_size unprotected,
> but that doesn't matter much in my opinion. Any application relying on
> the result of sys_stat to do appending or subsequent lseeks would be
> racy anyways. (and it can only be fixed correctly when we get a FS
> specific getattr method).

Hmm ... the race you mention in sys_stat is the problem I saw.  I also
can't say for sure whether any code, or future code, would touch
i_size.  It is just not safe.

Note also that reverting to the remote_llseek method won't break
anything; it is the previous behavior.  Certainly I would much rather
just use the inode semaphore, but I'd prefer to not introduce any
races.  Ideally we need a solution that eliminates the BKL _and_ is not
racy.

I'd be happy to keep Coda using the new generic_file_llseek if Al Viro
agrees with you.  Al?

	Robert Love

