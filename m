Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUGAWEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUGAWEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUGAWEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:04:09 -0400
Received: from mail.shareable.org ([81.29.64.88]:12462 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266311AbUGAWEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:04:04 -0400
Date: Thu, 1 Jul 2004 23:00:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org
Cc: linux-kernel@vger.kernel.org
Subject: A question about PROT_EXEC-only pages on IA64
Message-ID: <20040701220058.GA7928@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi IA64 folks,

I'm doing a survey of the different architectural implementations of
PROT_* flags for mmap() and mprotect().  I'm looking at linux-2.6.5.

According to my reading of the source, from include/asm-ia64/pgtable.h
and arch/ia64/mm/fault.c, IA64 on Linux implements the following:

Requested PROT flags | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
=====================+======================================================
ia64 MAP_SHARED      | ---    r--    !w-    rw-    *-x    r-x    !wx    rwx
ia64 MAP_PRIVATE     | ---    r--    !w-    rw-    *-x    r-x    !wx    rwx

"!" means that a read access raises a signal *sometimes*.  This is
because the page protection when the page is installed allows reading,
but if there isn't a page installed, then a read fault will raise a
signal.

(Several architectures have "!" entries, but their places in the table
vary.  On x86_64, and i386 with NX, for example, the sequence is "---
r-- !w- rw- r-x r-x rwx rwx": notice no "!" in the -WX case.  That's
because of different logic in the fault handler.)

I have a question about about the column with "*".  You have
implemented PROT_EXEC-only pages using these flags:

#define __P100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)

I.e. _PAGE_AR_X_RX.  My question is: does this mean that reading those
pages in *kernel* mode will succeed, i.e. so that write() would
succeed in reading from those pages?

If that's the behaviour, and the intention is to create exec-only
pages, then it's a bug.  A similar bug has been found on the Sparc for
PROT_NONE pages, which is more serious.

It's not necessarily important on IA64, because IA64 is the _only_
Linux platform which does exec-only pages.  (This despite other
hardware being able to have exec-only permissions.  See another mail
about that in a few minutes).

I would simply like to know if this is the IA64 behaviour, where a
PROT_EXEC-only area is readable by get_user(), to document it.  (It's
possible that I don't understand the technical implications of
_PAGE_AR_X_RX, and that in fact get_user() in kernel won't be able to
read exec-only pages.)

Thanks,
-- Jamie
