Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTDQTvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDQTvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:51:51 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:10979 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262186AbTDQTvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:51:42 -0400
Date: Thu, 17 Apr 2003 21:05:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Steven Rostedt <rostedt@stny.rr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <srostedt@goodmis.org>
Subject: Re: What's the reason that /dev/mem can't map unreserved RAM?
In-Reply-To: <Pine.LNX.4.44.0304171414470.13337-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304172036540.1966-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, Steven Rostedt wrote:
> 
> What's the rational behind /dev/mem not being able to map unreserved RAM?
> It can't be for protecting the system, because if you have access to 
> reserved RAM (kernel text) then you can modify the remap_pte_range to 
> allow for mapping of ram.
> 
> I have a user program for debugging kernel modules and the like, and it 
> uses /dev/mem to map ram and prints it out. But unless I take out the 
> check in remap_pte_range, I can't see allocated pages.
> 
> I just want to know the rational behind this.

I understand your surprise and frustration.

The reason is not a very good one, it's just that we haven't
yet done the work to allow unrestrained mapping of /dev/mem.

A mapping of /dev/mem is unlike the usual mapping of a shared file.
I can't explain this at all well: might one say, when you map a file,
you are mapping the pages for the data they currently contain; but
when you map /dev/mem, you are mapping the pages for their frames?

Think about the page->count, think about how in your mapping of
/dev/mem there may be pages which belong to (currently contain
data from) mapped files (and much else besides).

When you munmap your mapping of /dev/mem, that must not free the
pages you had mapped, you don't have any hold on them at all; yet
as things stand (if you were allowed to map unReserved pages),
it would decrement page->count, free unowned pages, cause havoc.

There should be a specific VM_RESERVED flag (there is already but
it's not used in quite this way) to forbid page->count manipulations
on vmas (mappings) of /dev/mem.  But that code is not in place,
so instead this rather ugly PageReserved stuff has hung around.

I did start out on eliminating PageReserved a few months ago,
but was persuaded to delay that until 2.7.  When that's done,
you will be able to mmap /dev/mem properly.

Hugh

