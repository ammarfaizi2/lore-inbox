Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262030AbSIYRFZ>; Wed, 25 Sep 2002 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbSIYRFZ>; Wed, 25 Sep 2002 13:05:25 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:18572 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id <S262030AbSIYRFY>; Wed, 25 Sep 2002 13:05:24 -0400
To: frankeh@watson.ibm.com
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
From: Mark_H_Johnson@raytheon.com
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
Date: Wed, 25 Sep 2002 11:57:35 -0500
Message-ID: <OFA909F528.299706E8-ON86256C3F.005D287A-86256C3F.005D29EC@hou.us.ray.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 5.0.10 |March 22, 2002) at
 09/25/2002 11:57:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This is what the manpage says...
>
>       mlockall  disables  paging  for  all pages mapped into the
>       address space of the calling process.  This  includes  the
>       pages  of  the  code,  data  and stack segment, as well as
>       shared libraries, user space kernel  data,  shared  memory
>       and  memory  mapped files. All mapped pages are guaranteed
>       to be resident  in  RAM  when  the  mlockall  system  call
>       returns  successfully  and  they are guaranteed to stay in
>       RAM until the pages  are  unlocked  again  by  munlock  or
>       munlockall  or  until  the  process  terminates  or starts
>       another program with exec.  Child processes do not inherit
>       page locks across a fork.
>
>Do you read that all pages must be faulted in apriori ?
>Or is it sufficient to to make sure none of the currently mapped
>pages are swapped out and future swapout is prohibited.
>
The key phrase is that "...all mapped pages are guaranteed to be resident
in RAM when the mlockall system call returns successfully..." (third
sentence) In that way I would expect the segments containing the code,
heap, and current stack allocations to be resident. I do not expect
the full stack allocation (e.g., 2M for each thread if that is the
stack size) to be mapped (nor resident) unless I take special action
to grow the stack that large.

We happen to have special code to grow each stack and allocate heap
variables to account for what we expect to use prior to mlockall.

That does raise a question though - are there other segments (e.g.,
debug information) that may be in the total size calculations that
are mapped only when some special action is taken (e.g., I run the
debugger)? That would explain the difference - the measures I reported
on were with executables built with debug symbols.

That might also explain a possible problem we have had when trying
to debug such an application after an hour of run time or so. If
running gdb triggers a growth in locked memory (and we don't have
enough) - we would likely get an error condition that isn't normally
expected by gdb.

>This still allows for page faults on pages that have not been
>mapped in the specified range or process. If required the
>app could touch these and they wouldn't be swapped later.
>

I don't think touching the pages is enough - they have to be allocated
and the maps generated (e.g., calls to mmap, malloc). That is a possibly
expensive operation when real time is active and something we try to
avoid whenever possible.

--
--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


