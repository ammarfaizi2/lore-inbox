Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVISJIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVISJIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVISJIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:08:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932393AbVISJIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:08:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: schwidefsky@de.ibm.com
X-Fcc: ~/Mail/linus
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, macro@linux-mips.org, akpm@osdl.org, dev@sw.ru
Subject: Re: [PATCH] more sigkill priority fix
In-Reply-To: Martin Schwidefsky's message of  Monday, 19 September 2005 10:57:44 +0200 <1127120264.4897.34.camel@localhost.localdomain>
X-Windows: some voids are better left unfilled.
Message-Id: <20050919090804.55590180E1D@magilla.sf.frob.com>
Date: Mon, 19 Sep 2005 02:08:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does that mean that it is incorrect to deliver one signal at a time?

Whenever there are pending unblocked signals, they need to be delivered
before running any more user code.  If after setting up a signal handler
(and blocking signals for it), there is another unblocked signal pending,
then that must be delivered immediately.  This can mean terminating the
process before the handler ever runs, or it can mean setting up another
signal handler frame starting from the context of the first handler frame. 

The only change with this bug fix is that this reliably happens immediately.
Before, it would always happen pretty soon (except in a pathological case
with a bad stack).  That is, the next preemption, system call, fault, 
other trap, or external interrupt--anything that entered the kernel--would
check the pending signals properly before returning to user mode.  


Thanks,
Roland
