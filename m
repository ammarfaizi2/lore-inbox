Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319556AbSIMIJh>; Fri, 13 Sep 2002 04:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319559AbSIMIJh>; Fri, 13 Sep 2002 04:09:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:37844 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319556AbSIMIJg>;
	Fri, 13 Sep 2002 04:09:36 -0400
Message-ID: <3D81A200.C1B6A293@digeo.com>
Date: Fri, 13 Sep 2002 01:29:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
References: <3D80E139.ACC1719D@digeo.com> <20020913.162252.56050784.taka@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 08:14:20.0820 (UTC) FILETIME=[8FF4B540:01C25AFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> 
> Hello,
> 
> I updated the writev patch which may be easy to understand.
> How about it?

Looks nice.   And yes, you hung onto the atomic kmap across multiple
iov segments ;)  That will save a tlb invalidate per segment.
 
> But I have one question, Could let me know if you have any idea,
> why does filemap_copy_from_user() try to call kamp()+__copy_from_user()
> again after the first trial get fault.
> 
> Is there any meanings?

We're not allowed to schedule away inside atomic_kmap - must remain
in the same task, on the same CPU etc.  So the pagefault handler
will return immediately if we take a pagefault while copying to/from
userspace while holding an atomic kmap.

So the code first touches the userspace page (via __get_user) to
fault it in.  Now, there is a 99.999999% chance that the copy_*_user()
will not fault - it will remain wholly atomic.

But there is the 0.0000001% chance that the VM will evict (or at least
unmap) the page between the __get_user() and the completion of the 
copy_*_user().  In this case, copy_*_user() will fail and will return
a short copy.

Now, we could just touch the page with another __get_user() and retry
the atomic kmap approach.  But I flipped a coin and decided to fall back
to a regular sleeping kmap instead.  With a sleeping kmap, in a
non-atomic region the kernel will actually take the fault, fix it up
and the copy_*_user() will work OK.

> ...
> --- linux/mm/filemap.c.ORG      Wed Sep 11 19:48:00 2030
> +++ linux/mm/filemap.c  Fri Sep 13 16:08:51 2030

I shall retest...
