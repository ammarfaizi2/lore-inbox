Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRHWRqx>; Thu, 23 Aug 2001 13:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269436AbRHWRqm>; Thu, 23 Aug 2001 13:46:42 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:32016 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269417AbRHWRqh>; Thu, 23 Aug 2001 13:46:37 -0400
Message-ID: <3B854186.F0C00E3C@zip.com.au>
Date: Thu, 23 Aug 2001 10:46:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk> <3B83FB3F.A0BDC056@zip.com.au> <3B853BE6.3010703@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:
> 
> Andrew Morton wrote:
> 
> > It matters.  -ac kernels handle this by clearing out the blocks
> > on the error path in __block_prepare_write().  If you retest with
> > -ac kernels, you should just see zeroes.
> 
> That doesn't help. The problem occurs just the same on -ac kernels.

OK, that code is for IO errors and disk-full.

> In this case __block_prepare_write() is successful. What happens is that
> if __copy_from_user() fails, the block remains mapped but not up to
> date. Thus the next read access to the file fetches the garbage data off
> disk, and presents it to the user.

generic_file_write() will mark the page not up-to-date in this case.
I wonder what's actually going on?  Perhaps the fact that we've
instantiated a block in ext2 outside i_size?

If you change the error path in -ac's generic_file_write() thusly:

-	goto fail_write;
+	status = -EFAULT;
+	goto sync_failure;

does it fix it?

Can you send the code you're using to demonstrate this?

-
