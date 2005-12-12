Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVLLG1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVLLG1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVLLG1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:27:49 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:51651 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751137AbVLLG1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:27:48 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, oleg@tv-sign.ru, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask 
In-reply-to: Your message of "Sun, 11 Dec 2005 20:32:26 -0800."
             <20051211203226.4deafd59.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Dec 2005 17:27:38 +1100
Message-ID: <4143.1134368858@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2005 20:32:26 -0800, 
Andrew Morton <akpm@osdl.org> wrote:
>"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>>
>> 1.	wmb() guarantees that any writes preceding the wmb() will
>>  	be seen by the interconnect before any writes following the
>>  	wmb().  But this applies -only- to the writes executed by
>>  	the CPU doing the wmb().
>> 
>>  2.	rmb() guarantees that any changes seen by the interconnect
>>  	preceding the rmb() will be seen by any reads following the
>>  	rmb().  Again, this applies only to reads executed by the
>>  	CPU doing the wmb().  However, the changes might be due to
>>  	any CPU.
>> 
>>  3.	mb() combines the guarantees made by rmb() and wmb().
>
>So foo_mb() in preemptible code is potentially buggy.
>
>I guess we assume that a context switch accidentally did enough of the
>right types of barriers for things to work OK.

Not by accident.  Any context switch must flush the memory state from
the old cpu's internal buffers, and that flush must get at least as far
as the globally snoopable cache.  Otherwise the old cpu could still own
partial memory updates from the process, even though the process was
now running on a new cpu.

