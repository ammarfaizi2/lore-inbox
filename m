Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUHJJEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUHJJEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUHJJCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:02:03 -0400
Received: from holomorphy.com ([207.189.100.168]:18151 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263735AbUHJJA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:00:56 -0400
Date: Tue, 10 Aug 2004 02:00:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810090051.GK11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080430.GA25866@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810080430.GA25866@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 03:45:46PM -0700, William Lee Irwin III wrote:
>> None of the printk()'s in do_boot_cpu() appear essential. The
>> following also boots:

On Tue, Aug 10, 2004 at 10:04:30AM +0200, Ingo Molnar wrote:
> the key seems to be not doing fork_idle() call via keventd?
> i'm wondering about:

It deadlocks with or without the fork_idle() call being via keventd;
the printk change is what makes the difference. =(


William Lee Irwin III <wli@holomorphy.com> wrote:
>>-	if (!keventd_up() || current_is_keventd())
>>-		work.func(work.data);
>>-	else {
>>-		schedule_work(&work);
>>-		wait_for_completion(&c_idle.done);
>>-	}

On Tue, Aug 10, 2004 at 10:04:30AM +0200, Ingo Molnar wrote:
> is keventd_up() true during normal SMP bootup? If not then could you do
> something like this in do_fork_idle():
> 	if (keventd_up())
> 		complete(&c_idle->done);
> since we are in the idle thread and waking up ourselves could move us
> back to the runqueue. (bad)

There appear to be some dependencies on idle being able to schedule
and participate in kernel activity, e.g. kthread_create() does
something odd like this during migration_init().


-- wli
