Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUIMTak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUIMTak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268892AbUIMTak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:30:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:40128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268899AbUIMTaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:30:24 -0400
Date: Mon, 13 Sep 2004 12:30:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [no patch] broken use of mm_release / deactivate_mm
In-Reply-To: <20040913190633.GA22639@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0409131224440.2378@ppc970.osdl.org>
References: <20040913190633.GA22639@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Sep 2004, Andries Brouwer wrote:
>
> What happens at a fork, is that a long sequence of things is done,
> and if a failure occurs all previous things are undone. Thus
> (in copy_process()):
> 
>         if ((retval = copy_mm(clone_flags, p)))
>                 goto bad_fork_cleanup_signal;
>         if ((retval = copy_namespace(clone_flags, p)))
>                 goto bad_fork_cleanup_mm;
>         retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
>         if (retval)
>                 goto bad_fork_cleanup_namespace;
> 
> ...
> 
> bad_fork_cleanup_namespace:
>         exit_namespace(p);
> bad_fork_cleanup_mm:
>         exit_mm(p);
>         if (p->active_mm)
>                 mmdrop(p->active_mm);

I agree. Looks like the "exit_mm()" should really be a "mmput()".

Can we have a few more eyes on this thing? Ingo, Nick?

		Linus
