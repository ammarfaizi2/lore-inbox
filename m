Return-Path: <linux-kernel-owner+w=401wt.eu-S1751041AbXAIFB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbXAIFB2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbXAIFB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:01:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:33230 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbXAIFB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:01:27 -0500
Date: Tue, 9 Jan 2007 10:31:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] reimplement flush_workqueue()
Message-ID: <20070109050104.GA29119@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061229171827.GA158@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229171827.GA158@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 08:18:27PM +0300, Oleg Nesterov wrote:
> Remove ->remove_sequence, ->insert_sequence, and ->work_done from struct
> cpu_workqueue_struct. To implement flush_workqueue() we can queue a barrier
> work on each CPU and wait for its completition.

Oleg,
	Because of this change, was curious to know if this is possible:


CPU0					CPU1
(Thread0)

flush_workqueue()
					queue_work(W1)	
  flush_cpu_workqueue(cpu1)
    insert_barrier(B1)
      wait_on_completion();
	
					run_workqueue()
					   W1.func();
					     flush_workqueue();
						B1.func(); <- wakes Thread0

The intention of barrier B1 was to wait untill W1 was -complete-. If
W1.func()->....->something() were to call flush_workqueue on the same
workqueue, then we would be returning from the barrier prematurely.

Looks possible in theory. Don't know if it is a practical issue.

-- 
Regards,
vatsa
