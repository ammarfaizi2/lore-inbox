Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWHRLMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHRLMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWHRLMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:12:31 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:44635 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932393AbWHRLMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:12:30 -0400
Message-ID: <44E5A12E.6020900@sw.ru>
Date: Fri, 18 Aug 2006 15:14:54 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>	 <1155751868.22595.65.camel@galaxy.corp.google.com> <44E458C4.9030902@sw.ru> <1155833753.14617.21.camel@galaxy.corp.google.com>
In-Reply-To: <1155833753.14617.21.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Thu, 2006-08-17 at 15:53 +0400, Kirill Korotaev wrote:
> 
>>Rohit Seth wrote:
>>
>>>On Wed, 2006-08-16 at 19:37 +0400, Kirill Korotaev wrote:
>>>
>>>
>>>>Core functionality and interfaces of UBC:
>>>>find/create beancounter, initialization,
>>>>charge/uncharge of resource, core objects' declarations.
>>>>
>>>>Basic structures:
>>>> ubparm           - resource description
>>>> user_beancounter - set of resources, id, lock
>>>>
>>>>Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
>>>>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
>>>>
>>>>---
>>>>include/ub/beancounter.h |  157 ++++++++++++++++++
>>>>init/main.c              |    4
>>>>kernel/Makefile          |    1
>>>>kernel/ub/Makefile       |    7
>>>>kernel/ub/beancounter.c  |  398 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>5 files changed, 567 insertions(+)
>>>>
>>>>--- /dev/null	2006-07-18 14:52:43.075228448 +0400
>>>>+++ ./include/ub/beancounter.h	2006-08-10 14:58:27.000000000 +0400
>>>>@@ -0,0 +1,157 @@
>>>>+/*
>>>>+ *  include/ub/beancounter.h
>>>>+ *
>>>>+ *  Copyright (C) 2006 OpenVZ. SWsoft Inc
>>>>+ *
>>>>+ */
>>>>+
>>>>+#ifndef _LINUX_BEANCOUNTER_H
>>>>+#define _LINUX_BEANCOUNTER_H
>>>>+
>>>>+/*
>>>>+ *	Resource list.
>>>>+ */
>>>>+
>>>>+#define UB_RESOURCES	0
>>>>+
>>>>+struct ubparm {
>>>>+	/*
>>>>+	 * A barrier over which resource allocations are failed gracefully.
>>>>+	 * e.g. if the amount of consumed memory is over the barrier further
>>>>+	 * sbrk() or mmap() calls fail, the existing processes are not killed.
>>>>+	 */
>>>>+	unsigned long	barrier;
>>>>+	/* hard resource limit */
>>>>+	unsigned long	limit;
>>>>+	/* consumed resources */
>>>>+	unsigned long	held;
>>>>+	/* maximum amount of consumed resources through the last period */
>>>>+	unsigned long	maxheld;
>>>>+	/* minimum amount of consumed resources through the last period */
>>>>+	unsigned long	minheld;
>>>>+	/* count of failed charges */
>>>>+	unsigned long	failcnt;
>>>>+};
>>>
>>>
>>>What is the difference between barrier and limit. They both sound like
>>>hard limits.  No?
>>
>>check __charge_beancounter_locked and severity.
>>It provides some kind of soft and hard limits.
>>
> 
> 
> Would be easier to just rename them as soft and hard limits...
> 
> 
>>>>+
>>>>+/*
>>>>+ * Kernel internal part.
>>>>+ */
>>>>+
>>>>+#ifdef __KERNEL__
>>>>+
>>>>+#include <linux/config.h>
>>>>+#include <linux/spinlock.h>
>>>>+#include <linux/list.h>
>>>>+#include <asm/atomic.h>
>>>>+
>>>>+/*
>>>>+ * UB_MAXVALUE is essentially LONG_MAX declared in a cross-compiling safe form.
>>>>+ */
>>>>+	/* resources statistics and settings */
>>>>+	struct ubparm		ub_parms[UB_RESOURCES];
>>>>+};
>>>>+
>>>
>>>
>>>I presume UB_RESOURCES value is going to change as different resources
>>>start getting tracked.
>>
>>what's wrong with it?
>>
> 
> 
> ...just that user land will need to be some how informed about that.
the same way user space knows that system call is (not) implemented.
(include unistd.h :))) )

>>>I think something like configfs should be used for user interface.  It
>>>automatically presents the right interfaces to user land (based on
>>>kernel implementation).  And you wouldn't need any changes in glibc etc.
>>
>>1. UBC doesn't require glibc modificatins.
> 
> 
> You are right not for setting the limits.  But for adding any new
> functionality related to containers....as in you just added a new system
> call to get the limits.
Do you state that glibc describes _all_ the existing system calls with some wrappers?

>>2. if you think a bit more about it, adding UB parameters doesn't
>>   require user space changes as well.
>>3. it is possible to add any kind of interface for UBC. but do you like the idea
>>   to grep 200(containers)x20(parameters) files for getting current usages?
> 
> 
> How are you doing it currently and how much more efficient it is in
> comparison to configfs?
currently it is done with a single file read.
you can grep it, sum up resources or do what ever you want from bash.
what is important! you can check whether container hits its limits
with a single command, while with configs you would have to look through
20 files...

IMHO it is convinient to have a text file representing the whole information state
and system call for applications.

>>   Do you like the idea to convert numbers to strings and back w/o
>>   thinking of data types?
> 
> 
> IMO, setting up limits and containers (themselves) is not a common
> operation.    I wouldn't be too worried about loosing those few extra
> cycles in setting them up.
it is not the question of performance...

Kirill

