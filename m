Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUHMWXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUHMWXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267610AbUHMWXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:23:41 -0400
Received: from holomorphy.com ([207.189.100.168]:16022 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267602AbUHMWXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:23:40 -0400
Date: Fri, 13 Aug 2004 15:23:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040813222303.GO11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de, linux-kernel@vger.kernel.org
References: <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <1089857602.15336.4120.camel@abyss.home> <20040715023300.GJ3411@holomorphy.com> <20040715023951.GK3411@holomorphy.com> <20040715024447.GL3411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715024447.GL3411@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 07:39:51PM -0700, William Lee Irwin III wrote:
>> Careful not to make too much of ignoring signals, mm/oom_kill.c sets
>> PF_MEMDIE out-of-context, so when an OOM kill is issued while a task
>> is looping in __alloc_pages() it will eventually break out of the
>> rebalance loop due to the flag.

On Wed, Jul 14, 2004 at 07:44:47PM -0700, William Lee Irwin III wrote:
> However, note the modifications of task->flags are not atomic. In
> principle, one may have:
> __alloc_pages()			__oom_kill_task()
> load current->flags		load current->flags
> |= PF_MEMALLOC in registers	|= PF_MEMALLOC|PF_MEMDIE in registers
> IRQ/delay/whatever		store current->flags
> store current->flags		...
> try_to_free_pages() etc.	force_sig() etc.
> ... and voila! PF_MEMDIE in ->flags has been lost.

I have a testcase that panics in mm/oom_kill.c (no processes left) on
several kinds of machines with weaker memory consistency, but does not
on x86-64. I suspect it is related to lack of task->flags atomicity.


-- wli
