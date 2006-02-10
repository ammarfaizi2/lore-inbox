Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWBJEaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWBJEaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBJEaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:30:21 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:12457 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751079AbWBJEaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:30:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=P+8IjHaNbQI8uETgRNImW/vtmASNElQCftQ/19cJ5jTTqOSOdbffsggaNuqS1TpdYQT0okuVRBMhOmB927oZTJqTfc3vwXBgJ98zhoqOeco07o7XdXWLMIgT5umPbHKrecmTnxnZt6pgDs18/x9FORHJzfmYzRUel+qPjsCnzxs=  ;
Message-ID: <43EC16D8.8030300@yahoo.com.au>
Date: Fri, 10 Feb 2006 15:30:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org>
In-Reply-To: <20060209201333.62db0e24.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> I don't think anyone would use MS_ASYNC for anything other than
>> performance improvement, so it is not like we need super well
>> defined behaviour... the earlier it will start IO AFAIKS the better.
> 
> 
> Well, no.  Consider a continuously-running application which modifies its
> data store via MAP_SHARED+msync(MS_ASYNC).  If the msync() immediately
> started I/O, the disk would be seeking all over the place all the time.  The
> queue merging and timer-based unplugging would help here, but it won't be
> as good as a big, infrequent ascending-file-offset pdflush pass.
> 

Sure you can shoot yourself in the foot.

   "msync  flushes  changes  made  to  the  in-core copy of a file that
    was mapped into memory using mmap(2) back to disk. "

We usually don't cater to foot shooters at the expense of valid users.

AFAIKS, basically the only valid use for MS_ASYNC is for the app to tell
the kernel that it isn't going to write here for a long time, so writeback
may as well be scheduled; or to pipeline other work with an upcoming data
integrity point which will need to be guaranteed by a second call to MS_SYNC.

> Secondly, consider the behaviour of the above application if it is modifying
> the same page relatively frequently (quite likely).  If MS_ASYNC starts I/O
> immediately, that page will get written 10, 100 or 1000 times per second. 
> If MS_ASYNC leaves it to pdflush, that page gets written once per 30
> seconds, so we do far much less I/O.
> 
> We just don't know.  It's better to leave it up to the application designer
> rather than lumping too many operations into the one syscall.

Well it remains the same conceptual operation (asynchronously "schedule"
dirty pages for writeout). However it simply becomes more useful to start
the writeout immediately, given that's the (pretty explicit) hint that is
given to us.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
