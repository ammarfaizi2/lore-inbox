Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWHHP2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWHHP2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWHHP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:27:59 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:26986 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964956AbWHHP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:27:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HGvYddsqXB1YkZi5INatMtVCoDVfJOoqyqgXBT4cbVJYjo8pVF7JOgI084GvJD8qmNLhtQyY83vbj/SE7zSovrb9+wPWS+gj3cxgXSgF16j0ww+bZ752wx18g9h/MZEh2y1pi6IfPCIJ2LjgTZxMraZtMgVWhhAHr5BTolZUB60=  ;
Message-ID: <44D8A9BE.3050607@yahoo.com.au>
Date: Wed, 09 Aug 2006 01:11:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>	 <200608081429.44497.dada1@cosmosbay.com>	 <200608081447.42587.ak@suse.de>	 <200608081457.11430.dada1@cosmosbay.com> <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>
In-Reply-To: <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On 8/8/06, Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
>> The validity of the virtual address is still tested by normal get_user()
>> call.. If the memory was freed by a thread, then a normal EFAULT error 
>> will
>> be reported... eventually.
> 
> 
> This is indeed what should be done.  Private futexes are the by far
> more frequent case and I bet you'd see improvements when avoiding the
> mm mutex even for normal machines since futexes really are everywhere.
> For shared mutexes you end up doing two lookups and that's fine IMO
> as long as the first lookup is fast.

The private futex's namespace is its virtual address, so I don't see
how you can decouple that from the management of virtual addresses.

Let me get this straight: to insert a contended futex into your rbtree,
you need to hold the mmap sem to ensure that address remains valid,
then you need to take a lock which protects your rbtree. Then to wake
up a process and remove the futex, you need to take the rbtree lock. Or
to unmap any memory you also need to take the rbtree lock and ensure
there are no futexes there.

So you just add another lock for no reason, or have I got a few screws
loose myself? I don't see how you can significantly reduce lock
cacheline bouncing in a futex heavy workload if you're just going to
add another shared data structure. But if you can, sweet ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
