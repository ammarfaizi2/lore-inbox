Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291086AbSCDDLB>; Sun, 3 Mar 2002 22:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291088AbSCDDKk>; Sun, 3 Mar 2002 22:10:40 -0500
Received: from tapu.f00f.org ([66.60.186.129]:49805 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S291086AbSCDDK3>;
	Sun, 3 Mar 2002 22:10:29 -0500
Date: Sun, 3 Mar 2002 19:10:23 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [bkpatch] add sys_sendfile64
Message-ID: <20020304031023.GA14757@tapu.f00f.org>
In-Reply-To: <20020303161818.A18187@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020303161818.A18187@redhat.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 04:18:18PM -0500, Benjamin LaHaise wrote:

    The below bitkeeper patch can be pulled from
    	bk://bcrlbits.bkbits.net/linux-2.5

    and adds a sys_sendfile64 call.  Arch maintainers should 
    probably add the entry to their syscall tables if it is 
    appropriate.

Neat.  I made something similar last night but messed it up originally
so never sent it.

    +
    +asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
    +{
    +	loff_t pos, *ppos = NULL;
    +	ssize_t ret;
    +	if (offset) {
    +		off_t off;
    +		if (unlikely(get_user(off, offset)))
    +			return -EFAULT;
    +		pos = off;
    +		ppos = &pos;

We have a problem if off + count >= 2^32 here.

Ideally i think we need to check for 32-bit (31-bit?) overflow here
and return -EOVERFLOW.  I made a similar patch last night for
sendfile64 which included this check (although I was tired and the
patch was slightly wrong).  Actually, I think wew are missing
EOVERFLOW checks in a number of paths, ideally I'd like to make one
function to check and have all other functions reference that if
people agree that makes sense.

    +	}
    +	ret = common_sendfile(out_fd, in_fd, ppos, count);
    +	if (offset)
    +		put_user((off_t)pos, offset);
    +	return ret;

What is another thread unmapped 'offset' during the system call?  Do
we want to check the result of put_user here and return -EFAULT?
(If so, there are other system calls to consider such as select).




  --cw
