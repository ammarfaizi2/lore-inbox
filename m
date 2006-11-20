Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934190AbWKTO3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934190AbWKTO3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934191AbWKTO3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:29:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934190AbWKTO3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:29:49 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds
Date: Mon, 20 Nov 2006 14:27:13 +0000
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The workqueue struct is huge, and this limits it's usefulness.  On a 64-bit
architecture it's nearly 100 bytes in size, of which the timer_list is half.
These patches shrink work_struct by 8 of the 12 words it ordinarily consumes.
This is done by:

 (1) Splitting the timer out so that delayable work items are defined by a
     separate structure which incorporates a basic work_struct and a timer.

 (2) Folding the pending bit and wq_data data together

 (3) Removing the private data.  This can almost always be derived from the
     address of the work_struct using container_of() and the selection of the
     work function.  For the cases where the container of the work_struct may
     go away the moment the pending bit is cleared, it is made possible to
     defer the release of the structure by deferring the clearing of the
     pending bit.


These patches reduce the size of the work_struct thusly:

			#WORDS		32-bit arch	64-bit arch
			===============	===============	===============
	As is		12		48 bytes	96 bytes
	Non-delayable	4		16 bytes	32 bytes
	Delayable	10		40 bytes	80 bytes

I've looked through most of the usages of work_structs, and I think that
probably fewer than half the work_structs used actually require delayability,
and I'm not sure that it's absolutely necessary in all cases.


With these patches applied, there are four classes of work item where
previously there was one.  These are made up of a combination of the following
characteristics:

 (*) Delayable vs Non-delayable.

     Delayable work items have their execution deferred for at least a certain
     amount of time; non-delayable items are executed as soon as possible.

 (*) Auto-release vs Non-auto-release

     Ordinarily, the work queue executor would release the work_struct for
     further scheduling or deallocation by clearing the pending bit prior to
     jumping to the work function.  This means that, unless the driver makes
     some guarantee itself that the work_struct won't go away, the work
     function may not access anything else in the work_struct or its container
     lest they be deallocated..  This is a problem if the auxiliary data is
     taken away (as done by the last patch).

     However, if the pending bit is *not* cleared before jumping to the work
     function, then the work function *may* access the work_struct and its
     container with no problems.  But then the work function must itself
     release the work_struct by calling work_release().

     In most cases, automatic release is fine, so this is the default.  Special
     initiators exist for the non-auto-release case.


Note that this is a partial conversion.  If these patches are generally
acceptable, then the rest of the kernel will also need modification.  I've
tested these patches on my x86_64 testbox only thus far.

Furthermore, the timer_list struct could possibly be shrunk by 1 word if it
also lost its data member.

David
