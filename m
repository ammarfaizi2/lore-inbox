Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWHHOkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWHHOkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWHHOkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:40:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:5175 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964932AbWHHOj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:39:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JptUUSxvvVOriLRqEiAebGjuadYn/ZsMcDBySvo47igMjPlwEeU43bgGn5gZ0n+XSXKgvkFbUgtwFIz16hYjbeExRo3l8sg43ORkWfbkjRF/asiyAL1yRBaLEKgDN44EXmg5xMschzGpNVogEK3VKw9i46g6CrT4e4zIUgcEWB8=
Message-ID: <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>
Date: Tue, 8 Aug 2006 07:39:57 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Subject: Re: [RFC] NUMA futex hashing
Cc: "Andi Kleen" <ak@suse.de>, "Ravikiran G Thirumalai" <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "pravin b shelar" <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608081457.11430.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808070708.GA3931@localhost.localdomain>
	 <200608081429.44497.dada1@cosmosbay.com>
	 <200608081447.42587.ak@suse.de>
	 <200608081457.11430.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Eric Dumazet <dada1@cosmosbay.com> wrote:
> The validity of the virtual address is still tested by normal get_user()
> call.. If the memory was freed by a thread, then a normal EFAULT error will
> be reported... eventually.

This is indeed what should be done.  Private futexes are the by far
more frequent case and I bet you'd see improvements when avoiding the
mm mutex even for normal machines since futexes really are everywhere.
 For shared mutexes you end up doing two lookups and that's fine IMO
as long as the first lookup is fast.

As for the NUMA case, I would oppose any change which has the
slightest impact on non-NUMA machines.  It cannot be allowed that the
majority of systems is slowed down significantly just because of NUMA.
 Especially since the effects of NUMA beside cache line transfer
penalties IMO probably are neglect able.  The in-kernel futex
representation only exists when there are waiters and so the memory
needed is only allocated when we a waiting.  In this case it just be
easy enough to use local memory.  But this unlikely will help much
since the waker thread is ideally not on the same processor, maybe not
even on the same node.  So there will be cacheline transfers in most
cases and everything possible improvement will be minimal and maybe
even not generally measurable.

If you want to do anything in this area, first remove the global
mutex.  Then really measure with real world application.  And I don't
mean specially designed HPC apps which assign threads/processes to
processors or nodes.  Those are special cases of a special case.
