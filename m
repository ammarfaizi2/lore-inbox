Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTHOVwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbTHOVwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:52:20 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:16000 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S267561AbTHOVwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:52:10 -0400
To: Ed L Cashin <ecashin@uga.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
References: <20030815184720.A4D482CE79@lists.samba.org>
	<877k5e8vwe.fsf@uga.edu> <20030815212244.GQ1027@matchmail.com>
From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 15 Aug 2003 17:52:09 -0400
Message-ID: <87k79e7fna.fsf@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Fri, Aug 15, 2003 at 05:15:45PM -0400, Ed L Cashin wrote:
>> Rusty Russell <rusty@rustcorp.com.au> writes:
>> 
>> > In message <87d6fixvpm.fsf@uga.edu> you write:
>> >> This patch just does what the comment says should be done.
>> >
>> > Hi Ed!
>> >
>> > 	Not trivial I'm afraid.  Send to Linus and lkml.
>> 
>> 
>> This patch just does what the comment says should be done.  I thought
>> it was a trivial patch, but Rusty Russell has informed me otherwise.
>> (Thanks, RR).
>> 
>> 
>> --- linux-2.6.0-test2/mm/memory.c.orig	Sun Jul 27 13:01:24 2003
>> +++ linux-2.6.0-test2/mm/memory.c	Wed Aug  6 18:30:55 2003
>> @@ -990,15 +990,10 @@
>>  	int ret;
>>  
>>  	if (unlikely(!pfn_valid(pfn))) {
>> -		/*
>> -		 * This should really halt the system so it can be debugged or
>> -		 * at least the kernel stops what it's doing before it corrupts
>> -		 * data, but for the moment just pretend this is OOM.
>> -		 */
>> -		pte_unmap(page_table);
>>  		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
>>  				address);
>> -		goto oom;
>> +		dump_stack();
>> +		BUG();
>
> You're not unmapping the pte I guess to not interfere with the dump_stack,

This patch changes the logic from "pretend it's out of memory" to
"announce something's very wrong and bail out right away."  Unmapping
the pte seems like a precursor to carrying on business as usual, but
there must be some subtleties here that I am unaware of, or Rusty
Russell wouldn't have called this patch non-trivial.

> but what about the printk?  Will that affect the dump_stack also?

It seems like you'd return from the printk before dumping the stack,
so I wouldn't think so.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

