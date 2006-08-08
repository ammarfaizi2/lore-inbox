Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWHHRIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWHHRIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWHHRIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:08:21 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:36267 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S965000AbWHHRIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:08:20 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: "Ulrich Drepper" <drepper@gmail.com>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 19:08:17 +0200
User-Agent: KMail/1.9.1
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andi Kleen" <ak@suse.de>,
       "Ravikiran G Thirumalai" <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "pravin b shelar" <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <200608081808.34708.dada1@cosmosbay.com> <a36005b50608080958n192e9324jb9d5a7a59b365eae@mail.gmail.com>
In-Reply-To: <a36005b50608080958n192e9324jb9d5a7a59b365eae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081908.18157.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 18:58, Ulrich Drepper wrote:
> On 8/8/06, Eric Dumazet <dada1@cosmosbay.com> wrote:
> > So we really can... but for 'private futexes' which are the vast majority
> > of futexes needed by typical program (using POSIX pshared thread mutex
> > attribute PTHREAD_PROCESS_PRIVATE, currently not used by NPTL glibc)
>
> Nonsense.  Mutexes are by default always private.  They explicitly
> have to be marked as sharable.  This happens using the
> pthread_mutexattr_setpshared function which takes
> PTHREAD_PROCESS_PRIVATE or PTHREAD_PROCESS_SHARED in the second
> parameter.  So the former _is_ clearly used.
>

I was saying that PTHREAD_PROCESS_PRIVATE or PTHREAD_PROCESS_SHARED info is 
not provided to the kernel (because futex api/implementation dont need to). 
It was not an attack on glibc.

> > Of course we would need a new syscall, and to change glibc to be able to
> > actually use this new private_futex syscall.
>
> No, why?  The kernel already does recognize private mutexes.  It just
> checks whether the pages used to store it are private or mapped.  This
> requires some interaction with the memory subsystem but as long as no
> crashes happen the data can change underneath.  It's the program's
> fault if it does.

But if you let futex code doing the vma walk to check the private/shared 
status, you still need the mmap_sem locking.

Moreover, a program can mmap() a file (shared in terms of VMA), and continue 
to use a  PTHREAD_PROCESS_PRIVATE mutex lying in this shared zone
(Example : shmem or hugetlb mapping, wich API might always give a 'shared' 
vma)

>
> On the waker side you would search the local futex hash table/tree
> first and if this doesn't yield a match, search the global table.
> Wakeup calls without any waiters are usually rare.

If the two searches touch two different cache lines in the hash table, we 
might have a performance regression.
Of course we might chose a hash function so that the same slot is accessed.

Eric

