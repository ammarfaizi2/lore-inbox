Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWIENEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWIENEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWIENEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:04:20 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:25514 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932181AbWIENES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:04:18 -0400
Date: Tue, 5 Sep 2006 15:03:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: lockdep oddity
Message-ID: <20060905130356.GB6940@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock validator gives me this (latest -mm and 2.6.18-rc6):

===================================== 
[ BUG: bad unlock balance detected! ] 
------------------------------------- 
swapper/0 is trying to release lock (resource_lock) at:
[<0000000000042842>] request_resource+0x52/0x88 
but there are no more locks to release! 

The reason is that the BUILD_LOCK_OPS macros in kernel/lockdep.c don't contain
any of the *_acquire calls, while all of the _unlock functions contain a
*_release call. Hence I get immediately unbalanced locks.

CONFIG_PREEMPT,
CONFIG_SMP,
!CONFIG_PROVE_LOCKING,
CONFIG_DEBUG_LOCK_ALLOC,
and
CONFIG_LOCKDEP

will generate this code.

Found this will debugging some random memory corruptions that happen when
CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on.
Switching both off or having only one of them on seems to work.
