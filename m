Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVHQPWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVHQPWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVHQPWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:22:30 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:22448 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751152AbVHQPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:22:30 -0400
Date: Wed, 17 Aug 2005 11:19:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, taka@valinux.co.jp,
       lkml.hyoshiok@gmail.com
Message-ID: <200508171121_MC3-1-A776-594E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 at 13:50:22 +0900 (JST), Hiro Yoshioka wrote:

> 3) page faults/exceptions/...
> 3-1  TS flag is set by the CPU (Am I right?)

  TS will _not_ be set if a trap/fault or interrupt occurs.  The only
way that could happen automatically would be to use a separate hardware
task with its own TSS to handle those.

  And since the kernel does not have any state information of its own
(no task_struct) any attempt to save the kernel-mode FPU state would
overwrite the current user-mode state anyway.

  Interrupt and fault handlers will not use FP instructions anyway.
The only thing you have to worry about is getting scheduled away
while your code is running, and I guess that's why you have to worry
about page faults.  And as Arjan pointed out, if you are doing
__copy_from_user_inatomic you cannot sleep (==switch to another task.)

  So I would try the code from include/asm-i386/xor.h, modify it to
save as many registers as you plan to use and see what happens.  It will
do all the right things. See the xor_sse_2() for how to save and restore
properly -- you will need to put your xmm_save area on the stack.
 
__
Chuck
