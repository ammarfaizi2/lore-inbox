Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264291AbUEMQRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUEMQRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUEMQRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:17:35 -0400
Received: from iPass.cambridge.arm.com ([193.131.176.58]:10464 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S264291AbUEMQRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:17:31 -0400
Subject: local_irq_save, memory clobbering and volatile
From: scott douglass <scott.douglass@arm.com>
To: linux-kernel@vger.kernel.org
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084465048.12767.106.camel@pc982.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 17:17:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
I've searched through the mailing list archives and I've found these
comments about volatile (albeit from a few years back):

> "volatile" is _never_ a good idea, [...]

and

> [...] volatile is an evil keyword that is badly specified and only 
> makes the compiler generate worse code without ever fixing any real
> bugs.

But there's a lot of archive to search though and I may have missed
something relevant.  I also looked though the Documentation directory
without success.

If I understand correctly, the arguments against volatile are/were that
using volatile can slow down some critical regions like list traversal
and can hide the absence of proper locking.  It seems to me that the
"slow down some critical regions" can be handled by manually caching the
value (in the critical region) rather than hoping the compiler would
notice.

Do I understand the arguments against volatile correctly?

Is this still the official position?  If so, why is volatile used so
much in the current kernel sources?

I think the clobbering of memory by local_irq_save, et al. is not
necessary in cases were volatile is used correctly.  The clobbering
inhibits the compiler's ability to optimize more than volatile does. 
When memory gets clobbered the compiler can't optimize other memory
accesses in the function even though they are not involved in the
critical region.  As compilers do more inlining the amount of
optimization damage done by clobbering memory grows.
 
Existing code relies on the current clobbering instead of using volatile
accesses, so I'm suggesting that there should be new, non-clobbering
forms, e.g. local_irq_save_no_clobber, etc.  To use them correctly the
accesses in the critical region must be to volatile objects, for
example:
 
__inline__ void atomic_clear_mask (unsigned long mask, volatile unsigned
long *addr) {
	unsigned long flags;
 
	local_irq_save_no_clobber(flags);
	*addr &= ~mask;
	local_irq_restore_no_clobber(flags);
}
 
This lets the compiler know exactly which accesses are to volatile
objects and means that functions that call atomic_clear_mask can still
be optimized.  Some of the C definitions of atomic_clear_mask in the
sources already have this volatile qualification.
 
Is there any reason not to add local_irq_save_no_clobber, etc. (perhaps
with better names)?

[I'm not on the mailing list but I will check the mailing list for
replies.]

Thanks.

