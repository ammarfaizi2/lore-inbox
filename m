Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbRL0ELX>; Wed, 26 Dec 2001 23:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286210AbRL0ELN>; Wed, 26 Dec 2001 23:11:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:47374 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286207AbRL0ELE>;
	Wed, 26 Dec 2001 23:11:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk
Subject: [RFC] Remove section .text.lock
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 15:10:50 +1100
Message-ID: <11665.1009426250@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I plan to stop using section .text.lock for out of line code.  Using a
special section for out of line code can generate dangling refernces to
discarded sections, the dangling references are flagged as an error by
binutils 2.11.92.0.12 onwards.  See the l-k discussion in thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=100909932003300&w=2

After the above discussion there is general agreement (well, nobody
disagreed) that .text.lock can be replaced with .subsection 1.  It
still gives out of line code but without the dangling reference problem
because all references are within the same section.  It can even
generate better code, intra section branches can be smaller than inter
section branches.

I am going through 2.4.18-pre1 looking at all references to .text.lock
and converting them, removing vmlinux.lds entries and dead comments at
the same time.  Most of the changes are obvious, only i386, ia64, m68k
and arm are really using .text.lock, the rest are copy and paste lines
in vmlinux.lds and are already redundant.

ARM is a problem.  It does not use .text.lock for spinlocks (UP only),
instead it uses .text.lock for __do_softirq, __down_failed and friends.
AFAICT this is completely pointless, these routines only occur once so
they are already out of line.  .text.lock should be used for the code
that calls these functions and only on the fail path, I see no point in
putting the functions themselves in .text.lock.  Can somebody explain
why these arm functions are in section .text.lock instead of normal
.text?

