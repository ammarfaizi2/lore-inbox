Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUHJIuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUHJIuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUHJIuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:50:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9866 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262450AbUHJIuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:50:32 -0400
Date: Tue, 10 Aug 2004 10:04:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810080430.GA25866@elte.hu>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810063445.GE11200@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Aug 09, 2004 at 03:45:46PM -0700, William Lee Irwin III wrote:
> > Adding mdelay(1000) before and after the wakeup IPI didn't help. Must
> > be something else going on in printk().
> 
> None of the printk()'s in do_boot_cpu() appear essential. The
> following also boots:

the key seems to be not doing fork_idle() call via keventd?

i'm wondering about:

> -	if (!keventd_up() || current_is_keventd())
> -		work.func(work.data);
> -	else {
> -		schedule_work(&work);
> -		wait_for_completion(&c_idle.done);
> -	}

is keventd_up() true during normal SMP bootup? If not then could you do
something like this in do_fork_idle():

	if (keventd_up())
		complete(&c_idle->done);

since we are in the idle thread and waking up ourselves could move us
back to the runqueue. (bad)

	Ingo
