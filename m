Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263597AbRFIRUy>; Sat, 9 Jun 2001 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbRFIRUe>; Sat, 9 Jun 2001 13:20:34 -0400
Received: from HSE-MTL-ppp72639.qc.sympatico.ca ([64.229.201.194]:57728 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S263597AbRFIRUY>; Sat, 9 Jun 2001 13:20:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Keith Owens <kaos@ocs.com.au>, tlan@stud.ntnu.no
Subject: Re: missing symbol do_softirq in net moduels for pre-2
Date: Sat, 9 Jun 2001 13:20:19 -0400
X-Mailer: KMail [version 1.2]
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
In-Reply-To: <16799.992106264@ocs4.ocs-net>
In-Reply-To: <16799.992106264@ocs4.ocs-net>
MIME-Version: 1.0
Message-Id: <01060913201900.01845@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 June 2001 13:04, Keith Owens wrote:
> On Sat, 9 Jun 2001 18:56:24 +0200,
>
> =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no> wrote:
> >Keith Owens:
> >> >Built -pre2 and noticed most of the modules in net/* are getting
> >> >a missing symbol for do_softirq.
> >>
> >> http://www.tux.org/lkml/#s8-8
> >
> >I got the same error on -pre1, and tried the info in the link, didn't
> > help:
> >
> >root@test4:/usr/src# depmod -ae
> >depmod: *** Unresolved symbols in
> > /lib/modules/2.4.6-pre1/kernel/net/ipv4/netfilter/ip_tables.o depmod:    
> >     do_softirq
>
> It was missing in 6-pre1.  It should have been fixed in 6-pre2.

The fix to export ksyms for do_softirq is _in_ pre2...  its just not working.

from ksyms in pre2:
/* software interrupts */
EXPORT_SYMBOL(tasklet_hi_vec);
EXPORT_SYMBOL(tasklet_vec);
EXPORT_SYMBOL(bh_task_vec);
EXPORT_SYMBOL(init_bh);
EXPORT_SYMBOL(remove_bh);
EXPORT_SYMBOL(tasklet_init);
EXPORT_SYMBOL(tasklet_kill);
EXPORT_SYMBOL(__run_task_queue);
EXPORT_SYMBOL(do_softirq);
EXPORT_SYMBOL(tasklet_schedule);
EXPORT_SYMBOL(tasklet_hi_schedule);

in the arch code for softirq we now have:

+#define local_bh_enable()                                              \
+do {                                                                   \
+       unsigned int *ptr = &local_bh_count(smp_processor_id());        \
+                                                                       \
+       if (!--*ptr)                                                    \
+               __asm__ __volatile__ (                                  \
+                       "cmpl $0, -8(%0);"                              \
+                       "jnz 2f;"                                       \
+                       "1:;"                                           \
+                                                                       \
+                       ".section .text.lock,\"ax\";"                   \
+                       "2: pushl %%eax; pushl %%ecx; pushl %%edx;"     \
+                       "call do_softirq;"

What has to happen to get assembly code to version the symbol?

Ed Tomlinson
