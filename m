Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265349AbSJXIai>; Thu, 24 Oct 2002 04:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbSJXIai>; Thu, 24 Oct 2002 04:30:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:53247 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265349AbSJXIah>;
	Thu, 24 Oct 2002 04:30:37 -0400
Message-ID: <3DB7B11B.9E552CFF@digeo.com>
Date: Thu, 24 Oct 2002 01:36:43 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: writepage return value check in vmscan.c
References: <20021024082505.GB1471@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 08:36:43.0565 (UTC) FILETIME=[7B3B15D0:01C27B38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:
> 
> Hi Andrew,
> 
> It might be a silly question.

It's an excellent question.

> ...
> I try to find out what happen if user memory map a sparse file then
> kernel try to write it back to disk and hit a no disk space error.
> To my surprise, it seems to me that both 2.4 and 2.5 kernel do not
> check the return value of "writepage". If there is an error like ENOSPC
> it will just drop it on the ground? Do I miss something obvious?

Yup.  If the kernel cannot write back your MAP_SHARED page due to
ENOSPC it throws your data away.

The alternative would be to allow you to pin an arbitrary amount of
unpageable memory.

A few fixes have been discussed.  One way would be to allocate
the space for the page when it is first faulted into reality and
deliver SIGBUS if backing store for it could not be allocated.
 
> BTW, I am amazed that there is so many way user can abuse the mmap system
> call. e.g. open a file, ftruncate to a bigger size, unlink that file while
> keep the file descriptor, mmap to some memory using that descriptor,
> close that descriptor, you can still use that mmaped memory.

Ayup.  MAP_SHARED is a crock.  If you want to write to a file, use write().

View MAP_SHARED as a tool by which separate processes can attach
to some shared memory which is identified by the filesystem namespace.
It's not a very good way of performing I/O.

That's not to say that you deserve to have the kernel silently throw
your data away as punishment for having used it though.  Thanks for the
prod.  We should do something about that.
