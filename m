Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUHJI6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUHJI6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUHJI60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:58:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6855 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263555AbUHJI5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:57:45 -0400
Date: Tue, 10 Aug 2004 10:58:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810085849.GC26081@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092103522.761.2.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

>  [<c01062d8>] common_interrupt+0x18/0x20
>  [<c013e2ee>] do_anonymous_page+0x7e/0x190
>  [<c013e44e>] do_no_page+0x4e/0x310
>  [<c013e8d1>] handle_mm_fault+0xc1/0x170
>  [<c013d2a0>] get_user_pages+0x130/0x3b0
>  [<c013ea28>] make_pages_present+0x68/0x90
>  [<c01401d8>] do_mmap_pgoff+0x3f8/0x640
>  [<c010b656>] sys_mmap2+0x76/0xb0
>  [<c01060b7>] syscall_call+0x7/0xb

another idea: you are running this on a C3, using CONFIG_MCYRIXIII,
correct? That is one of the rare configs that triggers X86_USE_3DNOW and
MMX ops. If 3dnow is in any way handicapped in that CPU then that could
cause trouble. Could you compile for e.g. CONFIG_M586TSC? [that option
should be fully compatible with a C3.] - this will exclude the MMX page
clearing ops.

what makes me suspicious is this entry in your call-trace:

>  [<c013e2ee>] do_anonymous_page+0x7e/0x190

this is the next instruction after:

   call   c01d1910 <mmx_clear_page>

but it's all a bit weird - the ALSA interrupt should have hit the
fast_clear_page() function but it didnt. Maybe it doesnt show up because
the call to fast_clear_page() within mmx_clear_page() is tail-optimized
and possibly the stack entry is lost. But still ...

	Ingo
