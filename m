Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWHHQ6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWHHQ6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWHHQ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:58:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:3418 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964977AbWHHQ6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:58:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YOjMMR2MRSIFY7vWJXTbtJbKWYprgz6mO1tN3SPmnZJpMDTRcWjY8O4aAtCa6qmrg7lhKWUWi0dHiixMSN56+7chJQZYNM5HHXyyQy/Qi+3nouUacm7oGnGuzQQfKF/vv2AQ6Yw0zdOKSbkhtY/fmlIpmHqD/ukOmaYb4q/k1tA=
Message-ID: <a36005b50608080958n192e9324jb9d5a7a59b365eae@mail.gmail.com>
Date: Tue, 8 Aug 2006 09:58:10 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Subject: Re: [RFC] NUMA futex hashing
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andi Kleen" <ak@suse.de>,
       "Ravikiran G Thirumalai" <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "pravin b shelar" <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608081808.34708.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808070708.GA3931@localhost.localdomain>
	 <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>
	 <44D8A9BE.3050607@yahoo.com.au>
	 <200608081808.34708.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Eric Dumazet <dada1@cosmosbay.com> wrote:
> So we really can... but for 'private futexes' which are the vast majority of
> futexes needed by typical program (using POSIX pshared thread mutex attribute
> PTHREAD_PROCESS_PRIVATE, currently not used by NPTL glibc)

Nonsense.  Mutexes are by default always private.  They explicitly
have to be marked as sharable.  This happens using the
pthread_mutexattr_setpshared function which takes
PTHREAD_PROCESS_PRIVATE or PTHREAD_PROCESS_SHARED in the second
parameter.  So the former _is_ clearly used.


> Of course we would need a new syscall, and to change glibc to be able to
> actually use this new private_futex syscall.

No, why?  The kernel already does recognize private mutexes.  It just
checks whether the pages used to store it are private or mapped.  This
requires some interaction with the memory subsystem but as long as no
crashes happen the data can change underneath.  It's the program's
fault if it does.

On the waker side you would search the local futex hash table/tree
first and if this doesn't yield a match, search the global table.
Wakeup calls without any waiters are usually rare.
