Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316095AbSEJSN3>; Fri, 10 May 2002 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316097AbSEJSN2>; Fri, 10 May 2002 14:13:28 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:14031 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S316095AbSEJSN1>; Fri, 10 May 2002 14:13:27 -0400
Message-Id: <200205101813.g4AIDLw17587@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables for O(1)  scheduler
Date: Fri, 10 May 2002 11:13:08 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3CDBFFCD.94589E4F@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 requires more tweaks than just this to work.  This patch as it stands 
isn't expected to work for ia64.

Getting the register states for the note sections is more involved for ia64 
as well as the avoiding of patch collisions with  the diffs in 
/pub/linux/kernel/ports/ia64/v2.5/ 

I have an ia64 patch set thats partially tested for 2.4.17, that seems to 
work.  It didn't get posted as O(1) support became a bigger priority.

I'm hoping to start updating the ia64 patch to support 2.5x very soon.

--mgross

On Friday 10 May 2002 01:13 pm, Manfred Spraul wrote:
> Have you checked that your patch doesn't deadlock on ia64?
>
> > +       /* First pause all related threaded processes */
> > +       if (dump_threads)       {
> > +               suspend_threads();
> > +       }
> > +
> > +       /* now stop all vm operations */
> > +       down_write(&current->mm->mmap_sem);
> > +       segs = current->mm->map_count;
> > +
>
> Stopping all vm operations means that copy_{to,from}_user can cause
> deadlocks.
> ia64 needs copy_to_user in their stack unwind handler, IIRC called by
> ELF_CORE_COPY_REGS.
>
> Afaics you don't handle that. You must dump all thread state before
> down_write(mmap_sem). And I don't see how you protect against 2 threads
> of one process calling suspend_threads() simultaneously.
