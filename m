Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292375AbSCDOSC>; Mon, 4 Mar 2002 09:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292378AbSCDORm>; Mon, 4 Mar 2002 09:17:42 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26130 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S292375AbSCDORg>; Mon, 4 Mar 2002 09:17:36 -0500
Date: Mon, 4 Mar 2002 09:17:28 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [bkpatch] add sys_sendfile64
Message-ID: <20020304091727.B18187@redhat.com>
In-Reply-To: <20020303161818.A18187@redhat.com> <20020304031023.GA14757@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020304031023.GA14757@tapu.f00f.org>; from cw@f00f.org on Sun, Mar 03, 2002 at 07:10:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 07:10:23PM -0800, Chris Wedgwood wrote:
> We have a problem if off + count >= 2^32 here.
> 
> Ideally i think we need to check for 32-bit (31-bit?) overflow here
> and return -EOVERFLOW.  I made a similar patch last night for
> sendfile64 which included this check (although I was tired and the
> patch was slightly wrong).  Actually, I think wew are missing
> EOVERFLOW checks in a number of paths, ideally I'd like to make one
> function to check and have all other functions reference that if
> people agree that makes sense.

I was just following the semantics of the original code.  -EOVERFLOW 
checks are certainly doable; I'll post an update in a bit.

>     +	}
>     +	ret = common_sendfile(out_fd, in_fd, ppos, count);
>     +	if (offset)
>     +		put_user((off_t)pos, offset);
>     +	return ret;
> 
> What is another thread unmapped 'offset' during the system call?  Do
> we want to check the result of put_user here and return -EFAULT?
> (If so, there are other system calls to consider such as select).

Again, the original code didn't bother checking.  As far as how it 
should work, I'd rather send a segv to the app as otherwise it is 
impossible to determine how much data was actually transferred.

		-ben
