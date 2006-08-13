Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWHMQaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWHMQaW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWHMQaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:30:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29403 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751303AbWHMQaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:30:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org,
       "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [RFC] ps command race fix
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
Date: Sun, 13 Aug 2006 10:29:51 -0600
In-Reply-To: <20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Tue, 25 Jul 2006 12:16:40 +0900")
Message-ID: <m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> On Tue, 25 Jul 2006 11:50:04 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
>> BTW, how large pids and how many proccess in a (heavy and big) system ?
>> 
> I found
> /*
>  * A maximum of 4 million PIDs should be enough for a while.
>  * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
>  */
> #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
>         (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
>
> ...we have to manage 4 millions tids.
>
> I'll try to make use of pidmap array which is already maintained in pid.c
> and to avoid using extra memory.

Has any progress been made on this front?

I know I was initially discouraging.

I looked up the posix definition for readdir and thought about this
some more and I do agree that this is a problem that needs to be fixed.

The basic posix/susv guarantee is that in readdir if a directory
entry is neither deleted nor added between opendir and closedir of the
directory you should see the directory entry.   I could not
quite tell what the rules were with regards seekdir.

That is a sane set of guarantees to build a userspace implementation
on.

Since the current implementation does not provide those guarantees
it is hard to build a normal user space implementation, because
the guarantees provided are not the normal ones, and the current
guarantees provided (it works if you have a big enough readdir
buffer) aren't terribly useful as they require several hundred
megabytes in the worse case.

There are also other reasons to changing to a pid base traversal
of /proc.  It allows us to display information on process groups,
and sessions whose original leader has died.  If namespaces get
assigned a pid traversal by pid looks like a good way to display
namespaces that are not used by any process but are still alive.
Albert does that sound like a sane extension?

I also have always liked the idea of a different data structure
because hash tables may it ugly when it comes to implementing
namespaces.  But I believe the current hash table is generally better
than what I have seen proposed, as replacements.

In the normal case the current hash has 4096 entries and pid_max
is set to 32768.  In the normal case that means we have a single
hash table lookup, which is very cache friendly since we only have
the single cache line miss.  Not always but largely we can assume
any lookup in the data structure is going to be a cache miss.  pid
traversal might be different I'm not certain. 

Our worst case with the current hash table with a pid_max of 32768 is
traversing a linked list 9 items long. (I just computed this by brute
force).  Of course when you push pid_max to the maximum of
(4*1024*1024) the hash chains can get as long as 1024 entries which
is distressing, but at least uniformly distributed.

Comparing that with a radix tree with a height of 6.  For 32768 pids
we get a usual height of ceil(15/6) = 3 and in the worst case
ceil(22/6) = 4.

Our hash function distributes things well which is good.  It is a
known function which means an attacker can predict it, and with a
series of fork/exit can within some reasonable bounds pick which
pids are getting used. A cryptographic hash will not help because
the input space can be trivially brute force searched.

So for systems that are going to be using a larger number of pid
values I think we need a better data structure, and containers are
likely to push us in that area.  Which means either an extensible
hash table or radix tree look like the sane choices.


Eric

