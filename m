Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTDYXme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbTDYXme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:42:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1962 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263225AbTDYXmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:42:32 -0400
Message-ID: <3EA9CA25.E140A02C@us.ibm.com>
Date: Fri, 25 Apr 2003 16:52:05 -0700
From: badari <pbadari@us.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: TASK_UNMAPPED_BASE & stack location
References: <459930000.1051302738@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

Only problem with moving TASK_UNMAPPED_BASE right above
text would be - limiting the malloc() space. malloc() is clever enough
to mmap() and do the right thing. Once I moved TASK_UNMAPPED_BASE
to 0x10000000 and I could not run some of the programs with large
data segments.

Moving stacks below text would be tricky. pthread library knows
the placement of stack. It uses this to distinguish between
threads and pthreads manager.

I don't know what other librarys/apps depend on this kind of stuff.

Thanks,
Badari

static inline pthread_descr thread_self (void)
{
#ifdef THREAD_SELF
  return THREAD_SELF;
#else
  char *sp = CURRENT_STACK_FRAME;
  if (sp >= __pthread_initial_thread_bos)
    return &__pthread_initial_thread;
  else if (sp >= __pthread_manager_thread_bos
           && sp < __pthread_manager_thread_tos)
    return &__pthread_manager_thread;
  else if (__pthread_nonstandard_stacks)
    return __pthread_find_self();
  else
#ifdef _STACK_GROWS_DOWN
    return (pthread_descr)(((unsigned long)sp | (STACK_SIZE-1))+1) - 1;
#else
    return (pthread_descr)((unsigned long)sp &~ (STACK_SIZE-1));
#endif
#endif
}


"Martin J. Bligh" wrote:

> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
> libraries directly above the program text? Red Hat seems to have patches to
> dynamically tune it on a per-processes basis anyway ...
>
> Moreover, can we put the stack back where it's meant to be, below the
> program text, in that wasted 128MB of virtual space? Who really wants
> > 128MB of stack anyway (and can't fix their app)?
>
> I'm sure there's some horrible reason we can't do this ... would just like
> to know what it is. If it's "standards compilance" I don't really believe
> it - we don't comply with the standard now anyway ...
>
> M.
>
> PS. Motivation is creating large shmem segments for DBs.
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>

