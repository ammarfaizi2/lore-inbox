Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270855AbRHSWrY>; Sun, 19 Aug 2001 18:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270856AbRHSWrP>; Sun, 19 Aug 2001 18:47:15 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2311 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S270855AbRHSWqy>; Sun, 19 Aug 2001 18:46:54 -0400
Message-ID: <3B8041E4.8D02A20B@zip.com.au>
Date: Sun, 19 Aug 2001 15:47:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduling with io_lock held in 2.4.6
In-Reply-To: "from (env: ptb) at Aug 19, 2001 06:38:18 pm" <200108191858.UAA01216@nbd.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> I am now fairly certain that the schedule occured while
> blkdev_release_request was in a completely innocuous line
> 

No - from your earlier trace it looks like what happened
was that you dereferenced a bad address in blkdev_release_request():

Unable to handle kernel paging request at virtual address 00002004

But when the kernel processes this error the last thing it
tries to do is to kill off the offending process by calling
do_exit().  But do_exit() calls schedule().

So if you take an oops in interrupt context you'll basically
always see the "scheduling in interrupt" thing.  So don't
worry about it.

You need to find out why you're dereferencing a bad pointer
in blkdev_release_request().

-
