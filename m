Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSHPIEN>; Fri, 16 Aug 2002 04:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHPIEM>; Fri, 16 Aug 2002 04:04:12 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:53889 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S316789AbSHPIEK>; Fri, 16 Aug 2002 04:04:10 -0400
Date: Fri, 16 Aug 2002 17:07:52 +0900 (JST)
Message-Id: <20020816.170752.846937151.nomura@hpc.bs1.fc.nec.co.jp>
To: akpm@zip.com.au
Cc: j-nomura@ce.jp.nec.com, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18(19) swapcache oops
From: j-nomura@ce.jp.nec.com
In-Reply-To: <3D5C823A.4850F8B5@zip.com.au>
References: <3D5C0D3D.E68137BA@zip.com.au>
	<20020816.131922.730554388.nomura@hpc.bs1.fc.nec.co.jp>
	<3D5C823A.4850F8B5@zip.com.au>
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.18(19) swapcache oops
Date: Thu, 15 Aug 2002 21:40:26 -0700

> You must have been able to reproduce it quite quickly.  But the
> code has been like that for ages.  Why is that?  Are you testing
> on an unusual machine?

Not so unusual. It's Itanium2 SMP machine (4cpus to 32cpus).
The problem have occured at first after I run a very large multi-threaded
program for days.

To investigate the problem, I made a small program which allocate
memory and then create some threads to access the shared space in parallel.
It makes shared pages swapped in and out with very high frequency.
Running it with small free memory situation, the program could cause
the oops in a few minutes on 4cpu machine.

---------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#define NPROC 4
#define SIZE 0x20000000

char *ptr;

void*
loop(void* none)
{
        while(1)
                memset((char *)ptr, 0, SIZE);
}
        
int
main(int argc, char** argv)
{
        int i;
        void *v;

        pthread_t tid[NPROC];

        ptr=malloc(SIZE);
        memset(ptr, 0, SIZE);

        for(i=0; i<NPROC; i++){
                pthread_create((pthread_t *)&tid[i],
                                (pthread_attr_t *)NULL,
                                loop,
                                (void *)NULL);
        }

        for(i=0; i<NPROC; i++)
                pthread_join(tid[i], (void**)NULL);

        return 0;
}
---------------------------------------------------------------------

> > As to the second fix from 2.5.32, it can't be applicable to 2.4, can it?
> > try_to_swap_out() may call add_to_swap_cache() with PG_lru page.
> 
> Ah, good point.  In 2.5, add_to_page_cache() does not add the
> page to the LRU.  Anonymous pages are already there, and we
> don't need to do that.  The first patch should be OK.

I hope the patch will be taken in next 2.4 release.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
HPC Operating System Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.
