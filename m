Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWAYUVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWAYUVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWAYUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:21:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12963 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751205AbWAYUVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:21:19 -0500
Date: Wed, 25 Jan 2006 21:21:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [patch, validator] fix proc_subdir_lock related deadlock
Message-ID: <20060125202142.GA12823@elte.hu>
References: <20060125170331.GA29339@elte.hu> <1138209283.6695.55.camel@localhost.localdomain> <20060125180811.GA12762@elte.hu> <20060125102351.28cd52b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125102351.28cd52b8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > to solve this we must either change files_lock to be softirq-safe too 
> > (bleh!), or we must forbid remove_proc_entry() use from softirq 
> > contexts. Neither is a happy solution - remove_proc_entry() is used 
> > within free_irq(), and who knows how many drivers do free_irq() in 
> > softirq/tasklet context ...
> 
> free_irq()'s /proc fiddling has always been a pain - we just shouldn't 
> be doing filesystem things in irq/bh context.

the second patch i sent is quite straightforward.

> > Andrew, this needs to be resolved before v2.6.16, correct? Steve's patch 
> > solves a real bug in the upstream kernel.
> 
> It's not a very big bug - I think only Steve hit it, and that with a 
> stress-test which was somewhat tuned to hit it.

still ...

> So we can afford to sit on the problem for a while, as long as someone 
> is working on a broader /proc-sanity fix.  But nobody will do that.
> 
> I wonder if we can just punt the unregister_handler_proc/kfree up to a 
> keventd callback.

i'd rather do the files_lock change i sent, and perhaps add a 
WARN_ON_ONCE() to all known places that do a free_irq() from softirq 
context.

	Ingo
