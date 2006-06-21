Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWFUOP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWFUOP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWFUOP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:15:26 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:29630 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751230AbWFUOPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:15:25 -0400
Message-ID: <44995453.8030005@watson.ibm.com>
Date: Wed, 21 Jun 2006 10:14:43 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: akpm@osdl.org, Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6-mm2] Fix exit race in per-task-delay-accounting
References: <20060621055952.6658.49704.sendpatchset@localhost.localdomain> <4498EB1B.1070002@in.ibm.com>
In-Reply-To: <4498EB1B.1070002@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Balbir Singh wrote:
> 
>> Hi, Andrew,
>>
>> This patch fixes a race in per-task-delay-accounting. This race
>> was reported by Jay Lan. I tested the patch using
>> cerebrus test control system for eight hours with getdelays running on
>> the side (for both push and pull of delay statistics).
>>
>> It fixed the problem that Jay Lan saw.

Balbir, Andrew,

I'd recommend holding off on including the patch for a bit
since the solution proposed uses a
a) global and b) taskstats related
mutex to solve a race that is in the delay accounting code.

The locking required to resolve this race is for the exiting task
(whose tsk->delays is being set to null) and that too only for
accessing its delay accounting field.

Using a global mutex that is also being used to serialize exits
may be unnecessarily
- increasing contention
- introducing dependency between taskstats (generic) and delay accounting
layers.

So if there is an inexpensive way of achieving this locking using
something localized and specific to delay accounting (the most obvious
way seems to be a tsk->delay_lock but that has the unpleasant aspect of adding
yet another field to struct task) we should explore that first.

--Shailabh

>>
>> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
>> ---
>>
>>  include/linux/taskstats_kern.h |    1 +
>>  kernel/delayacct.c             |    5 ++++-
>>  kernel/taskstats.c             |    5 ++++-
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff -puN kernel/taskstats.c~per-task-delay-accounting-fix-exit-race
>> kernel/taskstats.c
>> ---
