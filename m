Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbUBFLG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUBFLG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:06:28 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:24239 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265413AbUBFLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:06:21 -0500
Subject: When should we use likely() / unlikely() / get_unaligned() ?
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: matthew@wil.cx
Content-Type: text/plain
Message-Id: <1076065578.16147.72.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 06 Feb 2004 11:06:19 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be no coherent answer to the above questions. On some
architectures likely() might bypass dynamic branch prediction, so we
shouldn't use it unless there's at _least_ a 95% probability; on others
it may simply affect code ordering and we gain a tiny benefit from it if
the probabilities aren't precisely 50/50.

Likewise for using get_unaligned() to inline the alignment fixups --
what is the ratio between the costs of inlining the fixup and of
potentially taking the exception? If the pointer is expected to be
unaligned 25% of the time, should we use get_unaligned? What if it's
50%? 75%?

These are all very arch-specific, and sometimes compiler-specific. The
likely()/unlikely()/get_unaligned() functions as they currently stand
make little sense.

I think we need to include a probability, in order for use of these
functions in _generic_ code to make any sense. So we replace
likely(condition) with probable(condition, percentage), and likewise
with get_unaligned()...


#define ARCH_PROBABILITY_HIGH 75    // These actually defined by arch code
#define ARCH_PROBABILITY_LOW 25
#define ARCH_ALIGNMENT_COST_THRESHOLD 50

#define probable(condition, pc)					\
	(__builtin_constant_p(pc)?				\
	 (((pc) > ARCH_PROBABILITY_HIGH)?			\
	      __builtin_expect((condition),1):			\
	      (((pc) < ARCH_PROBABILITY_LOW)?			\
	           __builtin_expect((condition),0):		\
		  (condition)))					\
	 :(condition))


#define get_unaligned_p(ptr, pc)						\
	((__builtin_constant_p(pc)&&(pc) < ARCH_ALIGNMENT_COST_THRESHOLD)?	\
	 (*(ptr)):get_unaligned(ptr))


In fact some uClinux architectures _cannot_ fix up alignment, and would
set ARCH_ALIGNMENT_COST_THRESHOLD to zero. 

-- 
dwmw2

