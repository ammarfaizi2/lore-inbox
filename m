Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWJaJk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWJaJk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422914AbWJaJk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:40:26 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:47969 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422796AbWJaJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:40:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YXh/cqFd72sdNljlpfZgose3bi+fs0zfWO+gRCoDVzZ+YuxmjUTRnx6RXA55wGlLZXF1/KZ3eI9bEy5HqAg2vClSmWCcVXYhwe0f943nNiUCBeczwYV7mz287g4wFUmFjMBjHw2Qy4tHDvOxPaDJ02vSH9nTzbMHApxOea+cF/0=  ;
Message-ID: <45471A05.20205@yahoo.com.au>
Date: Tue, 31 Oct 2006 20:40:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
References: <1162199005.24143.169.camel@taijtu> <20061030224802.f73842b8.akpm@osdl.org> <4546FA81.1020804@cosmosbay.com>
In-Reply-To: <4546FA81.1020804@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> This patch deletes two calls to smp_mb() that were done after 
> mutex_unlock() that contains an implicit memory barrier.

Uh, there is nothing that says mutex_unlock or any unlock
functions contain an implicit smp_mb(). What is given is that the
lock and unlock obey aquire and release memory ordering,
respectively.

a = x;
xxx_unlock
b = y;

In this situation, the load of y can be executed before that of x.
And some architectures will even do so (i386 can, because the
unlock is an unprefixed store; ia64 can, because it uses a release
barrier in the unlock).

Whenever you rely on orderings of things *outside* locks (even
partially outside), you do need to be very careful about barriers
and can't rely on locks to do the right thing for you.

> 
> The first one in splice_to_pipe(), where 'do_wakeup' is set to true only 
> if pipe->inode is set (and in this case the
> if (pipe->inode)
>    mutex_unlock(&pipe->inode->i_mutex);
> is done too)
> 
> The second one in link_pipe(), following inode_double_unlock() that 
> contains calls to mutex_unlock() too.

It *may* be the case that these can be removed, but not by virtue
of the fact that the smp_mb is redundant.

> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux/fs/splice.c	2006-10-31 07:49:52.000000000 +0100
> +++ linux-ed/fs/splice.c	2006-10-31 08:04:58.000000000 +0100
> @@ -248,7 +248,6 @@
>  		mutex_unlock(&pipe->inode->i_mutex);
>  
>  	if (do_wakeup) {
> -		smp_mb();
>  		if (waitqueue_active(&pipe->wait))
>  			wake_up_interruptible(&pipe->wait);
>  		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> @@ -1518,7 +1517,6 @@
>  	 * If we put data in the output pipe, wakeup any potential readers.
>  	 */
>  	if (ret > 0) {
> -		smp_mb();
>  		if (waitqueue_active(&opipe->wait))
>  			wake_up_interruptible(&opipe->wait);
>  		kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
