Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbTGDGka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 02:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbTGDGka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 02:40:30 -0400
Received: from voldemort.codesourcery.com ([65.73.237.138]:26089 "EHLO
	mail.codesourcery.com") by vger.kernel.org with ESMTP
	id S265801AbTGDGk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 02:40:26 -0400
From: "Zack Weinberg" <zack@codesourcery.com>
To: linux-kernel@vger.kernel.org
Subject: Garbage collectors and VM (was Re: What to expect with the 2.6 VM)
In-Reply-To: <20030703184825.GA17090@mail.jlokier.co.uk>
Date: Thu, 03 Jul 2003 23:54:50 -0700
Message-ID: <87u1a2srwl.fsf@egil.codesourcery.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, but there was a meek request to get writable/read-only protection
> working with remap_file_pages, so that a garbage collector can change
> protection on individual pages without requiring O(nr_pages) vmas.
> Perhaps that should have nothing to do with remap_file_pages, though.

I have an old design for this lying around from early 2.4 days.  I
never got anywhere with it, but maybe it's of interest...  My tests,
back then, indicated that fully half the overhead of write-barrier
handling was in signal delivery.  So I wanted to avoid that, as well
as having to split vmas endlessly.  I also didn't want to add new
syscalls if it could be avoided.  Thus, a new pseudo-device, with the
semantics:

 * mmapping it creates anonymous pages, just like /dev/zero.
 * Data written to the file descriptor is interpreted as a list of
   user-space pointers to pages.  All the pages pointed to, that
   are anonymous pages created by mmapping that same descriptor,
   become read-only.
 * But when the program takes a write fault to such a page, the
   kernel simply records the user-space address of that page,
   resets it to read-write, and restarts the faulting instruction.
   The user space process doesn't get a signal.
 * Reading from the descriptor produces a list of user-space pointers
   to all the pages that have been reset to read-write since the last
   read.
 * I never decided what to do if the program forks.  The application I
   personally care about doesn't do that, but for a general GC like
   Boehm it matters.

Thoughts?

Please cc: me, I'm not subscribed to l-k.

zw
