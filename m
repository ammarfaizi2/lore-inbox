Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbUAEXZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUAEXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:25:30 -0500
Received: from [193.138.115.2] ([193.138.115.2]:27908 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265997AbUAEXX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:23:57 -0500
Date: Tue, 6 Jan 2004 00:20:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to
 sector_t being unsigned, advice requested
Message-ID: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

First of all, please let me explain the large number of recipients.
I initially posted a mail about this issue to lkml asking for confirmation
that what I'd found really was a bug. I got no reply appart from a single
suggestion that I attempt to email the maintainers of the filesystems in
question directly - this is what I'm now doing.
I've included lkml as CC in case someone there should know something but
missed the original mail.


The problem is what seems (to me, but I could be dead wrong) to be invalid
use of variables of type sector_t.

Let me use fs/ufs/inode.c as the example :

on lines 334 & 335 there is this code

  if (fragment < 0)
          goto abort_negative;

fragment being of type sector_t which (as far as I've been able to find
out) is always an unsigned datatype. That means that it can never be < 0
and thus the branch will never be taken and the code in abort_negative
never executed.
Looks like a bug to me.

I initially discovered this in fs/ufs/inode.c line 334 (this is all
releative to 2.6.1-rc1-mm1 btw), but when I started looking for it
elsewere I found the same (or similar) issue in
fs/adfs/inode.c line 30,
fs/befs/linuxvfs.c line 135,
fs/bfs/file.c line 67 &
fs/reiserfs/inode.c line 577

When I went digging for the actual type of sector_t I found the following:

include/linux/types.h defines sector_t as
typedef unsigned long sector_t;

and in include/asm* sector_t is defined as :
asm-sh/types.h:typedef u64 sector_t;
asm-x86_64/types.h:typedef u64 sector_t;
asm-h8300/types.h:typedef u64 sector_t;
asm-i386/types.h:typedef u64 sector_t;
asm-mips/types.h:typedef u64 sector_t;
asm-s390/types.h:typedef u64 sector_t;
asm-ppc/types.h:typedef u64 sector_t;

all unsigned types.

Have I missed a location where sector_t is defined as a signed type?

The naive approach would be to simply remove the test for < 0 and the
associated code in abort_negative. But since I don't know enough about
file system internals to know why that test was put in there in the first
place (and I've been unable to deduce it from reading the surrounding
code) I need your help.

- Why is that code there?

- Can it simply be removed (seems like what you'd want if it will never
 execute)?

- Can you point me at some relevant documentation I should read in order
to discover the ansver for myself?
I've so far been reading the affected .c files themselves and the files in
Documentation/filesystems/ , but I can't seem to find anything even
remotely related to sector_t's being negative...

- Am I missing something obvious?


I want to thank you in advance for your time - I hope I'm not wasting it.


Kind regards,

Jesper Juhl
