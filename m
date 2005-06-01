Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFAWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFAWJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVFAWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:08:54 -0400
Received: from [203.171.93.254] ([203.171.93.254]:27342 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261328AbVFAWHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:07:10 -0400
Subject: Re: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050601130205.GA1940@openzaurus.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117663709.13830.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 02 Jun 2005 08:08:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning.

On Wed, 2005-06-01 at 23:02, Pavel Machek wrote:
> Hi!
> 
> > Here are the freezer patches. They were prepared against rc3, but I
> > think they still apply fine against rc5. (Ben, these are the same ones I
> > sent you the other day).
> 
> 304 seems ugly and completely useless for mainline

That's because you don't understand what it's doing.

The new refrigerator implementation works like this:

Userspace processes that begin a sys_*sync gain the process flag
PF_SYNCTHREAD for the duration of their syscall.

We then freeze processes in three distinct groups.

1. Userspace processes (p->mm) that don't have PF_SYNCTHREAD set are
signalled first. This causes them to enter the refrigerator, thereby
stopping them from submitting further I/O that could cause the syncing
threads to potentially spin for ever.

2. Syncing threads are signalled so that when they finish syncing (if
they haven't already), they also enter the refrigerator. Any processes
that were in group 2 but are now in group 1 are also signalled.

It is possible that no process was syncing data. We thus now call
sys_sync ourselves, to flush remaining dirty data to disk.

3. Kernel threads not needed during suspend (kjournald, eg) are frozen.

> 300: stopping softirqd seems dangerous to me... are you sure?

It's been that way for ages without any reports of deadlocks. I'm happy
to change it if it really was dangerous for some reason.

> 301: patching exit should not be neccessary. Why do you need it?

Maybe you're right. I think it's a left over from the old
implementation. I'll try removing the call and see how the freezer
survives some stress testing.

Regards,

Nigel

