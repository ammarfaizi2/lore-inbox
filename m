Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265829AbTFSQAD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbTFSQAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:00:03 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:12956 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265829AbTFSQAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:00:00 -0400
Message-ID: <3EF1E136.40305@colorfullife.com>
Date: Thu, 19 Jun 2003 18:13:42 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to
 hang in
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

your bug description seems to be correct, but the fix is wrong:
If the allocation is for the 2nd page of wait queue heads, then 
"current->state = TASK_INTERRUPTIBLE" can lead to lost wakeups, if an fd 
that is stored in the first page gets ready during the allocation. 
Setting the state to interruptible is only permitted if a full scan of 
all file descriptors happens before calling schedule(). This is 
expensive and should be avoided.

The correct fix is current->state = TASK_RUNNING just before calling 
yield() in the rebalance code.

--
    Manfred

