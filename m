Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313824AbSDZRZ0>; Fri, 26 Apr 2002 13:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSDZRZZ>; Fri, 26 Apr 2002 13:25:25 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:40107 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP
	id <S313824AbSDZRZY>; Fri, 26 Apr 2002 13:25:24 -0400
Date: Fri, 26 Apr 2002 12:25:23 -0500 (CDT)
Message-Id: <200204261725.MAA02024@radium.lmcg.wisc.edu>
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E17117p-0002fH-00@charged.uio.no> (message from Trond Myklebust
	on Fri, 26 Apr 2002 10:30:41 +0200)
Subject: Re: lockd hanging
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>> On Wednesday 24. April 2002 23:13, Daniel Forrest wrote:
>> > The bug I have found is in fs/lockd/svclock.c and is caused by downing
>> > an already downed semaphore:
>> >
>> > ->nlmsvc_lock				calls down(&file->f_sema)
>> 
>> Just exactly what is f_sema protecting? I've looked at the code,
>> and I just can't figure out why we need a semaphore there at all.
>> 
>> AFAICS, all we are using them for is to protect the 2 lists
>> f_shares and f_blocks in struct nlm_file. Since we are already
>> holding the BKL, I don't see why we need an extra lock. (Yes:
>> nlmsvc_delete_block() can sleep, so we need to be careful with the
>> loop in nlmsvc_traverse_blocks(), but that is trivial to cope
>> with...)

I agree that it seems to be used to protect those two lists.  I'm very
new to looking at the Linux kernel and I don't know how many threads
are running or how they preempt each other, but I think it is because
there are three paths that enter the code.  One is RPC or an RPC
callback, one is a VFS callback, and one is the lockd thread itself.
Do they each hold the BKL while they are running?  If there are any
on-line resources that describe this I would be quite interested in
reading them.

I'm afraid I don't follow your last comment either.  Why might
nlmsvc_delete_block() sleep?  (kfree()???)  And how is this a problem?

>> As for calling nlmclnt_lookup_host() in nlmsvc_create_block(). Why
>> not just pass the value that we looked up in nlmsvc_proc_lock()?

I'm not sure why, but there seem to be two flavors of host entries.
One is created by a client request using nlmsvc_lookup_host() and the
other is created by lockd itself using nlmclnt_lookup_host().  The
first one seems to be used to keep track of the client who owns or has
requested a lock, while the second seems to be used only for the RPC
callback.  I suppose this makes things easier in the case that the
request is cancelled while the RPC is still in progress?

Dan

-- 
+----------------------------------+----------------------------------+
| Daniel K. Forrest                | Laboratory for Molecular and     |
| forrest@lmcg.wisc.edu            | Computational Genomics           |
| (608)262-9479                    | University of Wisconsin, Madison |
+----------------------------------+----------------------------------+
