Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWDMWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWDMWrr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDMWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:47:47 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:8944 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751138AbWDMWrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:47:46 -0400
Message-Id: <6.2.5.6.2.20060413145913.03436f38@comcast.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.5.6
Date: Thu, 13 Apr 2006 15:06:03 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
From: Dan Bonachea <bonachead@comcast.net>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1144965022.12387.23.camel@localhost.localdomain>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
 <20060412214613.404cf49f.akpm@osdl.org>
 <443DE2BD.1080103@yahoo.com.au>
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
 <1144965022.12387.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:50 PM 4/13/2006, Alan Cox wrote:
>The only serious case historically has been O_APPEND which does have
>pretty precise semantics. Nowdays we also have pread/pwrite which have
>pretty clear semantics and deal with threading. The O_APPEND case is
>very important to get correct and 2.4 certainly did so.
...
>As such I belive that the O_APPEND case must be kept locked properly and
>the non O_APPEND cases are already correctly handled by the kernel. That
>seems to argue for f_pos serialization on O_APPEND only.

I agree that O_APPEND is important to get correct. However, would that also 
handle the specific case of stdout redirection to a file? (ie "a.out > 
result", not just "a.out >> result" - the latter incidentally does not 
currently seem to fail, at least with my tests)

>Looking at the spec it says the following
>
>"If the O_APPEND flag of the file status flags is set, the file offset
>shall be set to the end of the file prior to each write and no
>intervening file modification operation shall occur between changing the
>file offset and the write operation."
>
>This is what 2.4 took great paints to guarantee for file writes. Now in
>actual fact no OS I know of implements this to the extreme (mmap) but
>does for the other cases.
>
>Outside of O_APPEND the specification says only that
>- The write starts at the file position
>- The file position is updated before the syscall returns
>
>It makes no other guarantee I can see.

The POSIX 1003.1-2001 spec seems to provide a very clear guarantee of 
thread-safety behavior wrt threads:

2.9.1 Thread-Safety
All functions defined by this volume of IEEE Std 1003.1-2001 shall be 
thread-safe, except that the following functions need not be thread-safe.
    <omitted list of functions, which does not include write>
Implementations shall provide internal synchronization as necessary in order 
to satisfy this
requirement.
...
2.9.7 Thread Interactions with Regular File Operations
All of the functions chmod( ), close( ), fchmod( ), fcntl( ), fstat( ), 
ftruncate( ), lseek( ), open( ), read( ), readlink( ), stat( ), symlink( ), 
and write( ) shall be atomic with respect to each other in the effects 
specified in IEEE Std 1003.1-2001 when they operate on regular files. If two 
threads each call one of these functions, each call shall either see all of 
the specified effects of the other call, or none of them.

Unless I'm missing something, that doesn't leave much ambiguity regarding 
what's required for POSIX compliance on this issue (although I'm not sure 
POSIX compliance is the right metric).

Dan

