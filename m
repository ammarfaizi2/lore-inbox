Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbUCNCqI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbUCNCqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:46:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:19338 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263255AbUCNCqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:46:04 -0500
Date: Sat, 13 Mar 2004 18:45:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: raybry@sgi.com, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Hugetlbpages in very large memory machines.......
Message-Id: <20040313184547.6e127b51.akpm@osdl.org>
In-Reply-To: <20040313034840.GF4638@wotan.suse.de>
References: <40528383.10305@sgi.com>
	<20040313034840.GF4638@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > We've looked at allocating and zeroing hugetlbpages at fault time, which 
>  > would at least allow multiple processors to be thrown at the problem.  
>  > Question is, has anyone else been working on
>  > this problem and might they have prototype code they could share with us?
> 
>  Yes. I ran into exactly this problem with NUMA API too. 
>  mbind() runs after mmap, but it cannot work anymore when
>  the pages are already allocated.
> 
>  I fixed it on x86-64/i386 by allocating the pages lazily.
>  Doing it for IA64 has been on the todo list too.
> 
>  i386/x86-64 Code as an example attached.
> 
>  One drawback is that the out of memory handling is lot less nicer
>  than it was before - when you run out of hugepages you get SIGBUS
>  now instead of a ENOMEM from mmap. Maybe some prereservation would
>  make sense, but that would be somewhat harder. Alternatively
>  fall back to smaller pages if possible (I was told it isn't easily
>  possible on IA64)

Demand-paging the hugepages is a decent feature to have, and ISTR resisting
it before for this reason.

Even though it's early in the 2.6 series I'd be a bit worried about
breaking existing hugetlb users in this way.  Yes, the pages are
preallocated so it is unlikely that a working setup is suddenly going to
break.  Unless someone is using the return value from mmap to find out how
many pages they can get.

So ho-hum.  I think it needs to be back-compatible.  Could we add
MAP_NO_PREFAULT?

