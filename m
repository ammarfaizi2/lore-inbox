Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSILHwj>; Thu, 12 Sep 2002 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSILHwj>; Thu, 12 Sep 2002 03:52:39 -0400
Received: from dp.samba.org ([66.70.73.150]:18888 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S313181AbSILHwi>;
	Thu, 12 Sep 2002 03:52:38 -0400
Date: Thu, 12 Sep 2002 17:48:22 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] fix NMI watchdog, 2.5.34
Message-Id: <20020912174822.2ecd4294.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0209102008000.1100-100000@linux-box.realnet.co.sz>
References: <20020910054147.CD7972C201@lists.samba.org>
	<Pine.LNX.4.44.0209102008000.1100-100000@linux-box.realnet.co.sz>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002 20:11:49 +0200 (SAST)
Zwane Mwaikambo <zwane@mwaikambo.name> wrote:

> On Tue, 10 Sep 2002, Rusty Russell wrote:
> 
> > Well spotted.  You might want to test the following patch which
> > catches calls to smp_call_function() before the cpus are actually
> > online.  I ran a variant on my (crappy, old, SMP) box before I sent
> > the patch to Linus, and all I saw was the (harmless) tlb_flush.
> 
> hmm...
> 
> > diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.34/arch/i386/kernel/smpboot.c working-2.5.34-smp_call_cpus/arch/i386/kernel/smpboot.c
> > --- linux-2.5.34/arch/i386/kernel/smpboot.c	Sun Sep  1 12:22:57 2002
> > +++ working-2.5.34-smp_call_cpus/arch/i386/kernel/smpboot.c	Tue Sep 10 14:35:07 2002
> > @@ -1218,7 +1218,10 @@ int __devinit __cpu_up(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +unsigned int smp_done = 0;
> > +
> >  void __init smp_cpus_done(unsigned int max_cpus)
> >  {
> >  	zap_low_mappings();
> > +	smp_done = 1;
> 
> I've got an SMP box which dies reliably at zap_low_mappings, i wonder if 
> this could be the same problem. My BSP sits spinning on the completion 
> check.

Hmmm, I can't see how: you mean it hangs in flush_tlb_all() (waiting for the
ack in smp_call_function()?).  If so, that seems really wierd.  You could add
a printk("here: %u\n", smp_processor_id()) in flush_tlb_all_ipi() to see which
CPU isn't getting it...

Strange,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
