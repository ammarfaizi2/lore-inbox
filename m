Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVHSGDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVHSGDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHSGDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:03:45 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:11271 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932558AbVHSGDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:03:45 -0400
Message-ID: <43057641.70700@symas.com>
Date: Thu, 18 Aug 2005 23:03:45 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: sched_yield() makes OpenLDAP slow
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, seems there's a great deal of misinformation in this thread.

>  I also think OpenLDAP is wrong. First, it should be calling
>  pthread_yield() because slapd is a multithreading process and it just
>  wants to run the other threads. See:
...
>  AFAIKS, sched_yield should only really be used by realtime
>  applications that know exactly what they're doing.

pthread_yield() was deleted from the POSIX threads drafts years ago. 
sched_yield() is the officially supported API, and OpenLDAP is using it 
for the documented purpose. Anyone who says "applications shouldn't be 
using sched_yield()" doesn't know what they're talking about.

>  It's really more a feature than a bug that it breaks so easily
>  because they should be really using futexes instead, which have much
>  better behaviour than any sched_yield ever could (they will directly
>  wake up another process waiting for the lock and avoid the thundering
>  herd for contended locks)

You assume that spinlocks are the only reason a developer may want to 
yield the processor. This assumption is unfounded. Case in point - the 
primary backend in OpenLDAP uses a transactional database with 
page-level locking of its data structures to provide high levels of 
concurrency. It is the nature of such a system to encounter deadlocks 
over the normal course of operations. When a deadlock is detected, some 
thread must be chosen (by one of a variety of algorithms) to abort its 
transaction, in order to allow other operations to proceed to 
completion. In this situation, the chosen thread must get control of the 
CPU long enough to clean itself up, and then it must yield the CPU in 
order to allow any other competing threads to complete their 
transaction. The thread with the aborted transaction relinquishes all of 
its locks and then waits to get another shot at the CPU to try 
everything over again. Again, this is all fundamental to the nature of 
transactional programming. If the 2.6 kernel makes this programming 
model unreasonably slow, then quite simply this kernel is not viable as 
a database platform.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

