Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUBJDrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 22:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUBJDrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 22:47:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:59023 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265538AbUBJDrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 22:47:21 -0500
Subject: [BUG] get_unmapped_area() change -> non booting machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Message-Id: <1076384799.893.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 14:47:09 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've finally found what is causing my box not to boot any more
with recent 2.6.3-rc* bk's.

Andi change to get_unmapped_area() is triggering that interesting
scenario:

 - bash tries to load
 - ld.so tries to map libc somewhere below the executable at a
location provided by the prelink informations. However, probably due to
outdated prelink informations (I didn't re-run prelink since I updated
glibc), it won't fit.
 - Andi change cause do_mmap() to actually do a search of a free
space from the address... when ends up beeing right after the brk point
of the just loaded bash
 - something (glibc) is now mapped right after brk point of bash,
preventing it from malloc'ing, so it dies.

Just reverting the patch fixes it. Though, the patch do make sense in
some cases, paulus suggested to modify the code so that for a non
MAP_FIXED map, it still search from the passed-in address, but avoids
the spare between the current mm->brk and TASK_UNMAPPED_BASE, thus the
algorithm would still work for things outside of these areas.

Commment ?

(Sorry, no patch at this point, still recovering the box and deep
into another bug...)

Ben.


