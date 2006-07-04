Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWGDMru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWGDMru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWGDMru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:47:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8422 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750796AbWGDMrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:47:49 -0400
From: David Howells <dhowells@redhat.com>
To: Ingo Molnar <mingo@redhat.com>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: R/W semaphore changes
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 04 Jul 2006 13:47:42 +0100
Message-ID: <14683.1152017262@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see you've made some R/W semaphore changes...

| /*
|  * nested locking:
|  */

This comment is inadequate.  Please be more explicit about when you're allowed
to do this.

| extern void down_read_nested(struct rw_semaphore *sem, int subclass);
| extern void down_write_nested(struct rw_semaphore *sem, int subclass);

Please, please, please don't.  R/W semaphores are _not_ permitted to nest.
That way lies deadlock.

| /*
|  * Take/release a lock when not the owner will release it:
|  */
| extern void down_read_non_owner(struct rw_semaphore *sem);
| extern void up_read_non_owner(struct rw_semaphore *sem);

Does that mean that the owner may not then release the semaphore?  I presume
not, but it's not entirely clear.

| # define down_read_nested(sem, subclass)		down_read(sem)
| # define down_write_nested(sem, subclass)	down_write(sem)

This is _not_ okay.


I also notice that you've out-of-lined the rwsems debugging wrappers in all
situations.  Please don't.  On some archs this is going to slow things down.
On FRV for example, this is converted to:

	0xc00437f0 <down_read+0>:	addi sp,-16,sp
	0xc00437f4 <down_read+4>:	sti fp,@(sp,0)
	0xc00437f8 <down_read+8>:	ori sp,0,fp
	0xc00437fc <down_read+12>:	movsg lr,gr5
	0xc0043800 <down_read+16>:	sti gr5,@(fp,8)
	0xc0043804 <down_read+20>:	call 0xc01ea910 <__down_read>
	0xc0043808 <down_read+24>:	ldi @(fp,8),gr5
	0xc004380c <down_read+28>:	ld @(fp,gr0),fp
	0xc0043810 <down_read+32>:	addi sp,16,sp
	0xc0043814 <down_read+36>:	jmpl @(gr5,gr0)

When previously __down_read would be called directly...  This applies to every
arch that uses the spinlock-based R/W sems.  In FRV's case, you've required
the loading of extra icache lines to no useful purpose.  Now I do have GDB
stub compiled in, so normally it would be shorter than this as it wouldn't
normally save the frame pointer, and would probably tail-call.

If you must put your annotations somewhere, please place them in lib/rwsem*.c
directly.

Please _only_ out-of-line the rwsem debugging wrappers when the appropriate
config options are set.  It is reasonable to do it then - it is debugging code
after all, and therefore not enabled for normal operation.

Oh, and if you're going to out-of-line the rwsem debugging wrappers like this,
please remove all the then-redundant PUSHL instructions from the inline asm in
include/asm-i386/rwsem.h.  They're then no longer required as there's no need
to save registers that are callee-clobbered, since you're marking them
clobbered anyway by interpolating an extra function call.
