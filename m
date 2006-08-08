Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWHHQWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWHHQWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWHHQWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:22:23 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:53907 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964956AbWHHQWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:22:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=egkbEGAYM3h9L65WpewaS7trXrz4CJTPzar4w4R6cBsuQjBcSj5SEMI7BpIqrhfnS1Gl+dvVSbaUAytHEcsYKEnFyfvEcxIoJeHe6iomSWE4nKV8gplAfidvdjGDlJgQfWFOpyFJwsdWcQLPoTJfMUZeHrIMFGun+UK+mk79pzw=  ;
Message-ID: <44D8BA39.5020405@yahoo.com.au>
Date: Wed, 09 Aug 2006 02:22:17 +1000
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
References: <20060808070708.GA3931@localhost.localdomain>	 <200608081429.44497.dada1@cosmosbay.com>	 <200608081447.42587.ak@suse.de>	 <200608081457.11430.dada1@cosmosbay.com>	 <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>	 <44D8A9BE.3050607@yahoo.com.au> <a36005b50608080836u3e58ab85l61bb50b2bac5a0e3@mail.gmail.com>
In-Reply-To: <a36005b50608080836u3e58ab85l61bb50b2bac5a0e3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On 8/8/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> Let me get this straight: to insert a contended futex into your rbtree,
>> you need to hold the mmap sem to ensure that address remains valid,
>> then you need to take a lock which protects your rbtree.
> 
> 
> Why does it have to remain valid?  As long as the kernel doesn't crash
> on any of the operations associated with the futex syscalls let the
> address space region explode, implode, whatever.  It's  a bug in the
> program if the address region is changed while a futex is placed
> there.  If the futex syscall hangs forever or returns with a bogus
> state (error or even success) this is perfectly acceptable.  We

I thought mremap (no, that's already kind of messed up); or
even just getting consistency in failures (eg. so you don't have
the situation that a futex op can succeed on a previously
unmapped region).

If you're not worried about the latter, then it might work...

I didn't initially click that the private futex API operates
purely on tokens rather than virtual memory... comments in
futex.c talk about futexes being hashed to a particular
physical page (which is the case for shared). That's whacked.

So actually you would change semantics in some weird corner
cases, like mremaping a shared futex over a private futex's
Arguably that's broken, though ;)

> shouldn't slow down correct uses just to make it possible for broken
> programs to receive a more detailed error description.
> 

No we shouldn't slow them down. I'd be interested to see whether
locking is significantly sped up with this new data structure,
though.

You might also slow down due to the fact that you'd have to do the
locking and unconditionally traverse the private futexes even for
shared futexes.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
