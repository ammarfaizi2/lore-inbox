Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSJBSzC>; Wed, 2 Oct 2002 14:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262668AbSJBSzC>; Wed, 2 Oct 2002 14:55:02 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54221 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262662AbSJBSzB>;
	Wed, 2 Oct 2002 14:55:01 -0400
Message-ID: <3D9B4176.5020100@us.ibm.com>
Date: Wed, 02 Oct 2002 11:56:54 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Erich Focht <efocht@ess.nec.de>
Subject: Re: [RFC] Simple NUMA scheduler patch
References: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain> <1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com> <20021002141121.C2141@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Oct 01, 2002 at 04:55:35PM -0700, Michael Hohnbaum wrote:
>>--- clean-2.5.40/kernel/sched.c	Tue Oct  1 13:48:34 2002
>>+++ linux-2.5.40/kernel/sched.c	Tue Oct  1 13:27:46 2002
>>@@ -30,6 +30,9 @@
>> #include <linux/notifier.h>
>> #include <linux/delay.h>
>> #include <linux/timer.h>
>>+#if CONFIG_NUMA
>>+#include <asm/topology.h>
>>+#endif
> 
> Please make this inlcude unconditional, okay?
Agreed...  The topology macros are designed to work for *any* 
architecture, so there's no need to selectively include them.

>>+/*
>>+ * find_busiest_queue - find the busiest runqueue.
>>+ */
>>+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
>>+{
>>+	int nr_running, load, max_load_on_node, max_load_off_node, i;
>>+	runqueue_t *busiest, *busiest_on_node, *busiest_off_node, *rq_src;
> 
> You're new find_busiest_queue is to 80 or 90% the same as the non-NUMA one.
> At least add the #ifdefs only where needed, but as cpu_to_node() optimizes
> away for the non-NUMA case I think you could just make it unconditional.
Looking over the code... I think I agree with Christoph here.  I think 
that most of the new code won't even get touched in the non-NUMA case. 
Of course, let me know if I'm wrong! ;)


>>+		if (__cpu_to_node(i) == __cpu_to_node(this_cpu)) {
> 
> I think it should be cpu_to_node, not __cpu_to_node.
Actually, the non-double-underbar versions are not in the kernel...  I 
have a patch for them, though...  They just do some simple bound/error 
checking as wrappers around the double-underbar versions.  As long as 
you aren't calling the macros with bizarre values (ie 0<=i<=NR_CPUS), 
the double-underbar versions will work just fine, and will be mildly 
quicker.

Other than that, it looks good to me!

Cheers!

-Matt

