Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUG1BtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUG1BtB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266761AbUG1BtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:49:01 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21983 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266758AbUG1Bs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:48:58 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention 
In-reply-to: Your message of "Tue, 27 Jul 2004 17:40:30 MST."
             <20040728004030.GK2334@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Jul 2004 11:48:05 +1000
Message-ID: <2479.1090979285@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 17:40:30 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>It's good to know there is a precedent and that the backtrace issue has
>been looked at on other architectures.
>
>On Wed, Jul 28, 2004 at 10:35:08AM +1000, Keith Owens wrote:
>> Are you are planning to consolidate the out of line code for i386?  Is
>> there a patch (even work in progress) so I can start thinking about
>> doing reliable backtraces?
>
>The experiments were carried out using the standard calling convention.
>We may investigate less standard calling conventions, but they should
>actually already be there given __write_lock_failed/__read_lock_failed.
>i.e. if reliable backtraces are going to be an issue they should
>already be an issue for rwlocks.

rwlocks are already a issue on i386, but not a big one.  The return
address from __write_lock_failed/__read_lock_failed is pointing into
the out of line code, not the code that really took the rwlock.  The
nearest label is LOCK_SECTION_NAME, i.e. .text.lock.KBUILD_BASENAME.  A
backtrace through a contended rwlock on i386 looks like this

  interrupt
  __write_lock_failed/__read_lock_failed
  .text.lock.KBUILD_BASENAME
  caller of routine that took the lock
  ...

when it should really be

  interrupt
  __write_lock_failed/__read_lock_failed
  .text.lock.KBUILD_BASENAME
  routine that took the look  <=== missing information
  caller of routine that took the lock
  ...

IOW we only get the name of the object, not the function within the
object that took the lock.  i386 gets away with this because
.text.lock.KBUILD_BASENAME is usually enough information to determine
which lock is the problem, and the i386 backtrace algorithm has enough
redundancy to get back in sync for the rest of the trace, even with the
missing function entry.

OTOH, ia64 unwind is incredibly sensitive to the exact instruction
pointer and there is zero redundancy in the unwind data.  If the return
ip is not known to the unwind code, then the ia64 unwinder cannot
backtrace correctly.  Which meant that I had to get the ia64 out of
line code exactly right, close enough was not good enough.

With Zwane's patch, any contended spinlock on i386 will look like
rwsem, it will be missing the routine that took the look.  Good enough
for most cases.

kdb does unwind through out of line spinlock code exactly right, simply
because I added extra heuristics to kdb to cope with this special case.
When people complain that the kdb i386 backtrace code is too messy,
they are really saying that they do not care about getting exact data
for all the hand crafted assembler in the kernel.

BTW, if anybody is planning to switch to dwarf for debugging the i386
kernel then you _must_ have valid dwarf data for the out of line code.

