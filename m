Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSFRVMB>; Tue, 18 Jun 2002 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSFRVMA>; Tue, 18 Jun 2002 17:12:00 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19193 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317623AbSFRVL7>; Tue, 18 Jun 2002 17:11:59 -0400
Date: Tue, 18 Jun 2002 17:12:00 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020618171200.G16091@redhat.com>
References: <E17KPdj-0004EP-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0206181334500.981-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206181334500.981-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jun 18, 2002 at 01:41:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 01:41:12PM -0700, Linus Torvalds wrote:
> That wasn't so hard, was it?
> 
> Besides, we've had this interface for about 15 years, and it's called
> "select()".  It scales fine to thousands of descriptors, and we're talking
> about something that is a hell of a lot less timing-critical than select
> ever was.

I take issue with the statement that select scales fine to thousands of 
file descriptors.  It doesn't.  For fairly trivial workloads it degrades 
to 0 operations per second with more than a few dozen filedescriptors in 
the array, but only one descriptor being active.  To sustain decent 
throughput, select needs something like 50% of the filedescriptors in an 
array to be active at every select() call, which makes in unsuitable for 
things like LDAP servers, or HTTP/FTP where the clients are behind slow 
connections or interactive (like in the real world).  I've benchmarked 
it -- we should really include something like /dev/epoll in the kernel 
to improve this case.

Still, I think the bitmap approach in this case is useful, as having 
affinity to multiple CPUs can be needed, and it is not a frequently 
occuring operation (unlike select()).

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
