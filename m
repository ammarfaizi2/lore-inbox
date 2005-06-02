Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVFBAxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVFBAxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFBAxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:53:07 -0400
Received: from science.horizon.com ([192.35.100.1]:53825 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261264AbVFBAxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:53:02 -0400
Date: 2 Jun 2005 00:52:59 -0000
Message-ID: <20050602005259.10673.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Abstracted Priority Inheritance for RT
Cc: inaky.perez-gonzalez@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Do you plan to use that callback for priority inheritance?
>>> If so: It would lead to an recursive algorithm. That is not very nice in
>>> the kernel with a limited call-stack. It is not so much a problem if the
>>> mechanism is used in the kernel only, but if it is used for user-space
>>> locking, which can have unlimited neesting, it is potential problem.
>>
>> I'm not sure I see how this could become recursive, could you explain
>> more?
?
> Maybe he is referring to the case?
> 
> A owns M
> B owns N and is waiting for M
> A is trying to wait for N

No, that's just a straight deadlock and a bug whether you have PI oir not.
The recursive concern is the following case:

Process priorities: A < B < C < ...

Process A holds lock 1
Process B holds lock 2 and is trying for lock 1
Process C holds lock 3 and is trying for lock 2
Process D holds lock 4 and is trying for lock 3

Now see what happens when high-priority process E tries to
take lock 4.  We need to push its priority all the way down
the chain to process A.

If a process is only allowed to try for one lock at a time, that could,
in theory, be done iteratively, but it might take some care.


Actually, the tricky part of priority inheritance implementation is
usually dropping the priority properly when locks are released.

For example, with priorities A < B < C:
Process A holds locks 1 and 2
Process B is trying for lock 1
Process C is trying for lock 2

Now, if process A were to drop lock 1, its priority would stay
elevated to C's level.  But if it were to drop lock 2, its
proproty would drop to B's level, and C would preempt it.
You can come up with some very perverse priority trees this way.
