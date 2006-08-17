Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWHQQ5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWHQQ5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWHQQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:57:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:37525 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932564AbWHQQ5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:57:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=djKFGZY2iRff2yUeE+JRRiWTa7Il2LF06fIbLLyZypJPUux6kTtdghAdLhkMSXbsj
	naIMJDu+bcZyDIy1NgdpQ==
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E458C4.9030902@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>
	 <1155751868.22595.65.camel@galaxy.corp.google.com> <44E458C4.9030902@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 09:55:53 -0700
Message-Id: <1155833753.14617.21.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 15:53 +0400, Kirill Korotaev wrote:
> Rohit Seth wrote:
> > On Wed, 2006-08-16 at 19:37 +0400, Kirill Korotaev wrote:
> > 
> >>Core functionality and interfaces of UBC:
> >>find/create beancounter, initialization,
> >>charge/uncharge of resource, core objects' declarations.
> >>
> >>Basic structures:
> >>  ubparm           - resource description
> >>  user_beancounter - set of resources, id, lock
> >>
> >>Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> >>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> >>
> >>---
> >> include/ub/beancounter.h |  157 ++++++++++++++++++
> >> init/main.c              |    4
> >> kernel/Makefile          |    1
> >> kernel/ub/Makefile       |    7
> >> kernel/ub/beancounter.c  |  398 +++++++++++++++++++++++++++++++++++++++++++++++
> >> 5 files changed, 567 insertions(+)
> >>
> >>--- /dev/null	2006-07-18 14:52:43.075228448 +0400
> >>+++ ./include/ub/beancounter.h	2006-08-10 14:58:27.000000000 +0400
> >>@@ -0,0 +1,157 @@
> >>+/*
> >>+ *  include/ub/beancounter.h
> >>+ *
> >>+ *  Copyright (C) 2006 OpenVZ. SWsoft Inc
> >>+ *
> >>+ */
> >>+
> >>+#ifndef _LINUX_BEANCOUNTER_H
> >>+#define _LINUX_BEANCOUNTER_H
> >>+
> >>+/*
> >>+ *	Resource list.
> >>+ */
> >>+
> >>+#define UB_RESOURCES	0
> >>+
> >>+struct ubparm {
> >>+	/*
> >>+	 * A barrier over which resource allocations are failed gracefully.
> >>+	 * e.g. if the amount of consumed memory is over the barrier further
> >>+	 * sbrk() or mmap() calls fail, the existing processes are not killed.
> >>+	 */
> >>+	unsigned long	barrier;
> >>+	/* hard resource limit */
> >>+	unsigned long	limit;
> >>+	/* consumed resources */
> >>+	unsigned long	held;
> >>+	/* maximum amount of consumed resources through the last period */
> >>+	unsigned long	maxheld;
> >>+	/* minimum amount of consumed resources through the last period */
> >>+	unsigned long	minheld;
> >>+	/* count of failed charges */
> >>+	unsigned long	failcnt;
> >>+};
> > 
> > 
> > What is the difference between barrier and limit. They both sound like
> > hard limits.  No?
> check __charge_beancounter_locked and severity.
> It provides some kind of soft and hard limits.
> 

Would be easier to just rename them as soft and hard limits...

> >>+
> >>+/*
> >>+ * Kernel internal part.
> >>+ */
> >>+
> >>+#ifdef __KERNEL__
> >>+
> >>+#include <linux/config.h>
> >>+#include <linux/spinlock.h>
> >>+#include <linux/list.h>
> >>+#include <asm/atomic.h>
> >>+
> >>+/*
> >>+ * UB_MAXVALUE is essentially LONG_MAX declared in a cross-compiling safe form.
> >>+ */
> >>+	/* resources statistics and settings */
> >>+	struct ubparm		ub_parms[UB_RESOURCES];
> >>+};
> >>+
> > 
> > 
> > I presume UB_RESOURCES value is going to change as different resources
> > start getting tracked.
> what's wrong with it?
> 

...just that user land will need to be some how informed about that.

> > I think something like configfs should be used for user interface.  It
> > automatically presents the right interfaces to user land (based on
> > kernel implementation).  And you wouldn't need any changes in glibc etc.
> 1. UBC doesn't require glibc modificatins.

You are right not for setting the limits.  But for adding any new
functionality related to containers....as in you just added a new system
call to get the limits.

> 2. if you think a bit more about it, adding UB parameters doesn't
>    require user space changes as well.
> 3. it is possible to add any kind of interface for UBC. but do you like the idea
>    to grep 200(containers)x20(parameters) files for getting current usages?

How are you doing it currently and how much more efficient it is in
comparison to configfs?

>    Do you like the idea to convert numbers to strings and back w/o
>    thinking of data types?

IMO, setting up limits and containers (themselves) is not a common
operation.    I wouldn't be too worried about loosing those few extra
cycles in setting them up.

-rohit

