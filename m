Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVKPKZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVKPKZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVKPKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:25:10 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:60635 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932597AbVKPKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:25:08 -0500
Date: Wed, 16 Nov 2005 02:24:31 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, ak@muc.de, benh@kernel.crashing.org,
       paulus@samba.org, tony.luck@intel.comf
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-ID: <20051116102431.GB26411@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net> <200511150050.27556.arnd@arndb.de> <20051115090612.GA22160@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115090612.GA22160@infradead.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On Tue, Nov 15, 2005 at 09:06:12AM +0000, Christoph Hellwig wrote:
> On Tue, Nov 15, 2005 at 12:50:26AM +0100, Arnd Bergmann wrote:
> > > --- 25/include/asm-powerpc/unistd.h~perfmon2-reserve-system-calls???????Mon Nov 14 15:27:32 2005
> > > +++ 25-akpm/include/asm-powerpc/unistd.h????????Mon Nov 14 15:27:32 2005
> > > @@ -296,8 +296,20 @@
> > > ?#define __NR_inotify_init??????275
> > > ?#define __NR_inotify_add_watch?276
> > > ?#define __NR_inotify_rm_watch??277
> > > +#define __NR_pfm_create_context????????278
> > > +#define __NR_pfm_write_pmcs????279
> > > +#define __NR_pfm_write_pmds????280
> > > +#define __NR_pfm_read_pmds?????281
> > > +#define __NR_pfm_load_context??282
> > > +#define __NR_pfm_start?????????283
> > > +#define __NR_pfm_stop??????????284
> > > +#define __NR_pfm_restart???????285
> > > +#define __NR_pfm_create_evtsets????????286
> > > +#define __NR_pfm_getinfo_evtsets 287
> > > +#define __NR_pfm_delete_evtsets 288
> > > +#define __NR_pfm_unload_context????????289
> > > ?
> > > -#define __NR_syscalls??????????278
> > > +#define __NR_syscalls??????????290
> 
> 
> anyway, this is an awfull lot of syscalls numbers for what essentially
> is a driver not core kernel functionality.  I think we should do an API
> review first.

I have cut the number of system calls as much as I could. Initially
this started out as a single multiplexing system call. Given the feedback
I received, I switched it over to multiple system calls. In retrospect,
I think this is better than the initial design.

As for your driver question, it is true that if we were only interested in
accessing the performance counters on a system-wide basis, like OProfile,
we could have implemented a device driver.

However we want both the ability to measure on a system-wide basis, i.e.,
across all kernel threads running on a processor, but also on a per kernel thread
basis. Both modes are important. Certain measurements do need to be applied
to a single thread, e.g., counting the number of retired instructions for /bin/ls.

The per-thread mode implies that, on context switch, the counters be saved
and restored like the rest of the machine state. I don't believe it is allowed
for a device driver to access to the context switch code.

Furthermore we want to have the monitoring interface be builtin to make it easier
for tools developers. A system call interface also gives us more flexibility
as to how the interface looks like, i.e., number and types of arguments.

Fro all those reasons, we felt that the syscall approach was the best.


> and why didn't this patch get sent to lkml for review?

For the last few months, I have been posting announces on lkml, perfctr-devel
and also linux-ia64-kernel about the new releases of the multi-platform perfmon
code base to sollicate feedback. I don't claim to know all the kernel internal
semantics and interfaces nor each hardware platofrm intricacies. Thus I welcome
any comments, complaints especially if they are constructive and poinpoint precise
problems in the code. This way I think we all make forward progress.

I will be releasing a new version of the patch this week. I would certainly welcome
your comments.

-- 
-Stephane
