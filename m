Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316071AbSEJRNy>; Fri, 10 May 2002 13:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316072AbSEJRNy>; Fri, 10 May 2002 13:13:54 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3726 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S316071AbSEJRNx>;
	Fri, 10 May 2002 13:13:53 -0400
Message-ID: <3CDBFFCD.94589E4F@colorfullife.com>
Date: Fri, 10 May 2002 19:13:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mark Gross <mgross@unix-os.sc.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables for O(1) 
 scheduler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you checked that your patch doesn't deadlock on ia64?

> +       /* First pause all related threaded processes */
> +       if (dump_threads)       {
> +               suspend_threads();
> +       }
> +       
> +       /* now stop all vm operations */
> +       down_write(&current->mm->mmap_sem);
> +       segs = current->mm->map_count;
> +
Stopping all vm operations means that copy_{to,from}_user can cause
deadlocks.
ia64 needs copy_to_user in their stack unwind handler, IIRC called by
ELF_CORE_COPY_REGS.

Afaics you don't handle that. You must dump all thread state before
down_write(mmap_sem). And I don't see how you protect against 2 threads
of one process calling suspend_threads() simultaneously.

--
	Manfred
