Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWEMBey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWEMBey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWEMBey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 21:34:54 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:44471 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751299AbWEMBey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 21:34:54 -0400
Date: Fri, 12 May 2006 21:30:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 7/11] perfmon2 patch for review: modified i386
  files
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200605122132_MC3-1-BFA1-E625@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200605121633.k4CGXmKd027348@frankl.hpl.hp.com>

On Fri, 12 May 2006 09:33:48 -0700, Stephane Eranian wrote:

<snip>

 > --- linux-2.6.17-rc4.orig/arch/i386/kernel/entry.S    2006-05-12 03:16:09.000000000 -0700
 > +++ linux-2.6.17-rc4/arch/i386/kernel/entry.S 2006-05-12 03:18:52.000000000 -0700
 > @@ -436,6 +436,16 @@
 >  /* The include is where all of the SMP etc. interrupts come from */
 >  #include "entry_arch.h"
 >  
 > +#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFMON)
 > +ENTRY(pmu_interrupt)
 > +     pushl $LOCAL_PERFMON_VECTOR-256
 > +     SAVE_ALL
 > +     pushl %esp
 > +     call pfm_intr_handler
 > +     addl $4, %esp
 > +     jmp ret_from_intr
 > +#endif
 > +
 >  ENTRY(divide_error)
 >       pushl $0                        # no error code
 >       pushl $do_divide_error

You should rename pfm_intr_handler to smp_pmu_interrupt (yes, it's not
really SMP but other functions have that problem too, e.g.
smp_error_interrupt) and make it fastcall, then you can do:

BUILD_INTERRUPT(pmu_interrupt, LOCAL_PERFMON_VECTOR)

instead of open-coding it.  Then the Xen patch that extends the interrupt
vector range won't have to change to accommodate your patch.

You should also probably move the BUILD_INTERRUPT() into entry_arch.h
with the rest of them.

-- 
Chuck

"The x86 isn't all that complex -- it just doesn't make a lot of sense."
                                                        -- Mike Johnson
