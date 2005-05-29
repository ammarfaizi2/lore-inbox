Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVE2N6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVE2N6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVE2N6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:58:49 -0400
Received: from pat.uio.no ([129.240.130.16]:63923 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261308AbVE2N6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:58:46 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <4299A7F6.3A31BB7D@tv-sign.ru>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru>  <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org>
	 <4299A7F6.3A31BB7D@tv-sign.ru>
Content-Type: text/plain
Date: Sun, 29 May 2005 06:58:28 -0700
Message-Id: <1117375108.11049.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.06, required 12,
	autolearn=disabled, AWL 1.94, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 29.05.2005 Klokka 15:31 (+0400) skreiv Oleg Nesterov:
> __rpc_execute() calls ->tk_exit and goes to 'restarted' label.
> What if ->tk_exit calls rpc_sleep_on() ? If it is possible, we
> have a race.
> 
> CPU_0 (main loop in rpc_execute restarted)		CPU_1
> 
> rpc_delete_timer:
> 	if (RPC_IS_QUEUED())	// YES
> 		return;
> 							rpc_run_timer:
> 								rpc_wake_up_task:
> 									clear_bit(RPC_TASK_QUEUED)
> 								preemption, or long interrupt
> 
> if (!RPC_IS_QUEUED())		// YES
> 	task->tk_action()
> 		__rpc_add_timer:
> 			set_bit(RPC_TASK_HAS_TIMER)
> 			mod_timer();
> 								clear_bit(RPC_TASK_HAS_TIMER)
> 
> Now we have pending timer without RPC_TASK_HAS_TIMER bit set.

It is possible, but it should be _extremely_ rare. The only cases where
tk_exit() sets a timer are the cases where we call rpc_delay(). In the
existing cases in the kernel, that would be setting timers of 5 seconds
(for the case of JUKEBOX errors) or longer.

These tx_exit()+restart events are very rare in themselves (JUKEBOX
errors only occur if the server needs to do something with a long
latency - such as retrieving a file from an HSM unit), but for that to
coincide with a preemption or interrupt of > 5 seconds inside
__rpc_execute... I'd hate to see those RPC performance figures.

> Is this patch makes any sense?

Yes. I agree the scenario is theoretically possible (so I can queue that
patch up for you). I am not convinced it is a plausible explanation for
what John claims to be seeing, though.

Cheers,
  Trond

